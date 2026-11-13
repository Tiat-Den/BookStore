using BookStore.Application.Common;
using BookStore.Application.DTOs.Marketing;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using BookStore.Domain.Enums;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class ReviewService : IReviewService
{
    private readonly BookStoreDbContext _context;

    public ReviewService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<List<ReviewDto>>> GetBookReviewsAsync(Guid bookId)
    {
        var reviews = await _context.Reviews
            .AsNoTracking()
            .Include(r => r.User)
            .Where(r => r.BookId == bookId && r.Status == "APPROVED")
            .OrderByDescending(r => r.CreatedAt)
            .Select(r => new ReviewDto
            {
                Id = r.Id,
                UserId = r.UserId,
                UserName = r.User.FullName,
                BookId = r.BookId,
                Rating = r.Rating,
                Content = r.Content,
                Status = r.Status,
                CreatedAt = r.CreatedAt
            })
            .ToListAsync();

        return ApiResponse<List<ReviewDto>>.Ok(reviews);
    }

    public async Task<ApiResponse<ReviewDto>> CreateReviewAsync(Guid userId, CreateReviewDto request)
    {
        // BR-28: Rating 1 - 5
        if (request.Rating < 1 || request.Rating > 5)
        {
            return ApiResponse<ReviewDto>.Fail("Đánh giá sao phải từ 1 đến 5 sao.");
        }

        // BR-29: Chỉ khách hàng đã mua và nhận sách thành công mới được đánh giá
        var hasPurchased = await _context.Orders
            .Where(o => o.UserId == userId && (o.OrderStatus == OrderStatusConstants.Delivered || o.OrderStatus == "DELIVERED"))
            .AnyAsync(o => o.Items.Any(i => i.BookId == request.BookId));

        if (!hasPurchased)
        {
            return ApiResponse<ReviewDto>.Fail("Bạn chỉ có thể đánh giá sản phẩm sau khi đã mua và nhận hàng thành công.");
        }

        // BR-30: Không cho review trùng
        var alreadyReviewed = await _context.Reviews.AnyAsync(r => r.UserId == userId && r.BookId == request.BookId);
        if (alreadyReviewed)
        {
            return ApiResponse<ReviewDto>.Fail("Bạn đã gửi đánh giá cho cuốn sách này rồi.");
        }

        var review = new Review
        {
            Id = Guid.NewGuid(),
            UserId = userId,
            BookId = request.BookId,
            Rating = request.Rating,
            Content = request.Content.Trim(),
            Status = "APPROVED",
            CreatedAt = DateTime.UtcNow
        };

        _context.Reviews.Add(review);
        await _context.SaveChangesAsync();

        var user = await _context.Users.FindAsync(userId);

        return ApiResponse<ReviewDto>.Ok(new ReviewDto
        {
            Id = review.Id,
            UserId = review.UserId,
            UserName = user?.FullName ?? string.Empty,
            BookId = review.BookId,
            Rating = review.Rating,
            Content = review.Content,
            Status = review.Status,
            CreatedAt = review.CreatedAt
        }, "Cảm ơn bạn đã gửi đánh giá sản phẩm!");
    }

    public async Task<ApiResponse<bool>> DeleteReviewAsync(Guid reviewId, Guid userId, bool isManager = false)
    {
        var review = await _context.Reviews.FindAsync(reviewId);
        if (review == null)
        {
            return ApiResponse<bool>.Fail("Không tìm thấy đánh giá.");
        }

        if (!isManager && review.UserId != userId)
        {
            return ApiResponse<bool>.Fail("Bạn không có quyền xóa đánh giá này.");
        }

        _context.Reviews.Remove(review);
        await _context.SaveChangesAsync();
        return ApiResponse<bool>.Ok(true, "Đã xóa đánh giá.");
    }
}

public class WishlistService : IWishlistService
{
    private readonly BookStoreDbContext _context;

