using BookStore.Application.Common;
using BookStore.Domain.Enums;
using BookStore.Application.DTOs.Reports;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class ReportService : IReportService
{
    private readonly BookStoreDbContext _context;

    public ReportService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<DashboardStatsDto>> GetDashboardStatsAsync()
    {
        try
        {
            // BR-35: Tính từ đơn hàng có PaymentStatus = PAID và OrderStatus != CANCELLED
            var paidOrdersQuery = _context.Orders
                .Where(o => o.PaymentStatus == PaymentStatusConstants.Paid && o.OrderStatus != OrderStatusConstants.Cancelled);

            var totalRevenue = await paidOrdersQuery.SumAsync(o => (decimal?)o.TotalAmount) ?? 0m;
            var totalOrders = await _context.Orders.CountAsync();
            var totalBooks = await _context.Books.CountAsync(b => b.Status == BookStatus.Active && !b.IsDeleted);
            
            // Số lượng khách hàng (User có vai trò CUSTOMER hoặc tổng số user ngoại trừ ADMIN)
            var totalCustomers = await _context.Users.CountAsync();

            // Thống kê đơn hàng theo trạng thái
            var orderStatusCounts = await _context.Orders
                .GroupBy(o => o.OrderStatus)
                .Select(g => new OrderStatusCountDto
                {
                    Status = g.Key,
                    Count = g.Count()
                })
                .ToListAsync();

            // Doanh thu 6 tháng gần nhất
            var revenueByMonth = await GetMonthlyRevenueInternalAsync(6);

            // Top 5 sách bán chạy nhất
            var topSelling = await GetTopSellingInternalAsync(5);

            // Đơn hàng gần nhất (5 đơn)
            var recentOrders = await _context.Orders
                .Include(o => o.User)
                .OrderByDescending(o => o.CreatedAt)
                .Take(5)
                .Select(o => new RecentOrderDto
                {
                    Id = o.Id,
                    OrderCode = o.OrderCode,
                    CustomerName = o.User.FullName,
                    TotalAmount = o.TotalAmount,
                    PaymentMethod = o.PaymentMethod,
                    PaymentStatus = o.PaymentStatus,
                    OrderStatus = o.OrderStatus,
                    CreatedAt = o.CreatedAt
                })
                .ToListAsync();

            var stats = new DashboardStatsDto
            {
                TotalRevenue = totalRevenue,
                TotalOrders = totalOrders,
                TotalBooks = totalBooks,
                TotalCustomers = totalCustomers,
                OrderStatusCounts = orderStatusCounts,
                RevenueByMonth = revenueByMonth,
                TopSellingBooks = topSelling,
                RecentOrders = recentOrders
            };

            return ApiResponse<DashboardStatsDto>.Ok(stats);
        }
        catch (Exception ex)
        {
            return ApiResponse<DashboardStatsDto>.Fail($"Lỗi khi lấy báo cáo thống kê: {ex.Message}");
        }
    }

    public async Task<ApiResponse<List<MonthlyRevenueDto>>> GetRevenueByMonthsAsync(int months = 6)
    {
        var result = await GetMonthlyRevenueInternalAsync(months);
        return ApiResponse<List<MonthlyRevenueDto>>.Ok(result);
    }

    public async Task<ApiResponse<List<TopSellingBookDto>>> GetTopSellingBooksAsync(int limit = 5)
    {
        var result = await GetTopSellingInternalAsync(limit);
        return ApiResponse<List<TopSellingBookDto>>.Ok(result);
    }

    private async Task<List<MonthlyRevenueDto>> GetMonthlyRevenueInternalAsync(int months)
    {
        var startDate = DateTime.UtcNow.AddMonths(-months + 1);
        startDate = new DateTime(startDate.Year, startDate.Month, 1);

        var orders = await _context.Orders
            .Where(o => o.CreatedAt >= startDate &&
                        o.PaymentStatus == PaymentStatusConstants.Paid &&
                        o.OrderStatus != OrderStatusConstants.Cancelled)
            .Select(o => new { o.CreatedAt, o.TotalAmount })
            .ToListAsync();

        var result = new List<MonthlyRevenueDto>();
        for (int i = 0; i < months; i++)
        {
            var targetMonth = startDate.AddMonths(i);
            var monthStr = targetMonth.ToString("MM/yyyy");

            var monthlyOrders = orders
                .Where(o => o.CreatedAt.Year == targetMonth.Year && o.CreatedAt.Month == targetMonth.Month)
                .ToList();

            result.Add(new MonthlyRevenueDto
            {
                Month = monthStr,
                Revenue = monthlyOrders.Sum(o => o.TotalAmount),
                OrderCount = monthlyOrders.Count
            });
        }

        return result;
    }

    private async Task<List<TopSellingBookDto>> GetTopSellingInternalAsync(int limit)
    {
        // Nhóm từ OrderItems của các đơn hàng không bị hủy
        var topBooks = await _context.OrderItems
            .Include(oi => oi.Book)
            .Where(oi => oi.Order.OrderStatus != OrderStatusConstants.Cancelled)
            .GroupBy(oi => new { oi.BookId, oi.ProductNameSnapshot, oi.Book.CoverImageUrl })
            .Select(g => new TopSellingBookDto
            {
                BookId = g.Key.BookId,
                Title = g.Key.ProductNameSnapshot,
                ImageUrl = g.Key.CoverImageUrl,
                QuantitySold = g.Sum(x => x.Quantity),
                TotalRevenue = g.Sum(x => x.TotalPrice)
            })
            .OrderByDescending(x => x.QuantitySold)
            .Take(limit)
            .ToListAsync();

        return topBooks;
    }
}

