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
    private readonly IEmailService _emailService;

    public AuthService(BookStoreDbContext context, IJwtTokenGenerator jwtTokenGenerator, IEmailService emailService)
    {
        _context = context;
        _jwtTokenGenerator = jwtTokenGenerator;
        _emailService = emailService;
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
            .Include(u => u.Addresses)
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

        var defaultAddr = user.Addresses.FirstOrDefault(a => a.IsDefault) ?? user.Addresses.FirstOrDefault();
        var addressString = defaultAddr?.AddressLine;

        var profile = new UserProfileDto
        {
            Id = user.Id,
            FullName = user.FullName,
            Email = user.Email,
            Phone = user.Phone,
            Address = addressString,
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
            .Include(u => u.Addresses)
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

        var defaultAddr = user.Addresses.FirstOrDefault(a => a.IsDefault) ?? user.Addresses.FirstOrDefault();
        var addressString = defaultAddr?.AddressLine;

        var profile = new UserProfileDto
        {
            Id = user.Id,
            FullName = user.FullName,
            Email = user.Email,
            Phone = user.Phone,
            Address = addressString,
            Status = user.Status.ToString(),
            Roles = roles,
            Permissions = permissions
        };

        return ApiResponse<UserProfileDto>.Ok(profile);
    }

    public async Task<ApiResponse<UserProfileDto>> UpdateProfileAsync(Guid userId, UpdateProfileRequestDto request)
    {
        var user = await _context.Users
            .Include(u => u.UserRoles)
                .ThenInclude(ur => ur.Role)
            .Include(u => u.Addresses)
            .FirstOrDefaultAsync(u => u.Id == userId);

        if (user == null)
        {
            return ApiResponse<UserProfileDto>.Fail("Không tìm thấy thông tin người dùng.");
        }

        user.FullName = request.FullName.Trim();
        user.Phone = request.Phone?.Trim();
        user.UpdatedAt = DateTime.UtcNow;

        if (request.Address != null)
        {
            var defaultAddr = user.Addresses.FirstOrDefault(a => a.IsDefault) ?? user.Addresses.FirstOrDefault();
            if (defaultAddr != null)
            {
                defaultAddr.AddressLine = request.Address.Trim();
                defaultAddr.ReceiverName = user.FullName;
                defaultAddr.Phone = user.Phone ?? "";
            }
            else if (!string.IsNullOrWhiteSpace(request.Address))
            {
                _context.Addresses.Add(new Address
                {
                    UserId = userId,
                    ReceiverName = user.FullName,
                    Phone = user.Phone ?? "",
                    AddressLine = request.Address.Trim(),
                    Province = "",
                    District = "",
                    Ward = "",
                    IsDefault = true
                });
            }
        }

        await _context.SaveChangesAsync();

        return await GetProfileAsync(userId);
    }

    public async Task<ApiResponse<bool>> ChangePasswordAsync(Guid userId, ChangePasswordRequestDto request)
    {
        var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == userId);
        if (user == null)
        {
            return ApiResponse<bool>.Fail("Không tìm thấy thông tin người dùng.");
        }

        if (!BCrypt.Net.BCrypt.Verify(request.CurrentPassword, user.PasswordHash))
        {
            return ApiResponse<bool>.Fail("Mật khẩu hiện tại không chính xác.");
        }

        user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
        user.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync();

        return ApiResponse<bool>.Ok(true, "Đổi mật khẩu thành công!");
    }

    private static readonly System.Collections.Concurrent.ConcurrentDictionary<string, (string Otp, DateTime ExpiresAt)> _otpCache = new(StringComparer.OrdinalIgnoreCase);

    public async Task<ApiResponse<ForgotPasswordResponseDto>> ForgotPasswordAsync(ForgotPasswordRequestDto request)
    {
        var input = (request.Identifier ?? request.Email ?? request.Phone ?? "").Trim();
        if (string.IsNullOrWhiteSpace(input))
        {
            return ApiResponse<ForgotPasswordResponseDto>.Fail("Vui lòng nhập Email của bạn.");
        }

        var isEmail = input.Contains('@');
        User? user = null;

        if (isEmail)
        {
            var emailLower = input.ToLowerInvariant();
            user = await _context.Users.FirstOrDefaultAsync(u => u.Email.ToLower() == emailLower);
        }
        else
        {
            var cleanPhone = new string(input.Where(char.IsDigit).ToArray());
            user = await _context.Users.FirstOrDefaultAsync(u => u.Phone != null && u.Phone.Replace(" ", "").Replace("-", "").Replace(".", "") == cleanPhone);
        }

        if (user == null)
        {
            return ApiResponse<ForgotPasswordResponseDto>.Fail(isEmail 
                ? "Không tìm thấy tài khoản tương ứng với email này." 
                : "Không tìm thấy tài khoản tương ứng với số điện thoại này.");
        }

        if (user.Status == UserStatus.Locked)
        {
            return ApiResponse<ForgotPasswordResponseDto>.Fail("Tài khoản này hiện đang bị khóa. Vui lòng liên hệ quản trị viên.");
        }

        var otp = Random.Shared.Next(100000, 999999).ToString();
        var cacheKey = user.Id.ToString();
        var expiresAt = DateTime.UtcNow.AddMinutes(15);
        _otpCache[cacheKey] = (otp, expiresAt);
        if (!string.IsNullOrEmpty(user.Email)) _otpCache[user.Email.ToLowerInvariant()] = (otp, expiresAt);
        if (!string.IsNullOrEmpty(user.Phone)) _otpCache[user.Phone.Trim()] = (otp, expiresAt);

        // Gửi email OTP thực tế qua Google SMTP
        var targetEmail = !string.IsNullOrEmpty(user.Email) ? user.Email : (isEmail ? input : null);
        if (string.IsNullOrEmpty(targetEmail))
        {
            return ApiResponse<ForgotPasswordResponseDto>.Fail("Tài khoản này không có email để nhận mã OTP.");
        }

        var sendSuccess = await _emailService.SendOtpEmailAsync(targetEmail, otp, user.FullName);
        if (!sendSuccess)
        {
            return ApiResponse<ForgotPasswordResponseDto>.Fail("Không thể gửi mã xác nhận qua email. Vui lòng kiểm tra lại địa chỉ email hoặc thử lại sau ít phút.");
        }

        return ApiResponse<ForgotPasswordResponseDto>.Ok(new ForgotPasswordResponseDto
        {
            Target = targetEmail,
            Method = "EMAIL",
            Message = $"Mã OTP đã được gửi thành công đến hòm thư {targetEmail}. Vui lòng kiểm tra hộp thư đến (Inbox) hoặc thư mục Spam.",
            DevOtp = otp
        });
    }

    public async Task<ApiResponse<bool>> VerifyOtpAsync(VerifyOtpRequestDto request)
    {
        var input = (request.Identifier ?? request.Email ?? request.Phone ?? "").Trim();
        if (string.IsNullOrWhiteSpace(input))
        {
            return ApiResponse<bool>.Fail("Vui lòng cung cấp Email của bạn.");
        }

        var isEmail = input.Contains('@');
        User? user = null;

        if (isEmail)
        {
            var emailLower = input.ToLowerInvariant();
            user = await _context.Users.FirstOrDefaultAsync(u => u.Email.ToLower() == emailLower);
        }
        else
        {
            var cleanPhone = new string(input.Where(char.IsDigit).ToArray());
            user = await _context.Users.FirstOrDefaultAsync(u => u.Phone != null && u.Phone.Replace(" ", "").Replace("-", "").Replace(".", "") == cleanPhone);
        }

        if (user == null)
        {
            return ApiResponse<bool>.Fail("Không tìm thấy người dùng tương ứng.");
        }

        var cacheKey = user.Id.ToString();
        if (!_otpCache.TryGetValue(cacheKey, out var cacheItem) &&
            !_otpCache.TryGetValue(user.Email.ToLowerInvariant(), out cacheItem) &&
            (user.Phone == null || !_otpCache.TryGetValue(user.Phone.Trim(), out cacheItem)))
        {
            return ApiResponse<bool>.Fail("Mã xác nhận không tồn tại hoặc đã hết hạn. Vui lòng yêu cầu lại mã mới.");
        }

        if (DateTime.UtcNow > cacheItem.ExpiresAt)
        {
            _otpCache.TryRemove(cacheKey, out _);
            return ApiResponse<bool>.Fail("Mã xác nhận đã hết hiệu lực. Vui lòng gửi lại yêu cầu mã mới.");
        }

        if (cacheItem.Otp != request.Otp.Trim())
        {
            return ApiResponse<bool>.Fail("Mã xác nhận (OTP) không chính xác.");
        }

        return ApiResponse<bool>.Ok(true, "Mã xác nhận hợp lệ.");
    }

    public async Task<ApiResponse<bool>> ResetPasswordAsync(ResetPasswordRequestDto request)
    {
        var input = (request.Identifier ?? request.Email ?? request.Phone ?? "").Trim();
        if (string.IsNullOrWhiteSpace(input))
        {
            return ApiResponse<bool>.Fail("Vui lòng cung cấp Email của bạn.");
        }

        var isEmail = input.Contains('@');
        User? user = null;

        if (isEmail)
        {
            var emailLower = input.ToLowerInvariant();
            user = await _context.Users.FirstOrDefaultAsync(u => u.Email.ToLower() == emailLower);
        }
        else
        {
            var cleanPhone = new string(input.Where(char.IsDigit).ToArray());
            user = await _context.Users.FirstOrDefaultAsync(u => u.Phone != null && u.Phone.Replace(" ", "").Replace("-", "").Replace(".", "") == cleanPhone);
        }

        if (user == null)
        {
            return ApiResponse<bool>.Fail("Không tìm thấy người dùng tương ứng.");
        }

        var cacheKey = user.Id.ToString();
        if (!_otpCache.TryGetValue(cacheKey, out var cacheItem) &&
            !_otpCache.TryGetValue(user.Email.ToLowerInvariant(), out cacheItem) &&
            (user.Phone == null || !_otpCache.TryGetValue(user.Phone.Trim(), out cacheItem)))
        {
            return ApiResponse<bool>.Fail("Mã xác nhận không tồn tại hoặc đã hết hạn. Vui lòng yêu cầu lại mã mới.");
        }

        if (DateTime.UtcNow > cacheItem.ExpiresAt)
        {
            _otpCache.TryRemove(cacheKey, out _);
            return ApiResponse<bool>.Fail("Mã xác nhận đã hết hiệu lực. Vui lòng gửi lại yêu cầu mã mới.");
        }

        if (cacheItem.Otp != request.Otp.Trim())
        {
            return ApiResponse<bool>.Fail("Mã xác nhận (OTP) không chính xác.");
        }

        user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.NewPassword);
        user.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync();
        _otpCache.TryRemove(cacheKey, out _);
        if (!string.IsNullOrEmpty(user.Email)) _otpCache.TryRemove(user.Email.ToLowerInvariant(), out _);
        if (!string.IsNullOrEmpty(user.Phone)) _otpCache.TryRemove(user.Phone.Trim(), out _);

        return ApiResponse<bool>.Ok(true, "Đặt lại mật khẩu thành công! Bạn có thể đăng nhập bằng mật khẩu mới.");
    }
}

