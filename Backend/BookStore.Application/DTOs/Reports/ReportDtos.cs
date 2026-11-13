namespace BookStore.Application.DTOs.Reports;

public class DashboardStatsDto
{
    public decimal TotalRevenue { get; set; }
    public int TotalOrders { get; set; }
    public int TotalBooks { get; set; }
    public int TotalCustomers { get; set; }
    public List<OrderStatusCountDto> OrderStatusCounts { get; set; } = new();
    public List<MonthlyRevenueDto> RevenueByMonth { get; set; } = new();
    public List<TopSellingBookDto> TopSellingBooks { get; set; } = new();
    public List<RecentOrderDto> RecentOrders { get; set; } = new();
}

public class OrderStatusCountDto
{
    public string Status { get; set; } = string.Empty;
    public int Count { get; set; }
}

public class MonthlyRevenueDto
{
    public string Month { get; set; } = string.Empty; // Format: "MM/yyyy"
    public decimal Revenue { get; set; }
    public int OrderCount { get; set; }
}

public class TopSellingBookDto
{
    public Guid BookId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? ImageUrl { get; set; }
    public int QuantitySold { get; set; }
    public decimal TotalRevenue { get; set; }
}

public class RecentOrderDto
{
    public Guid Id { get; set; }
    public string OrderCode { get; set; } = string.Empty;
    public string CustomerName { get; set; } = string.Empty;
    public decimal TotalAmount { get; set; }
    public string PaymentMethod { get; set; } = string.Empty;
    public string PaymentStatus { get; set; } = string.Empty;
    public string OrderStatus { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
}

public class ProcessPaymentDto
{
    public Guid OrderId { get; set; }
    public string PaymentMethod { get; set; } = "VNPAY";
    public bool IsSuccess { get; set; } = true;
    public string? BankCode { get; set; } = "NCB";
}
