using System.Threading;
using System.Threading.Tasks;
using BookStore.Application.DTOs.Chat;

namespace BookStore.Application.Interfaces;

public interface IAiService
{
    Task<AiResponse> CompleteAsync(AiRequest request, CancellationToken ct = default);
}
