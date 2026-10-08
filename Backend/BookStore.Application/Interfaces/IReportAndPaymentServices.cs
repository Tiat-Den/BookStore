using BookStore.Application.Common;
using BookStore.Application.DTOs.Reports;

namespace BookStore.Application.Interfaces;

public interface IReportService
{
    Task<ApiResponse<DashboardStatsDto>> GetDashboardStatsAsync();
    Task<ApiResponse<List<MonthlyRevenueDto>>> GetRevenueByMonthsAsync(int months = 6);
    Task<ApiResponse<List<TopSellingBookDto>>> GetTopSellingBooksAsync(int limit = 5);
}

public interface IPaymentService
{
    Task<ApiResponse<string>> CreateVNPayPaymentUrlAsync(Guid orderId, string ipAddress);
    Task<ApiResponse<bool>> ProcessPaymentResultAsync(ProcessPaymentDto request);
}
