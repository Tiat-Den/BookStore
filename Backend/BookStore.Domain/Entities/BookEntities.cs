using BookStore.Domain.Enums;

namespace BookStore.Domain.Entities;

public class Category
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid? ParentId { get; set; }
    public virtual Category? Parent { get; set; }
    public virtual ICollection<Category> SubCategories { get; set; } = new List<Category>();

    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string? Description { get; set; }
    public bool IsActive { get; set; } = true;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }

    public virtual ICollection<BookCategory> BookCategories { get; set; } = new List<BookCategory>();
}

public class Author
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Name { get; set; } = string.Empty;
    public string? Biography { get; set; }
    public string? ImageUrl { get; set; }
    public string? Nationality { get; set; }
    public bool IsActive { get; set; } = true;

    public virtual ICollection<BookAuthor> BookAuthors { get; set; } = new List<BookAuthor>();
}

public class Publisher
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string Name { get; set; } = string.Empty;
    public string? Address { get; set; }
    public string? Email { get; set; }
    public string? Phone { get; set; }
    public string? Website { get; set; }
    public bool IsActive { get; set; } = true;

    public virtual ICollection<Book> Books { get; set; } = new List<Book>();
}

public class Book
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public string ISBN { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }
    public decimal ImportPrice { get; set; }
    public decimal SalePrice { get; set; }
    public decimal? DiscountPrice { get; set; }
    public int StockQuantity { get; set; } = 0;
    public int SoldQuantity { get; set; } = 0;

    public Guid? PublisherId { get; set; }
    public virtual Publisher? Publisher { get; set; }

    public int? PublishedYear { get; set; }
    public int? PageCount { get; set; }
    public string? Language { get; set; }
    public string? Dimensions { get; set; }
    public double? Weight { get; set; }

    public BookStatus Status { get; set; } = BookStatus.Active;
    public bool IsDeleted { get; set; } = false;
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }

    // Navigation
    public virtual ICollection<BookAuthor> BookAuthors { get; set; } = new List<BookAuthor>();
    public virtual ICollection<BookCategory> BookCategories { get; set; } = new List<BookCategory>();
    public virtual ICollection<CartItem> CartItems { get; set; } = new List<CartItem>();
    public virtual ICollection<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
    public virtual Inventory? Inventory { get; set; }
    public virtual ICollection<InventoryTransaction> InventoryTransactions { get; set; } = new List<InventoryTransaction>();
    public virtual ICollection<Review> Reviews { get; set; } = new List<Review>();
    public virtual ICollection<WishlistItem> WishlistItems { get; set; } = new List<WishlistItem>();
}

public class BookAuthor
{
    public Guid BookId { get; set; }
    public virtual Book Book { get; set; } = null!;

    public Guid AuthorId { get; set; }
    public virtual Author Author { get; set; } = null!;
}

public class BookCategory
{
    public Guid BookId { get; set; }
    public virtual Book Book { get; set; } = null!;

    public Guid CategoryId { get; set; }
    public virtual Category Category { get; set; } = null!;
}
