using BookStore.Application.Common;
using BookStore.Application.DTOs.Reports;
using BookStore.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Api.Controllers;

[Authorize]
[ApiController]
[Route("api/[controller]")]
public class PaymentController : ControllerBase
{
    private readonly IPaymentService _paymentService;

    public PaymentController(IPaymentService paymentService)
    {
        _paymentService = paymentService;
    }

    [HttpPost("vnpay/create-url")]
    public async Task<ActionResult<ApiResponse<string>>> CreateVNPayUrl([FromBody] Guid orderId)
    {
        var ip = HttpContext.Connection.RemoteIpAddress?.ToString() ?? "127.0.0.1";
        var result = await _paymentService.CreateVNPayPaymentUrlAsync(orderId, ip);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [HttpPost("vnpay/process-mock")]
    public async Task<ActionResult<ApiResponse<bool>>> ProcessMockPayment([FromBody] ProcessPaymentDto request)
    {
        var result = await _paymentService.ProcessPaymentResultAsync(request);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }
}
