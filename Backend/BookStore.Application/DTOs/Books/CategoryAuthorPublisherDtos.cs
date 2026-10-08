using System.ComponentModel.DataAnnotations;

namespace BookStore.Application.DTOs.Books;

public class CategoryDto
{
    public Guid Id { get; set; }
    public Guid? ParentId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string? Description { get; set; }
    public bool IsActive { get; set; }
    public int BookCount { get; set; }
    public List<CategoryDto> SubCategories { get; set; } = new();
}

public class CategoryCreateUpdateDto
{
    [Required(ErrorMessage = "Tên danh mục không được để trống")]
    [StringLength(150, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    public Guid? ParentId { get; set; }
    public string? Description { get; set; }
    public bool IsActive { get; set; } = true;
}

public class AuthorDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Biography { get; set; }
    public string? ImageUrl { get; set; }
    public string? Nationality { get; set; }
    public bool IsActive { get; set; }
    public int BookCount { get; set; }
}

public class AuthorCreateUpdateDto
{
    [Required(ErrorMessage = "Tên tác giả không được để trống")]
    [StringLength(150, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    public string? Biography { get; set; }
    public string? ImageUrl { get; set; }
    public string? Nationality { get; set; }
    public bool IsActive { get; set; } = true;
}

public class PublisherDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Address { get; set; }
    public string? Email { get; set; }
    public string? Phone { get; set; }
    public string? Website { get; set; }
    public bool IsActive { get; set; }
    public int BookCount { get; set; }
}

public class PublisherCreateUpdateDto
{
    [Required(ErrorMessage = "Tên nhà xuất bản không được để trống")]
    [StringLength(150, MinimumLength = 1)]
    public string Name { get; set; } = string.Empty;

    public string? Address { get; set; }
    public string? Email { get; set; }
    public string? Phone { get; set; }
    public string? Website { get; set; }
    public bool IsActive { get; set; } = true;
}
