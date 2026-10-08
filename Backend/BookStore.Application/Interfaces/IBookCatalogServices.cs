using BookStore.Application.Common;
using BookStore.Application.DTOs.Books;

namespace BookStore.Application.Interfaces;

public interface IBookService
{
    Task<ApiResponse<PagedResult<BookDto>>> GetBooksAsync(BookFilterDto filter, bool includeInactive = false);
    Task<ApiResponse<BookDto>> GetBookByIdAsync(Guid id);
    Task<ApiResponse<BookDto>> GetBookBySlugAsync(string slug);
    Task<ApiResponse<BookDto>> CreateBookAsync(BookCreateDto request);
    Task<ApiResponse<BookDto>> UpdateBookAsync(Guid id, BookUpdateDto request);
    Task<ApiResponse<bool>> DeleteBookAsync(Guid id); // BR-08, BR-10: Soft delete
    Task<ApiResponse<bool>> UpdateStatusAsync(Guid id, int status);
}

public interface ICategoryService
{
    Task<ApiResponse<List<CategoryDto>>> GetAllCategoriesAsync(bool activeOnly = true);
    Task<ApiResponse<CategoryDto>> GetCategoryByIdAsync(Guid id);
    Task<ApiResponse<CategoryDto>> CreateCategoryAsync(CategoryCreateUpdateDto request);
    Task<ApiResponse<CategoryDto>> UpdateCategoryAsync(Guid id, CategoryCreateUpdateDto request);
    Task<ApiResponse<bool>> DeleteCategoryAsync(Guid id);
}

public interface IAuthorService
{
    Task<ApiResponse<List<AuthorDto>>> GetAllAuthorsAsync();
    Task<ApiResponse<AuthorDto>> GetAuthorByIdAsync(Guid id);
    Task<ApiResponse<AuthorDto>> CreateAuthorAsync(AuthorCreateUpdateDto request);
    Task<ApiResponse<AuthorDto>> UpdateAuthorAsync(Guid id, AuthorCreateUpdateDto request);
    Task<ApiResponse<bool>> DeleteAuthorAsync(Guid id);
}

public interface IPublisherService
{
    Task<ApiResponse<List<PublisherDto>>> GetAllPublishersAsync();
    Task<ApiResponse<PublisherDto>> GetPublisherByIdAsync(Guid id);
    Task<ApiResponse<PublisherDto>> CreatePublisherAsync(PublisherCreateUpdateDto request);
    Task<ApiResponse<PublisherDto>> UpdatePublisherAsync(Guid id, PublisherCreateUpdateDto request);
    Task<ApiResponse<bool>> DeletePublisherAsync(Guid id);
}
