using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;

namespace BookStore.Application.Utils;

public static class SlugHelper
{
    public static string GenerateSlug(string text)
    {
        if (string.IsNullOrWhiteSpace(text)) return string.Empty;

        // Chuẩn hóa ký tự Unicode và bỏ dấu tiếng Việt
        text = text.Normalize(NormalizationForm.FormD);
        var chars = text.Where(c => CharUnicodeInfo.GetUnicodeCategory(c) != UnicodeCategory.NonSpacingMark).ToArray();
        var cleanStr = new string(chars).Normalize(NormalizationForm.FormC);

        cleanStr = cleanStr.Replace('đ', 'd').Replace('Đ', 'D');

        // Bỏ ký tự đặc biệt, chuyển dấu cách thành gạch ngang
        cleanStr = Regex.Replace(cleanStr, @"[^a-zA-Z0-9\s-]", "");
        cleanStr = Regex.Replace(cleanStr, @"\s+", " ").Trim();
        cleanStr = Regex.Replace(cleanStr, @"\s", "-");

        return cleanStr.ToLowerInvariant();
    }
}
