using BookStore.Domain.Entities;

namespace BookStore.Application.Interfaces;

public interface IEmailService
{
    Task<bool> SendOtpEmailAsync(string toEmail, string otp, string recipientName = "");
    Task<bool> SendOrderConfirmationEmailAsync(Order order, string toEmail, string recipientName = "", string customTitle = "");
    Task<bool> SendNewsletterWelcomeEmailAsync(string toEmail, string voucherCode, decimal discountValue, decimal minOrderAmount);
}