    public WishlistService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<WishlistDto>> GetWishlistAsync(Guid userId)
    {
        var wishlist = await GetOrCreateWishlistAsync(userId);

        var dto = new WishlistDto
        {
            Id = wishlist.Id,
            UserId = wishlist.UserId,
            Items = wishlist.Items.Select(i => new WishlistItemDto
            {
                Id = i.Id,
                BookId = i.BookId,
                Title = i.Book.Title,
                Slug = i.Book.Slug,
                CoverImageUrl = i.Book.CoverImageUrl,
                SalePrice = i.Book.SalePrice,
                DiscountPrice = i.Book.DiscountPrice,
                StockQuantity = i.Book.StockQuantity,
                AddedAt = i.CreatedAt
            }).ToList()
        };

        return ApiResponse<WishlistDto>.Ok(dto);
    }

    public async Task<ApiResponse<WishlistDto>> AddToWishlistAsync(Guid userId, Guid bookId)
    {
        var wishlist = await GetOrCreateWishlistAsync(userId);
        if (!wishlist.Items.Any(i => i.BookId == bookId))
        {
            var item = new WishlistItem
            {
                Id = Guid.NewGuid(),
                WishlistId = wishlist.Id,
                BookId = bookId,
                CreatedAt = DateTime.UtcNow
            };
            _context.WishlistItems.Add(item);
            await _context.SaveChangesAsync();
        }

        return await GetWishlistAsync(userId);
    }

    public async Task<ApiResponse<WishlistDto>> RemoveFromWishlistAsync(Guid userId, Guid bookId)
    {
        var wishlist = await GetOrCreateWishlistAsync(userId);
        var item = wishlist.Items.FirstOrDefault(i => i.BookId == bookId);
        if (item != null)
        {
            _context.WishlistItems.Remove(item);
            await _context.SaveChangesAsync();
        }

        return await GetWishlistAsync(userId);
    }

    private async Task<Wishlist> GetOrCreateWishlistAsync(Guid userId)
    {
        var wishlist = await _context.Wishlists
            .Include(w => w.Items)
                .ThenInclude(i => i.Book)
            .FirstOrDefaultAsync(w => w.UserId == userId);

        if (wishlist == null)
        {
            wishlist = new Wishlist
            {
                Id = Guid.NewGuid(),
                UserId = userId,
                CreatedAt = DateTime.UtcNow
            };
            _context.Wishlists.Add(wishlist);
            await _context.SaveChangesAsync();
        }

        return wishlist;
    }
}

public class CouponService : ICouponService
{
    private readonly BookStoreDbContext _context;

    public CouponService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<List<CouponDto>>> GetAllCouponsAsync()
    {
        var coupons = await _context.Coupons
            .AsNoTracking()
            .OrderByDescending(c => c.StartAt)
            .Select(c => new CouponDto
            {
                Id = c.Id,
                Code = c.Code,
                Name = c.Name,
                Type = c.Type,
                Value = c.Value,
                MinimumOrderAmount = c.MinimumOrderAmount,
                MaximumDiscountAmount = c.MaximumDiscountAmount,
                UsageLimit = c.UsageLimit,
                UsedCount = c.UsedCount,
                StartAt = c.StartAt,
                EndAt = c.EndAt,
                IsActive = c.IsActive
            })
            .ToListAsync();

        return ApiResponse<List<CouponDto>>.Ok(coupons);
    }

