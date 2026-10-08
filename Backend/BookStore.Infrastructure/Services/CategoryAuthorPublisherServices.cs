using BookStore.Application.Common;
using BookStore.Application.DTOs.Books;
using BookStore.Application.Interfaces;
using BookStore.Application.Utils;
using BookStore.Domain.Entities;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class CategoryService : ICategoryService
{
    private readonly BookStoreDbContext _context;

    public CategoryService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<List<CategoryDto>>> GetAllCategoriesAsync(bool activeOnly = true)
    {
        var query = _context.Categories
            .AsNoTracking()
            .Include(c => c.BookCategories)
            .Include(c => c.SubCategories)
                .ThenInclude(sc => sc.BookCategories)
            .AsQueryable();

        if (activeOnly)
        {
            query = query.Where(c => c.IsActive);
        }

        var categories = await query.Where(c => c.ParentId == null).ToListAsync();

        var result = categories.Select(c => new CategoryDto
        {
            Id = c.Id,
            ParentId = c.ParentId,
            Name = c.Name,
            Slug = c.Slug,
            Description = c.Description,
            IsActive = c.IsActive,
            BookCount = c.BookCategories.Count,
            SubCategories = c.SubCategories
                .Where(sc => !activeOnly || sc.IsActive)
                .Select(sc => new CategoryDto
                {
                    Id = sc.Id,
                    ParentId = sc.ParentId,
                    Name = sc.Name,
                    Slug = sc.Slug,
                    Description = sc.Description,
                    IsActive = sc.IsActive,
                    BookCount = sc.BookCategories.Count
                }).ToList()
        }).ToList();

        return ApiResponse<List<CategoryDto>>.Ok(result);
    }

    public async Task<ApiResponse<CategoryDto>> GetCategoryByIdAsync(Guid id)
    {
        var c = await _context.Categories
            .AsNoTracking()
            .Include(c => c.BookCategories)
            .Include(c => c.SubCategories)
            .FirstOrDefaultAsync(c => c.Id == id);

        if (c == null)
            return ApiResponse<CategoryDto>.Fail("Không tìm thấy danh mục.");

        var dto = new CategoryDto
        {
            Id = c.Id,
            ParentId = c.ParentId,
            Name = c.Name,
            Slug = c.Slug,
            Description = c.Description,
            IsActive = c.IsActive,
            BookCount = c.BookCategories.Count,
            SubCategories = c.SubCategories.Select(sc => new CategoryDto
            {
                Id = sc.Id,
                ParentId = sc.ParentId,
                Name = sc.Name,
                Slug = sc.Slug,
                Description = sc.Description,
                IsActive = sc.IsActive
            }).ToList()
        };

        return ApiResponse<CategoryDto>.Ok(dto);
    }

    public async Task<ApiResponse<CategoryDto>> CreateCategoryAsync(CategoryCreateUpdateDto request)
    {
        var slug = SlugHelper.GenerateSlug(request.Name);
        var originalSlug = slug;
        var count = 1;
        while (await _context.Categories.AnyAsync(c => c.Slug == slug))
        {
            slug = $"{originalSlug}-{count++}";
        }

        var category = new Category
        {
            Id = Guid.NewGuid(),
            ParentId = request.ParentId,
            Name = request.Name.Trim(),
            Slug = slug,
            Description = request.Description,
            IsActive = request.IsActive,
            CreatedAt = DateTime.UtcNow
        };

        _context.Categories.Add(category);
        await _context.SaveChangesAsync();

        return await GetCategoryByIdAsync(category.Id);
    }

    public async Task<ApiResponse<CategoryDto>> UpdateCategoryAsync(Guid id, CategoryCreateUpdateDto request)
    {
        var category = await _context.Categories.FindAsync(id);
        if (category == null)
            return ApiResponse<CategoryDto>.Fail("Không tìm thấy danh mục.");

        category.Name = request.Name.Trim();
        category.ParentId = request.ParentId;
        category.Description = request.Description;
        category.IsActive = request.IsActive;
        category.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync();
        return await GetCategoryByIdAsync(id);
    }

    public async Task<ApiResponse<bool>> DeleteCategoryAsync(Guid id)
    {
        var category = await _context.Categories.Include(c => c.BookCategories).FirstOrDefaultAsync(c => c.Id == id);
        if (category == null)
            return ApiResponse<bool>.Fail("Không tìm thấy danh mục.");

        if (category.BookCategories.Any())
            return ApiResponse<bool>.Fail("Không thể xóa danh mục đang có sách liên kết.");

        _context.Categories.Remove(category);
        await _context.SaveChangesAsync();
        return ApiResponse<bool>.Ok(true, "Xóa danh mục thành công.");
    }
}

public class AuthorService : IAuthorService
{
    private readonly BookStoreDbContext _context;

    public AuthorService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<List<AuthorDto>>> GetAllAuthorsAsync()
    {
        var authors = await _context.Authors
            .AsNoTracking()
            .Include(a => a.BookAuthors)
            .OrderBy(a => a.Name)
            .Select(a => new AuthorDto
            {
                Id = a.Id,
                Name = a.Name,
                Biography = a.Biography,
                ImageUrl = a.ImageUrl,
                Nationality = a.Nationality,
                IsActive = a.IsActive,
                BookCount = a.BookAuthors.Count
            }).ToListAsync();

        return ApiResponse<List<AuthorDto>>.Ok(authors);
    }

