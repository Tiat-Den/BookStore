using BookStore.Domain.Entities;
using BookStore.Domain.Enums;
using Microsoft.EntityFrameworkCore;

namespace BookStore.Infrastructure.Data;

public static class DbInitializer
{
    public static async Task SeedAsync(BookStoreDbContext context)
    {
        // 1. Roles
        var adminRole = await context.Roles.FirstOrDefaultAsync(r => r.Name == "ADMIN");
        if (adminRole == null)
        {
            adminRole = new Role
            {
                Id = Guid.NewGuid(),
                Name = "ADMIN",
                Description = "Quản trị viên toàn quyền hệ thống"
            };
            context.Roles.Add(adminRole);
        }

        var employeeRole = await context.Roles.FirstOrDefaultAsync(r => r.Name == "EMPLOYEE");
        if (employeeRole == null)
        {
            employeeRole = new Role
            {
                Id = Guid.NewGuid(),
                Name = "EMPLOYEE",
                Description = "Nhân viên quản lý sách, kho và đơn hàng"
            };
            context.Roles.Add(employeeRole);
        }

        var customerRole = await context.Roles.FirstOrDefaultAsync(r => r.Name == "CUSTOMER");
        if (customerRole == null)
        {
            customerRole = new Role
            {
                Id = Guid.NewGuid(),
                Name = "CUSTOMER",
                Description = "Khách hàng mua sách"
            };
            context.Roles.Add(customerRole);
        }

        await context.SaveChangesAsync();

        // 2. Default Permissions
        var permissions = new List<(string Code, string Name)>
        {
            ("PRODUCT_VIEW", "Xem danh sách sách"),
            ("PRODUCT_CREATE", "Thêm sách mới"),
            ("PRODUCT_UPDATE", "Cập nhật sách"),
            ("PRODUCT_DELETE", "Xóa sách"),
            ("ORDER_VIEW", "Xem đơn hàng"),
            ("ORDER_UPDATE", "Cập nhật trạng thái đơn hàng"),
            ("USER_VIEW", "Xem danh sách người dùng"),
            ("USER_UPDATE", "Cập nhật người dùng"),
            ("EMPLOYEE_CREATE", "Tạo tài khoản nhân viên"),
            ("EMPLOYEE_UPDATE", "Cập nhật nhân viên"),
            ("EMPLOYEE_DELETE", "Khóa/xóa nhân viên"),
            ("REPORT_VIEW", "Xem báo cáo thống kê")
        };

        foreach (var (code, name) in permissions)
        {
            if (!await context.Permissions.AnyAsync(p => p.Code == code))
            {
                var perm = new Permission
                {
                    Id = Guid.NewGuid(),
                    Code = code,
                    Name = name
                };
                context.Permissions.Add(perm);
                context.RolePermissions.Add(new RolePermission
                {
                    RoleId = adminRole.Id,
                    Permission = perm
                });

                // Gán quyền cho EMPLOYEE nếu thuộc phạm vi quản lý sách, đơn hàng, báo cáo
                var employeePerms = new[] { "PRODUCT_VIEW", "PRODUCT_CREATE", "PRODUCT_UPDATE", "ORDER_VIEW", "ORDER_UPDATE", "REPORT_VIEW" };
                if (employeePerms.Contains(code))
                {
                    context.RolePermissions.Add(new RolePermission
                    {
                        RoleId = employeeRole.Id,
                        Permission = perm
                    });
                }
            }
        }
        await context.SaveChangesAsync();

        // 3. Default Admin User (Password: Admin@123456)
        var adminEmail = "admin@bookstore.com";
        var existingAdmin = await context.Users.Include(u => u.UserRoles).FirstOrDefaultAsync(u => u.Email == adminEmail);
        if (existingAdmin == null)
        {
            var adminUser = new User
            {
                Id = Guid.NewGuid(),
                FullName = "Administrator",
                Email = adminEmail,
                Phone = "0987654321",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("Admin@123456"),
                Status = UserStatus.Active,
                CreatedAt = DateTime.UtcNow
            };

            context.Users.Add(adminUser);
            context.UserRoles.Add(new UserRole
            {
                UserId = adminUser.Id,
                RoleId = adminRole.Id
            });
            await context.SaveChangesAsync();
        }

        // 3.1 Default Employee User (Password: Employee@123456)
        var employeeEmail = "employee@bookstore.com";
        var existingEmployee = await context.Users.Include(u => u.UserRoles).FirstOrDefaultAsync(u => u.Email == employeeEmail);
        if (existingEmployee == null)
        {
            var employeeUser = new User
            {
                Id = Guid.NewGuid(),
                FullName = "Nhân Viên Quản Lý",
                Email = employeeEmail,
                Phone = "0911223344",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("Employee@123456"),
                Status = UserStatus.Active,
                CreatedAt = DateTime.UtcNow
            };

            context.Users.Add(employeeUser);
            context.UserRoles.Add(new UserRole
            {
                UserId = employeeUser.Id,
                RoleId = employeeRole.Id
            });
            await context.SaveChangesAsync();
        }

        // 3.2 Default Customer User (Password: Password@123)
        var customerEmail = "customer1@gmail.com";
        var existingCustomer = await context.Users.Include(u => u.UserRoles).FirstOrDefaultAsync(u => u.Email == customerEmail);
        if (existingCustomer == null)
        {
            var customerUser = new User
            {
                Id = Guid.NewGuid(),
                FullName = "Nguyễn Văn A",
                Email = customerEmail,
                Phone = "0909123456",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("Password@123"),
                Status = UserStatus.Active,
                CreatedAt = DateTime.UtcNow
            };

            context.Users.Add(customerUser);
            context.UserRoles.Add(new UserRole
            {
                UserId = customerUser.Id,
                RoleId = customerRole.Id
            });
            await context.SaveChangesAsync();
        }

        // 4. Sample Categories
        if (!await context.Categories.AnyAsync())
        {
            var categories = new List<Category>
            {
                new() { Name = "Văn học", Slug = "van-hoc", Description = "Tiểu thuyết, truyện ngắn, thơ ca" },
                new() { Name = "Kinh tế", Slug = "kinh-te", Description = "Quản trị kinh doanh, tài chính, marketing" },
                new() { Name = "Kỹ năng sống", Slug = "ky-nang-song", Description = "Phát triển bản thân, tư duy, tâm lý" },
                new() { Name = "Công nghệ", Slug = "cong-nghe", Description = "Lập trình, CNTT, AI, phần cứng" },
                new() { Name = "Thiếu nhi", Slug = "thieu-nhi", Description = "Truyện tranh, cổ tích, khoa học nhí" },
                new() { Name = "Giáo dục", Slug = "giao-duc", Description = "Sách giáo khoa, luyện thi, ngoại ngữ" }
            };

            context.Categories.AddRange(categories);
            await context.SaveChangesAsync();
        }

        // 5. Sample Publisher & Author
        if (!await context.Publishers.AnyAsync())
        {
            var publisher = new Publisher
            {
                Name = "NXB Trẻ",
                Address = "161B Lý Chính Thắng, Quận 3, TP.HCM",
                Email = "hopthu@nxbtre.com.vn",
                Phone = "02839316289",
                Website = "https://www.nxbtre.com.vn"
            };
            context.Publishers.Add(publisher);
            await context.SaveChangesAsync();
        }

        if (!await context.Authors.AnyAsync())
        {
            var author = new Author
            {
                Name = "Nguyễn Nhật Ánh",
                Biography = "Nhà văn nổi tiếng của Việt Nam với các tác phẩm dành cho tuổi thanh thiếu niên.",
                Nationality = "Việt Nam"
            };
            context.Authors.Add(author);
            await context.SaveChangesAsync();
        }

        // 6. Sample Books
        if (!await context.Books.AnyAsync())
        {
            var vanHoc = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "van-hoc");
            var congNghe = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "cong-nghe");
            var kyNang = await context.Categories.FirstOrDefaultAsync(c => c.Slug == "ky-nang-song");
            var publisher = await context.Publishers.FirstOrDefaultAsync();
            var author = await context.Authors.FirstOrDefaultAsync();

