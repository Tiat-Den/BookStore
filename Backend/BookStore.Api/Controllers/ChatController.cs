using System;
using System.Security.Claims;
using System.Threading.Tasks;
using BookStore.Application.DTOs.Chat;
using BookStore.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Api.Controllers;

[ApiController]
[Route("api/chat")]
[Authorize]
public class ChatController : ControllerBase
{
    private readonly IChatService _chatService;

    public ChatController(IChatService chatService)
    {
        _chatService = chatService;
    }

    private Guid GetCurrentUserId()
    {
        var userIdStr = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userIdStr) || !Guid.TryParse(userIdStr, out var userId))
        {
            throw new UnauthorizedAccessException("Người dùng chưa được xác thực hợp lệ.");
        }
        return userId;
    }

    private Guid? GetOptionalUserId()
    {
        var userIdStr = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (!string.IsNullOrEmpty(userIdStr) && Guid.TryParse(userIdStr, out var userId))
        {
            return userId;
        }
        return null;
    }

    /// <summary>
    /// Gửi tin nhắn đến AI Chatbot và nhận câu trả lời cùng danh sách sách gợi ý (Hỗ trợ cả khách vãng lai)
    /// </summary>
    [HttpPost("messages")]
    [AllowAnonymous]
    public async Task<IActionResult> SendMessage([FromBody] SendMessageRequest request)
    {
        if (request == null || string.IsNullOrWhiteSpace(request.Message))
        {
            return BadRequest(new { success = false, message = "Nội dung tin nhắn không được để trống." });
        }

        try
        {
            var userId = GetOptionalUserId();
            var response = await _chatService.SendMessageAsync(userId, request.ConversationId, request.Message);
            return Ok(new { success = true, data = response });
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(new { success = false, message = ex.Message });
        }
        catch (Exception ex)
        {
            return StatusCode(500, new { success = false, message = "Lỗi khi xử lý tin nhắn: " + ex.Message });
        }
    }

    /// <summary>
    /// Lấy danh sách các cuộc trò chuyện của người dùng hiện tại (Yêu cầu đăng nhập)
    /// </summary>
    [HttpGet("conversations")]
    public async Task<IActionResult> GetConversations()
    {
        var userId = GetCurrentUserId();
        var conversations = await _chatService.GetConversationsAsync(userId);
        return Ok(new { success = true, data = conversations });
    }

    /// <summary>
    /// Lấy toàn bộ lịch sử tin nhắn của một cuộc trò chuyện (Hỗ trợ cả khách vãng lai)
    /// </summary>
    [HttpGet("conversations/{conversationId:guid}")]
    [AllowAnonymous]
    public async Task<IActionResult> GetConversationDetail(Guid conversationId)
    {
        try
        {
            var userId = GetOptionalUserId();
            var history = await _chatService.GetConversationHistoryAsync(userId, conversationId);
            return Ok(new { success = true, data = history });
        }
        catch (KeyNotFoundException)
        {
            return NotFound(new { success = false, message = "Cuộc hội thoại không tồn tại." });
        }
    }

    /// <summary>
    /// Xóa một cuộc trò chuyện
    /// </summary>
    [HttpDelete("conversations/{conversationId:guid}")]
    public async Task<IActionResult> DeleteConversation(Guid conversationId)
    {
        var userId = GetCurrentUserId();
        var result = await _chatService.DeleteConversationAsync(userId, conversationId);
        if (!result)
        {
            return NotFound(new { success = false, message = "Không tìm thấy cuộc hội thoại để xóa." });
        }
        return Ok(new { success = true, message = "Xóa cuộc hội thoại thành công." });
    }

    /// <summary>
    /// Thêm sách vào giỏ hàng sau khi người dùng bấm xác nhận hành động trên UI Chat
    /// </summary>
    [HttpPost("cart/items")]
    public async Task<IActionResult> ConfirmAddToCart([FromBody] ConfirmAddToCartRequest request)
    {
        if (request == null || request.BookId == Guid.Empty || request.Quantity <= 0)
        {
            return BadRequest(new { success = false, message = "Dữ liệu thêm vào giỏ không hợp lệ." });
        }

        var userId = GetCurrentUserId();
        var result = await _chatService.AddToCartAfterConfirmAsync(userId, request);
        if (!result.Success)
        {
            return BadRequest(new { success = false, message = result.Message });
        }

        return Ok(result);
    }

    /// <summary>
    /// [Admin] Lấy cấu hình Bật/Tắt và thông báo của AI Chatbot
    /// </summary>
    [HttpGet("admin/settings")]
    [Authorize(Roles = "ADMIN")]
    public async Task<IActionResult> GetAdminSettings()
    {
        var settings = await _chatService.GetSettingsAsync();
        return Ok(new { success = true, data = settings });
    }

    /// <summary>
    /// [Admin] Cập nhật cấu hình Bật/Tắt (Kill-Switch) và thông điệp của AI Chatbot
    /// </summary>
    [HttpPut("admin/settings")]
    [Authorize(Roles = "ADMIN")]
    public async Task<IActionResult> UpdateAdminSettings([FromBody] UpdateChatSettingRequest request)
    {
        var updated = await _chatService.UpdateSettingsAsync(request);
        return Ok(new { success = true, message = "Cập nhật cấu hình Chatbot AI thành công.", data = updated });
    }

    /// <summary>
    /// [Admin] Thống kê tổng quan lượt chat và người dùng hoạt động
    /// </summary>
    [HttpGet("admin/stats")]
    [Authorize(Roles = "ADMIN")]
    public async Task<IActionResult> GetAdminStats()
    {
        var stats = await _chatService.GetUsageStatsAsync();
        return Ok(new { success = true, data = stats });
    }

    /// <summary>
    /// [Admin] Lấy toàn bộ danh sách các cuộc hội thoại để giám sát
    /// </summary>
    [HttpGet("admin/conversations")]
    [Authorize(Roles = "ADMIN")]
    public async Task<IActionResult> GetAdminConversations()
    {
        var list = await _chatService.GetAllConversationsForAdminAsync();
        return Ok(new { success = true, data = list });
    }

    /// <summary>
    /// [Admin] Xem chi tiết toàn bộ tin nhắn của một cuộc hội thoại
    /// </summary>
    [HttpGet("admin/conversations/{id}")]
    [Authorize(Roles = "ADMIN")]
    public async Task<IActionResult> GetAdminConversationDetail(Guid id)
    {
        try
        {
            var detail = await _chatService.GetConversationDetailForAdminAsync(id);
            return Ok(new { success = true, data = detail });
        }
        catch (KeyNotFoundException ex)
        {
            return NotFound(new { success = false, message = ex.Message });
        }
    }

    /// <summary>
    /// [Admin] Xóa một cuộc hội thoại
    /// </summary>
    [HttpDelete("admin/conversations/{id}")]
    [Authorize(Roles = "ADMIN")]
    public async Task<IActionResult> DeleteAdminConversation(Guid id)
    {
        var success = await _chatService.DeleteConversationByAdminAsync(id);
        if (!success)
        {
            return NotFound(new { success = false, message = "Không tìm thấy cuộc hội thoại để xóa." });
        }
        return Ok(new { success = true, message = "Đã xóa cuộc hội thoại thành công." });
    }

    /// <summary>
    /// Endpoint công khai lấy trạng thái hoạt động của Chatbot cho Frontend
    /// </summary>
    [HttpGet("status")]
    [AllowAnonymous]
    public async Task<IActionResult> GetPublicStatus()
    {
        var settings = await _chatService.GetSettingsAsync();
        return Ok(new { 
            success = true, 
            data = new {
                isEnabled = settings.IsEnabled,
                welcomeMessage = settings.WelcomeMessage,
                systemNotice = settings.SystemNotice
            } 
        });
    }
}
