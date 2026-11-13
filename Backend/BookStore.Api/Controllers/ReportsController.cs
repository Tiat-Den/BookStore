using BookStore.Application.Common;
using BookStore.Application.DTOs.Reports;
using BookStore.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Api.Controllers;

[Authorize(Roles = "ADMIN,EMPLOYEE")]
[ApiController]
[Route("api/[controller]")]
public class ReportsController : ControllerBase
{
    private readonly IReportService _reportService;

    public ReportsController(IReportService reportService)
    {
        _reportService = reportService;
    }

    [HttpGet("dashboard")]
    public async Task<ActionResult<ApiResponse<DashboardStatsDto>>> GetDashboardStats()
    {
        var result = await _reportService.GetDashboardStatsAsync();
        return Ok(result);
    }

    [HttpGet("revenue")]
    public async Task<ActionResult<ApiResponse<List<MonthlyRevenueDto>>>> GetRevenue([FromQuery] int months = 6)
    {
        var result = await _reportService.GetRevenueByMonthsAsync(months);
        return Ok(result);
    }

    [HttpGet("top-books")]
    public async Task<ActionResult<ApiResponse<List<TopSellingBookDto>>>> GetTopSellingBooks([FromQuery] int limit = 5)
    {
        var result = await _reportService.GetTopSellingBooksAsync(limit);
        return Ok(result);
    }
}