    public async Task<ApiResponse<AuthorDto>> GetAuthorByIdAsync(Guid id)
    {
        var a = await _context.Authors.AsNoTracking().Include(a => a.BookAuthors).FirstOrDefaultAsync(a => a.Id == id);
        if (a == null) return ApiResponse<AuthorDto>.Fail("Không tìm thấy tác giả.");

        return ApiResponse<AuthorDto>.Ok(new AuthorDto
        {
            Id = a.Id,
            Name = a.Name,
            Biography = a.Biography,
            ImageUrl = a.ImageUrl,
            Nationality = a.Nationality,
            IsActive = a.IsActive,
            BookCount = a.BookAuthors.Count
        });
    }

    public async Task<ApiResponse<AuthorDto>> CreateAuthorAsync(AuthorCreateUpdateDto request)
    {
        var author = new Author
        {
            Id = Guid.NewGuid(),
            Name = request.Name.Trim(),
            Biography = request.Biography,
            ImageUrl = request.ImageUrl,
            Nationality = request.Nationality,
            IsActive = request.IsActive
        };
        _context.Authors.Add(author);
        await _context.SaveChangesAsync();

        return await GetAuthorByIdAsync(author.Id);
    }

    public async Task<ApiResponse<AuthorDto>> UpdateAuthorAsync(Guid id, AuthorCreateUpdateDto request)
    {
        var author = await _context.Authors.FindAsync(id);
        if (author == null) return ApiResponse<AuthorDto>.Fail("Không tìm thấy tác giả.");

        author.Name = request.Name.Trim();
        author.Biography = request.Biography;
        author.ImageUrl = request.ImageUrl;
        author.Nationality = request.Nationality;
        author.IsActive = request.IsActive;

        await _context.SaveChangesAsync();
        return await GetAuthorByIdAsync(id);
    }

    public async Task<ApiResponse<bool>> DeleteAuthorAsync(Guid id)
    {
        var author = await _context.Authors.Include(a => a.BookAuthors).FirstOrDefaultAsync(a => a.Id == id);
        if (author == null) return ApiResponse<bool>.Fail("Không tìm thấy tác giả.");
        if (author.BookAuthors.Any()) return ApiResponse<bool>.Fail("Không thể xóa tác giả đang có sách liên kết.");

        _context.Authors.Remove(author);
        await _context.SaveChangesAsync();
        return ApiResponse<bool>.Ok(true, "Xóa tác giả thành công.");
    }
}

public class PublisherService : IPublisherService
{
    private readonly BookStoreDbContext _context;

    public PublisherService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<List<PublisherDto>>> GetAllPublishersAsync()
    {
        var publishers = await _context.Publishers
            .AsNoTracking()
            .Include(p => p.Books)
            .OrderBy(p => p.Name)
            .Select(p => new PublisherDto
            {
                Id = p.Id,
                Name = p.Name,
                Address = p.Address,
                Email = p.Email,
                Phone = p.Phone,
                Website = p.Website,
                IsActive = p.IsActive,
                BookCount = p.Books.Count
            }).ToListAsync();

        return ApiResponse<List<PublisherDto>>.Ok(publishers);
    }

    public async Task<ApiResponse<PublisherDto>> GetPublisherByIdAsync(Guid id)
    {
        var p = await _context.Publishers.AsNoTracking().Include(p => p.Books).FirstOrDefaultAsync(p => p.Id == id);
        if (p == null) return ApiResponse<PublisherDto>.Fail("Không tìm thấy nhà xuất bản.");

        return ApiResponse<PublisherDto>.Ok(new PublisherDto
        {
            Id = p.Id,
            Name = p.Name,
            Address = p.Address,
            Email = p.Email,
            Phone = p.Phone,
            Website = p.Website,
            IsActive = p.IsActive,
            BookCount = p.Books.Count
        });
    }

    public async Task<ApiResponse<PublisherDto>> CreatePublisherAsync(PublisherCreateUpdateDto request)
    {
        var publisher = new Publisher
        {
            Id = Guid.NewGuid(),
            Name = request.Name.Trim(),
            Address = request.Address,
            Email = request.Email,
            Phone = request.Phone,
            Website = request.Website,
            IsActive = request.IsActive
        };
        _context.Publishers.Add(publisher);
        await _context.SaveChangesAsync();

        return await GetPublisherByIdAsync(publisher.Id);
    }

    public async Task<ApiResponse<PublisherDto>> UpdatePublisherAsync(Guid id, PublisherCreateUpdateDto request)
    {
        var publisher = await _context.Publishers.FindAsync(id);
        if (publisher == null) return ApiResponse<PublisherDto>.Fail("Không tìm thấy nhà xuất bản.");

        publisher.Name = request.Name.Trim();
        publisher.Address = request.Address;
        publisher.Email = request.Email;
        publisher.Phone = request.Phone;
        publisher.Website = request.Website;
        publisher.IsActive = request.IsActive;

        await _context.SaveChangesAsync();
        return await GetPublisherByIdAsync(id);
    }

    public async Task<ApiResponse<bool>> DeletePublisherAsync(Guid id)
    {
        var publisher = await _context.Publishers.Include(p => p.Books).FirstOrDefaultAsync(p => p.Id == id);
        if (publisher == null) return ApiResponse<bool>.Fail("Không tìm thấy nhà xuất bản.");
        if (publisher.Books.Any()) return ApiResponse<bool>.Fail("Không thể xóa NXB đang có sách liên kết.");

        _context.Publishers.Remove(publisher);
        await _context.SaveChangesAsync();
        return ApiResponse<bool>.Ok(true, "Xóa NXB thành công.");
    }
}
