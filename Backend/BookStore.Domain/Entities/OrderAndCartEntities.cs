namespace BookStore.Domain.Entities;

public class Cart
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid UserId { get; set; }
    public virtual User User { get; set; } = null!;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<CartItem> Items { get; set; } = new List<CartItem>();
}

public class CartItem
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid CartId { get; set; }
    public virtual Cart Cart { get; set; } = null!;

    public Guid BookId { get; set; }
    public virtual Book Book { get; set; } = null!;

    public int Quantity { get; set; } = 1;
    public decimal UnitPrice { get; set; }
}

public class Order
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string OrderCode { get; set; } = string.Empty; // e.g. ORD-20261008-XXXX

    public Guid UserId { get; set; }
    public virtual User User { get; set; } = null!;

    public Guid? AddressId { get; set; }
    public virtual Address? Address { get; set; }

    public decimal SubTotal { get; set; }
    public decimal DiscountAmount { get; set; } = 0;
    public decimal ShippingFee { get; set; } = 0;
    public decimal TotalAmount { get; set; }

    public string PaymentMethod { get; set; } = "COD";
    public string PaymentStatus { get; set; } = "PENDING";
    public string OrderStatus { get; set; } = "PENDING";
    public string? Note { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<OrderItem> Items { get; set; } = new List<OrderItem>();
    public virtual ICollection<Payment> Payments { get; set; } = new List<Payment>();
    public virtual Shipment? Shipment { get; set; }
    public virtual ICollection<CouponUsage> CouponUsages { get; set; } = new List<CouponUsage>();
}

public class OrderItem
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid OrderId { get; set; }
    public virtual Order Order { get; set; } = null!;

    public Guid BookId { get; set; }
    public virtual Book Book { get; set; } = null!;

    // Snapshot at purchase time
    public string ProductNameSnapshot { get; set; } = string.Empty;
    public decimal UnitPrice { get; set; }
    public int Quantity { get; set; }
    public decimal TotalPrice { get; set; }
}

public class Payment
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid OrderId { get; set; }
    public virtual Order Order { get; set; } = null!;

    public string PaymentMethod { get; set; } = "COD";
    public string? TransactionCode { get; set; }
    public decimal Amount { get; set; }
    public string Status { get; set; } = "PENDING"; // PENDING, PAID, FAILED, REFUNDED
    public DateTime? PaidAt { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}

public class Shipment
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid OrderId { get; set; }
    public virtual Order Order { get; set; } = null!;

    public string? Carrier { get; set; }
    public string? TrackingCode { get; set; }
    public string ReceiverName { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public decimal ShippingFee { get; set; } = 0;
    public string Status { get; set; } = "PENDING"; // PENDING, PICKED_UP, DELIVERING, DELIVERED, CANCELLED
    public DateTime? ShippedAt { get; set; }
    public DateTime? DeliveredAt { get; set; }
}
