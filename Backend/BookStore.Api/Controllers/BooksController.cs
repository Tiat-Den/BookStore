using BookStore.Application.Common;
using BookStore.Application.DTOs.Books;
using BookStore.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class BooksController : ControllerBase
{
    private readonly IBookService _bookService;

    public BooksController(IBookService bookService)
    {
        _bookService = bookService;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<PagedResult<BookDto>>>> GetBooks([FromQuery] BookFilterDto filter)
    {
        var isManager = User.IsInRole("ADMIN") || User.IsInRole("EMPLOYEE");
        var result = await _bookService.GetBooksAsync(filter, includeInactive: isManager);
        return Ok(result);
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<ApiResponse<BookDto>>> GetBookById(Guid id)
    {
        var result = await _bookService.GetBookByIdAsync(id);
        if (!result.Success)
            return NotFound(result);

        return Ok(result);
    }

    [HttpGet("slug/{slug}")]
    public async Task<ActionResult<ApiResponse<BookDto>>> GetBookBySlug(string slug)
    {
        var result = await _bookService.GetBookBySlugAsync(slug);
        if (!result.Success)
            return NotFound(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPost]
    public async Task<ActionResult<ApiResponse<BookDto>>> CreateBook([FromBody] BookCreateDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<BookDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _bookService.CreateBookAsync(request);
        if (!result.Success)
            return BadRequest(result);

        return CreatedAtAction(nameof(GetBookById), new { id = result.Data!.Id }, result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPut("{id:guid}")]
    public async Task<ActionResult<ApiResponse<BookDto>>> UpdateBook(Guid id, [FromBody] BookUpdateDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<BookDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _bookService.UpdateBookAsync(id, request);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpDelete("{id:guid}")]
    public async Task<ActionResult<ApiResponse<bool>>> DeleteBook(Guid id)
    {
        var result = await _bookService.DeleteBookAsync(id);
        if (!result.Success)
            return NotFound(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPatch("{id:guid}/status")]
    public async Task<ActionResult<ApiResponse<bool>>> UpdateStatus(Guid id, [FromBody] int status)
    {
        var result = await _bookService.UpdateStatusAsync(id, status);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }
}
