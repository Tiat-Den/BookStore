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
public class OrdersController : ControllerBase
{
    private readonly IOrderService _orderService;

    public OrdersController(IOrderService orderService)
    {
        _orderService = orderService;
    }

    private Guid GetUserId() => Guid.Parse(User.FindFirst(ClaimTypes.NameIdentifier)!.Value);
    private bool IsManager() => User.IsInRole("ADMIN") || User.IsInRole("EMPLOYEE");

    [HttpGet]
    public async Task<ActionResult<ApiResponse<PagedResult<OrderDto>>>> GetOrders([FromQuery] OrderFilterDto filter)
    {
        var result = await _orderService.GetOrdersAsync(filter, userId: GetUserId(), isManager: IsManager());
        return Ok(result);
    }

    [HttpGet("my-orders")]
    public async Task<ActionResult<ApiResponse<PagedResult<OrderDto>>>> GetMyOrders([FromQuery] OrderFilterDto filter)
    {
        filter.OnlyMyOrders = true;
        var result = await _orderService.GetOrdersAsync(filter, userId: GetUserId(), isManager: false);
        return Ok(result);
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<ApiResponse<OrderDto>>> GetOrderById(Guid id)
    {
        var result = await _orderService.GetOrderByIdAsync(id, userId: GetUserId(), isManager: IsManager());
        if (!result.Success)
            return NotFound(result);

        return Ok(result);
    }

    [HttpPost]
    public async Task<ActionResult<ApiResponse<OrderDto>>> CreateOrder([FromBody] CreateOrderDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<OrderDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _orderService.CreateOrderAsync(GetUserId(), request);
        if (!result.Success)
            return BadRequest(result);

        return CreatedAtAction(nameof(GetOrderById), new { id = result.Data!.Id }, result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPatch("{id:guid}/status")]
    public async Task<ActionResult<ApiResponse<OrderDto>>> UpdateStatus(Guid id, [FromBody] UpdateOrderStatusDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<OrderDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _orderService.UpdateOrderStatusAsync(id, request, GetUserId());
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [HttpPost("{id:guid}/cancel")]
    public async Task<ActionResult<ApiResponse<bool>>> CancelOrder(Guid id, [FromBody] CancelOrderDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<bool>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _orderService.CancelOrderAsync(id, GetUserId(), request, isManager: IsManager());
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }
}
