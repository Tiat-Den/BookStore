using System.ComponentModel.DataAnnotations;

namespace BookStore.Application.DTOs.Auth;

public class RegisterRequestDto
{
    [Required(ErrorMessage = "Họ tên không được để trống")]
    [StringLength(150, MinimumLength = 2, ErrorMessage = "Họ tên từ 2 đến 150 ký tự")]
    public string FullName { get; set; } = string.Empty;

    [Required(ErrorMessage = "Email không được để trống")]
    [EmailAddress(ErrorMessage = "Email không đúng định dạng")]
    public string Email { get; set; } = string.Empty;

    [Phone(ErrorMessage = "Số điện thoại không hợp lệ")]
    public string? Phone { get; set; }

    [Required(ErrorMessage = "Mật khẩu không được để trống")]
    [MinLength(6, ErrorMessage = "Mật khẩu tối thiểu 6 ký tự")]
    public string Password { get; set; } = string.Empty;
}

public class LoginRequestDto
{
    [Required(ErrorMessage = "Email không được để trống")]
    [EmailAddress(ErrorMessage = "Email không đúng định dạng")]
    public string Email { get; set; } = string.Empty;

    [Required(ErrorMessage = "Mật khẩu không được để trống")]
    public string Password { get; set; } = string.Empty;
}

public class AuthResponseDto
{
    public string Token { get; set; } = string.Empty;
    public UserProfileDto User { get; set; } = null!;
}

public class UserProfileDto
{
    public Guid Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public string Status { get; set; } = string.Empty;
    public List<string> Roles { get; set; } = new();
    public List<string> Permissions { get; set; } = new();
}
