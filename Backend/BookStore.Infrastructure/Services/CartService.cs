using BookStore.Application.Common;
using BookStore.Application.DTOs.Orders;
using BookStore.Application.Interfaces;
using BookStore.Domain.Entities;
using BookStore.Domain.Enums;
using BookStore.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Services;

public class CartService : ICartService
{
    private readonly BookStoreDbContext _context;

    public CartService(BookStoreDbContext context)
    {
        _context = context;
    }

    public async Task<ApiResponse<CartDto>> GetCartAsync(Guid userId)
    {
        var cart = await _context.Carts
            .AsNoTracking()
            .Include(c => c.Items)
                .ThenInclude(i => i.Book)
            .FirstOrDefaultAsync(c => c.UserId == userId);

        if (cart == null)
        {
            cart = await GetOrCreateCartAsync(userId);
        }

        var dto = new CartDto
        {
            Id = cart.Id,
            UserId = cart.UserId,
            Items = cart.Items.Select(i => new CartItemDto
            {
                Id = i.Id,
                BookId = i.BookId,
                BookTitle = i.Book?.Title ?? string.Empty,
                BookSlug = i.Book?.Slug ?? string.Empty,
                CoverImageUrl = i.Book?.CoverImageUrl,
                UnitPrice = i.Book != null ? (i.Book.DiscountPrice ?? i.Book.SalePrice) : i.UnitPrice,
                Quantity = i.Quantity,
                AvailableStock = i.Book?.StockQuantity ?? 0
            }).ToList()
        };

        return ApiResponse<CartDto>.Ok(dto);
    }

    public async Task<ApiResponse<CartDto>> AddToCartAsync(Guid userId, AddToCartDto request)
    {
        var book = await _context.Books.FirstOrDefaultAsync(b => b.Id == request.BookId && !b.IsDeleted);
        if (book == null || book.Status != BookStatus.Active)
        {
            return ApiResponse<CartDto>.Fail("Sách không tồn tại hoặc đã ngừng kinh doanh.");
        }

        // BR-11: Kiểm tra tồn kho
        if (book.StockQuantity < request.Quantity)
        {
            return ApiResponse<CartDto>.Fail($"Số lượng tồn kho không đủ. Chỉ còn {book.StockQuantity} cuốn.");
        }

        var cart = await GetOrCreateCartAsync(userId);
        var existingItem = cart.Items.FirstOrDefault(i => i.BookId == request.BookId && _context.Entry(i).State != EntityState.Deleted && _context.Entry(i).State != EntityState.Detached);

        if (existingItem != null)
        {
            var newQuantity = existingItem.Quantity + request.Quantity;
            if (newQuantity > book.StockQuantity)
            {
                return ApiResponse<CartDto>.Fail($"Tổng số lượng trong giỏ ({newQuantity}) vượt quá tồn kho hiện có ({book.StockQuantity}).");
            }

            existingItem.Quantity = newQuantity;
            existingItem.UnitPrice = book.DiscountPrice ?? book.SalePrice;
        }
        else
        {
            var newItem = new CartItem
            {
                Id = Guid.NewGuid(),
                CartId = cart.Id,
                BookId = book.Id,
                Quantity = request.Quantity,
                UnitPrice = book.DiscountPrice ?? book.SalePrice,
                Book = book
            };
            _context.CartItems.Add(newItem);
        }

        cart.UpdatedAt = DateTime.UtcNow;
        await _context.SaveChangesAsync();

        return await GetCartAsync(userId);
    }

    public async Task<ApiResponse<CartDto>> UpdateItemQuantityAsync(Guid userId, Guid cartItemId, int quantity)
    {
        // BR-10: Quantity > 0
        if (quantity <= 0)
        {
            return await RemoveItemAsync(userId, cartItemId);
        }

        var cart = await GetOrCreateCartAsync(userId);
        var item = cart.Items.FirstOrDefault(i => i.Id == cartItemId && _context.Entry(i).State != EntityState.Deleted && _context.Entry(i).State != EntityState.Detached);
        if (item == null)
        {
            return ApiResponse<CartDto>.Fail("Sản phẩm không có trong giỏ hàng.");
        }

        var book = await _context.Books.FindAsync(item.BookId);
        if (book == null || book.IsDeleted)
        {
            return ApiResponse<CartDto>.Fail("Sách không tồn tại.");
        }

        // BR-11: Quantity không vượt tồn kho
        if (quantity > book.StockQuantity)
        {
            return ApiResponse<CartDto>.Fail($"Số lượng yêu cầu vượt quá tồn kho ({book.StockQuantity} cuốn).");
        }

        item.Quantity = quantity;
        item.UnitPrice = book.DiscountPrice ?? book.SalePrice;
        cart.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync();
        return await GetCartAsync(userId);
    }

    public async Task<ApiResponse<CartDto>> RemoveItemAsync(Guid userId, Guid cartItemId)
    {
        var cart = await GetOrCreateCartAsync(userId);
        var item = cart.Items.FirstOrDefault(i => i.Id == cartItemId);
        if (item != null)
        {
            _context.CartItems.Remove(item);
            cart.Items.Remove(item);
            cart.UpdatedAt = DateTime.UtcNow;
            await _context.SaveChangesAsync();
        }

        return await GetCartAsync(userId);
    }

    public async Task<ApiResponse<bool>> ClearCartAsync(Guid userId)
    {
        var cart = await GetOrCreateCartAsync(userId);
        if (cart.Items.Any())
        {
            var itemsToRemove = cart.Items.ToList();
            _context.CartItems.RemoveRange(itemsToRemove);
            foreach (var it in itemsToRemove)
            {
                cart.Items.Remove(it);
            }
            cart.UpdatedAt = DateTime.UtcNow;
            await _context.SaveChangesAsync();
        }

        return ApiResponse<bool>.Ok(true, "Đã làm trống giỏ hàng.");
    }

    private async Task<Cart> GetOrCreateCartAsync(Guid userId)
    {
        var cart = await _context.Carts
            .Include(c => c.Items)
                .ThenInclude(i => i.Book)
            .FirstOrDefaultAsync(c => c.UserId == userId);

        if (cart == null)
        {
            cart = new Cart
            {
                Id = Guid.NewGuid(),
                UserId = userId,
                CreatedAt = DateTime.UtcNow
            };
            _context.Carts.Add(cart);
            await _context.SaveChangesAsync();
        }

        return cart;
    }
}
