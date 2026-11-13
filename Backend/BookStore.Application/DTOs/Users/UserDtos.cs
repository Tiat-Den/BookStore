using System.ComponentModel.DataAnnotations;
using BookStore.Domain.Enums;

namespace BookStore.Application.DTOs.Users;

public class UserDto
{
    public Guid Id { get; set; }
    public string FullName { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public string Status { get; set; } = "Active";
    public DateTime CreatedAt { get; set; }
    public List<string> Roles { get; set; } = new();
}

public class UserFilterDto
{
    public string? Keyword { get; set; }
    public string? Role { get; set; }
    public string? Status { get; set; }
    public int Page { get; set; } = 1;
    public int PageSize { get; set; } = 10;
}

public class CreateEmployeeDto
{
    [Required(ErrorMessage = "Họ tên nhân viên không được để trống")]
    [MaxLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Required(ErrorMessage = "Email không được để trống")]
    [EmailAddress(ErrorMessage = "Email không đúng định dạng")]
    public string Email { get; set; } = string.Empty;

    [Phone(ErrorMessage = "Số điện thoại không đúng định dạng")]
    public string? Phone { get; set; }

    [Required(ErrorMessage = "Mật khẩu không được để trống")]
    [MinLength(6, ErrorMessage = "Mật khẩu phải từ 6 ký tự trở lên")]
    public string Password { get; set; } = string.Empty;
}

public class UpdateUserStatusDto
{
    [Required]
    public string Status { get; set; } = "Active"; // Active, Inactive, Locked
}

public class UpdateUserDto
{
    [Required(ErrorMessage = "Họ tên không được để trống")]
    [MaxLength(100)]
    public string FullName { get; set; } = string.Empty;

    [Phone(ErrorMessage = "Số điện thoại không đúng định dạng")]
    public string? Phone { get; set; }

    public string? Role { get; set; } // "CUSTOMER", "EMPLOYEE", "ADMIN"

    public string? Status { get; set; } // "Active", "Inactive", "Locked"
}
