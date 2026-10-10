using BookStore.Application.Common;
using BookStore.Application.DTOs.Users;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using BookStore.Domain.Enums;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class UserService : IUserService
{
    private readonly BookStoreDbContext _context;

    public UserService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<PagedResult<UserDto>>> GetUsersAsync(UserFilterDto filter)
    {
        try
        {
            var query = _context.Users
                .AsNoTracking()
                .Include(u => u.UserRoles)
                    .ThenInclude(ur => ur.Role)
                .AsQueryable();

            if (!string.IsNullOrWhiteSpace(filter.Keyword))
            {
                var kw = filter.Keyword.Trim().ToLower();
                query = query.Where(u => u.FullName.ToLower().Contains(kw) || u.Email.ToLower().Contains(kw) || (u.Phone != null && u.Phone.Contains(kw)));
            }

            if (!string.IsNullOrWhiteSpace(filter.Role))
            {
                var roleName = filter.Role.Trim().ToUpper();
                query = query.Where(u => u.UserRoles.Any(ur => ur.Role.Name == roleName));
            }

            if (!string.IsNullOrWhiteSpace(filter.Status))
            {
                if (Enum.TryParse<UserStatus>(filter.Status, true, out var st))
                {
                    query = query.Where(u => u.Status == st);
                }
            }

            var totalCount = await query.CountAsync();
            var page = filter.Page > 0 ? filter.Page : 1;
            var pageSize = filter.PageSize > 0 ? filter.PageSize : 10;

            var users = await query
                .OrderByDescending(u => u.CreatedAt)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            var dtos = users.Select(u => new UserDto
            {
                Id = u.Id,
                FullName = u.FullName,
                Email = u.Email,
                Phone = u.Phone,
                Status = u.Status.ToString(),
                CreatedAt = u.CreatedAt,
                Roles = u.UserRoles.Select(ur => ur.Role.Name).ToList()
            }).ToList();

            return ApiResponse<PagedResult<UserDto>>.Ok(new PagedResult<UserDto>
            {
                Items = dtos,
                TotalCount = totalCount,
                PageIndex = page,
                PageSize = pageSize
            });
        }
        catch (Exception ex)
        {
            return ApiResponse<PagedResult<UserDto>>.Fail($"Lỗi khi lấy danh sách người dùng: {ex.Message}");
        }
    }

    public async Task<ApiResponse<UserDto>> GetUserByIdAsync(Guid id)
    {
        var user = await _context.Users
            .Include(u => u.UserRoles)
                .ThenInclude(ur => ur.Role)
            .FirstOrDefaultAsync(u => u.Id == id);

        if (user == null)
            return ApiResponse<UserDto>.Fail("Không tìm thấy người dùng.");

        return ApiResponse<UserDto>.Ok(new UserDto
        {
            Id = user.Id,
            FullName = user.FullName,
            Email = user.Email,
            Phone = user.Phone,
            Status = user.Status.ToString(),
            CreatedAt = user.CreatedAt,
            Roles = user.UserRoles.Select(ur => ur.Role.Name).ToList()
        });
    }

    public async Task<ApiResponse<UserDto>> CreateEmployeeAsync(CreateEmployeeDto request)
    {
        var email = request.Email.Trim().ToLowerInvariant();
        if (await _context.Users.AnyAsync(u => u.Email.ToLower() == email))
        {
            return ApiResponse<UserDto>.Fail("Email này đã được sử dụng trong hệ thống.");
        }

        var employeeRole = await _context.Roles.FirstOrDefaultAsync(r => r.Name == "EMPLOYEE");
        if (employeeRole == null)
        {
            employeeRole = new Role
            {
                Id = Guid.NewGuid(),
                Name = "EMPLOYEE",
                Description = "Nhân viên quản lý sách, kho và đơn hàng"
            };
            _context.Roles.Add(employeeRole);
        }

        var user = new User
        {
            Id = Guid.NewGuid(),
            FullName = request.FullName.Trim(),
            Email = email,
            Phone = request.Phone?.Trim(),
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password),
            Status = UserStatus.Active,
            CreatedAt = DateTime.UtcNow
        };

        user.UserRoles.Add(new UserRole
        {
            UserId = user.Id,
            RoleId = employeeRole.Id
        });

        _context.Users.Add(user);
        await _context.SaveChangesAsync();

        return ApiResponse<UserDto>.Ok(new UserDto
        {
            Id = user.Id,
            FullName = user.FullName,
            Email = user.Email,
            Phone = user.Phone,
            Status = user.Status.ToString(),
            CreatedAt = user.CreatedAt,
            Roles = new List<string> { "EMPLOYEE" }
        }, "Tạo tài khoản nhân viên thành công.");
    }

    public async Task<ApiResponse<bool>> UpdateUserStatusAsync(Guid id, string status, Guid currentUserId)
    {
        if (id == currentUserId)
        {
            return ApiResponse<bool>.Fail("Bạn không thể tự thay đổi trạng thái hoặc khóa tài khoản của chính mình.");
        }

        var user = await _context.Users.FindAsync(id);
        if (user == null)
        {
            return ApiResponse<bool>.Fail("Không tìm thấy người dùng.");
        }

        if (!Enum.TryParse<UserStatus>(status, true, out var newStatus))
        {
            return ApiResponse<bool>.Fail("Trạng thái không hợp lệ. Chỉ chấp nhận Active, Inactive, hoặc Locked.");
        }

        user.Status = newStatus;
        user.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync();
        return ApiResponse<bool>.Ok(true, $"Cập nhật trạng thái tài khoản sang {newStatus} thành công.");
    }

    public async Task<ApiResponse<UserDto>> UpdateUserAsync(Guid id, UpdateUserDto request, Guid currentUserId)
    {
        var user = await _context.Users
            .Include(u => u.UserRoles)
                .ThenInclude(ur => ur.Role)
            .FirstOrDefaultAsync(u => u.Id == id);

        if (user == null)
        {
            return ApiResponse<UserDto>.Fail("Không tìm thấy người dùng.");
        }

        user.FullName = request.FullName.Trim();
        user.Phone = request.Phone?.Trim();

        // Cập nhật trạng thái (nếu có cung cấp)
        if (!string.IsNullOrWhiteSpace(request.Status))
        {
            if (id == currentUserId && request.Status.Equals("Locked", StringComparison.OrdinalIgnoreCase))
            {
                return ApiResponse<UserDto>.Fail("Bạn không thể tự khóa tài khoản của chính mình.");
            }

            if (Enum.TryParse<UserStatus>(request.Status, true, out var newStatus))
            {
                user.Status = newStatus;
            }
        }

        // Cập nhật vai trò (nếu có cung cấp)
        if (!string.IsNullOrWhiteSpace(request.Role))
        {
            var targetRoleName = request.Role.Trim().ToUpperInvariant();

            // Nếu người dùng hiện tại là Admin đang tự đổi vai trò của chính mình -> Ngăn chặn để tránh mất quyền quản trị
            if (id == currentUserId && targetRoleName != "ADMIN")
            {
                return ApiResponse<UserDto>.Fail("Bạn không thể tự hạ cấp vai trò Quản trị viên của chính mình.");
            }

            var targetRole = await _context.Roles.FirstOrDefaultAsync(r => r.Name == targetRoleName);
            if (targetRole == null)
            {
                targetRole = new Role
                {
                    Id = Guid.NewGuid(),
                    Name = targetRoleName,
                    Description = $"Vai trò {targetRoleName}"
                };
                _context.Roles.Add(targetRole);
                await _context.SaveChangesAsync();
            }

            // Gán lại vai trò mới
            user.UserRoles.Clear();
            user.UserRoles.Add(new UserRole
            {
                UserId = user.Id,
                RoleId = targetRole.Id
            });
        }

        user.UpdatedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync();

        return await GetUserByIdAsync(user.Id);
    }
}
