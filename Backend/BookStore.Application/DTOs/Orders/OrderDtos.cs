using System.ComponentModel.DataAnnotations;

namespace BookStore.Application.DTOs.Orders;

public class CreateOrderDto
{
    public Guid? AddressId { get; set; }

    // Thông tin nhận hàng (nếu không chọn sẵn AddressId)
    [StringLength(100)]
    public string? ReceiverName { get; set; }

    [Phone]
    public string? Phone { get; set; }

    public string? Province { get; set; }
    public string? District { get; set; }
    public string? Ward { get; set; }
    public string? AddressLine { get; set; }

    [Required]
    public string PaymentMethod { get; set; } = "COD"; // COD, VNPAY, MOMO

    public string? CouponCode { get; set; }
    public string? Note { get; set; }
}

public class OrderDto
{
    public Guid Id { get; set; }
    public string OrderCode { get; set; } = string.Empty;
    public Guid UserId { get; set; }
    public string CustomerName { get; set; } = string.Empty;
    public string CustomerEmail { get; set; } = string.Empty;

    public decimal SubTotal { get; set; }
    public decimal DiscountAmount { get; set; }
    public decimal ShippingFee { get; set; }
    public decimal TotalAmount { get; set; }

    public string PaymentMethod { get; set; } = string.Empty;
    public string PaymentStatus { get; set; } = string.Empty;
    public string OrderStatus { get; set; } = string.Empty;
    public string? Note { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }

    public List<OrderItemDto> Items { get; set; } = new();
    public ShipmentDto? Shipment { get; set; }
}

public class OrderItemDto
{
    public Guid Id { get; set; }
    public Guid BookId { get; set; }
    public string ProductNameSnapshot { get; set; } = string.Empty;
    public decimal UnitPrice { get; set; }
    public int Quantity { get; set; }
    public decimal TotalPrice { get; set; }
}

public class ShipmentDto
{
    public string ReceiverName { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public string Status { get; set; } = string.Empty;
    public string? Carrier { get; set; }
    public string? TrackingCode { get; set; }
}

public class UpdateOrderStatusDto
{
    [Required(ErrorMessage = "Trạng thái mới không được để trống")]
    public string NewStatus { get; set; } = string.Empty;
    public string? Note { get; set; }
}

public class CancelOrderDto
{
    [Required(ErrorMessage = "Lý do hủy đơn không được để trống")]
    public string Reason { get; set; } = string.Empty;
}

public class OrderFilterDto
{
    public string? OrderStatus { get; set; }
    public string? PaymentStatus { get; set; }
    public string? Keyword { get; set; }
    public DateTime? FromDate { get; set; }
    public DateTime? ToDate { get; set; }
    public int Page { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}
