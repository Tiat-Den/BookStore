using BookStore.Application.Common;
using BookStore.Application.DTOs.Auth;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using BookStore.Domain.Enums;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class AuthService : IAuthService
{
    private readonly BookStoreDbContext _context;
    private readonly IJwtTokenGenerator _jwtTokenGenerator;

    public AuthService(BookStoreDbContext context, IJwtTokenGenerator jwtTokenGenerator)
    {
        _context = context;
        _jwtTokenGenerator = jwtTokenGenerator;
    }

    public async Task<ApiResponse<AuthResponseDto>> RegisterAsync(RegisterRequestDto request)
    {
        var email = request.Email.Trim().ToLowerInvariant();

        // BR-01: Email không trùng
        if (await _context.Users.AnyAsync(u => u.Email.ToLower() == email))
        {
            return ApiResponse<AuthResponseDto>.Fail("Email đã được sử dụng trên hệ thống.");
        }

        var customerRole = await _context.Roles.FirstOrDefaultAsync(r => r.Name == "CUSTOMER");
        if (customerRole == null)
        {
            customerRole = new Role
            {
                Id = Guid.NewGuid(),
                Name = "CUSTOMER",
                Description = "Khách hàng mua sách"
            };
            _context.Roles.Add(customerRole);
            await _context.SaveChangesAsync();
        }

        // BR-02: Password phải hash
        var newUser = new User
        {
            Id = Guid.NewGuid(),
            FullName = request.FullName.Trim(),
            Email = email,
            Phone = request.Phone?.Trim(),
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password),
            Status = UserStatus.Active,
            CreatedAt = DateTime.UtcNow
        };

        // Gán Role CUSTOMER
        newUser.UserRoles.Add(new UserRole
        {
            UserId = newUser.Id,
            RoleId = customerRole.Id
        });

        // Tạo sẵn Giỏ hàng & Wishlist
        newUser.Cart = new Cart
        {
            Id = Guid.NewGuid(),
            UserId = newUser.Id,
            CreatedAt = DateTime.UtcNow
        };

        newUser.Wishlist = new Wishlist
        {
            Id = Guid.NewGuid(),
            UserId = newUser.Id,
            CreatedAt = DateTime.UtcNow
        };

        _context.Users.Add(newUser);
        await _context.SaveChangesAsync();

        var roles = new List<string> { customerRole.Name };
        var permissions = new List<string>();

        var token = _jwtTokenGenerator.GenerateToken(newUser, roles, permissions);

        var profile = new UserProfileDto
        {
            Id = newUser.Id,
            FullName = newUser.FullName,
            Email = newUser.Email,
            Phone = newUser.Phone,
            Status = newUser.Status.ToString(),
            Roles = roles,
            Permissions = permissions
        };

        return ApiResponse<AuthResponseDto>.Ok(new AuthResponseDto
        {
            Token = token,
            User = profile
        }, "Đăng ký tài khoản thành công!");
    }

    public async Task<ApiResponse<AuthResponseDto>> LoginAsync(LoginRequestDto request)
    {
        var email = request.Email.Trim().ToLowerInvariant();

        var user = await _context.Users
            .Include(u => u.UserRoles)
                .ThenInclude(ur => ur.Role)
                    .ThenInclude(r => r.RolePermissions)
                        .ThenInclude(rp => rp.Permission)
            .FirstOrDefaultAsync(u => u.Email.ToLower() == email);

        if (user == null)
        {
            return ApiResponse<AuthResponseDto>.Fail("Email hoặc mật khẩu không chính xác.");
        }

        // BR-03: LOCKED không được đăng nhập
        if (user.Status == UserStatus.Locked)
        {
            return ApiResponse<AuthResponseDto>.Fail("Tài khoản của bạn đã bị khóa. Vui lòng liên hệ quản trị viên.");
        }

        // Kiểm tra mật khẩu
        if (!BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash))
        {
            return ApiResponse<AuthResponseDto>.Fail("Email hoặc mật khẩu không chính xác.");
        }

        var roles = user.UserRoles.Select(ur => ur.Role.Name).Distinct().ToList();
        var permissions = user.UserRoles
            .SelectMany(ur => ur.Role.RolePermissions)
            .Select(rp => rp.Permission.Code)
            .Distinct()
            .ToList();

        var token = _jwtTokenGenerator.GenerateToken(user, roles, permissions);

        var profile = new UserProfileDto
        {
            Id = user.Id,
            FullName = user.FullName,
            Email = user.Email,
            Phone = user.Phone,
            Status = user.Status.ToString(),
            Roles = roles,
            Permissions = permissions
        };

        return ApiResponse<AuthResponseDto>.Ok(new AuthResponseDto
        {
            Token = token,
            User = profile
        }, "Đăng nhập thành công!");
    }

    public async Task<ApiResponse<UserProfileDto>> GetProfileAsync(Guid userId)
    {
        var user = await _context.Users
            .Include(u => u.UserRoles)
                .ThenInclude(ur => ur.Role)
                    .ThenInclude(r => r.RolePermissions)
                        .ThenInclude(rp => rp.Permission)
            .FirstOrDefaultAsync(u => u.Id == userId);

        if (user == null)
        {
            return ApiResponse<UserProfileDto>.Fail("Không tìm thấy thông tin người dùng.");
        }

        var roles = user.UserRoles.Select(ur => ur.Role.Name).Distinct().ToList();
        var permissions = user.UserRoles
            .SelectMany(ur => ur.Role.RolePermissions)
            .Select(rp => rp.Permission.Code)
            .Distinct()
            .ToList();

        var profile = new UserProfileDto
        {
            Id = user.Id,
            FullName = user.FullName,
            Email = user.Email,
            Phone = user.Phone,
            Status = user.Status.ToString(),
            Roles = roles,
            Permissions = permissions
        };

        return ApiResponse<UserProfileDto>.Ok(profile);
    }
}
