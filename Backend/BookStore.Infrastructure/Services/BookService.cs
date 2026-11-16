using BookStore.Application.Common;
using BookStore.Application.DTOs.Books;
using BookStore.Application.Interfaces;
using BookStore.Application.Utils;
using BookStore.Domain.Entities;
using BookStore.Domain.Enums;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class BookService : IBookService
{
    private readonly BookStoreDbContext _context;

    public BookService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<PagedResult<BookDto>>> GetBooksAsync(BookFilterDto filter, bool includeInactive = false)
    {
        var query = _context.Books
            .AsNoTracking()
            .AsQueryable();

        // 1. Soft delete & Active status filter
        query = query.Where(b => !b.IsDeleted);
        if (!includeInactive)
        {
            query = query.Where(b => b.Status == BookStatus.Active);
        }

        // 2. Keyword filter (Title, ISBN, Slug, Author, Publisher, Category)
        if (!string.IsNullOrWhiteSpace(filter.Keyword))
        {
            var kw = filter.Keyword.Trim().ToLower();
            query = query.Where(b =>
                b.Title.ToLower().Contains(kw) ||
                b.ISBN.ToLower().Contains(kw) ||
                b.Slug.ToLower().Contains(kw) ||
                b.BookAuthors.Any(ba => ba.Author.Name.ToLower().Contains(kw)) ||
                (b.Publisher != null && b.Publisher.Name.ToLower().Contains(kw)) ||
                b.BookCategories.Any(bc => bc.Category.Name.ToLower().Contains(kw))
            );
        }

        // 3. Category filter
        if (filter.CategoryId.HasValue)
        {
            var catId = filter.CategoryId.Value;
            var catIds = _context.Categories
                .Where(c => c.Id == catId || c.ParentId == catId)
                .Select(c => c.Id);

            var bookIdsInCategory = _context.BookCategories
                .Where(bc => catIds.Contains(bc.CategoryId))
                .Select(bc => bc.BookId);

            query = query.Where(b => bookIdsInCategory.Contains(b.Id));
        }

        // 4. Author filter
        if (filter.AuthorId.HasValue)
        {
            var authorId = filter.AuthorId.Value;
            var bookIdsWithAuthor = _context.BookAuthors
                .Where(ba => ba.AuthorId == authorId)
                .Select(ba => ba.BookId);

            query = query.Where(b => bookIdsWithAuthor.Contains(b.Id));
        }

        // 5. Publisher filter
        if (filter.PublisherId.HasValue)
        {
            query = query.Where(b => b.PublisherId == filter.PublisherId.Value);
        }

        // 6. Price filter (min & max price)
        if (filter.MinPrice.HasValue)
        {
            query = query.Where(b => (b.DiscountPrice ?? b.SalePrice) >= filter.MinPrice.Value);
        }
        if (filter.MaxPrice.HasValue)
        {
            query = query.Where(b => (b.DiscountPrice ?? b.SalePrice) <= filter.MaxPrice.Value);
        }

        // 7. Sorting
        query = filter.Sort?.ToLower() switch
        {
            "price_asc" => query.OrderBy(b => b.DiscountPrice ?? b.SalePrice),
            "price_desc" => query.OrderByDescending(b => b.DiscountPrice ?? b.SalePrice),
            "best_seller" => query.OrderByDescending(b => b.SoldQuantity),
            "title" => query.OrderBy(b => b.Title),
            _ => query.OrderByDescending(b => b.CreatedAt) // default: newest
        };

        // 8. Pagination
        var totalCount = await query.CountAsync();
        var page = filter.Page > 0 ? filter.Page : 1;
        var pageSize = filter.PageSize > 0 ? filter.PageSize : 12;

        var rawBooks = await query
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .Select(b => new
            {
                b.Id,
                b.ISBN,
                b.Title,
                b.Slug,
                b.Description,
                b.CoverImageUrl,
                b.ImportPrice,
                b.SalePrice,
                b.DiscountPrice,
                b.StockQuantity,
                b.SoldQuantity,
                b.PublisherId,
                PublisherName = b.Publisher != null ? b.Publisher.Name : null,
                b.PublishedYear,
                b.PageCount,
                b.Language,
                b.Dimensions,
                b.Weight,
                b.Status,
                b.IsDeleted,
                b.CreatedAt,
                b.UpdatedAt
            })
            .ToListAsync();

        var bookIds = rawBooks.Select(b => b.Id).ToList();

        var authorsGroup = await _context.BookAuthors
            .AsNoTracking()
            .Where(ba => bookIds.Contains(ba.BookId))
            .Select(ba => new { ba.BookId, ba.AuthorId, ba.Author.Name })
            .ToListAsync();

        var categoriesGroup = await _context.BookCategories
            .AsNoTracking()
            .Where(bc => bookIds.Contains(bc.BookId))
            .Select(bc => new { bc.BookId, bc.CategoryId, bc.Category.Name, bc.Category.Slug })
            .ToListAsync();

        var dtoList = rawBooks.Select(b => new BookDto
        {
            Id = b.Id,
            ISBN = b.ISBN,
            Title = b.Title,
            Slug = b.Slug,
            Description = b.Description,
            CoverImageUrl = b.CoverImageUrl,
            ImportPrice = b.ImportPrice,
            SalePrice = b.SalePrice,
            DiscountPrice = b.DiscountPrice,
            StockQuantity = b.StockQuantity,
            SoldQuantity = b.SoldQuantity,
            PublisherId = b.PublisherId,
            PublisherName = b.PublisherName,
            PublishedYear = b.PublishedYear,
            PageCount = b.PageCount,
            Language = b.Language,
            Dimensions = b.Dimensions,
            Weight = b.Weight,
            Status = b.Status,
            IsDeleted = b.IsDeleted,
            CreatedAt = b.CreatedAt,
            UpdatedAt = b.UpdatedAt,
            Authors = authorsGroup
                .Where(a => a.BookId == b.Id)
                .Select(a => new AuthorBriefDto { Id = a.AuthorId, Name = a.Name })
                .ToList(),
            Categories = categoriesGroup
                .Where(c => c.BookId == b.Id)
                .Select(c => new CategoryBriefDto { Id = c.CategoryId, Name = c.Name, Slug = c.Slug })
                .ToList()
        }).ToList();

        var result = new PagedResult<BookDto>
        {
            Items = dtoList,
            TotalCount = totalCount,
            PageIndex = page,
            PageSize = pageSize
        };

        return ApiResponse<PagedResult<BookDto>>.Ok(result);
    }

    public async Task<ApiResponse<BookDto>> GetBookByIdAsync(Guid id)
    {
        var book = await _context.Books
            .AsNoTracking()
            .Include(b => b.Publisher)
            .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
            .Include(b => b.BookCategories).ThenInclude(bc => bc.Category)
            .FirstOrDefaultAsync(b => b.Id == id && !b.IsDeleted);

        if (book == null)
            return ApiResponse<BookDto>.Fail("Không tìm thấy sách.");

        return ApiResponse<BookDto>.Ok(MapToDto(book));
    }

    public async Task<ApiResponse<BookDto>> GetBookBySlugAsync(string slug)
    {
        var book = await _context.Books
            .AsNoTracking()
            .Include(b => b.Publisher)
            .Include(b => b.BookAuthors).ThenInclude(ba => ba.Author)
            .Include(b => b.BookCategories).ThenInclude(bc => bc.Category)
            .FirstOrDefaultAsync(b => b.Slug == slug && !b.IsDeleted);

        if (book == null)
            return ApiResponse<BookDto>.Fail("Không tìm thấy sách.");

        return ApiResponse<BookDto>.Ok(MapToDto(book));
    }

    public async Task<ApiResponse<BookDto>> CreateBookAsync(BookCreateDto request)
    {
        // BR-05: ISBN không trùng
        if (await _context.Books.AnyAsync(b => b.ISBN == request.ISBN.Trim()))
        {
            return ApiResponse<BookDto>.Fail("Mã ISBN đã tồn tại trên hệ thống.");
        }

        // BR-06: Giá không âm
        if (request.SalePrice < 0 || request.ImportPrice < 0 || (request.DiscountPrice.HasValue && request.DiscountPrice.Value < 0))
        {
            return ApiResponse<BookDto>.Fail("Giá sách không được nhỏ hơn 0.");
        }

        var slug = SlugHelper.GenerateSlug(request.Title);
        var baseSlug = slug;
        var counter = 1;
        while (await _context.Books.AnyAsync(b => b.Slug == slug))
        {
            slug = $"{baseSlug}-{counter++}";
        }

        var book = new Book
        {
            Id = Guid.NewGuid(),
            ISBN = request.ISBN.Trim(),
            Title = request.Title.Trim(),
            Slug = slug,
            Description = request.Description,
            CoverImageUrl = request.CoverImageUrl,
            ImportPrice = request.ImportPrice,
            SalePrice = request.SalePrice,
            DiscountPrice = request.DiscountPrice,
            StockQuantity = request.StockQuantity,
            SoldQuantity = 0,
            PublisherId = request.PublisherId,
            PublishedYear = request.PublishedYear,
            PageCount = request.PageCount,
            Language = request.Language,
            Dimensions = request.Dimensions,
            Weight = request.Weight,
            Status = BookStatus.Active,
            IsDeleted = false,
            CreatedAt = DateTime.UtcNow
        };

        // Gán tác giả
        if (!string.IsNullOrWhiteSpace(request.AuthorName))
        {
            var authorName = request.AuthorName.Trim();
            var author = await _context.Authors.FirstOrDefaultAsync(a => a.Name.ToLower() == authorName.ToLower());
            if (author == null)
            {
                author = new Author
                {
                    Id = Guid.NewGuid(),
                    Name = authorName,
                    Nationality = "Việt Nam"
                };
                _context.Authors.Add(author);
                await _context.SaveChangesAsync();
            }
            book.BookAuthors.Add(new BookAuthor { BookId = book.Id, AuthorId = author.Id });
        }
        else if (request.AuthorIds.Any())
        {
            foreach (var authorId in request.AuthorIds)
            {
                book.BookAuthors.Add(new BookAuthor { BookId = book.Id, AuthorId = authorId });
            }
        }

        // Gán danh mục
        if (request.CategoryIds.Any())
        {
            foreach (var categoryId in request.CategoryIds)
            {
                book.BookCategories.Add(new BookCategory { BookId = book.Id, CategoryId = categoryId });
            }
        }

        // Tạo sẵn Inventory
        book.Inventory = new Inventory
        {
            Id = Guid.NewGuid(),
            BookId = book.Id,
            Quantity = request.StockQuantity,
            ReservedQuantity = 0,
            UpdatedAt = DateTime.UtcNow
        };

        _context.Books.Add(book);
        await _context.SaveChangesAsync();

        return await GetBookByIdAsync(book.Id);
    }

    public async Task<ApiResponse<BookDto>> UpdateBookAsync(Guid id, BookUpdateDto request)
    {
        var book = await _context.Books
            .Include(b => b.BookAuthors)
            .Include(b => b.BookCategories)
            .Include(b => b.Inventory)
            .FirstOrDefaultAsync(b => b.Id == id && !b.IsDeleted);

        if (book == null)
            return ApiResponse<BookDto>.Fail("Không tìm thấy sách.");

        // BR-06: Giá không âm
        if (request.SalePrice < 0 || request.ImportPrice < 0 || (request.DiscountPrice.HasValue && request.DiscountPrice.Value < 0))
        {
            return ApiResponse<BookDto>.Fail("Giá sách không được nhỏ hơn 0.");
        }

        book.Title = request.Title.Trim();
        book.Description = request.Description;
        book.CoverImageUrl = request.CoverImageUrl;
        book.ImportPrice = request.ImportPrice;
        book.SalePrice = request.SalePrice;
        book.DiscountPrice = request.DiscountPrice;
        book.StockQuantity = request.StockQuantity;
        book.PublisherId = request.PublisherId;
        book.PublishedYear = request.PublishedYear;
        book.PageCount = request.PageCount;
        book.Language = request.Language;
        book.Dimensions = request.Dimensions;
        book.Weight = request.Weight;
        book.Status = request.Status == BookStatus.Draft && book.Status == BookStatus.Active ? BookStatus.Active : request.Status;
        book.UpdatedAt = DateTime.UtcNow;

        // Cập nhật quan hệ Author (nếu được cung cấp qua tên hoặc ID)
        if (!string.IsNullOrWhiteSpace(request.AuthorName))
        {
            var authorName = request.AuthorName.Trim();
            var author = await _context.Authors.FirstOrDefaultAsync(a => a.Name.ToLower() == authorName.ToLower());
            if (author == null)
            {
                author = new Author
                {
                    Id = Guid.NewGuid(),
                    Name = authorName,
                    Nationality = "Việt Nam"
                };
                _context.Authors.Add(author);
                await _context.SaveChangesAsync();
            }
            book.BookAuthors.Clear();
            book.BookAuthors.Add(new BookAuthor { BookId = book.Id, AuthorId = author.Id });
        }
        else if (request.AuthorIds != null && request.AuthorIds.Count > 0)
        {
            book.BookAuthors.Clear();
            foreach (var authorId in request.AuthorIds)
            {
                book.BookAuthors.Add(new BookAuthor { BookId = book.Id, AuthorId = authorId });
            }
        }

        // Cập nhật quan hệ Category (nếu được cung cấp)
        if (request.CategoryIds != null && request.CategoryIds.Count > 0)
        {
            book.BookCategories.Clear();
            foreach (var categoryId in request.CategoryIds)
            {
                book.BookCategories.Add(new BookCategory { BookId = book.Id, CategoryId = categoryId });
            }
        }

        // Cập nhật Inventory tương ứng
        if (book.Inventory != null)
        {
            book.Inventory.Quantity = request.StockQuantity;
            book.Inventory.UpdatedAt = DateTime.UtcNow;
        }

        await _context.SaveChangesAsync();
        return await GetBookByIdAsync(id);
    }

    public async Task<ApiResponse<bool>> DeleteBookAsync(Guid id)
    {
        var book = await _context.Books.FirstOrDefaultAsync(b => b.Id == id && !b.IsDeleted);
        if (book == null)
            return ApiResponse<bool>.Fail("Không tìm thấy sách.");

        // BR-08, BR-10: Soft delete
        book.IsDeleted = true;
        book.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync();
        return ApiResponse<bool>.Ok(true, "Xóa sách thành công.");
    }

    public async Task<ApiResponse<bool>> UpdateStatusAsync(Guid id, int status)
    {
        var book = await _context.Books.FirstOrDefaultAsync(b => b.Id == id && !b.IsDeleted);
        if (book == null)
            return ApiResponse<bool>.Fail("Không tìm thấy sách.");

        book.Status = (BookStatus)status;
        book.UpdatedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync();

        return ApiResponse<bool>.Ok(true, "Cập nhật trạng thái sách thành công.");
    }

    private static BookDto MapToDto(Book b)
    {
        return new BookDto
        {
            Id = b.Id,
            ISBN = b.ISBN,
            Title = b.Title,
            Slug = b.Slug,
            Description = b.Description,
            CoverImageUrl = b.CoverImageUrl,
            ImportPrice = b.ImportPrice,
            SalePrice = b.SalePrice,
            DiscountPrice = b.DiscountPrice,
            StockQuantity = b.StockQuantity,
            SoldQuantity = b.SoldQuantity,
            PublisherId = b.PublisherId,
            PublisherName = b.Publisher?.Name,
            PublishedYear = b.PublishedYear,
            PageCount = b.PageCount,
            Language = b.Language,
            Dimensions = b.Dimensions,
            Weight = b.Weight,
            Status = b.Status,
            IsDeleted = b.IsDeleted,
            CreatedAt = b.CreatedAt,
            UpdatedAt = b.UpdatedAt,
            Authors = b.BookAuthors.Select(ba => new AuthorBriefDto
            {
                Id = ba.AuthorId,
                Name = ba.Author.Name
            }).ToList(),
            Categories = b.BookCategories.Select(bc => new CategoryBriefDto
            {
                Id = bc.CategoryId,
                Name = bc.Category.Name,
                Slug = bc.Category.Slug
            }).ToList()
        };
    }
}
