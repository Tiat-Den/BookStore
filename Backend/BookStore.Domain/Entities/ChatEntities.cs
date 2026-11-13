using System;
using System.Collections.Generic;

namespace BookStore.Domain.Entities;

public class ChatConversation
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid? UserId { get; set; }
    public string Title { get; set; } = "Cuộc trò chuyện mới";
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
    public string Status { get; set; } = "Active"; // Active | Deleted

    // Navigation
    public User? User { get; set; }
    public List<ChatMessage> Messages { get; set; } = new();
}

public class ChatMessage
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public Guid ConversationId { get; set; }
    public string Role { get; set; } = "user"; // user | assistant | model
    public string Content { get; set; } = string.Empty;
    public string? MetadataJson { get; set; } // Danh sách BookId hoặc tool call data (JSON)
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

    // Navigation
    public ChatConversation? Conversation { get; set; }
}

public class PolicyDocument
{
    public int Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public string Category { get; set; } = "General"; // Shipping, Return, Payment, General
    public string Status { get; set; } = "Approved"; // Draft | Approved
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
}

public class ChatSetting
{
    public int Id { get; set; }
    public bool IsEnabled { get; set; } = true;
    public string WelcomeMessage { get; set; } = "Xin chào! Mình là trợ lý AI của BookStore. Mình có thể giúp gì cho bạn hôm nay?";
    public string SystemNotice { get; set; } = string.Empty;
    public DateTime UpdatedAt { get; set; } = DateTime.UtcNow;
}