    public async Task<ApiResponse<CouponDto>> CreateCouponAsync(CreateCouponDto request)
    {
        var code = request.Code.Trim().ToUpperInvariant();

        // BR-24: Code unique
        if (await _context.Coupons.AnyAsync(c => c.Code == code))
        {
            return ApiResponse<CouponDto>.Fail("Mã giảm giá này đã tồn tại.");
        }

        var coupon = new Coupon
        {
            Id = Guid.NewGuid(),
            Code = code,
            Name = request.Name.Trim(),
            Type = request.Type.ToUpper(),
            Value = request.Value,
            MinimumOrderAmount = request.MinimumOrderAmount,
            MaximumDiscountAmount = request.MaximumDiscountAmount,
            UsageLimit = request.UsageLimit,
            UsedCount = 0,
            StartAt = request.StartAt,
            EndAt = request.EndAt,
            IsActive = true
        };

        _context.Coupons.Add(coupon);
        await _context.SaveChangesAsync();

        return ApiResponse<CouponDto>.Ok(new CouponDto
        {
            Id = coupon.Id,
            Code = coupon.Code,
            Name = coupon.Name,
            Type = coupon.Type,
            Value = coupon.Value,
            MinimumOrderAmount = coupon.MinimumOrderAmount,
            MaximumDiscountAmount = coupon.MaximumDiscountAmount,
            UsageLimit = coupon.UsageLimit,
            UsedCount = coupon.UsedCount,
            StartAt = coupon.StartAt,
            EndAt = coupon.EndAt,
            IsActive = coupon.IsActive
        }, "Tạo mã giảm giá thành công.");
    }

    public async Task<ApiResponse<bool>> DeleteCouponAsync(Guid couponId)
    {
        var coupon = await _context.Coupons.FindAsync(couponId);
        if (coupon == null)
        {
            return ApiResponse<bool>.Fail("Không tìm thấy mã giảm giá.");
        }

        _context.Coupons.Remove(coupon);
        await _context.SaveChangesAsync();
        return ApiResponse<bool>.Ok(true, "Đã xóa mã giảm giá.");
    }

    public async Task<ApiResponse<CouponValidationResultDto>> ValidateCouponAsync(ValidateCouponRequestDto request)
    {
        var code = request.Code.Trim().ToUpperInvariant();
        var coupon = await _context.Coupons.FirstOrDefaultAsync(c => c.Code == code);

        if (coupon == null || !coupon.IsActive)
        {
            return ApiResponse<CouponValidationResultDto>.Ok(new CouponValidationResultDto
            {
                IsValid = false,
                Message = "Mã giảm giá không tồn tại hoặc đã bị vô hiệu hóa."
            });
        }

        // BR-25: Thời gian hiệu lực
        var now = DateTime.UtcNow;
        if (now < coupon.StartAt || now > coupon.EndAt)
        {
            return ApiResponse<CouponValidationResultDto>.Ok(new CouponValidationResultDto
            {
                IsValid = false,
                Message = "Mã giảm giá chưa đến ngày áp dụng hoặc đã hết hạn."
            });
        }

        // BR-26: Giới hạn lượt dùng
        if (coupon.UsedCount >= coupon.UsageLimit)
        {
            return ApiResponse<CouponValidationResultDto>.Ok(new CouponValidationResultDto
            {
                IsValid = false,
                Message = "Mã giảm giá đã hết lượt sử dụng."
            });
        }

        // BR-27: Giá trị đơn tối thiểu
        if (request.OrderAmount < coupon.MinimumOrderAmount)
        {
            return ApiResponse<CouponValidationResultDto>.Ok(new CouponValidationResultDto
            {
                IsValid = false,
                Message = $"Mã giảm giá chỉ áp dụng cho đơn hàng từ {coupon.MinimumOrderAmount:N0}đ trở lên."
            });
        }

        // Tính số tiền được giảm
        decimal discountAmount;
        if (coupon.Type == CouponTypeConstants.Percent)
        {
            discountAmount = request.OrderAmount * (coupon.Value / 100m);
            if (coupon.MaximumDiscountAmount.HasValue && discountAmount > coupon.MaximumDiscountAmount.Value)
            {
                discountAmount = coupon.MaximumDiscountAmount.Value;
            }
        }
        else
        {
            discountAmount = coupon.Value;
        }

        return ApiResponse<CouponValidationResultDto>.Ok(new CouponValidationResultDto
        {
            IsValid = true,
            Code = coupon.Code,
            DiscountAmount = discountAmount,
            Message = $"Áp dụng mã giảm giá thành công! Được giảm {discountAmount:N0}đ."
        });
    }
}
