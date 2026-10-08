using System.ComponentModel.DataAnnotations;

namespace BookStore.Application.DTOs.Orders;

public class CartDto
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public List<CartItemDto> Items { get; set; } = new();
    public int TotalItems => Items.Sum(i => i.Quantity);
    public decimal SubTotal => Items.Sum(i => i.TotalPrice);
}

public class CartItemDto
{
    public Guid Id { get; set; }
    public Guid BookId { get; set; }
    public string BookTitle { get; set; } = string.Empty;
    public string BookSlug { get; set; } = string.Empty;
    public string? CoverImageUrl { get; set; }
    public decimal UnitPrice { get; set; }
    public int Quantity { get; set; }
    public decimal TotalPrice => UnitPrice * Quantity;
    public int AvailableStock { get; set; }
    public bool IsInStock => AvailableStock >= Quantity;
}

public class AddToCartDto
{
    [Required(ErrorMessage = "Mã sách không được để trống")]
    public Guid BookId { get; set; }

    [Range(1, 100, ErrorMessage = "Số lượng phải từ 1 đến 100")]
    public int Quantity { get; set; } = 1;
}

public class UpdateCartItemDto
{
    [Range(1, 100, ErrorMessage = "Số lượng phải từ 1 đến 100")]
    public int Quantity { get; set; }
}
