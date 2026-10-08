using BookStore.Application.Common;
using BookStore.Application.DTOs.Marketing;

namespace BookStore.Application.Interfaces;

public interface IReviewService
{
    Task<ApiResponse<List<ReviewDto>>> GetBookReviewsAsync(Guid bookId);
    Task<ApiResponse<ReviewDto>> CreateReviewAsync(Guid userId, CreateReviewDto request);
    Task<ApiResponse<bool>> DeleteReviewAsync(Guid reviewId, Guid userId, bool isManager = false);
}

public interface IWishlistService
{
    Task<ApiResponse<WishlistDto>> GetWishlistAsync(Guid userId);
    Task<ApiResponse<WishlistDto>> AddToWishlistAsync(Guid userId, Guid bookId);
    Task<ApiResponse<WishlistDto>> RemoveFromWishlistAsync(Guid userId, Guid bookId);
}

public interface ICouponService
{
    Task<ApiResponse<List<CouponDto>>> GetAllCouponsAsync();
    Task<ApiResponse<CouponDto>> CreateCouponAsync(CreateCouponDto request);
    Task<ApiResponse<bool>> DeleteCouponAsync(Guid couponId);
    Task<ApiResponse<CouponValidationResultDto>> ValidateCouponAsync(ValidateCouponRequestDto request);
}
