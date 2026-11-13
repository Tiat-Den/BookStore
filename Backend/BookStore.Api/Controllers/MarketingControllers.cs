using System.Security.Claims;
using BookStore.Application.Common;
using BookStore.Application.DTOs.Marketing;
using BookStore.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ReviewsController : ControllerBase
{
    private readonly IReviewService _reviewService;

    public ReviewsController(IReviewService reviewService)
    {
        _reviewService = reviewService;
    }

    private Guid GetUserId() => Guid.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

    [HttpGet("book/{bookId:guid}")]
    public async Task<ActionResult<ApiResponse<List<ReviewDto>>>> GetBookReviews(Guid bookId)
    {
        var result = await _reviewService.GetBookReviewsAsync(bookId);
        return Ok(result);
    }

    [Authorize]
    [HttpPost]
    public async Task<ActionResult<ApiResponse<ReviewDto>>> CreateReview([FromBody] CreateReviewDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<ReviewDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _reviewService.CreateReviewAsync(GetUserId(), request);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [Authorize]
    [HttpDelete("{id:guid}")]
    public async Task<ActionResult<ApiResponse<bool>>> DeleteReview(Guid id)
    {
        var isManager = User.IsInRole("ADMIN") || User.IsInRole("EMPLOYEE");
        var result = await _reviewService.DeleteReviewAsync(id, GetUserId(), isManager);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }
}

[Authorize]
[ApiController]
[Route("api/[controller]")]
public class WishlistController : ControllerBase
{
    private readonly IWishlistService _wishlistService;

    public WishlistController(IWishlistService wishlistService)
    {
        _wishlistService = wishlistService;
    }

    private Guid GetUserId() => Guid.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

    [HttpGet]
    public async Task<ActionResult<ApiResponse<WishlistDto>>> GetWishlist()
    {
        var result = await _wishlistService.GetWishlistAsync(GetUserId());
        return Ok(result);
    }

    [HttpPost("items/{bookId:guid}")]
    public async Task<ActionResult<ApiResponse<WishlistDto>>> AddItem(Guid bookId)
    {
        var result = await _wishlistService.AddToWishlistAsync(GetUserId(), bookId);
        return Ok(result);
    }

    [HttpDelete("items/{bookId:guid}")]
    public async Task<ActionResult<ApiResponse<WishlistDto>>> RemoveItem(Guid bookId)
    {
        var result = await _wishlistService.RemoveFromWishlistAsync(GetUserId(), bookId);
        return Ok(result);
    }
}

[ApiController]
[Route("api/[controller]")]
public class CouponsController : ControllerBase
{
    private readonly ICouponService _couponService;

    public CouponsController(ICouponService couponService)
    {
        _couponService = couponService;
    }

    [HttpPost("validate")]
    public async Task<ActionResult<ApiResponse<CouponValidationResultDto>>> ValidateCoupon([FromBody] ValidateCouponRequestDto request)
    {
        var result = await _couponService.ValidateCouponAsync(request);
        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpGet]
    public async Task<ActionResult<ApiResponse<List<CouponDto>>>> GetAllCoupons()
    {
        var result = await _couponService.GetAllCouponsAsync();
        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPost]
    public async Task<ActionResult<ApiResponse<CouponDto>>> CreateCoupon([FromBody] CreateCouponDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<CouponDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _couponService.CreateCouponAsync(request);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpDelete("{id:guid}")]
    public async Task<ActionResult<ApiResponse<bool>>> DeleteCoupon(Guid id)
    {
        var result = await _couponService.DeleteCouponAsync(id);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }
}
