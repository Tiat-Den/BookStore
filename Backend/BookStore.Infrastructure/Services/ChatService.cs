using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.Json;
using System.Threading;
using System.Threading.Tasks;
using BookStore.Application.DTOs.Chat;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;

namespace BookStore.Infrastructure.Services;

public class ChatService : IChatService
{
    private readonly BookStoreDbContext _context;
    private readonly IAiService _aiService;
    private readonly IBookSearchService _bookSearchService;
    private readonly ICartService _cartService;
    private readonly IOrderService _orderService;
    private readonly ILogger<ChatService> _logger;

    private const string SystemPrompt = @"Bạn là trợ lý AI thông minh và thân thiện của website bán sách trực tuyến BookStore.
Nhiệm vụ của bạn:
1. Luôn trả lời người dùng bằng tiếng Việt tự nhiên, lịch sự, ngắn gọn và hữu ích.
2. Tư vấn, gợi ý sách theo thể loại, tác giả, khoảng giá, hoặc sở thích người dùng.
3. Khi người dùng hỏi về sách, tìm sách, hoặc hỏi 'sách bán chạy', 'sách hay nhất', 'gợi ý sách', hãy sử dụng công cụ SearchBooks (truyền keyword='bán chạy' khi hỏi sách bán chạy/sách hot/hay nhất) để lấy danh sách từ cơ sở dữ liệu.
4. Khi người dùng hỏi về chính sách mua hàng, đổi trả, bảo hành, phí vận chuyển, hãy gọi công cụ GetPolicyAnswer.
5. Khi người dùng muốn xem giỏ hàng hiện tại hoặc hỏi giỏ hàng có gì, hãy gọi công cụ GetCart.
6. Khi người dùng hỏi thăm tình trạng đơn hàng hoặc kiểm tra mã đơn hàng, hãy gọi công cụ GetOrderStatus.
7. Khi người dùng nói muốn mua hoặc muốn thêm sách vào giỏ hàng, hãy gọi công cụ ProposeAddToCart. Lưu ý: Công cụ này CHỈ ĐỀ XUẤT hành động để người dùng bấm nút xác nhận trên màn hình, KHÔNG tự ý trừ tiền hay đặt hàng ngay.
8. Tuyệt đối KHÔNG tự bịa đặt giá sách hay số lượng tồn kho. Nếu không tìm thấy sách, hãy thông báo lịch sự cho người dùng.";

    public ChatService(
        BookStoreDbContext context,
        IAiService aiService,
        IBookSearchService bookSearchService,
        ICartService cartService,
        IOrderService orderService,
        ILogger<ChatService> logger)
    {
        _context = context;
        _aiService = aiService;
        _bookSearchService = bookSearchService;
        _cartService = cartService;
        _orderService = orderService;
        _logger = logger;
    }

    public async Task<ChatResponseDto> SendMessageAsync(
        Guid? userId,
        Guid? conversationId,
        string message,
        CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(message))
        {
            throw new ArgumentException("Nội dung tin nhắn không được để trống.");
        }

        message = message.Trim();
        if (message.Length > 1000)
        {
            message = message.Substring(0, 1000);
        }

        // 0. Kiểm tra công tắc Chatbot (Kill-Switch)
        var chatSetting = await _context.ChatSettings.FirstOrDefaultAsync(ct);
        if (chatSetting != null && !chatSetting.IsEnabled)
        {
            var disabledNotice = !string.IsNullOrWhiteSpace(chatSetting.SystemNotice) 
                ? chatSetting.SystemNotice 
                : "Hệ thống trợ lý AI hiện đang tạm bảo trì để nâng cấp. Vui lòng quay lại sau ít phút hoặc liên hệ hotline cửa hàng nhé!";
            
            return new ChatResponseDto
            {
                ConversationId = conversationId ?? Guid.NewGuid(),
                MessageId = Guid.NewGuid(),
                Text = disabledNotice,
                Suggestions = new List<string>()
            };
        }