public class PaymentService : IPaymentService
{
    private readonly BookStoreDbContext _context;

    public PaymentService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<string>> CreateVNPayPaymentUrlAsync(Guid orderId, string ipAddress)
    {
        var order = await _context.Orders.FindAsync(orderId);
        if (order == null)
            return ApiResponse<string>.Fail("Không tìm thấy đơn hàng cần thanh toán.");

        if (order.PaymentStatus == PaymentStatusConstants.Paid)
            return ApiResponse<string>.Fail("Đơn hàng này đã được thanh toán trước đó.");

        // Tạo Mock Gateway URL hoặc Sandbox URL
        var mockPaymentUrl = $"/checkout/mock-vnpay?orderId={order.Id}&orderCode={order.OrderCode}&amount={order.TotalAmount}";
        return ApiResponse<string>.Ok(mockPaymentUrl, "Tạo URL thanh toán thành công.");
    }

    public async Task<ApiResponse<bool>> ProcessPaymentResultAsync(ProcessPaymentDto request)
    {
        var order = await _context.Orders
            .Include(o => o.Payments)
            .FirstOrDefaultAsync(o => o.Id == request.OrderId);

        if (order == null)
            return ApiResponse<bool>.Fail("Không tìm thấy đơn hàng.");

        if (order.PaymentStatus == PaymentStatusConstants.Paid)
            return ApiResponse<bool>.Ok(true, "Đơn hàng đã được thanh toán trước đó.");

        if (request.IsSuccess)
        {
            order.PaymentStatus = PaymentStatusConstants.Paid;
            if (order.OrderStatus == OrderStatusConstants.Pending)
            {
                order.OrderStatus = OrderStatusConstants.Confirmed;
            }

            var transactionCode = $"VNP_{DateTime.UtcNow:yyyyMMddHHmmss}_{new Random().Next(1000, 9999)}";

            var payment = order.Payments.OrderByDescending(p => p.CreatedAt).FirstOrDefault();
            if (payment != null)
            {
                payment.Status = PaymentStatusConstants.Paid;
                payment.TransactionCode = transactionCode;
                payment.PaidAt = DateTime.UtcNow;
            }
            else
            {
                order.Payments.Add(new Payment
                {
                    Id = Guid.NewGuid(),
                    OrderId = order.Id,
                    PaymentMethod = request.PaymentMethod,
                    Amount = order.TotalAmount,
                    TransactionCode = transactionCode,
                    Status = PaymentStatusConstants.Paid,
                    PaidAt = DateTime.UtcNow,
                    CreatedAt = DateTime.UtcNow
                });
            }

            await _context.SaveChangesAsync();
            return ApiResponse<bool>.Ok(true, $"Thanh toán đơn hàng {order.OrderCode} thành công qua {request.PaymentMethod}.");
        }
        else
        {
            var payment = order.Payments.OrderByDescending(p => p.CreatedAt).FirstOrDefault();
            if (payment != null)
            {
                payment.Status = "FAILED";
            }
            await _context.SaveChangesAsync();
            return ApiResponse<bool>.Fail("Giao dịch thanh toán thất bại hoặc người dùng đã hủy.");
        }
    }
}
