using System.Net;
using System.Net.Mail;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace BookStore.Infrastructure.Services;

public class EmailService : IEmailService
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<EmailService> _logger;

    public EmailService(IConfiguration configuration, ILogger<EmailService> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    private async Task<bool> SendEmailInternalAsync(string toEmail, string subject, string htmlBody)
    {
        try
        {
            var smtpServer = _configuration["EmailSettings:SmtpServer"] ?? "smtp.gmail.com";
            var port = int.TryParse(_configuration["EmailSettings:Port"], out var p) ? p : 587;
            var senderEmail = _configuration["EmailSettings:SenderEmail"] ?? "datpham14563@gmail.com";
            var senderName = _configuration["EmailSettings:SenderName"] ?? "BookStore Online";
            var password = _configuration["EmailSettings:Password"] ?? "zmuvoqloagywajdl";
            var enableSsl = !bool.TryParse(_configuration["EmailSettings:EnableSsl"], out var ssl) || ssl;

            using var client = new SmtpClient(smtpServer, port)
            {
                Credentials = new NetworkCredential(senderEmail, password),
                EnableSsl = enableSsl
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress(senderEmail, senderName),
                Subject = subject,
                Body = htmlBody,
                IsBodyHtml = true
            };
            mailMessage.To.Add(toEmail);

            _logger.LogInformation("Đang gửi email '{Subject}' tới {ToEmail} qua SMTP Gmail...", subject, toEmail);
            await client.SendMailAsync(mailMessage);
            _logger.LogInformation("Gửi email '{Subject}' tới {ToEmail} thành công!", subject, toEmail);

            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Lỗi khi gửi email '{Subject}' tới {ToEmail}", subject, toEmail);
            return false;
        }
    }

    public async Task<bool> SendOtpEmailAsync(string toEmail, string otp, string recipientName = "")
    {
        try
        {
            var displayName = string.IsNullOrWhiteSpace(recipientName) ? "Quý khách" : recipientName;
            var subject = $"[{otp}] Mã xác nhận khôi phục mật khẩu - BookStore";

            var htmlBody = $@"
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>Khôi phục mật khẩu BookStore</title>
</head>
<body style='margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, ""Segoe UI"", Roboto, Helvetica, Arial, sans-serif; background-color: #f8fafc; color: #1e293b;'>
    <div style='max-width: 560px; margin: 40px auto; background-color: #ffffff; border-radius: 14px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: 1px solid #e2e8f0;'>
        
        <!-- Header -->
        <div style='background: linear-gradient(135deg, #2563eb, #1d4ed8); padding: 32px 24px; text-align: center; color: #ffffff;'>
            <div style='font-size: 28px; font-weight: 800; letter-spacing: -0.5px; margin-bottom: 6px;'>
                📚 BookStore
            </div>
            <div style='font-size: 14px; opacity: 0.9;'>
                Sách Cho Mọi Nhà - Nâng Tầm Tri Thức
            </div>
        </div>

        <!-- Body -->
        <div style='padding: 36px 32px;'>
            <h2 style='font-size: 20px; font-weight: 700; color: #0f172a; margin-top: 0; margin-bottom: 16px;'>
                Yêu Cầu Khôi Phục Mật Khẩu
            </h2>

            <p style='font-size: 15px; line-height: 1.6; color: #475569; margin-bottom: 20px;'>
                Xin chào <strong>{displayName}</strong>,
            </p>

            <p style='font-size: 15px; line-height: 1.6; color: #475569; margin-bottom: 24px;'>
                Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản BookStore liên kết với địa chỉ email <strong>{toEmail}</strong>. Vui lòng sử dụng mã xác nhận (OTP) dưới đây để tiếp tục:
            </p>

            <!-- OTP Box -->
            <div style='background-color: #f0fdf4; border: 2px dashed #86efac; border-radius: 12px; padding: 20px; text-align: center; margin: 28px 0;'>
                <div style='font-size: 12px; font-weight: 700; color: #166534; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px;'>
                    Mã Xác Thực Của Bạn
                </div>
                <div style='font-size: 36px; font-weight: 800; color: #15803d; letter-spacing: 8px; font-family: monospace;'>
                    {otp}
                </div>
                <div style='font-size: 13px; color: #15803d; margin-top: 8px;'>
                    Mã này có hiệu lực trong vòng <strong>15 phút</strong>
                </div>
            </div>

            <div style='background-color: #fffbeb; border-left: 4px solid #f59e0b; padding: 12px 16px; border-radius: 4px; margin-bottom: 24px;'>
                <p style='font-size: 13px; color: #b45309; margin: 0; line-height: 1.5;'>
                    <strong>Lưu ý bảo mật:</strong> Tuyệt đối không chia sẻ mã xác nhận này cho bất kỳ ai.
                </p>
            </div>

            <p style='font-size: 14px; color: #64748b; line-height: 1.5;'>
                Nếu bạn không gửi yêu cầu này, hãy bỏ qua email này hoặc kiểm tra bảo mật tài khoản của bạn ngay lập tức.
            </p>
        </div>

        <!-- Footer -->
        <div style='background-color: #f8fafc; border-top: 1px solid #e2e8f0; padding: 20px 32px; text-align: center; font-size: 12px; color: #94a3b8; line-height: 1.6;'>
            <p style='margin: 0;'>
                © 2026 BookStore Online.
            </p>
            <p style='margin: 4px 0 0;'>
                Email này được gửi tự động từ hệ thống BookStore, vui lòng không phản hồi lại thư này.
            </p>
        </div>

    </div>
</body>
</html>";

            return await SendEmailInternalAsync(toEmail, subject, htmlBody);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Lỗi khi xử lý email OTP tới {ToEmail}", toEmail);
            return false;
        }
    }

    public async Task<bool> SendOrderConfirmationEmailAsync(Order order, string toEmail, string recipientName = "", string customTitle = "")
    {
        try
        {
            var displayName = string.IsNullOrWhiteSpace(recipientName)
                ? (order.Shipment?.ReceiverName ?? "Quý khách")
                : recipientName;

            var isPaid = order.PaymentStatus == "PAID";
            var paymentMethodText = order.PaymentMethod?.ToUpper() switch
            {
                "VNPAY" => "Ví điện tử VNPay / QR Code",
                "MOMO" => "Ví MoMo",
                "BANK_TRANSFER" => "Chuyển khoản VietQR",
                "COD" => "Thanh toán khi nhận hàng (COD)",
                _ => order.PaymentMethod ?? "Không xác định"
            };

            var title = !string.IsNullOrWhiteSpace(customTitle)
                ? customTitle
                : (isPaid ? "Xác nhận thanh toán thành công" : "Xác nhận đặt hàng thành công");

            var subject = $"[{order.OrderCode}] {title} - BookStore";

            var itemsHtml = new System.Text.StringBuilder();
            if (order.Items != null && order.Items.Any())
            {
                foreach (var item in order.Items)
                {
                    itemsHtml.Append($@"
                    <tr style='border-bottom: 1px solid #f1f5f9;'>
                        <td style='padding: 12px 10px; font-size: 14px; color: #1e293b; font-weight: 500;'>{WebUtility.HtmlEncode(item.ProductNameSnapshot)}</td>
                        <td style='padding: 12px 10px; font-size: 14px; color: #475569; text-align: center;'>{item.Quantity}</td>
                        <td style='padding: 12px 10px; font-size: 14px; color: #475569; text-align: right;'>{item.UnitPrice:N0}đ</td>
                        <td style='padding: 12px 10px; font-size: 14px; color: #0f172a; font-weight: 600; text-align: right;'>{item.TotalPrice:N0}đ</td>
                    </tr>");
                }
            }
            else
            {
                itemsHtml.Append("<tr><td colspan='4' style='padding: 12px; text-align: center; color: #64748b;'>Không có dữ liệu sản phẩm</td></tr>");
            }

            var discountRow = order.DiscountAmount > 0
                ? $@"<tr>
                        <td colspan='3' style='padding: 8px 10px; text-align: right; color: #15803d; font-size: 14px;'>Giảm giá voucher:</td>
                        <td style='padding: 8px 10px; text-align: right; color: #15803d; font-weight: 600; font-size: 14px;'>-{order.DiscountAmount:N0}đ</td>
                    </tr>"
                : "";

            var shippingText = order.ShippingFee > 0 ? $"{order.ShippingFee:N0}đ" : "Miễn phí (0đ)";

            var statusBadge = isPaid
                ? "<span style='display: inline-block; background-color: #dcfce7; color: #15803d; font-weight: 700; padding: 6px 14px; border-radius: 20px; font-size: 13px;'>ĐÃ THANH TOÁN THÀNH CÔNG</span>"
                : "<span style='display: inline-block; background-color: #fef3c7; color: #b45309; font-weight: 700; padding: 6px 14px; border-radius: 20px; font-size: 13px;'>THANH TOÁN KHI NHẬN HÀNG (COD)</span>";

            var transactionInfo = "";
            var latestPayment = order.Payments?.OrderByDescending(p => p.CreatedAt).FirstOrDefault();
            if (isPaid && latestPayment != null && !string.IsNullOrEmpty(latestPayment.TransactionCode))
            {
                transactionInfo = $"<div style='margin-top: 4px; font-size: 13px; color: #64748b;'>Mã giao dịch: <strong>{latestPayment.TransactionCode}</strong></div>";
            }

            var receiverName = order.Shipment?.ReceiverName ?? displayName;
            var receiverPhone = order.Shipment?.Phone ?? "Chưa cung cấp";
            var receiverAddress = order.Shipment?.Address ?? "Chưa cung cấp";

            var htmlBody = $@"
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <title>{title}</title>
</head>
<body style='margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, ""Segoe UI"", Roboto, Helvetica, Arial, sans-serif; background-color: #f8fafc; color: #1e293b;'>
    <div style='max-width: 620px; margin: 30px auto; background-color: #ffffff; border-radius: 16px; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.06); border: 1px solid #e2e8f0;'>
        
        <!-- Header -->
        <div style='background: linear-gradient(135deg, #2563eb, #1d4ed8); padding: 32px 24px; text-align: center; color: #ffffff;'>
            <div style='font-size: 28px; font-weight: 800; letter-spacing: -0.5px; margin-bottom: 6px;'>
                📚 BookStore
            </div>
            <div style='font-size: 14px; opacity: 0.9;'>
                Sách Cho Mọi Nhà - Nâng Tầm Tri Thức
            </div>
        </div>

        <!-- Body -->
        <div style='padding: 32px 28px;'>
            <div style='text-align: center; margin-bottom: 24px;'>
                {statusBadge}
                <h2 style='font-size: 22px; font-weight: 800; color: #0f172a; margin-top: 14px; margin-bottom: 6px;'>
                    {title}
                </h2>
                <div style='font-size: 15px; color: #64748b;'>
                    Mã đơn hàng: <strong style='color: #2563eb;'>{order.OrderCode}</strong>
                </div>
                {transactionInfo}
            </div>

            <p style='font-size: 15px; line-height: 1.6; color: #334155; margin-bottom: 20px;'>
                Xin chào <strong>{displayName}</strong>,<br>
                Cảm ơn bạn đã đặt sách tại BookStore! Đơn hàng của bạn đã được ghi nhận trên hệ thống. Dưới đây là thông tin chi tiết đơn hàng:
            </p>

            <!-- Box Thông tin nhận hàng -->
            <div style='background-color: #f8fafc; border-radius: 12px; padding: 18px 20px; border: 1px solid #e2e8f0; margin-bottom: 24px;'>
                <div style='font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 0.5px;'>
                    Thông Tin Nhận Hàng
                </div>
                <div style='font-size: 14px; color: #475569; line-height: 1.6;'>
                    <div><strong>Người nhận:</strong> {receiverName}</div>
                    <div><strong>Số điện thoại:</strong> {receiverPhone}</div>
                    <div><strong>Địa chỉ:</strong> {receiverAddress}</div>
                    <div><strong>Phương thức thanh toán:</strong> {paymentMethodText}</div>
                    <div><strong>Thời gian đặt:</strong> {order.CreatedAt.AddHours(7):dd/MM/yyyy HH:mm}</div>
                </div>
            </div>

            <!-- Bảng Chi tiết sản phẩm -->
            <div style='margin-bottom: 24px;'>
                <div style='font-size: 14px; font-weight: 700; color: #0f172a; margin-bottom: 12px; text-transform: uppercase; letter-spacing: 0.5px;'>
                    Chi Tiết Đơn Hàng
                </div>
                <table style='width: 100%; border-collapse: collapse; margin-bottom: 12px;'>
                    <thead>
                        <tr style='background-color: #f1f5f9; border-bottom: 2px solid #e2e8f0;'>
                            <th style='padding: 10px; text-align: left; font-size: 13px; font-weight: 700; color: #475569;'>Sản phẩm</th>
                            <th style='padding: 10px; text-align: center; font-size: 13px; font-weight: 700; color: #475569; width: 50px;'>SL</th>
                            <th style='padding: 10px; text-align: right; font-size: 13px; font-weight: 700; color: #475569; width: 90px;'>Đơn giá</th>
                            <th style='padding: 10px; text-align: right; font-size: 13px; font-weight: 700; color: #475569; width: 100px;'>Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        {itemsHtml}
                    </tbody>
                    <tfoot>
                        <tr>
                            <td colspan='3' style='padding: 10px; text-align: right; color: #475569; font-size: 14px;'>Tạm tính:</td>
                            <td style='padding: 10px; text-align: right; color: #1e293b; font-weight: 600; font-size: 14px;'>{order.SubTotal:N0}đ</td>
                        </tr>
                        {discountRow}
                        <tr>
                            <td colspan='3' style='padding: 8px 10px; text-align: right; color: #475569; font-size: 14px;'>Phí vận chuyển:</td>
                            <td style='padding: 8px 10px; text-align: right; color: #1e293b; font-weight: 600; font-size: 14px;'>{shippingText}</td>
                        </tr>
                        <tr style='border-top: 2px solid #e2e8f0; background-color: #f8fafc;'>
                            <td colspan='3' style='padding: 14px 10px; text-align: right; color: #0f172a; font-weight: 800; font-size: 16px;'>Tổng thanh toán:</td>
                            <td style='padding: 14px 10px; text-align: right; color: #2563eb; font-weight: 800; font-size: 18px;'>{order.TotalAmount:N0}đ</td>
                        </tr>
                    </tfoot>
                </table>
            </div>

            <p style='font-size: 14px; color: #64748b; line-height: 1.5; margin-bottom: 0;'>
                Nếu bạn cần hỗ trợ hoặc có thắc mắc, vui lòng liên hệ hotline <strong>1900 1234</strong> hoặc phản hồi email này.
            </p>
        </div>

        <!-- Footer -->
        <div style='background-color: #f8fafc; border-top: 1px solid #e2e8f0; padding: 20px 28px; text-align: center; font-size: 12px; color: #94a3b8; line-height: 1.6;'>
            <p style='margin: 0;'>
                © 2026 BookStore Online.
            </p>
        </div>

    </div>
</body>
</html>";

            return await SendEmailInternalAsync(toEmail, subject, htmlBody);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Lỗi khi tạo email xác nhận đơn hàng {OrderCode} gửi tới {ToEmail}", order.OrderCode, toEmail);
            return false;
        }
    }
}
