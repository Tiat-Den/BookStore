using BookStore.Application.Common;
using BookStore.Application.DTOs.Orders;

namespace BookStore.Application.Interfaces;

public interface ICartService
{
    Task<ApiResponse<CartDto>> GetCartAsync(Guid userId);
    Task<ApiResponse<CartDto>> AddToCartAsync(Guid userId, AddToCartDto request);
    Task<ApiResponse<CartDto>> UpdateItemQuantityAsync(Guid userId, Guid cartItemId, int quantity);
    Task<ApiResponse<CartDto>> RemoveItemAsync(Guid userId, Guid cartItemId);
    Task<ApiResponse<bool>> ClearCartAsync(Guid userId);
}
