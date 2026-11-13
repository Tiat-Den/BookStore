using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using BookStore.Application.DTOs.Chat;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class BookSearchService : IBookSearchService
{
    private readonly BookStoreDbContext _context;

    public BookSearchService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<List<BookCardDto>> SearchBooksAsync(
        string? keyword,
        string? category,
        decimal? minPrice,
        decimal? maxPrice,
        int limit = 6,
        CancellationToken ct = default)
    {
        var query = _context.Books
            .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
            .Include(b => b.BookCategories).ThenInclude(bc => bc.Category)
            .Include(b => b.Inventory)
            .AsNoTracking()
            .AsQueryable();

        bool isBestSellerIntent = false;
        if (!string.IsNullOrWhiteSpace(keyword))
        {
            var lower = keyword.Trim().ToLower();
            if (lower.Contains("bán chạy") || lower.Contains("ban chay") || 
                lower.Contains("bestseller") || lower.Contains("best seller") || 
                lower.Contains("hay nhất") || lower.Contains("hay nhat") || 
                lower.Contains("nổi bật") || lower.Contains("noi bat") ||
                lower.Contains("phổ biến") || lower.Contains("pho bien") ||
                lower.Contains("hot"))
            {
                isBestSellerIntent = true;
                var cleanedKw = lower
                    .Replace("sách bán chạy nhất", "")
                    .Replace("sach ban chay nhat", "")
                    .Replace("sách bán chạy", "")
                    .Replace("sach ban chay", "")
                    .Replace("bán chạy nhất", "")
                    .Replace("ban chay nhat", "")
                    .Replace("bán chạy", "")
                    .Replace("ban chay", "")
                    .Replace("bestseller", "")
                    .Replace("best seller", "")
                    .Replace("gợi ý sách hay nhất", "")
                    .Replace("goi y sach hay nhat", "")
                    .Replace("sách hay nhất", "")
                    .Replace("sach hay nhat", "")
                    .Replace("hay nhất", "")
                    .Replace("hay nhat", "")
                    .Replace("sách nổi bật", "")
                    .Replace("sach noi bat", "")
                    .Replace("sách hot", "")
                    .Replace("sach hot", "")
                    .Trim();

                keyword = cleanedKw;
            }
        }

        // 1. Keyword filter (chỉ áp dụng nếu sau khi lọc intent còn từ khóa thực tế)
        if (!string.IsNullOrWhiteSpace(keyword) && keyword.Length >= 2)
        {
            var kw = keyword.Trim().ToLower();
            query = query.Where(b => 
                b.Title.ToLower().Contains(kw) ||
                b.BookAuthors.Any(ba => ba.Author.Name.ToLower().Contains(kw)) ||
                (b.Description != null && b.Description.ToLower().Contains(kw)));
        }

        // 2. Category filter
        if (!string.IsNullOrWhiteSpace(category))
        {
            var cat = category.Trim().ToLower();
            query = query.Where(b => b.BookCategories.Any(bc => bc.Category.Name.ToLower().Contains(cat)));
        }

        // 3. Price filter (So sánh với SalePrice hoặc DiscountPrice nếu có)
        if (minPrice.HasValue)
        {
            query = query.Where(b => (b.DiscountPrice ?? b.SalePrice) >= minPrice.Value);
        }

        if (maxPrice.HasValue)
        {
            query = query.Where(b => (b.DiscountPrice ?? b.SalePrice) <= maxPrice.Value);
        }

        // 4. Ưu tiên sách theo ý định: nếu hỏi bán chạy thì sắp xếp theo SoldQuantity giảm dần
        IOrderedQueryable<Book> orderedQuery;
        if (isBestSellerIntent)
        {
            orderedQuery = query
                .OrderByDescending(b => b.SoldQuantity)
                .ThenByDescending(b => b.Inventory != null && b.Inventory.Quantity > 0)
                .ThenByDescending(b => b.CreatedAt);
        }
        else
        {
            orderedQuery = query
                .OrderByDescending(b => b.Inventory != null && b.Inventory.Quantity > 0)
                .ThenByDescending(b => b.CreatedAt);
        }

        var books = await orderedQuery
            .Take(Math.Min(limit, 10))
            .ToListAsync(ct);

        return books.Select(b => new BookCardDto
        {
            Id = b.Id,
            Title = b.Title,
            Author = string.Join(", ", b.BookAuthors.Select(ba => ba.Author.Name)),
            Price = b.DiscountPrice ?? b.SalePrice,
            OriginalPrice = b.DiscountPrice.HasValue ? b.SalePrice : null,
            ImageUrl = b.CoverImageUrl,
            InStock = b.Inventory != null && b.Inventory.Quantity > 0,
            Slug = b.Slug
        }).ToList();
    }

    public async Task<BookCardDto?> GetBookDetailAsync(string bookIdOrTitle, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(bookIdOrTitle)) return null;

        var query = _context.Books
            .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
            .Include(b => b.Inventory)
            .AsNoTracking()
            .AsQueryable();

        if (Guid.TryParse(bookIdOrTitle, out var bookId))
        {
            query = query.Where(b => b.Id == bookId);
        }
        else
        {
            var kw = bookIdOrTitle.Trim().ToLower();
            query = query.Where(b => b.Title.ToLower().Contains(kw) || b.Slug.ToLower().Contains(kw));
        }

        var b = await query.FirstOrDefaultAsync(ct);
        if (b == null) return null;

        return new BookCardDto
        {
            Id = b.Id,
            Title = b.Title,
            Author = string.Join(", ", b.BookAuthors.Select(ba => ba.Author.Name)),
            Price = b.DiscountPrice ?? b.SalePrice,
            OriginalPrice = b.DiscountPrice.HasValue ? b.SalePrice : null,
            ImageUrl = b.CoverImageUrl,
            InStock = b.Inventory != null && b.Inventory.Quantity > 0,
            Slug = b.Slug
        };
    }

    public async Task<string?> GetPolicyAnswerAsync(string topic, CancellationToken ct = default)
    {
        if (string.IsNullOrWhiteSpace(topic)) return null;

        var kw = topic.Trim().ToLower();
        var policies = await _context.PolicyDocuments
            .Where(p => p.Status == "Approved" && 
                (p.Title.ToLower().Contains(kw) || p.Content.ToLower().Contains(kw) || p.Category.ToLower().Contains(kw)))
            .AsNoTracking()
            .ToListAsync(ct);

        if (policies.Count == 0)
        {
            // Fallback lấy toàn bộ chính sách đã duyệt để hỗ trợ AI
            var allApproved = await _context.PolicyDocuments
                .Where(p => p.Status == "Approved")
                .AsNoTracking()
                .Take(5)
                .ToListAsync(ct);

            if (allApproved.Count == 0) return null;
            return string.Join("\n\n", allApproved.Select(p => $"[{p.Title}]: {p.Content}"));
        }

        return string.Join("\n\n", policies.Select(p => $"[{p.Title}]: {p.Content}"));
    }
}
