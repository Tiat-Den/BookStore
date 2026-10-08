using BookStore.Application.Common;
using BookStore.Application.DTOs.Orders;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using BookStore.Domain.Enums;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class OrderService : IOrderService
{
    private readonly BookStoreDbContext _context;

    public OrderService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<OrderDto>> CreateOrderAsync(Guid userId, CreateOrderDto request)
    {
        var user = await _context.Users
            .Include(u => u.Cart)
                .ThenInclude(c => c!.Items)
                    .ThenInclude(i => i.Book)
                        .ThenInclude(b => b.Inventory)
            .FirstOrDefaultAsync(u => u.Id == userId);

        if (user == null)
        {
            return ApiResponse<OrderDto>.Fail("Không tìm thấy thông tin người dùng.");
        }

        var cart = user.Cart;
        // BR-12: Order phải có ít nhất 1 item
        if (cart == null || !cart.Items.Any())
        {
            return ApiResponse<OrderDto>.Fail("Giỏ hàng của bạn đang trống.");
        }

        // Bắt đầu Transaction cho Đặt hàng (Checkout)
        await using var transaction = await _context.Database.BeginTransactionAsync();
        try
        {
            decimal subTotal = 0;
            var orderItems = new List<OrderItem>();

            // 1. Kiểm tra tồn kho & tính toán đơn giá từ Server (BR-13, BR-14)
            foreach (var cartItem in cart.Items)
            {
                var book = cartItem.Book;
                if (book.IsDeleted || book.Status != BookStatus.Active)
                {
                    await transaction.RollbackAsync();
                    return ApiResponse<OrderDto>.Fail($"Sách '{book.Title}' đã ngừng kinh doanh.");
                }

                if (book.StockQuantity < cartItem.Quantity)
                {
                    await transaction.RollbackAsync();
                    return ApiResponse<OrderDto>.Fail($"Sách '{book.Title}' không đủ tồn kho (chỉ còn {book.StockQuantity} cuốn).");
                }

                var unitPrice = book.DiscountPrice ?? book.SalePrice;
                var itemTotal = unitPrice * cartItem.Quantity;
                subTotal += itemTotal;

                // BR-15: OrderItem lưu snapshot
                orderItems.Add(new OrderItem
                {
                    Id = Guid.NewGuid(),
                    BookId = book.Id,
                    ProductNameSnapshot = book.Title,
                    UnitPrice = unitPrice,
                    Quantity = cartItem.Quantity,
                    TotalPrice = itemTotal
                });

                // Trừ tồn kho & tăng số lượng đã bán (BR-21, BR-22)
                book.StockQuantity -= cartItem.Quantity;
                book.SoldQuantity += cartItem.Quantity;

                if (book.Inventory != null)
                {
                    book.Inventory.Quantity = book.StockQuantity;
                    book.Inventory.UpdatedAt = DateTime.UtcNow;
                }

                // Ghi nhận lịch sử xuất kho
                _context.InventoryTransactions.Add(new InventoryTransaction
                {
                    Id = Guid.NewGuid(),
                    BookId = book.Id,
                    Type = InventoryTransactionTypeConstants.Export,
                    Quantity = cartItem.Quantity,
                    ReferenceType = "ORDER",
                    Note = $"Xuất kho đơn hàng",
                    CreatedBy = userId,
                    CreatedAt = DateTime.UtcNow
                });
            }

            // 2. Tính mã giảm giá Coupon (nếu có)
            decimal discountAmount = 0;
            Coupon? coupon = null;
            if (!string.IsNullOrWhiteSpace(request.CouponCode))
            {
                var code = request.CouponCode.Trim().ToUpperInvariant();
                coupon = await _context.Coupons.FirstOrDefaultAsync(c => c.Code == code && c.IsActive);
                if (coupon != null && DateTime.UtcNow >= coupon.StartAt && DateTime.UtcNow <= coupon.EndAt)
                {
                    if (coupon.UsageLimit > coupon.UsedCount && subTotal >= coupon.MinimumOrderAmount)
                    {
                        if (coupon.Type == CouponTypeConstants.Percent)
                        {
                            discountAmount = subTotal * (coupon.Value / 100m);
                            if (coupon.MaximumDiscountAmount.HasValue && discountAmount > coupon.MaximumDiscountAmount.Value)
                            {
                                discountAmount = coupon.MaximumDiscountAmount.Value;
                            }
                        }
                        else
                        {
                            discountAmount = coupon.Value;
                        }

                        coupon.UsedCount += 1;
                    }
                }
            }

            decimal shippingFee = subTotal >= 300000 ? 0 : 30000; // Miễn phí vận chuyển từ 300k
            decimal totalAmount = Math.Max(0, subTotal - discountAmount + shippingFee);

            // 3. Tạo Order
            var orderCode = $"ORD-{DateTime.UtcNow:yyyyMMdd}-{Guid.NewGuid().ToString()[..6].ToUpper()}";
            var order = new Order
            {
                Id = Guid.NewGuid(),
                OrderCode = orderCode,
                UserId = userId,
                AddressId = request.AddressId,
                SubTotal = subTotal,
                DiscountAmount = discountAmount,
                ShippingFee = shippingFee,
                TotalAmount = totalAmount,
                PaymentMethod = request.PaymentMethod,
                PaymentStatus = PaymentStatusConstants.Pending,
                OrderStatus = OrderStatusConstants.Pending,
                Note = request.Note,
                CreatedAt = DateTime.UtcNow
            };

            foreach (var item in orderItems)
            {
                item.OrderId = order.Id;
                order.Items.Add(item);
            }

            // Ghi Coupon usage nếu áp dụng
            if (coupon != null && discountAmount > 0)
            {
                order.CouponUsages.Add(new CouponUsage
                {
                    Id = Guid.NewGuid(),
                    CouponId = coupon.Id,
                    UserId = userId,
                    OrderId = order.Id,
                    DiscountAmount = discountAmount,
                    UsedAt = DateTime.UtcNow
                });
            }

            // 4. Tạo thông tin giao hàng (Shipment)
            var receiverName = request.ReceiverName ?? user.FullName;
            var receiverPhone = request.Phone ?? user.Phone ?? string.Empty;
            var fullAddress = $"{request.AddressLine}, {request.Ward}, {request.District}, {request.Province}";
            if (string.IsNullOrWhiteSpace(request.AddressLine) && request.AddressId.HasValue)
            {
                var addr = await _context.Addresses.FindAsync(request.AddressId.Value);
                if (addr != null)
                {
                    receiverName = addr.ReceiverName;
                    receiverPhone = addr.Phone;
                    fullAddress = $"{addr.AddressLine}, {addr.Ward}, {addr.District}, {addr.Province}";
                }
            }

            var shipment = new Shipment
            {
                Id = Guid.NewGuid(),
                OrderId = order.Id,
                ReceiverName = receiverName,
                Phone = receiverPhone,
                Address = fullAddress,
                ShippingFee = shippingFee,
                Status = "PENDING"
            };
            order.Shipment = shipment;

            // 5. Tạo Payment record
            var payment = new Payment
            {
                Id = Guid.NewGuid(),
                OrderId = order.Id,
                PaymentMethod = request.PaymentMethod,
                Amount = totalAmount,
                Status = PaymentStatusConstants.Pending,
                CreatedAt = DateTime.UtcNow
            };
            order.Payments.Add(payment);

            _context.Orders.Add(order);

            // Ghi Notification cho người dùng khi tạo đơn thành công
            _context.Notifications.Add(new Notification
            {
                Id = Guid.NewGuid(),
                UserId = userId,
                Title = $"Đặt hàng thành công {order.OrderCode}",
                Message = $"Đơn hàng của bạn đã được tiếp nhận với tổng tiền {totalAmount:N0}đ.",
                Type = "ORDER",
                CreatedAt = DateTime.UtcNow
            });

            // 6. Xóa giỏ hàng sau khi đặt thành công
            _context.CartItems.RemoveRange(cart.Items);
            cart.UpdatedAt = DateTime.UtcNow;

            await _context.SaveChangesAsync();
            await transaction.CommitAsync();

            return await GetOrderByIdAsync(order.Id, userId);
        }
        catch (Exception ex)
        {
            await transaction.RollbackAsync();
            return ApiResponse<OrderDto>.Fail($"Đặt hàng thất bại: {ex.Message}");
        }
    }

    public async Task<ApiResponse<OrderDto>> GetOrderByIdAsync(Guid orderId, Guid? userId = null, bool isManager = false)
    {
        var query = _context.Orders
            .AsNoTracking()
            .Include(o => o.User)
            .Include(o => o.Items).ThenInclude(i => i.Book)
            .Include(o => o.Shipment)
            .AsQueryable();

        if (!isManager && userId.HasValue)
        {
            query = query.Where(o => o.UserId == userId.Value);
        }

        var order = await query.FirstOrDefaultAsync(o => o.Id == orderId);
        if (order == null)
        {
            return ApiResponse<OrderDto>.Fail("Không tìm thấy đơn hàng.");
        }

        return ApiResponse<OrderDto>.Ok(MapToDto(order));
    }

    public async Task<ApiResponse<PagedResult<OrderDto>>> GetOrdersAsync(OrderFilterDto filter, Guid? userId = null, bool isManager = false)
    {
        var query = _context.Orders
            .AsNoTracking()
            .Include(o => o.User)
            .Include(o => o.Items)
            .Include(o => o.Shipment)
            .AsQueryable();

        if ((!isManager || filter.OnlyMyOrders == true) && userId.HasValue)
        {
            query = query.Where(o => o.UserId == userId.Value);
        }

        if (!string.IsNullOrWhiteSpace(filter.OrderStatus))
        {
            query = query.Where(o => o.OrderStatus == filter.OrderStatus.Trim().ToUpper());
        }

        if (!string.IsNullOrWhiteSpace(filter.PaymentStatus))
        {
            query = query.Where(o => o.PaymentStatus == filter.PaymentStatus.Trim().ToUpper());
        }

        if (!string.IsNullOrWhiteSpace(filter.Keyword))
        {
            var kw = filter.Keyword.Trim().ToLower();
            query = query.Where(o => o.OrderCode.ToLower().Contains(kw) || o.User.FullName.ToLower().Contains(kw));
        }

        var totalCount = await query.CountAsync();
        var page = filter.Page > 0 ? filter.Page : 1;
        var pageSize = filter.PageSize > 0 ? filter.PageSize : 10;

        var orders = await query
            .OrderByDescending(o => o.CreatedAt)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();

        return ApiResponse<PagedResult<OrderDto>>.Ok(new PagedResult<OrderDto>
        {
            Items = orders.Select(MapToDto).ToList(),
            TotalCount = totalCount,
            PageIndex = page,
            PageSize = pageSize
        });
    }

    public async Task<ApiResponse<OrderDto>> UpdateOrderStatusAsync(Guid orderId, UpdateOrderStatusDto request, Guid currentUserId)
    {
        var order = await _context.Orders.Include(o => o.Shipment).FirstOrDefaultAsync(o => o.Id == orderId);
        if (order == null)
        {
            return ApiResponse<OrderDto>.Fail("Không tìm thấy đơn hàng.");
        }

        var newStatus = request.NewStatus.Trim().ToUpper();

        // BR-16: Quy tắc chuyển trạng thái hợp lệ
        // PENDING -> CONFIRMED -> PROCESSING -> SHIPPING -> DELIVERED
        var valid = (order.OrderStatus, newStatus) switch
        {
            (OrderStatusConstants.Pending, OrderStatusConstants.Confirmed) => true,
            (OrderStatusConstants.Confirmed, OrderStatusConstants.Processing) => true,
            (OrderStatusConstants.Processing, OrderStatusConstants.Shipping) => true,
            (OrderStatusConstants.Shipping, OrderStatusConstants.Delivered) => true,
            (OrderStatusConstants.Pending, OrderStatusConstants.Cancelled) => true,
            (OrderStatusConstants.Confirmed, OrderStatusConstants.Cancelled) => true,
            _ => false
        };

        if (!valid)
        {
            return ApiResponse<OrderDto>.Fail($"Không thể chuyển trạng thái đơn hàng từ '{order.OrderStatus}' sang '{newStatus}'.");
        }

        order.OrderStatus = newStatus;
        order.UpdatedAt = DateTime.UtcNow;

        if (newStatus == OrderStatusConstants.Delivered)
        {
            order.PaymentStatus = PaymentStatusConstants.Paid;
            if (order.Shipment != null)
            {
                order.Shipment.Status = "DELIVERED";
                order.Shipment.DeliveredAt = DateTime.UtcNow;
            }
        }
        else if (newStatus == OrderStatusConstants.Shipping && order.Shipment != null)
        {
            order.Shipment.Status = "DELIVERING";
            order.Shipment.ShippedAt = DateTime.UtcNow;
        }

        // Ghi AuditLog
        _context.AuditLogs.Add(new AuditLog
        {
            Id = Guid.NewGuid(),
            UserId = currentUserId,
            Action = "UPDATE_ORDER_STATUS",
            Entity = "Orders",
            EntityId = order.Id.ToString(),
            OldValue = order.OrderStatus,
            NewValue = newStatus,
            CreatedAt = DateTime.UtcNow
        });

        // Tạo thông báo cho khách hàng
        _context.Notifications.Add(new Notification
        {
            Id = Guid.NewGuid(),
            UserId = order.UserId,
            Title = $"Cập nhật đơn hàng {order.OrderCode}",
            Message = $"Đơn hàng của bạn đã chuyển sang trạng thái: {newStatus}",
            Type = "ORDER",
            CreatedAt = DateTime.UtcNow
        });

        await _context.SaveChangesAsync();
        return await GetOrderByIdAsync(orderId, isManager: true);
    }

    public async Task<ApiResponse<bool>> CancelOrderAsync(Guid orderId, Guid userId, CancelOrderDto request, bool isManager = false)
    {
        var order = await _context.Orders
            .Include(o => o.Items).ThenInclude(i => i.Book).ThenInclude(b => b.Inventory)
            .FirstOrDefaultAsync(o => o.Id == orderId);

        if (order == null)
        {
            return ApiResponse<bool>.Fail("Không tìm thấy đơn hàng.");
        }

        if (!isManager && order.UserId != userId)
        {
            return ApiResponse<bool>.Fail("Bạn không có quyền hủy đơn hàng này.");
        }

        // BR-17: Chỉ hủy khi trạng thái cho phép (PENDING, CONFIRMED)
        if (order.OrderStatus != OrderStatusConstants.Pending && order.OrderStatus != OrderStatusConstants.Confirmed)
        {
            return ApiResponse<bool>.Fail($"Đơn hàng đang ở trạng thái '{order.OrderStatus}', không thể hủy.");
        }

        await using var transaction = await _context.Database.BeginTransactionAsync();
        try
        {
            order.OrderStatus = OrderStatusConstants.Cancelled;
            order.UpdatedAt = DateTime.UtcNow;

            // Hoàn lại tồn kho đã trừ
            foreach (var item in order.Items)
            {
                var book = item.Book;
                book.StockQuantity += item.Quantity;
                book.SoldQuantity = Math.Max(0, book.SoldQuantity - item.Quantity);

                if (book.Inventory != null)
                {
                    book.Inventory.Quantity = book.StockQuantity;
                    book.Inventory.UpdatedAt = DateTime.UtcNow;
                }

                _context.InventoryTransactions.Add(new InventoryTransaction
                {
                    Id = Guid.NewGuid(),
                    BookId = book.Id,
                    Type = InventoryTransactionTypeConstants.Return,
                    Quantity = item.Quantity,
                    ReferenceType = "ORDER_CANCELLED",
                    Note = $"Hoàn trả tồn kho do hủy đơn {order.OrderCode}. Lý do: {request.Reason}",
                    CreatedBy = userId,
                    CreatedAt = DateTime.UtcNow
                });
            }

            _context.AuditLogs.Add(new AuditLog
            {
                Id = Guid.NewGuid(),
                UserId = userId,
                Action = "CANCEL_ORDER",
                Entity = "Orders",
                EntityId = order.Id.ToString(),
                OldValue = order.OrderStatus,
                NewValue = OrderStatusConstants.Cancelled,
                CreatedAt = DateTime.UtcNow
            });

            await _context.SaveChangesAsync();
            await transaction.CommitAsync();

            return ApiResponse<bool>.Ok(true, "Hủy đơn hàng thành công và đã hoàn lại tồn kho.");
        }
        catch (Exception ex)
        {
            await transaction.RollbackAsync();
            return ApiResponse<bool>.Fail($"Hủy đơn hàng thất bại: {ex.Message}");
        }
    }

    private static OrderDto MapToDto(Order o)
    {
        return new OrderDto
        {
            Id = o.Id,
            OrderCode = o.OrderCode,
            UserId = o.UserId,
            CustomerName = o.User?.FullName ?? string.Empty,
            CustomerEmail = o.User?.Email ?? string.Empty,
            SubTotal = o.SubTotal,
            DiscountAmount = o.DiscountAmount,
            ShippingFee = o.ShippingFee,
            TotalAmount = o.TotalAmount,
            PaymentMethod = o.PaymentMethod,
            PaymentStatus = o.PaymentStatus,
            OrderStatus = o.OrderStatus,
            Note = o.Note,
            CreatedAt = o.CreatedAt,
            UpdatedAt = o.UpdatedAt,
            Items = o.Items.Select(i => new OrderItemDto
            {
                Id = i.Id,
                BookId = i.BookId,
                ProductNameSnapshot = i.ProductNameSnapshot,
                UnitPrice = i.UnitPrice,
                Quantity = i.Quantity,
                TotalPrice = i.TotalPrice
            }).ToList(),
            Shipment = o.Shipment == null ? null : new ShipmentDto
            {
                ReceiverName = o.Shipment.ReceiverName,
                Phone = o.Shipment.Phone,
                Address = o.Shipment.Address,
                Status = o.Shipment.Status,
                Carrier = o.Shipment.Carrier,
                TrackingCode = o.Shipment.TrackingCode
            }
        };
    }
}
