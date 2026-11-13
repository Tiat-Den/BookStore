using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using BookStore.Application.DTOs.Chat;

namespace BookStore.Application.Interfaces;

public interface IChatService
{
    Task<ChatResponseDto> SendMessageAsync(Guid? userId, Guid? conversationId, string message, CancellationToken ct = default);
    Task<List<ConversationSummaryDto>> GetConversationsAsync(Guid userId, CancellationToken ct = default);
    Task<ConversationDetailDto> GetConversationHistoryAsync(Guid? userId, Guid conversationId, CancellationToken ct = default);
    Task<bool> DeleteConversationAsync(Guid userId, Guid conversationId, CancellationToken ct = default);
    Task<BookStore.Application.Common.ApiResponse<BookStore.Application.DTOs.Orders.CartDto>> AddToCartAfterConfirmAsync(Guid userId, ConfirmAddToCartRequest request, CancellationToken ct = default);
    Task<ChatSettingDto> GetSettingsAsync(CancellationToken ct = default);
    Task<ChatSettingDto> UpdateSettingsAsync(UpdateChatSettingRequest request, CancellationToken ct = default);
    Task<ChatUsageStatsDto> GetUsageStatsAsync(CancellationToken ct = default);
    Task<List<AdminConversationDto>> GetAllConversationsForAdminAsync(CancellationToken ct = default);
    Task<ConversationDetailDto> GetConversationDetailForAdminAsync(Guid conversationId, CancellationToken ct = default);
    Task<bool> DeleteConversationByAdminAsync(Guid conversationId, CancellationToken ct = default);
}