            var books = new List<Book>
            {
                new()
                {
                    Id = Guid.NewGuid(),
                    ISBN = "978-604-1-18234-1",
                    Title = "Mắt Biếc",
                    Slug = "mat-biec",
                    Description = "Một trong những tác phẩm nổi tiếng và xúc động nhất của nhà văn Nguyễn Nhật Ánh về tình yêu tuổi học trò trong trẻo, hoài niệm.",
                    CoverImageUrl = "https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80",
                    ImportPrice = 70000,
                    SalePrice = 110000,
                    DiscountPrice = 95000,
                    StockQuantity = 50,
                    SoldQuantity = 12,
                    PublisherId = publisher?.Id,
                    PublishedYear = 2020,
                    PageCount = 300,
                    Language = "Tiếng Việt",
                    Status = BookStatus.Active,
                    CreatedAt = DateTime.UtcNow
                },
                new()
                {
                    Id = Guid.NewGuid(),
                    ISBN = "978-604-1-18235-8",
                    Title = "Tôi Thấy Hoa Vàng Trên Cỏ Xanh",
                    Slug = "toi-thay-hoa-vang-tren-co-xanh",
                    Description = "Câu chuyện về tuổi thơ nghèo khó nhưng đong đầy tình cảm anh em, bè bạn ở làng quê miền Trung.",
                    CoverImageUrl = "https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80",
                    ImportPrice = 65000,
                    SalePrice = 125000,
                    DiscountPrice = 105000,
                    StockQuantity = 40,
                    SoldQuantity = 25,
                    PublisherId = publisher?.Id,
                    PublishedYear = 2021,
                    PageCount = 380,
                    Language = "Tiếng Việt",
                    Status = BookStatus.Active,
                    CreatedAt = DateTime.UtcNow
                },
                new()
                {
                    Id = Guid.NewGuid(),
                    ISBN = "978-013-2-35088-4",
                    Title = "Clean Code: A Handbook of Agile Software Craftsmanship",
                    Slug = "clean-code",
                    Description = "Cuốn sách gối đầu giường của mọi lập trình viên chuyên nghiệp về kỹ năng viết mã nguồn sạch và tối ưu.",
                    CoverImageUrl = "https://images.unsplash.com/photo-1532012164546-f432f2e37b73?auto=format&fit=crop&w=600&q=80",
                    ImportPrice = 250000,
                    SalePrice = 380000,
                    DiscountPrice = 350000,
                    StockQuantity = 30,
                    SoldQuantity = 8,
                    PublisherId = publisher?.Id,
                    PublishedYear = 2018,
                    PageCount = 464,
                    Language = "Tiếng Anh",
                    Status = BookStatus.Active,
                    CreatedAt = DateTime.UtcNow
                },
                new()
                {
                    Id = Guid.NewGuid(),
                    ISBN = "978-604-2-00123-9",
                    Title = "Đắc Nhân Tâm",
                    Slug = "dac-nhan-tam",
                    Description = "Cuốn sách nghệ thuật thu phục lòng người kinh điển của Dale Carnegie, giúp nâng cao kỹ năng giao tiếp và ứng xử.",
                    CoverImageUrl = "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80",
                    ImportPrice = 50000,
                    SalePrice = 86000,
                    DiscountPrice = 75000,
                    StockQuantity = 100,
                    SoldQuantity = 45,
                    PublisherId = publisher?.Id,
                    PublishedYear = 2019,
                    PageCount = 320,
                    Language = "Tiếng Việt",
                    Status = BookStatus.Active,
                    CreatedAt = DateTime.UtcNow
                }
            };