        // 1. Quản lý hội thoại (Conversation)
        ChatConversation? conversation = null;
        if (conversationId.HasValue)
        {
            if (userId.HasValue)
            {
                conversation = await _context.ChatConversations
                    .Include(c => c.Messages)
                    .FirstOrDefaultAsync(c => c.Id == conversationId.Value && c.UserId == userId.Value && c.Status == "Active", ct);
            }
            else
            {
                conversation = await _context.ChatConversations
                    .Include(c => c.Messages)
                    .FirstOrDefaultAsync(c => c.Id == conversationId.Value && c.UserId == null && c.Status == "Active", ct);
            }
        }

        if (conversation == null)
        {
            conversation = new ChatConversation
            {
                UserId = userId,
                Title = message.Length > 40 ? message.Substring(0, 37) + "..." : message,
                CreatedAt = DateTime.UtcNow,
                UpdatedAt = DateTime.UtcNow,
                Status = "Active"
            };
            _context.ChatConversations.Add(conversation);
            await _context.SaveChangesAsync(ct);
        }

        // 2. Lưu tin nhắn của User
        var userMsg = new ChatMessage
        {
            ConversationId = conversation.Id,
            Role = "user",
            Content = message,
            CreatedAt = DateTime.UtcNow
        };
        _context.ChatMessages.Add(userMsg);
        await _context.SaveChangesAsync(ct);

        // 3. Chuẩn bị lịch sử tin nhắn gần nhất (tối đa 8 tin)
        var recentMessages = await _context.ChatMessages
            .Where(m => m.ConversationId == conversation.Id)
            .OrderByDescending(m => m.CreatedAt)
            .Take(8)
            .OrderBy(m => m.CreatedAt)
            .Select(m => new AiMessage(m.Role, m.Content))
            .ToListAsync(ct);

        // 4. Định nghĩa Tools cho AI
        var tools = GetToolsDefinition();

        // 5. Vòng lặp Tool Calling
        var returnedBooks = new List<BookCardDto>();
        var proposedActions = new List<ProposedActionDto>();
        var aiRequest = new AiRequest(SystemPrompt, recentMessages, tools);
        var aiResponse = await _aiService.CompleteAsync(aiRequest, ct);

