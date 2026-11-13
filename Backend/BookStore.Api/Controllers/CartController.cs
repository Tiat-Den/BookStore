using System.Security.Claims;
using BookStore.Application.Common;
using BookStore.Application.DTOs.Orders;
using BookStore.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Api.Controllers;

[Authorize]
[ApiController]
[Route("api/[controller]")]
public class CartController : ControllerBase
{
    private readonly ICartService _cartService;

    public CartController(ICartService cartService)
    {
        _cartService = cartService;
    }

    private Guid GetUserId() => Guid.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);

    [HttpGet]
    public async Task<ActionResult<ApiResponse<CartDto>>> GetCart()
    {
        var result = await _cartService.GetCartAsync(GetUserId());
        return Ok(result);
    }

    [HttpPost("items")]
    public async Task<ActionResult<ApiResponse<CartDto>>> AddToCart([FromBody] AddToCartDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<CartDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _cartService.AddToCartAsync(GetUserId(), request);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [HttpPut("items/{id:guid}")]
    public async Task<ActionResult<ApiResponse<CartDto>>> UpdateItemQuantity(Guid id, [FromBody] UpdateCartItemDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<CartDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _cartService.UpdateItemQuantityAsync(GetUserId(), id, request.Quantity);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [HttpDelete("items/{id:guid}")]
    public async Task<ActionResult<ApiResponse<CartDto>>> RemoveItem(Guid id)
    {
        var result = await _cartService.RemoveItemAsync(GetUserId(), id);
        return Ok(result);
    }

    [HttpDelete]
    public async Task<ActionResult<ApiResponse<bool>>> ClearCart()
    {
        var result = await _cartService.ClearCartAsync(GetUserId());
        return Ok(result);
    }
}
