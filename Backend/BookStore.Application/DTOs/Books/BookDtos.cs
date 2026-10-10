using System.ComponentModel.DataAnnotations;
using BookStore.Domain.Enums;

namespace BookStore.Application.DTOs.Books;

public class BookDto
{
    public Guid Id { get; set; }
    public string ISBN { get; set; } = string.Empty;
    public string Title { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }
    public decimal ImportPrice { get; set; }
    public decimal SalePrice { get; set; }
    public decimal? DiscountPrice { get; set; }
    public int StockQuantity { get; set; }
    public int SoldQuantity { get; set; }

    public Guid? PublisherId { get; set; }
    public string? PublisherName { get; set; }

    public int? PublishedYear { get; set; }
    public int? PageCount { get; set; }
    public string? Language { get; set; }
    public string? Dimensions { get; set; }
    public double? Weight { get; set; }

    public BookStatus Status { get; set; }
    public bool IsDeleted { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }

    public List<AuthorBriefDto> Authors { get; set; } = new();
    public List<CategoryBriefDto> Categories { get; set; } = new();
}

public class BookCreateDto
{
    [Required(ErrorMessage = "ISBN không được để trống")]
    public string ISBN { get; set; } = string.Empty;

    [Required(ErrorMessage = "Tên sách không được để trống")]
    [StringLength(250, MinimumLength = 1)]
    public string Title { get; set; } = string.Empty;

    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }

    [Range(0, 1000000000, ErrorMessage = "Giá nhập không âm")]
    public decimal ImportPrice { get; set; }

    [Range(0, 1000000000, ErrorMessage = "Giá bán không âm")]
    public decimal SalePrice { get; set; }

    [Range(0, 1000000000, ErrorMessage = "Giá khuyến mãi không âm")]
    public decimal? DiscountPrice { get; set; }

    [Range(0, 1000000, ErrorMessage = "Tồn kho không âm")]
    public int StockQuantity { get; set; } = 0;

    public Guid? PublisherId { get; set; }
    public int? PublishedYear { get; set; }
    public int? PageCount { get; set; }
    public string? Language { get; set; }
    public string? Dimensions { get; set; }
    public double? Weight { get; set; }

    public string? AuthorName { get; set; }
    public List<Guid> AuthorIds { get; set; } = new();
    public List<Guid> CategoryIds { get; set; } = new();
}

public class BookUpdateDto
{
    [Required(ErrorMessage = "Tên sách không được để trống")]
    [StringLength(250, MinimumLength = 1)]
    public string Title { get; set; } = string.Empty;

    public string? Description { get; set; }
    public string? CoverImageUrl { get; set; }

    [Range(0, 1000000000, ErrorMessage = "Giá nhập không âm")]
    public decimal ImportPrice { get; set; }

    [Range(0, 1000000000, ErrorMessage = "Giá bán không âm")]
    public decimal SalePrice { get; set; }

    [Range(0, 1000000000, ErrorMessage = "Giá khuyến mãi không âm")]
    public decimal? DiscountPrice { get; set; }

    [Range(0, 1000000, ErrorMessage = "Tồn kho không âm")]
    public int StockQuantity { get; set; }

    public Guid? PublisherId { get; set; }
    public int? PublishedYear { get; set; }
    public int? PageCount { get; set; }
    public string? Language { get; set; }
    public string? Dimensions { get; set; }
    public double? Weight { get; set; }
    public BookStatus Status { get; set; } = BookStatus.Active;

    public string? AuthorName { get; set; }
    public List<Guid> AuthorIds { get; set; } = new();
    public List<Guid> CategoryIds { get; set; } = new();
}

public class BookFilterDto
{
    public string? Keyword { get; set; }
    public Guid? CategoryId { get; set; }
    public Guid? AuthorId { get; set; }
    public Guid? PublisherId { get; set; }
    public decimal? MinPrice { get; set; }
    public decimal? MaxPrice { get; set; }
    public string? Sort { get; set; } // new, price_asc, price_desc, best_seller, title
    public int Page { get; set; } = 1;
    public int PageSize { get; set; } = 12;
}

public class AuthorBriefDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
}

public class CategoryBriefDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
}
