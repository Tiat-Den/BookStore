using BookStore.Application.Common;
using BookStore.Application.DTOs.Orders;

namespace BookStore.Application.Interfaces;

public interface IOrderService
{
    Task<ApiResponse<OrderDto>> CreateOrderAsync(Guid userId, CreateOrderDto request);
    Task<ApiResponse<OrderDto>> GetOrderByIdAsync(Guid orderId, Guid? userId = null, bool isManager = false);
    Task<ApiResponse<PagedResult<OrderDto>>> GetOrdersAsync(OrderFilterDto filter, Guid? userId = null, bool isManager = false);
    Task<ApiResponse<OrderDto>> UpdateOrderStatusAsync(Guid orderId, UpdateOrderStatusDto request, Guid currentUserId);
    Task<ApiResponse<bool>> CancelOrderAsync(Guid orderId, Guid userId, CancelOrderDto request, bool isManager = false);
}
