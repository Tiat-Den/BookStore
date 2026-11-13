using System;
using System.Collections.Generic;

namespace BookStore.Application.DTOs.Chat;

public record AiMessage(string Role, string Content);

public record AiToolParameterProperty(string Type, string Description, bool? Required = null);

public record AiToolDefinition(
    string Name,
    string Description,
    object ParametersSchema
);

public record AiToolCall(
    string Name,
    Dictionary<string, object?> Arguments
);

public record AiRequest(
    string SystemPrompt,
    IReadOnlyList<AiMessage> Messages,
    IReadOnlyList<AiToolDefinition> Tools,
    int MaxTokens = 800
);

public record AiResponse(
    string? Text,
    IReadOnlyList<AiToolCall> ToolCalls
);

// Client API DTOs
public class SendMessageRequest
{
    public Guid? ConversationId { get; set; }
    public string Message { get; set; } = string.Empty;
}

public class BookCardDto
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string? Author { get; set; }
    public decimal Price { get; set; }
    public decimal? OriginalPrice { get; set; }
    public string? ImageUrl { get; set; }
    public bool InStock { get; set; }
    public string Slug { get; set; } = string.Empty;
}

public class ProposedActionDto
{
    public string ActionType { get; set; } = "AddToCart"; // AddToCart
    public Guid BookId { get; set; }
    public string BookTitle { get; set; } = string.Empty;
    public string? ImageUrl { get; set; }
    public decimal UnitPrice { get; set; }
    public int Quantity { get; set; } = 1;
    public string ConfirmationToken { get; set; } = Guid.NewGuid().ToString("N");
}

public class ConfirmAddToCartRequest
{
    public Guid BookId { get; set; }
    public int Quantity { get; set; } = 1;
    public string? IdempotencyKey { get; set; }
}

public class ChatResponseDto
{
    public Guid ConversationId { get; set; }
    public Guid MessageId { get; set; }
    public string Text { get; set; } = string.Empty;
    public List<BookCardDto> Books { get; set; } = new();
    public List<ProposedActionDto> ProposedActions { get; set; } = new();
    public List<string> Suggestions { get; set; } = new();
}

public class ConversationSummaryDto
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public DateTime UpdatedAt { get; set; }
    public string? LastMessage { get; set; }
}

public class ConversationDetailDto
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public List<ChatMessageDto> Messages { get; set; } = new();
}

public class ChatMessageDto
{
    public Guid Id { get; set; }
    public string Role { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public List<BookCardDto>? Books { get; set; }
    public DateTime CreatedAt { get; set; }
}

public class ChatSettingDto
{
    public bool IsEnabled { get; set; } = true;
    public string WelcomeMessage { get; set; } = string.Empty;
    public string SystemNotice { get; set; } = string.Empty;
    public DateTime UpdatedAt { get; set; }
}

public class UpdateChatSettingRequest
{
    public bool IsEnabled { get; set; }
    public string? WelcomeMessage { get; set; }
    public string? SystemNotice { get; set; }
}

public class ChatUsageStatsDto
{
    public int TotalConversations { get; set; }
    public int TotalMessages { get; set; }
    public int TotalActiveUsers { get; set; }
    public int MessagesToday { get; set; }
    public bool IsAiEnabled { get; set; }
    public string ActiveModel { get; set; } = "gemini-3.5-flash";
}

public class AdminConversationDto
{
    public Guid Id { get; set; }
    public Guid? UserId { get; set; }
    public string? UserName { get; set; }
    public string? UserEmail { get; set; }
    public string Title { get; set; } = string.Empty;
    public int MessageCount { get; set; }
    public string? LastMessage { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }
}
