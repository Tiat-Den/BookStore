using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using BookStore.Application.DTOs.Chat;

namespace BookStore.Application.Interfaces;

public interface IBookSearchService
{
    Task<List<BookCardDto>> SearchBooksAsync(string? keyword, string? category, decimal? minPrice, decimal? maxPrice, int limit = 6, CancellationToken ct = default);
    Task<BookCardDto?> GetBookDetailAsync(string bookIdOrTitle, CancellationToken ct = default);
    Task<string?> GetPolicyAnswerAsync(string topic, CancellationToken ct = default);
}
