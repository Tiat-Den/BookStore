using BookStore.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Data;

public class BookStoreDbContext : DbContext
{
    public BookStoreDbContext(DbContextOptions<BookStoreDbContext> options) : base(options)
    {
    }

    public DbSet<User> Users => Set<User>();
    public DbSet<Role> Roles => Set<Role>();
    public DbSet<Permission> Permissions => Set<Permission>();
    public DbSet<UserRole> UserRoles => Set<UserRole>();
    public DbSet<RolePermission> RolePermissions => Set<RolePermission>();
    public DbSet<Address> Addresses => Set<Address>();
    public DbSet<Category> Categories => Set<Category>();
    public DbSet<Author> Authors => Set<Author>();
    public DbSet<Publisher> Publishers => Set<Publisher>();
    public DbSet<Book> Books => Set<Book>();
    public DbSet<BookAuthor> BookAuthors => Set<BookAuthor>();
    public DbSet<BookCategory> BookCategories => Set<BookCategory>();
    public DbSet<Cart> Carts => Set<Cart>();
    public DbSet<CartItem> CartItems => Set<CartItem>();
    public DbSet<Order> Orders => Set<Order>();
    public DbSet<OrderItem> OrderItems => Set<OrderItem>();
    public DbSet<Payment> Payments => Set<Payment>();
    public DbSet<Shipment> Shipments => Set<Shipment>();
    public DbSet<Inventory> Inventories => Set<Inventory>();
    public DbSet<InventoryTransaction> InventoryTransactions => Set<InventoryTransaction>();
    public DbSet<Coupon> Coupons => Set<Coupon>();
    public DbSet<CouponUsage> CouponUsages => Set<CouponUsage>();
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<Wishlist> Wishlists => Set<Wishlist>();
    public DbSet<WishlistItem> WishlistItems => Set<WishlistItem>();
    public DbSet<Notification> Notifications => Set<Notification>();
    public DbSet<AuditLog> AuditLogs => Set<AuditLog>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // User
        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.Email).IsUnique();
            entity.Property(e => e.FullName).HasMaxLength(150).IsRequired();
            entity.Property(e => e.Email).HasMaxLength(150).IsRequired();
            entity.Property(e => e.Phone).HasMaxLength(20);
            entity.Property(e => e.PasswordHash).IsRequired();
        });

        // Role & Permission
        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.Name).IsUnique();
            entity.Property(e => e.Name).HasMaxLength(50).IsRequired();
        });

        modelBuilder.Entity<Permission>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.Code).IsUnique();
            entity.Property(e => e.Code).HasMaxLength(100).IsRequired();
            entity.Property(e => e.Name).HasMaxLength(150).IsRequired();
        });

        modelBuilder.Entity<UserRole>(entity =>
        {
            entity.HasKey(e => new { e.UserId, e.RoleId });
            entity.HasOne(e => e.User).WithMany(u => u.UserRoles).HasForeignKey(e => e.UserId);
            entity.HasOne(e => e.Role).WithMany(r => r.UserRoles).HasForeignKey(e => e.RoleId);
        });

        modelBuilder.Entity<RolePermission>(entity =>
        {
            entity.HasKey(e => new { e.RoleId, e.PermissionId });
            entity.HasOne(e => e.Role).WithMany(r => r.RolePermissions).HasForeignKey(e => e.RoleId);
            entity.HasOne(e => e.Permission).WithMany(p => p.RolePermissions).HasForeignKey(e => e.PermissionId);
        });

        // Address
        modelBuilder.Entity<Address>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasOne(e => e.User).WithMany(u => u.Addresses).HasForeignKey(e => e.UserId).OnDelete(DeleteBehavior.Cascade);
            entity.Property(e => e.ReceiverName).HasMaxLength(100).IsRequired();
            entity.Property(e => e.Phone).HasMaxLength(20).IsRequired();
        });

        // Category
        modelBuilder.Entity<Category>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.Slug).IsUnique();
            entity.Property(e => e.Name).HasMaxLength(150).IsRequired();
            entity.Property(e => e.Slug).HasMaxLength(150).IsRequired();
            entity.HasOne(e => e.Parent).WithMany(c => c.SubCategories).HasForeignKey(e => e.ParentId).OnDelete(DeleteBehavior.Restrict);
        });

        // Author & Publisher
        modelBuilder.Entity<Author>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).HasMaxLength(150).IsRequired();
        });

        modelBuilder.Entity<Publisher>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).HasMaxLength(150).IsRequired();
        });

        // Book
        modelBuilder.Entity<Book>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.ISBN).IsUnique();
            entity.HasIndex(e => e.Slug).IsUnique();
            entity.Property(e => e.Title).HasMaxLength(250).IsRequired();
            entity.Property(e => e.ISBN).HasMaxLength(50).IsRequired();
            entity.Property(e => e.Slug).HasMaxLength(250).IsRequired();

            entity.Property(e => e.ImportPrice).HasPrecision(18, 2);
            entity.Property(e => e.SalePrice).HasPrecision(18, 2);
            entity.Property(e => e.DiscountPrice).HasPrecision(18, 2);

            entity.HasOne(e => e.Publisher).WithMany(p => p.Books).HasForeignKey(e => e.PublisherId).OnDelete(DeleteBehavior.SetNull);
        });

        // BookAuthor (Many-to-Many)
        modelBuilder.Entity<BookAuthor>(entity =>
        {
            entity.HasKey(e => new { e.BookId, e.AuthorId });
            entity.HasOne(e => e.Book).WithMany(b => b.BookAuthors).HasForeignKey(e => e.BookId);
            entity.HasOne(e => e.Author).WithMany(a => a.BookAuthors).HasForeignKey(e => e.AuthorId);
        });

        // BookCategory (Many-to-Many)
        modelBuilder.Entity<BookCategory>(entity =>
        {
            entity.HasKey(e => new { e.BookId, e.CategoryId });
            entity.HasOne(e => e.Book).WithMany(b => b.BookCategories).HasForeignKey(e => e.BookId);
            entity.HasOne(e => e.Category).WithMany(c => c.BookCategories).HasForeignKey(e => e.CategoryId);
        });

        // Cart & CartItem
        modelBuilder.Entity<Cart>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.UserId).IsUnique();
            entity.HasOne(e => e.User).WithOne(u => u.Cart).HasForeignKey<Cart>(e => e.UserId).OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<CartItem>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => new { e.CartId, e.BookId }).IsUnique();
            entity.Property(e => e.UnitPrice).HasPrecision(18, 2);

            entity.HasOne(e => e.Cart).WithMany(c => c.Items).HasForeignKey(e => e.CartId).OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(e => e.Book).WithMany(b => b.CartItems).HasForeignKey(e => e.BookId).OnDelete(DeleteBehavior.Cascade);
        });

        // Order & OrderItem
        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.OrderCode).IsUnique();
            entity.HasIndex(e => new { e.UserId, e.CreatedAt });
            entity.HasIndex(e => e.OrderStatus);

            entity.Property(e => e.OrderCode).HasMaxLength(50).IsRequired();
            entity.Property(e => e.SubTotal).HasPrecision(18, 2);
            entity.Property(e => e.DiscountAmount).HasPrecision(18, 2);
            entity.Property(e => e.ShippingFee).HasPrecision(18, 2);
            entity.Property(e => e.TotalAmount).HasPrecision(18, 2);

            entity.HasOne(e => e.User).WithMany(u => u.Orders).HasForeignKey(e => e.UserId).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne(e => e.Address).WithMany().HasForeignKey(e => e.AddressId).OnDelete(DeleteBehavior.SetNull);
        });

        modelBuilder.Entity<OrderItem>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.ProductNameSnapshot).HasMaxLength(250).IsRequired();
            entity.Property(e => e.UnitPrice).HasPrecision(18, 2);
            entity.Property(e => e.TotalPrice).HasPrecision(18, 2);

            entity.HasOne(e => e.Order).WithMany(o => o.Items).HasForeignKey(e => e.OrderId).OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(e => e.Book).WithMany(b => b.OrderItems).HasForeignKey(e => e.BookId).OnDelete(DeleteBehavior.Restrict);
        });

        // Payment
        modelBuilder.Entity<Payment>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Amount).HasPrecision(18, 2);
            entity.HasOne(e => e.Order).WithMany(o => o.Payments).HasForeignKey(e => e.OrderId).OnDelete(DeleteBehavior.Cascade);
        });

        // Shipment
        modelBuilder.Entity<Shipment>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.OrderId).IsUnique();
            entity.Property(e => e.ShippingFee).HasPrecision(18, 2);
            entity.HasOne(e => e.Order).WithOne(o => o.Shipment).HasForeignKey<Shipment>(e => e.OrderId).OnDelete(DeleteBehavior.Cascade);
        });

        // Inventory
        modelBuilder.Entity<Inventory>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.BookId).IsUnique();
            entity.HasOne(e => e.Book).WithOne(b => b.Inventory).HasForeignKey<Inventory>(e => e.BookId).OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<InventoryTransaction>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasOne(e => e.Book).WithMany(b => b.InventoryTransactions).HasForeignKey(e => e.BookId).OnDelete(DeleteBehavior.Cascade);
        });

        // Coupon & CouponUsage
        modelBuilder.Entity<Coupon>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.Code).IsUnique();
            entity.Property(e => e.Code).HasMaxLength(50).IsRequired();
            entity.Property(e => e.Value).HasPrecision(18, 2);
            entity.Property(e => e.MinimumOrderAmount).HasPrecision(18, 2);
            entity.Property(e => e.MaximumDiscountAmount).HasPrecision(18, 2);
        });

        modelBuilder.Entity<CouponUsage>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.DiscountAmount).HasPrecision(18, 2);
            entity.HasOne(e => e.Coupon).WithMany(c => c.Usages).HasForeignKey(e => e.CouponId).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne(e => e.User).WithMany().HasForeignKey(e => e.UserId).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne(e => e.Order).WithMany(o => o.CouponUsages).HasForeignKey(e => e.OrderId).OnDelete(DeleteBehavior.Cascade);
        });

        // Review
        modelBuilder.Entity<Review>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.BookId);
            entity.HasOne(e => e.User).WithMany(u => u.Reviews).HasForeignKey(e => e.UserId).OnDelete(DeleteBehavior.Restrict);
            entity.HasOne(e => e.Book).WithMany(b => b.Reviews).HasForeignKey(e => e.BookId).OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(e => e.Order).WithMany().HasForeignKey(e => e.OrderId).OnDelete(DeleteBehavior.SetNull);
        });

        // Wishlist & WishlistItem
        modelBuilder.Entity<Wishlist>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => e.UserId).IsUnique();
            entity.HasOne(e => e.User).WithOne(u => u.Wishlist).HasForeignKey<Wishlist>(e => e.UserId).OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<WishlistItem>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasIndex(e => new { e.WishlistId, e.BookId }).IsUnique();
            entity.HasOne(e => e.Wishlist).WithMany(w => w.Items).HasForeignKey(e => e.WishlistId).OnDelete(DeleteBehavior.Cascade);
            entity.HasOne(e => e.Book).WithMany(b => b.WishlistItems).HasForeignKey(e => e.BookId).OnDelete(DeleteBehavior.Cascade);
        });

        // Notification & AuditLog
        modelBuilder.Entity<Notification>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasOne(e => e.User).WithMany(u => u.Notifications).HasForeignKey(e => e.UserId).OnDelete(DeleteBehavior.Cascade);
        });

        modelBuilder.Entity<AuditLog>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.HasOne(e => e.User).WithMany(u => u.AuditLogs).HasForeignKey(e => e.UserId).OnDelete(DeleteBehavior.SetNull);
        });
    }
}
