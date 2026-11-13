using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Threading;
using System.Threading.Tasks;
using BookStore.Application.DTOs.Chat;
using BookStore.Application.Interfaces;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace BookStore.Infrastructure.Services;

public class GeminiAiService : IAiService
{
    private readonly HttpClient _httpClient;
    private readonly string _apiKey;
    private readonly string _model;
    private readonly ILogger<GeminiAiService> _logger;

    private readonly string[] _fallbackModels = new[] { "gemini-3.1-flash-lite", "gemini-flash-latest", "gemini-3.5-flash" };

    public GeminiAiService(
        HttpClient httpClient,
        IConfiguration configuration,
        ILogger<GeminiAiService> logger)
    {
        _httpClient = httpClient;
        _logger = logger;
        _apiKey = configuration["GeminiSettings:ApiKey"] 
            ?? configuration["Gemini:ApiKey"] 
            ?? string.Empty;
        _model = configuration["GeminiSettings:Model"] ?? "gemini-3.1-flash-lite";
    }

    public async Task<AiResponse> CompleteAsync(AiRequest request, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(_apiKey))
        {
            _logger.LogWarning("Gemini API Key is missing.");
            return new AiResponse("Xin lỗi, hệ thống AI chưa được cấu hình API Key. Vui lòng liên hệ quản trị viên.", Array.Empty<AiToolCall>());
        }

        var modelsToTry = new List<string> { _model };
        foreach (var m in _fallbackModels)
        {
            if (!modelsToTry.Contains(m)) modelsToTry.Add(m);
        }

        foreach (var modelName in modelsToTry)
        {
            var res = await TryCallGeminiAsync(modelName, request, ct);
            if (res != null)
            {
                return res;
            }
        }

        return new AiResponse("Hiện tại mình đang gặp trục trặc khi kết nối đến dịch vụ AI. Bạn thử lại sau nhé!", Array.Empty<AiToolCall>());
    }

    private async Task<AiResponse?> TryCallGeminiAsync(string modelName, AiRequest request, CancellationToken ct)
    {
        var endpoint = $"https://generativelanguage.googleapis.com/v1beta/models/{modelName}:generateContent?key={_apiKey}";

        // Xây dựng payload contents
        var contents = new List<object>();

        // Lịch sử tin nhắn
        foreach (var msg in request.Messages)
        {
            var role = msg.Role == "assistant" || msg.Role == "model" ? "model" : "user";
            contents.Add(new
            {
                role = role,
                parts = new object[]
                {
                    new { text = msg.Content }
                }
            });
        }

        // System Instruction & Function Declarations (Tools)
        var payloadObj = new Dictionary<string, object>
        {
            ["contents"] = contents,
            ["systemInstruction"] = new
            {
                parts = new object[]
                {
                    new { text = request.SystemPrompt }
                }
            },
            ["generationConfig"] = new
            {
                maxOutputTokens = request.MaxTokens,
                temperature = 0.7
            }
        };

        // Thêm tool declarations nếu có
        if (request.Tools != null && request.Tools.Count > 0)
        {
            var functionDeclarations = new List<object>();
            foreach (var tool in request.Tools)
            {
                functionDeclarations.Add(new
                {
                    name = tool.Name,
                    description = tool.Description,
                    parameters = tool.ParametersSchema
                });
            }

            payloadObj["tools"] = new object[]
            {
                new { functionDeclarations = functionDeclarations }
            };
        }

        var jsonPayload = JsonSerializer.Serialize(payloadObj);
        using var httpRequest = new HttpRequestMessage(HttpMethod.Post, endpoint)
        {
            Content = new StringContent(jsonPayload, Encoding.UTF8, "application/json")
        };

        try
        {
            var response = await _httpClient.SendAsync(httpRequest, ct);
            var responseBody = await response.Content.ReadAsStringAsync(ct);

            if (!response.IsSuccessStatusCode)
            {
                _logger.LogWarning("Gemini API call to {Model} failed with status {StatusCode}: {Body}", modelName, response.StatusCode, responseBody);
                return null;
            }

            // Phân tích kết quả trả về từ Gemini
            var rootNode = JsonNode.Parse(responseBody);
            var candidates = rootNode?["candidates"]?.AsArray();
            if (candidates == null || candidates.Count == 0)
            {
                return new AiResponse("Xin lỗi, mình chưa thể đưa ra câu trả lời cho yêu cầu này.", Array.Empty<AiToolCall>());
            }

            var parts = candidates[0]?["content"]?["parts"]?.AsArray();
            if (parts == null || parts.Count == 0)
            {
                return new AiResponse("Xin lỗi, không có phản hồi nào được tạo.", Array.Empty<AiToolCall>());
            }

            var textBuilder = new StringBuilder();
            var toolCalls = new List<AiToolCall>();

            foreach (var part in parts)
            {
                if (part == null) continue;

                // 1. Nếu có Text
                if (part["text"] != null)
                {
                    textBuilder.Append(part["text"]!.GetValue<string>());
                }

                // 2. Nếu Gemini yêu cầu Function Call (Gọi tool)
                if (part["functionCall"] != null)
                {
                    var fnCall = part["functionCall"];
                    var name = fnCall?["name"]?.GetValue<string>() ?? string.Empty;
                    var argsNode = fnCall?["args"];
                    var argsDict = new Dictionary<string, object?>();

                    if (argsNode is JsonObject jsonObj)
                    {
                        foreach (var kv in jsonObj)
                        {
                            argsDict[kv.Key] = kv.Value?.ToString();
                        }
                    }

                    if (!string.IsNullOrEmpty(name))
                    {
                        toolCalls.Add(new AiToolCall(name, argsDict));
                    }
                }
            }

            return new AiResponse(textBuilder.ToString().Trim(), toolCalls);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Exception while calling Gemini model {Model}", modelName);
            return null;
        }
    }
}