        // Nếu Gemini gọi Tool
        if (aiResponse.ToolCalls != null && aiResponse.ToolCalls.Count > 0)
        {
            foreach (var toolCall in aiResponse.ToolCalls)
            {
                if (toolCall.Name == "SearchBooks")
                {
                    toolCall.Arguments.TryGetValue("keyword", out var kwObj);
                    toolCall.Arguments.TryGetValue("category", out var catObj);
                    toolCall.Arguments.TryGetValue("minPrice", out var minPObj);
                    toolCall.Arguments.TryGetValue("maxPrice", out var maxPObj);

                    decimal? minPrice = minPObj != null && decimal.TryParse(minPObj.ToString(), out var minVal) ? minVal : null;
                    decimal? maxPrice = maxPObj != null && decimal.TryParse(maxPObj.ToString(), out var maxVal) ? maxVal : null;

                    var books = await _bookSearchService.SearchBooksAsync(
                        kwObj?.ToString(),
                        catObj?.ToString(),
                        minPrice,
                        maxPrice,
                        6,
                        ct);

                    returnedBooks.AddRange(books);
                }
                else if (toolCall.Name == "GetBookDetail")
                {
                    toolCall.Arguments.TryGetValue("bookIdOrTitle", out var titleObj);
                    if (titleObj != null)
                    {
                        var book = await _bookSearchService.GetBookDetailAsync(titleObj.ToString()!, ct);
                        if (book != null && !returnedBooks.Any(b => b.Id == book.Id))
                        {
                            returnedBooks.Add(book);
                        }
                    }
                }
                else if (toolCall.Name == "GetPolicyAnswer")
                {
                    toolCall.Arguments.TryGetValue("topic", out var topicObj);
                    var policy = await _bookSearchService.GetPolicyAnswerAsync(topicObj?.ToString() ?? "chính sách", ct);
                    if (!string.IsNullOrEmpty(policy) && string.IsNullOrEmpty(aiResponse.Text))
                    {
                        aiResponse = new AiResponse($"Dạ đây là thông tin chính sách của cửa hàng ạ:\n\n{policy}", Array.Empty<AiToolCall>());
                    }
                }
                else if (toolCall.Name == "GetCart")
                {
                    if (!userId.HasValue)
                    {
                        aiResponse = new AiResponse("🛒 Dạ, tính năng xem giỏ hàng yêu cầu bạn phải đăng nhập tài khoản. Bạn vui lòng đăng nhập để kiểm tra giỏ hàng của mình nhé!", Array.Empty<AiToolCall>());
                    }
                    else
                    {
                        var cartRes = await _cartService.GetCartAsync(userId.Value);
                        if (cartRes.Success && cartRes.Data != null && cartRes.Data.Items.Any())
                        {
                            var itemsSummary = string.Join(", ", cartRes.Data.Items.Select(i => $"{i.BookTitle} (x{i.Quantity} - {i.UnitPrice:N0}đ)"));
                            aiResponse = new AiResponse($"🛒 Giỏ hàng hiện tại của bạn đang có {cartRes.Data.TotalItems} sản phẩm với tổng tiền là {cartRes.Data.SubTotal:N0}đ:\n- {itemsSummary}", Array.Empty<AiToolCall>());
                        }
                        else
                        {
                            aiResponse = new AiResponse("🛒 Giỏ hàng của bạn hiện đang trống. Bạn có muốn mình gợi ý vài cuốn sách bán chạy không ạ?", Array.Empty<AiToolCall>());
                        }
                    }
                }
                else if (toolCall.Name == "GetOrderStatus")
                {
                    if (!userId.HasValue)
                    {
                        aiResponse = new AiResponse("📦 Dạ, tính năng tra cứu đơn hàng yêu cầu bạn phải đăng nhập tài khoản. Bạn vui lòng đăng nhập để mình hỗ trợ kiểm tra đơn hàng nhé!", Array.Empty<AiToolCall>());
                    }
                    else
                    {
                        toolCall.Arguments.TryGetValue("orderCode", out var codeObj);
                        var orderCode = codeObj?.ToString();
                        var ordersRes = await _orderService.GetOrdersAsync(new BookStore.Application.DTOs.Orders.OrderFilterDto { Page = 1, PageSize = 10 }, userId.Value);
                        
                        if (ordersRes.Success && ordersRes.Data != null && ordersRes.Data.Items.Any())
                        {
                            BookStore.Application.DTOs.Orders.OrderDto? matchedOrder = null;
                            if (!string.IsNullOrEmpty(orderCode))
                            {
                                matchedOrder = ordersRes.Data.Items.FirstOrDefault(o => o.OrderCode.Equals(orderCode, StringComparison.OrdinalIgnoreCase));
                            }
                            else
                            {
                                matchedOrder = ordersRes.Data.Items.OrderByDescending(o => o.CreatedAt).FirstOrDefault();
                            }

                            if (matchedOrder != null)
                            {
                                aiResponse = new AiResponse($"📦 Đơn hàng #{matchedOrder.OrderCode} của bạn (đặt ngày {matchedOrder.CreatedAt:dd/MM/yyyy}) hiện đang ở trạng thái: **{matchedOrder.OrderStatus}**. Tổng giá trị đơn: {matchedOrder.TotalAmount:N0}đ.", Array.Empty<AiToolCall>());
                            }
                            else
                            {
                                aiResponse = new AiResponse($"Dạ, mình không tìm thấy đơn hàng có mã {orderCode} trong tài khoản của bạn. Bạn vui lòng kiểm tra lại mã đơn giúp mình nhé!", Array.Empty<AiToolCall>());
                            }
                        }
                        else
                        {
                            aiResponse = new AiResponse("Dạ, hiện tại bạn chưa có đơn hàng nào được ghi nhận trong hệ thống.", Array.Empty<AiToolCall>());
                        }
                    }
                }
                else if (toolCall.Name == "ProposeAddToCart")
                {
                    if (!userId.HasValue)
                    {
                        aiResponse = new AiResponse("🛒 Dạ, tính năng thêm sách vào giỏ hàng yêu cầu bạn phải đăng nhập tài khoản. Bạn vui lòng đăng nhập để thêm sách vào giỏ hàng và tiến hành thanh toán nhé! 😊", Array.Empty<AiToolCall>());
                    }
                    else
                    {
                        toolCall.Arguments.TryGetValue("bookIdOrTitle", out var bookIdOrTitleObj);
                        toolCall.Arguments.TryGetValue("quantity", out var qtyObj);

                        var qty = 1;
                        if (qtyObj != null && int.TryParse(qtyObj.ToString(), out var parsedQty) && parsedQty > 0)
                        {
                            qty = parsedQty;
                        }

                        if (bookIdOrTitleObj != null)
                        {
                            var book = await _bookSearchService.GetBookDetailAsync(bookIdOrTitleObj.ToString()!, ct);
                            if (book != null)
                            {
                                if (!book.InStock)
                                {
                                    aiResponse = new AiResponse($"Rất tiếc cuốn sách \"{book.Title}\" hiện tại đã tạm hết hàng trong kho rồi ạ.", Array.Empty<AiToolCall>());
                                }
                                else
                                {
                                    proposedActions.Add(new ProposedActionDto
                                    {
                                        ActionType = "AddToCart",
                                        BookId = book.Id,
                                        BookTitle = book.Title,
                                        ImageUrl = book.ImageUrl,
                                        UnitPrice = book.Price,
                                        Quantity = qty
                                    });

                                    aiResponse = new AiResponse($"Mình đã tạo đề xuất thêm cuốn \"{book.Title}\" (x{qty}) vào giỏ hàng với giá {book.Price:N0}đ. Bạn vui lòng bấm nút xác nhận bên dưới để hoàn tất nhé!", Array.Empty<AiToolCall>());
                                }
                            }
                            else
                            {
                                aiResponse = new AiResponse("Dạ mình chưa tìm thấy cuốn sách bạn muốn thêm vào giỏ. Bạn có thể nói rõ tên sách hơn được không ạ?", Array.Empty<AiToolCall>());
                            }
                        }
                    }
                }
            }
        }

