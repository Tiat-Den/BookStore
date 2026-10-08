using System.ComponentModel.DataAnnotations;

namespace BookStore.Application.DTOs.Marketing;

public class ReviewDto
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string UserName { get; set; } = string.Empty;
    public Guid BookId { get; set; }
    public int Rating { get; set; } // 1 - 5
    public string Content { get; set; } = string.Empty;
    public string Status { get; set; } = "APPROVED";
    public DateTime CreatedAt { get; set; }
}

public class CreateReviewDto
{
    [Required]
    public Guid BookId { get; set; }

    [Range(1, 5, ErrorMessage = "Đánh giá sao phải từ 1 đến 5")]
    public int Rating { get; set; } = 5;

    [Required(ErrorMessage = "Nội dung nhận xét không được để trống")]
    [StringLength(1000, MinimumLength = 5, ErrorMessage = "Nhận xét từ 5 đến 1000 ký tự")]
    public string Content { get; set; } = string.Empty;
}

public class WishlistDto
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public List<WishlistItemDto> Items { get; set; } = new();
}

public class WishlistItemDto
{
    public Guid Id { get; set; }
    public Guid BookId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string? CoverImageUrl { get; set; }
    public decimal SalePrice { get; set; }
    public decimal? DiscountPrice { get; set; }
    public int StockQuantity { get; set; }
    public DateTime AddedAt { get; set; }
}

public class CouponDto
{
    public Guid Id { get; set; }
    public string Code { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Type { get; set; } = "PERCENT"; // PERCENT, FIXED_AMOUNT
    public decimal Value { get; set; }
    public decimal MinimumOrderAmount { get; set; }
    public decimal? MaximumDiscountAmount { get; set; }
    public int UsageLimit { get; set; }
    public int UsedCount { get; set; }
    public DateTime StartAt { get; set; }
    public DateTime EndAt { get; set; }
    public bool IsActive { get; set; }
}

public class CreateCouponDto
{
    [Required(ErrorMessage = "Mã giảm giá không được để trống")]
    [StringLength(50, MinimumLength = 3)]
    public string Code { get; set; } = string.Empty;

    [Required(ErrorMessage = "Tên chương trình không được để trống")]
    public string Name { get; set; } = string.Empty;

    [Required]
    public string Type { get; set; } = "PERCENT"; // PERCENT, FIXED_AMOUNT

    [Range(0, 1000000000, ErrorMessage = "Giá trị giảm không âm")]
    public decimal Value { get; set; }

    public decimal MinimumOrderAmount { get; set; } = 0;
    public decimal? MaximumDiscountAmount { get; set; }
    public int UsageLimit { get; set; } = 100;
    public DateTime StartAt { get; set; } = DateTime.UtcNow;
    public DateTime EndAt { get; set; } = DateTime.UtcNow.AddMonths(1);
}

public class ValidateCouponRequestDto
{
    [Required]
    public string Code { get; set; } = string.Empty;

    [Range(0, 1000000000)]
    public decimal OrderAmount { get; set; }
}

public class CouponValidationResultDto
{
    public bool IsValid { get; set; }
    public string Message { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public decimal DiscountAmount { get; set; }
}
