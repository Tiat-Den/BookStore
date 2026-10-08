using BookStore.Domain.Enums;

namespace BookStore.Domain.Entities;

public class User
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public string PasswordHash { get; set; } = string.Empty;
    public UserStatus Status { get; set; } = UserStatus.Active;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }

    // Navigation
    public virtual ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>();
    public virtual ICollection<Address> Addresses { get; set; } = new List<Address>();
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();
    public virtual Cart? Cart { get; set; }
    public virtual Wishlist? Wishlist { get; set; }
    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();
    public virtual ICollection<Notification> Notifications { get; set; } = new List<Notification>();
    public virtual ICollection<AuditLog> AuditLogs { get; set; } = new List<AuditLog>();
}

public class Role
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Name { get; set; } = string.Empty; // ADMIN, EMPLOYEE, CUSTOMER
    public string? Description { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    // Navigation
    public virtual ICollection<UserRole> UserRoles { get; set; } = new List<UserRole>();
    public virtual ICollection<RolePermission> RolePermissions { get; set; } = new List<RolePermission>();
}

public class Permission
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Code { get; set; } = string.Empty; // PRODUCT_VIEW, PRODUCT_CREATE, etc.
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }

    // Navigation
    public virtual ICollection<RolePermission> RolePermissions { get; set; } = new List<RolePermission>();
}

public class UserRole
{
    public Guid UserId { get; set; }
    public virtual User User { get; set; } = null!;

    public Guid RoleId { get; set; }
    public virtual Role Role { get; set; } = null!;
}

public class RolePermission
{
    public Guid RoleId { get; set; }
    public virtual Role Role { get; set; } = null!;

    public Guid PermissionId { get; set; }
    public virtual Permission Permission { get; set; } = null!;
}

public class Address
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid UserId { get; set; }
    public virtual User User { get; set; } = null!;

    public string ReceiverName { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string Province { get; set; } = string.Empty;
    public string District { get; set; } = string.Empty;
    public string Ward { get; set; } = string.Empty;
    public string AddressLine { get; set; } = string.Empty;
    public bool IsDefault { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