        // Tự động tìm thêm nếu tin nhắn hỏi sách mà chưa có sách trả về
        if (returnedBooks.Count == 0 && (
            message.ToLower().Contains("sách") || 
            message.ToLower().Contains("mua") || 
            message.ToLower().Contains("tìm") ||
            message.ToLower().Contains("bán chạy") ||
            message.ToLower().Contains("hay nhất") ||
            message.ToLower().Contains("gợi ý")))
        {
            var fallbackKeyword = message.Replace("tìm", "").Replace("muốn mua", "").Trim();
            var autoBooks = await _bookSearchService.SearchBooksAsync(fallbackKeyword, null, null, null, 4, ct);
            returnedBooks.AddRange(autoBooks);
        }

        // Nội dung trả lời cuối cùng của Trợ lý
        var replyText = aiResponse.Text;
        if (string.IsNullOrWhiteSpace(replyText) || (returnedBooks.Count > 0 && replyText.Contains("chưa tìm thấy")))
        {
            if (returnedBooks.Count > 0)
            {
                var isBestSeller = message.ToLower().Contains("bán chạy") || message.ToLower().Contains("hay nhất") || message.ToLower().Contains("hot");
                replyText = isBestSeller
                    ? $"Dạ, đây là danh sách những cuốn sách bán chạy nhất tại BookStore (được sắp xếp theo số lượng đã bán), mình xin gửi bạn tham khảo ạ:"
                    : $"Dạ, mình đã tìm thấy {returnedBooks.Count} cuốn sách phù hợp với yêu cầu của bạn đây ạ!";
            }
            else
            {
                replyText = "Dạ, hiện tại mình chưa tìm thấy cuốn sách nào khớp với yêu cầu của bạn. Bạn có thể cho mình biết thêm thông tin về thể loại hoặc tác giả được không ạ?";
            }
        }