            foreach (var b in books)
            {
                if (author != null)
                {
                    b.BookAuthors.Add(new BookAuthor { BookId = b.Id, AuthorId = author.Id });
                }

                if (b.Slug.Contains("clean") && congNghe != null)
                {
                    b.BookCategories.Add(new BookCategory { BookId = b.Id, CategoryId = congNghe.Id });
                }
                else if (b.Slug.Contains("dac-nhan") && kyNang != null)
                {
                    b.BookCategories.Add(new BookCategory { BookId = b.Id, CategoryId = kyNang.Id });
                }
                else if (vanHoc != null)
                {
                    b.BookCategories.Add(new BookCategory { BookId = b.Id, CategoryId = vanHoc.Id });
                }

                b.Inventory = new Inventory
                {
                    Id = Guid.NewGuid(),
                    BookId = b.Id,
                    Quantity = b.StockQuantity,
                    ReservedQuantity = 0,
                    UpdatedAt = DateTime.UtcNow
                };

                context.Books.Add(b);
            }

            await context.SaveChangesAsync();
        }

        // 7. Sample Coupons
        if (!await context.Coupons.AnyAsync())
        {
            var coupons = new List<Coupon>
            {
                new()
                {
                    Id = Guid.NewGuid(),
                    Code = "BOOK20",
                    Name = "Giảm 20% đơn từ 100k",
                    Type = CouponTypeConstants.Percent,
                    Value = 20,
                    MinimumOrderAmount = 100000,
                    MaximumDiscountAmount = 50000,
                    UsageLimit = 200,
                    UsedCount = 0,
                    StartAt = DateTime.UtcNow.AddDays(-1),
                    EndAt = DateTime.UtcNow.AddYears(1),
                    IsActive = true
                },
                new()
                {
                    Id = Guid.NewGuid(),
                    Code = "FREESHIP",
                    Name = "Giảm 30k phí ship đơn từ 150k",
                    Type = CouponTypeConstants.FixedAmount,
                    Value = 30000,
                    MinimumOrderAmount = 150000,
                    MaximumDiscountAmount = 30000,
                    UsageLimit = 500,
                    UsedCount = 0,
                    StartAt = DateTime.UtcNow.AddDays(-1),
                    EndAt = DateTime.UtcNow.AddYears(1),
                    IsActive = true
                }
            };

            context.Coupons.AddRange(coupons);
            await context.SaveChangesAsync();
        }
    }
}
