namespace BookStore.Domain.Entities;

public class Inventory
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid BookId { get; set; }
    public virtual Book Book { get; set; } = null!;

    public int Quantity { get; set; } = 0;
    public int ReservedQuantity { get; set; } = 0;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
}

public class InventoryTransaction
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid BookId { get; set; }
    public virtual Book Book { get; set; } = null!;

    public string Type { get; set; } = "IMPORT"; // IMPORT, EXPORT, ADJUSTMENT, RETURN
    public int Quantity { get; set; }
    public string? ReferenceType { get; set; } // ORDER, MANUAL, RETURN
    public Guid? ReferenceId { get; set; }
    public string? Note { get; set; }
    public Guid? CreatedBy { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}

public class Coupon
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Type { get; set; } = "PERCENT"; // PERCENT, FIXED_AMOUNT
    public decimal Value { get; set; }
    public decimal MinimumOrderAmount { get; set; } = 0;
    public decimal? MaximumDiscountAmount { get; set; }
    public int UsageLimit { get; set; } = 100;
    public int UsedCount { get; set; } = 0;
    public DateTime StartAt { get; set; }
    public DateTime EndAt { get; set; }
    public bool IsActive { get; set; } = true;

    public virtual ICollection<CouponUsage> Usages { get; set; } = new List<CouponUsage>();
}

public class CouponUsage
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid CouponId { get; set; }
    public virtual Coupon Coupon { get; set; } = null!;

    public Guid UserId { get; set; }
    public virtual User User { get; set; } = null!;

    public Guid OrderId { get; set; }
    public virtual Order Order { get; set; } = null!;

    public decimal DiscountAmount { get; set; }
    public DateTime UsedAt { get; set; } = DateTime.UtcNow;
}

public class Review
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid UserId { get; set; }
    public virtual User User { get; set; } = null!;

    public Guid BookId { get; set; }
    public virtual Book Book { get; set; } = null!;

    public Guid? OrderId { get; set; }
    public virtual Order? Order { get; set; }

    public int Rating { get; set; } = 5; // 1 - 5
    public string Content { get; set; } = string.Empty;
    public string Status { get; set; } = "APPROVED"; // PENDING, APPROVED, HIDDEN
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
}

public class Wishlist
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid UserId { get; set; }
    public virtual User User { get; set; } = null!;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    public virtual ICollection<WishlistItem> Items { get; set; } = new List<WishlistItem>();
}

public class WishlistItem
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid WishlistId { get; set; }
    public virtual Wishlist Wishlist { get; set; } = null!;

    public Guid BookId { get; set; }
    public virtual Book Book { get; set; } = null!;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}

public class Notification
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid UserId { get; set; }
    public virtual User User { get; set; } = null!;

    public string Title { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public string Type { get; set; } = "SYSTEM";
    public bool IsRead { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}

public class AuditLog
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid? UserId { get; set; }
    public virtual User? User { get; set; }

    public string Action { get; set; } = string.Empty; // LOGIN, CREATE, UPDATE, DELETE, etc.
    public string Entity { get; set; } = string.Empty;
    public string? EntityId { get; set; }
    public string? OldValue { get; set; }
    public string? NewValue { get; set; }
    public string? IpAddress { get; set; }
    public string? UserAgent { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