        // 6. Lưu tin nhắn Assistant vào DB
        var assistantMsg = new ChatMessage
        {
            ConversationId = conversation.Id,
            Role = "assistant",
            Content = replyText,
            MetadataJson = returnedBooks.Count > 0 ? JsonSerializer.Serialize(returnedBooks.Select(b => b.Id)) : null,
            CreatedAt = DateTime.UtcNow
        };
        _context.ChatMessages.Add(assistantMsg);

        // Cập nhật UpdatedAt cho hội thoại
        conversation.UpdatedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync(ct);

        return new ChatResponseDto
        {
            ConversationId = conversation.Id,
            MessageId = assistantMsg.Id,
            Text = replyText,
            Books = returnedBooks,
            ProposedActions = proposedActions,
            Suggestions = new List<string> { "Gợi ý sách bán chạy nhất", "Xem giỏ hàng", "Kiểm tra đơn hàng", "Chính sách đổi trả" }
        };
    }

    public async Task<List<ConversationSummaryDto>> GetConversationsAsync(Guid userId, CancellationToken ct = default)
    {
        return await _context.ChatConversations
            .Where(c => c.UserId == userId && c.Status == "Active")
            .OrderByDescending(c => c.UpdatedAt)
            .Select(c => new ConversationSummaryDto
            {
                Id = c.Id,
                Title = c.Title,
                UpdatedAt = c.UpdatedAt,
                LastMessage = c.Messages.OrderByDescending(m => m.CreatedAt).Select(m => m.Content).FirstOrDefault()
            })
            .ToListAsync(ct);
    }

    public async Task<ConversationDetailDto> GetConversationHistoryAsync(Guid? userId, Guid conversationId, CancellationToken ct = default)
    {
        ChatConversation? conversation;
        if (userId.HasValue)
        {
            conversation = await _context.ChatConversations
                .Include(c => c.Messages)
                .AsNoTracking()
                .FirstOrDefaultAsync(c => c.Id == conversationId && c.UserId == userId.Value && c.Status == "Active", ct);
        }
        else
        {
            conversation = await _context.ChatConversations
                .Include(c => c.Messages)
                .AsNoTracking()
                .FirstOrDefaultAsync(c => c.Id == conversationId && c.UserId == null && c.Status == "Active", ct);
        }

        if (conversation == null)
        {
            throw new KeyNotFoundException("Không tìm thấy cuộc hội thoại.");
        }

        return new ConversationDetailDto
        {
            Id = conversation.Id,
            Title = conversation.Title,
            Messages = conversation.Messages.OrderBy(m => m.CreatedAt).Select(m => new ChatMessageDto
            {
                Id = m.Id,
                Role = m.Role,
                Content = m.Content,
                CreatedAt = m.CreatedAt
            }).ToList()
        };
    }

    public async Task<bool> DeleteConversationAsync(Guid userId, Guid conversationId, CancellationToken ct = default)
    {
        var conversation = await _context.ChatConversations
            .FirstOrDefaultAsync(c => c.Id == conversationId && c.UserId == userId, ct);

        if (conversation == null) return false;

        conversation.Status = "Deleted";
        conversation.UpdatedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync(ct);
        return true;
    }

    public async Task<BookStore.Application.Common.ApiResponse<BookStore.Application.DTOs.Orders.CartDto>> AddToCartAfterConfirmAsync(
        Guid userId,
        ConfirmAddToCartRequest request,
        CancellationToken ct = default)
    {
        if (request.Quantity <= 0)
        {
            return BookStore.Application.Common.ApiResponse<BookStore.Application.DTOs.Orders.CartDto>.Fail("Số lượng sản phẩm không hợp lệ.");
        }

        var addDto = new BookStore.Application.DTOs.Orders.AddToCartDto
        {
            BookId = request.BookId,
            Quantity = request.Quantity
        };

        return await _cartService.AddToCartAsync(userId, addDto);
    }

    public async Task<ChatSettingDto> GetSettingsAsync(CancellationToken ct = default)
    {
        var setting = await _context.ChatSettings.FirstOrDefaultAsync(ct);
        if (setting == null)
        {
            setting = new ChatSetting
            {
                IsEnabled = true,
                WelcomeMessage = "Xin chào! Mình là trợ lý AI của BookStore. Bạn cần tìm sách gì hôm nay?",
                SystemNotice = "",
                UpdatedAt = DateTime.UtcNow
            };
            _context.ChatSettings.Add(setting);
            await _context.SaveChangesAsync(ct);
        }

        return new ChatSettingDto
        {
            IsEnabled = setting.IsEnabled,
            WelcomeMessage = setting.WelcomeMessage,
            SystemNotice = setting.SystemNotice,
            UpdatedAt = setting.UpdatedAt
        };
    }

    public async Task<ChatSettingDto> UpdateSettingsAsync(UpdateChatSettingRequest request, CancellationToken ct = default)
    {
        var setting = await _context.ChatSettings.FirstOrDefaultAsync(ct);
        if (setting == null)
        {
            setting = new ChatSetting();
            _context.ChatSettings.Add(setting);
        }

        setting.IsEnabled = request.IsEnabled;
        if (!string.IsNullOrWhiteSpace(request.WelcomeMessage))
        {
            setting.WelcomeMessage = request.WelcomeMessage.Trim();
        }
        setting.SystemNotice = request.SystemNotice?.Trim() ?? string.Empty;
        setting.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync(ct);

        return new ChatSettingDto
        {
            IsEnabled = setting.IsEnabled,
            WelcomeMessage = setting.WelcomeMessage,
            SystemNotice = setting.SystemNotice,
            UpdatedAt = setting.UpdatedAt
        };
    }

    public async Task<ChatUsageStatsDto> GetUsageStatsAsync(CancellationToken ct = default)
    {
        var setting = await _context.ChatSettings.FirstOrDefaultAsync(ct);
        var totalConversations = await _context.ChatConversations.Where(c => c.Status == "Active").CountAsync(ct);
        var totalMessages = await _context.ChatMessages.CountAsync(ct);
        var totalActiveUsers = await _context.ChatConversations.Where(c => c.Status == "Active" && c.UserId != null).Select(c => c.UserId).Distinct().CountAsync(ct);
        
        var today = DateTime.UtcNow.Date;
        var messagesToday = await _context.ChatMessages.CountAsync(m => m.CreatedAt >= today, ct);

        return new ChatUsageStatsDto
        {
            TotalConversations = totalConversations,
            TotalMessages = totalMessages,
            TotalActiveUsers = totalActiveUsers,
            MessagesToday = messagesToday,
            IsAiEnabled = setting?.IsEnabled ?? true,
            ActiveModel = "gemini-3.1-flash-lite"
        };
    }

    public async Task<List<AdminConversationDto>> GetAllConversationsForAdminAsync(CancellationToken ct = default)
    {
        return await _context.ChatConversations
            .Where(c => c.Status == "Active")
            .Include(c => c.User)
            .Include(c => c.Messages)
            .AsNoTracking()
            .OrderByDescending(c => c.UpdatedAt)
            .Select(c => new AdminConversationDto
            {
                Id = c.Id,
                UserId = c.UserId,
                UserName = c.User != null ? c.User.FullName : "Khách vãng lai",
                UserEmail = c.User != null ? c.User.Email : "Ẩn danh (Chưa đăng nhập)",
                Title = c.Title,
                MessageCount = c.Messages.Count,
                LastMessage = c.Messages.OrderByDescending(m => m.CreatedAt).Select(m => m.Content).FirstOrDefault(),
                CreatedAt = c.CreatedAt,
                UpdatedAt = c.UpdatedAt
            })
            .ToListAsync(ct);
    }

    public async Task<ConversationDetailDto> GetConversationDetailForAdminAsync(Guid conversationId, CancellationToken ct = default)
    {
        var conversation = await _context.ChatConversations
            .Include(c => c.Messages)
            .AsNoTracking()
            .FirstOrDefaultAsync(c => c.Id == conversationId, ct);

        if (conversation == null)
        {
            throw new KeyNotFoundException("Không tìm thấy cuộc hội thoại.");
        }

        return new ConversationDetailDto
        {
            Id = conversation.Id,
            Title = conversation.Title,
            Messages = conversation.Messages.OrderBy(m => m.CreatedAt).Select(m => new ChatMessageDto
            {
                Id = m.Id,
                Role = m.Role,
                Content = m.Content,
                CreatedAt = m.CreatedAt
            }).ToList()
        };
    }

    public async Task<bool> DeleteConversationByAdminAsync(Guid conversationId, CancellationToken ct = default)
    {
        var conversation = await _context.ChatConversations
            .FirstOrDefaultAsync(c => c.Id == conversationId, ct);

        if (conversation == null) return false;

        conversation.Status = "Deleted";
        conversation.UpdatedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync(ct);
        return true;
    }

    private List<AiToolDefinition> GetToolsDefinition()
    {
        return new List<AiToolDefinition>
        {
            new AiToolDefinition(
                "SearchBooks",
                "Tìm kiếm sách trong cửa hàng dựa vào từ khóa tiêu đề, tác giả, thể loại, hoặc khoảng giá.",
                new
                {
                    type = "OBJECT",
                    properties = new Dictionary<string, object>
                    {
                        ["keyword"] = new { type = "STRING", description = "Từ khóa tìm kiếm (tên sách, tên tác giả, hoặc chủ đề)" },
                        ["category"] = new { type = "STRING", description = "Thể loại sách (ví dụ: Văn học, Kinh tế, Lịch sử...)" },
                        ["minPrice"] = new { type = "NUMBER", description = "Giá thấp nhất (VND)" },
                        ["maxPrice"] = new { type = "NUMBER", description = "Giá cao nhất (VND)" }
                    }
                }
            ),
            new AiToolDefinition(
                "GetBookDetail",
                "Xem chi tiết một cuốn sách bằng mã ID hoặc tên sách.",
                new
                {
                    type = "OBJECT",
                    properties = new Dictionary<string, object>
                    {
                        ["bookIdOrTitle"] = new { type = "STRING", description = "ID hoặc tên chính xác của cuốn sách" }
                    },
                    required = new[] { "bookIdOrTitle" }
                }
            ),
            new AiToolDefinition(
                "GetPolicyAnswer",
                "Tra cứu chính sách của cửa hàng như đổi trả, vận chuyển, bảo hành, phương thức thanh toán.",
                new
                {
                    type = "OBJECT",
                    properties = new Dictionary<string, object>
                    {
                        ["topic"] = new { type = "STRING", description = "Chủ đề cần tra cứu: đổi trả, vận chuyển, giao hàng, bảo hành" }
                    },
                    required = new[] { "topic" }
                }
            ),
            new AiToolDefinition(
                "GetCart",
                "Xem các sản phẩm hiện có trong giỏ hàng của người dùng đang đăng nhập và tổng tiền.",
                new
                {
                    type = "OBJECT",
                    properties = new Dictionary<string, object>()
                }
            ),
            new AiToolDefinition(
                "GetOrderStatus",
                "Kiểm tra trạng thái đơn hàng của người dùng. Có thể truyền mã đơn hàng (orderCode) hoặc để trống để kiểm tra đơn hàng gần nhất.",
                new
                {
                    type = "OBJECT",
                    properties = new Dictionary<string, object>
                    {
                        ["orderCode"] = new { type = "STRING", description = "Mã đơn hàng (ví dụ: ORD-20261012-1234) nếu có" }
                    }
                }
            ),
            new AiToolDefinition(
                "ProposeAddToCart",
                "Tạo đề xuất thêm một cuốn sách vào giỏ hàng để người dùng bấm nút xác nhận. KHÔNG tự ý ghi thẳng vào DB.",
                new
                {
                    type = "OBJECT",
                    properties = new Dictionary<string, object>
                    {
                        ["bookIdOrTitle"] = new { type = "STRING", description = "Tên cuốn sách hoặc mã ID sách muốn thêm" },
                        ["quantity"] = new { type = "INTEGER", description = "Số lượng muốn mua (mặc định là 1)" }
                    },
                    required = new[] { "bookIdOrTitle" }
                }
            )
        };
    }
}
