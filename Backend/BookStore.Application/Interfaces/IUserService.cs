using BookStore.Application.Common;
using BookStore.Application.DTOs.Users;

namespace BookStore.Application.Interfaces;

public interface IUserService
{
    Task<ApiResponse<PagedResult<UserDto>>> GetUsersAsync(UserFilterDto filter);
    Task<ApiResponse<UserDto>> GetUserByIdAsync(Guid id);
    Task<ApiResponse<UserDto>> CreateEmployeeAsync(CreateEmployeeDto request);
    Task<ApiResponse<bool>> UpdateUserStatusAsync(Guid id, string status, Guid currentUserId);
}
