using BookStore.Domain.Entities;

namespace BookStore.Application.Interfaces;

public interface IJwtTokenGenerator
{
    string GenerateToken(User user, IEnumerable<string> roles, IEnumerable<string> permissions);
}
