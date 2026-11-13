using BookStore.Application.Common;
using BookStore.Application.DTOs.Books;
using BookStore.Application.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace BookStore.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class CategoriesController : ControllerBase
{
    private readonly ICategoryService _categoryService;

    public CategoriesController(ICategoryService categoryService)
    {
        _categoryService = categoryService;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<List<CategoryDto>>>> GetCategories([FromQuery] bool activeOnly = true)
    {
        var result = await _categoryService.GetAllCategoriesAsync(activeOnly);
        return Ok(result);
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<ApiResponse<CategoryDto>>> GetCategoryById(Guid id)
    {
        var result = await _categoryService.GetCategoryByIdAsync(id);
        if (!result.Success)
            return NotFound(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPost]
    public async Task<ActionResult<ApiResponse<CategoryDto>>> CreateCategory([FromBody] CategoryCreateUpdateDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<CategoryDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _categoryService.CreateCategoryAsync(request);
        return CreatedAtAction(nameof(GetCategoryById), new { id = result.Data!.Id }, result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPut("{id:guid}")]
    public async Task<ActionResult<ApiResponse<CategoryDto>>> UpdateCategory(Guid id, [FromBody] CategoryCreateUpdateDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<CategoryDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _categoryService.UpdateCategoryAsync(id, request);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpDelete("{id:guid}")]
    public async Task<ActionResult<ApiResponse<bool>>> DeleteCategory(Guid id)
    {
        var result = await _categoryService.DeleteCategoryAsync(id);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }
}

[ApiController]
[Route("api/[controller]")]
public class AuthorsController : ControllerBase
{
    private readonly IAuthorService _authorService;

    public AuthorsController(IAuthorService authorService)
    {
        _authorService = authorService;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<List<AuthorDto>>>> GetAuthors()
    {
        var result = await _authorService.GetAllAuthorsAsync();
        return Ok(result);
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<ApiResponse<AuthorDto>>> GetAuthorById(Guid id)
    {
        var result = await _authorService.GetAuthorByIdAsync(id);
        if (!result.Success)
            return NotFound(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPost]
    public async Task<ActionResult<ApiResponse<AuthorDto>>> CreateAuthor([FromBody] AuthorCreateUpdateDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<AuthorDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _authorService.CreateAuthorAsync(request);
        return CreatedAtAction(nameof(GetAuthorById), new { id = result.Data!.Id }, result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPut("{id:guid}")]
    public async Task<ActionResult<ApiResponse<AuthorDto>>> UpdateAuthor(Guid id, [FromBody] AuthorCreateUpdateDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<AuthorDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _authorService.UpdateAuthorAsync(id, request);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpDelete("{id:guid}")]
    public async Task<ActionResult<ApiResponse<bool>>> DeleteAuthor(Guid id)
    {
        var result = await _authorService.DeleteAuthorAsync(id);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }
}

[ApiController]
[Route("api/[controller]")]
public class PublishersController : ControllerBase
{
    private readonly IPublisherService _publisherService;

    public PublishersController(IPublisherService publisherService)
    {
        _publisherService = publisherService;
    }

    [HttpGet]
    public async Task<ActionResult<ApiResponse<List<PublisherDto>>>> GetPublishers()
    {
        var result = await _publisherService.GetAllPublishersAsync();
        return Ok(result);
    }

    [HttpGet("{id:guid}")]
    public async Task<ActionResult<ApiResponse<PublisherDto>>> GetPublisherById(Guid id)
    {
        var result = await _publisherService.GetPublisherByIdAsync(id);
        if (!result.Success)
            return NotFound(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPost]
    public async Task<ActionResult<ApiResponse<PublisherDto>>> CreatePublisher([FromBody] PublisherCreateUpdateDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<PublisherDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _publisherService.CreatePublisherAsync(request);
        return CreatedAtAction(nameof(GetPublisherById), new { id = result.Data!.Id }, result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpPut("{id:guid}")]
    public async Task<ActionResult<ApiResponse<PublisherDto>>> UpdatePublisher(Guid id, [FromBody] PublisherCreateUpdateDto request)
    {
        if (!ModelState.IsValid)
        {
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            return BadRequest(ApiResponse<PublisherDto>.Fail("Dữ liệu không hợp lệ.", errors));
        }

        var result = await _publisherService.UpdatePublisherAsync(id, request);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }

    [Authorize(Roles = "ADMIN,EMPLOYEE")]
    [HttpDelete("{id:guid}")]
    public async Task<ActionResult<ApiResponse<bool>>> DeletePublisher(Guid id)
    {
        var result = await _publisherService.DeletePublisherAsync(id);
        if (!result.Success)
            return BadRequest(result);

        return Ok(result);
    }
}
