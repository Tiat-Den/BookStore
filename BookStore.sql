-- PHẦN 1: KHỞI TẠO CSDL BOOKSTORE
-- (Lưu ý: Backend appsettings.json mặc định dùng Database=BookStoreDb. 
-- ----------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = N'BookStoreDb')
BEGIN
    CREATE DATABASE [BookStoreDb] COLLATE Vietnamese_CI_AS;
END
GO

USE [BookStoreDb];
GO

-- ----------------------------------------------------------------------------------------------------
-- PHẦN 2: BẢNG LỊCH SỬ MIGRATION ENTITY FRAMEWORK CORE
-- (Giúp Backend .NET 8 nhận diện database đã được khởi tạo hoàn chỉnh, không bị lỗi Migration conflict)
-- ----------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'__EFMigrationsHistory')
BEGIN
    CREATE TABLE [dbo].[__EFMigrationsHistory] (
        [MigrationId] NVARCHAR(150) NOT NULL,
        [ProductVersion] NVARCHAR(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END
GO

-- ----------------------------------------------------------------------------------------------------
-- PHẦN 3: TẠO CÁC BẢNG NỀN TẢNG (ROLES, USERS, PERMISSIONS, CATEGORIES, AUTHORS, PUBLISHERS, COUPONS)
-- ----------------------------------------------------------------------------------------------------

-- 1. Bảng Vai trò (Roles)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Roles')
BEGIN
    CREATE TABLE [dbo].[Roles] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [Name] NVARCHAR(50) NOT NULL,
        [Description] NVARCHAR(MAX) NULL,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_Roles] PRIMARY KEY ([Id])
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Roles_Name] ON [dbo].[Roles] ([Name]);
END
GO

-- 2. Bảng Quyền hệ thống (Permissions)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Permissions')
BEGIN
    CREATE TABLE [dbo].[Permissions] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [Code] NVARCHAR(100) NOT NULL,
        [Name] NVARCHAR(150) NOT NULL,
        [Description] NVARCHAR(MAX) NULL,
        CONSTRAINT [PK_Permissions] PRIMARY KEY ([Id])
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Permissions_Code] ON [dbo].[Permissions] ([Code]);
END
GO

-- 3. Bảng Người dùng (Users)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Users')
BEGIN
    CREATE TABLE [dbo].[Users] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [FullName] NVARCHAR(150) NOT NULL,
        [Email] NVARCHAR(150) NOT NULL,
        [Phone] NVARCHAR(20) NULL,
        [PasswordHash] NVARCHAR(MAX) NOT NULL,
        [Status] INT NOT NULL DEFAULT 1, -- 1: Active, 2: Inactive, 3: Locked
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        [UpdatedAt] DATETIME2 NULL,
        CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_Email] ON [dbo].[Users] ([Email]);
END
GO

-- 4. Bảng Phân quyền Vai trò - Quyền (RolePermissions)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'RolePermissions')
BEGIN
    CREATE TABLE [dbo].[RolePermissions] (
        [RoleId] UNIQUEIDENTIFIER NOT NULL,
        [PermissionId] UNIQUEIDENTIFIER NOT NULL,
        CONSTRAINT [PK_RolePermissions] PRIMARY KEY ([RoleId], [PermissionId]),
        CONSTRAINT [FK_RolePermissions_Roles_RoleId] FOREIGN KEY ([RoleId]) 
            REFERENCES [dbo].[Roles] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_RolePermissions_Permissions_PermissionId] FOREIGN KEY ([PermissionId]) 
            REFERENCES [dbo].[Permissions] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_RolePermissions_PermissionId] ON [dbo].[RolePermissions] ([PermissionId]);
END
GO

-- 5. Bảng Gán Vai trò cho Người dùng (UserRoles)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'UserRoles')
BEGIN
    CREATE TABLE [dbo].[UserRoles] (
        [UserId] UNIQUEIDENTIFIER NOT NULL,
        [RoleId] UNIQUEIDENTIFIER NOT NULL,
        CONSTRAINT [PK_UserRoles] PRIMARY KEY ([UserId], [RoleId]),
        CONSTRAINT [FK_UserRoles_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_UserRoles_Roles_RoleId] FOREIGN KEY ([RoleId]) 
            REFERENCES [dbo].[Roles] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleId] ON [dbo].[UserRoles] ([RoleId]);
END
GO

-- 6. Bảng Sổ địa chỉ người dùng (Addresses)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Addresses')
BEGIN
    CREATE TABLE [dbo].[Addresses] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [UserId] UNIQUEIDENTIFIER NOT NULL,
        [ReceiverName] NVARCHAR(100) NOT NULL,
        [Phone] NVARCHAR(20) NOT NULL,
        [Province] NVARCHAR(MAX) NOT NULL,
        [District] NVARCHAR(MAX) NOT NULL,
        [Ward] NVARCHAR(MAX) NOT NULL,
        [AddressLine] NVARCHAR(MAX) NOT NULL,
        [IsDefault] BIT NOT NULL DEFAULT 0,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_Addresses] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Addresses_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_Addresses_UserId] ON [dbo].[Addresses] ([UserId]);
END
GO

-- 7. Bảng Thể loại sách (Categories)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Categories')
BEGIN
    CREATE TABLE [dbo].[Categories] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [ParentId] UNIQUEIDENTIFIER NULL,
        [Name] NVARCHAR(150) NOT NULL,
        [Slug] NVARCHAR(150) NOT NULL,
        [Description] NVARCHAR(MAX) NULL,
        [IsActive] BIT NOT NULL DEFAULT 1,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        [UpdatedAt] DATETIME2 NULL,
        CONSTRAINT [PK_Categories] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Categories_Categories_ParentId] FOREIGN KEY ([ParentId]) 
            REFERENCES [dbo].[Categories] ([Id]) ON DELETE NO ACTION
    );
    CREATE NONCLUSTERED INDEX [IX_Categories_ParentId] ON [dbo].[Categories] ([ParentId]);
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Categories_Slug] ON [dbo].[Categories] ([Slug]);
END
GO

-- 8. Bảng Tác giả (Authors)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Authors')
BEGIN
    CREATE TABLE [dbo].[Authors] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [Name] NVARCHAR(150) NOT NULL,
        [Biography] NVARCHAR(MAX) NULL,
        [ImageUrl] NVARCHAR(MAX) NULL,
        [Nationality] NVARCHAR(MAX) NULL,
        [IsActive] BIT NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Authors] PRIMARY KEY ([Id])
    );
END
GO

-- 9. Bảng Nhà xuất bản (Publishers)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Publishers')
BEGIN
    CREATE TABLE [dbo].[Publishers] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [Name] NVARCHAR(150) NOT NULL,
        [Address] NVARCHAR(MAX) NULL,
        [Email] NVARCHAR(MAX) NULL,
        [Phone] NVARCHAR(MAX) NULL,
        [Website] NVARCHAR(MAX) NULL,
        [IsActive] BIT NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Publishers] PRIMARY KEY ([Id])
    );
END
GO

-- 10. Bảng Sách (Books)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Books')
BEGIN
    CREATE TABLE [dbo].[Books] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [ISBN] NVARCHAR(50) NOT NULL,
        [Title] NVARCHAR(250) NOT NULL,
        [Slug] NVARCHAR(250) NOT NULL,
        [Description] NVARCHAR(MAX) NULL,
        [CoverImageUrl] NVARCHAR(MAX) NULL,
        [ImportPrice] DECIMAL(18,2) NOT NULL,
        [SalePrice] DECIMAL(18,2) NOT NULL,
        [DiscountPrice] DECIMAL(18,2) NULL,
        [StockQuantity] INT NOT NULL DEFAULT 0,
        [SoldQuantity] INT NOT NULL DEFAULT 0,
        [PublisherId] UNIQUEIDENTIFIER NULL,
        [PublishedYear] INT NULL,
        [PageCount] INT NULL,
        [Language] NVARCHAR(MAX) NULL,
        [Dimensions] NVARCHAR(MAX) NULL,
        [Weight] FLOAT NULL,
        [Status] INT NOT NULL DEFAULT 1, -- 0: Draft, 1: Active, 2: OutOfStock, 3: Discontinued
        [IsDeleted] BIT NOT NULL DEFAULT 0,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        [UpdatedAt] DATETIME2 NULL,
        CONSTRAINT [PK_Books] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Books_Publishers_PublisherId] FOREIGN KEY ([PublisherId]) 
            REFERENCES [dbo].[Publishers] ([Id]) ON DELETE SET NULL
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Books_ISBN] ON [dbo].[Books] ([ISBN]);
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Books_Slug] ON [dbo].[Books] ([Slug]);
    CREATE NONCLUSTERED INDEX [IX_Books_PublisherId] ON [dbo].[Books] ([PublisherId]);
END
GO

-- 11. Bảng Tác giả của Sách (BookAuthors)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'BookAuthors')
BEGIN
    CREATE TABLE [dbo].[BookAuthors] (
        [BookId] UNIQUEIDENTIFIER NOT NULL,
        [AuthorId] UNIQUEIDENTIFIER NOT NULL,
        CONSTRAINT [PK_BookAuthors] PRIMARY KEY ([BookId], [AuthorId]),
        CONSTRAINT [FK_BookAuthors_Books_BookId] FOREIGN KEY ([BookId]) 
            REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_BookAuthors_Authors_AuthorId] FOREIGN KEY ([AuthorId]) 
            REFERENCES [dbo].[Authors] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_BookAuthors_AuthorId] ON [dbo].[BookAuthors] ([AuthorId]);
END
GO

-- 12. Bảng Thể loại của Sách (BookCategories)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'BookCategories')
BEGIN
    CREATE TABLE [dbo].[BookCategories] (
        [BookId] UNIQUEIDENTIFIER NOT NULL,
        [CategoryId] UNIQUEIDENTIFIER NOT NULL,
        CONSTRAINT [PK_BookCategories] PRIMARY KEY ([BookId], [CategoryId]),
        CONSTRAINT [FK_BookCategories_Books_BookId] FOREIGN KEY ([BookId]) 
            REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_BookCategories_Categories_CategoryId] FOREIGN KEY ([CategoryId]) 
            REFERENCES [dbo].[Categories] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_BookCategories_CategoryId] ON [dbo].[BookCategories] ([CategoryId]);
END
GO

-- 13. Bảng Quản lý kho sách (Inventories)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Inventories')
BEGIN
    CREATE TABLE [dbo].[Inventories] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [BookId] UNIQUEIDENTIFIER NOT NULL,
        [Quantity] INT NOT NULL DEFAULT 0,
        [ReservedQuantity] INT NOT NULL DEFAULT 0,
        [UpdatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_Inventories] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Inventories_Books_BookId] FOREIGN KEY ([BookId]) 
            REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Inventories_BookId] ON [dbo].[Inventories] ([BookId]);
END
GO

-- 14. Bảng Lịch sử giao dịch kho (InventoryTransactions)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'InventoryTransactions')
BEGIN
    CREATE TABLE [dbo].[InventoryTransactions] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [BookId] UNIQUEIDENTIFIER NOT NULL,
        [Type] NVARCHAR(MAX) NOT NULL DEFAULT 'IMPORT', -- IMPORT, EXPORT, ADJUSTMENT, RETURN
        [Quantity] INT NOT NULL,
        [ReferenceType] NVARCHAR(MAX) NULL, -- ORDER, MANUAL, RETURN
        [ReferenceId] UNIQUEIDENTIFIER NULL,
        [Note] NVARCHAR(MAX) NULL,
        [CreatedBy] UNIQUEIDENTIFIER NULL,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_InventoryTransactions] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_InventoryTransactions_Books_BookId] FOREIGN KEY ([BookId]) 
            REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_InventoryTransactions_BookId] ON [dbo].[InventoryTransactions] ([BookId]);
END
GO

-- 15. Bảng Mã giảm giá (Coupons)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Coupons')
BEGIN
    CREATE TABLE [dbo].[Coupons] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [Code] NVARCHAR(50) NOT NULL,
        [Name] NVARCHAR(MAX) NOT NULL,
        [Type] NVARCHAR(MAX) NOT NULL DEFAULT 'PERCENT', -- PERCENT, FIXED_AMOUNT
        [Value] DECIMAL(18,2) NOT NULL,
        [MinimumOrderAmount] DECIMAL(18,2) NOT NULL DEFAULT 0,
        [MaximumDiscountAmount] DECIMAL(18,2) NULL,
        [UsageLimit] INT NOT NULL DEFAULT 100,
        [UsedCount] INT NOT NULL DEFAULT 0,
        [StartAt] DATETIME2 NOT NULL,
        [EndAt] DATETIME2 NOT NULL,
        [IsActive] BIT NOT NULL DEFAULT 1,
        CONSTRAINT [PK_Coupons] PRIMARY KEY ([Id])
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Coupons_Code] ON [dbo].[Coupons] ([Code]);
END
GO

-- 16. Bảng Giỏ hàng (Carts)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Carts')
BEGIN
    CREATE TABLE [dbo].[Carts] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [UserId] UNIQUEIDENTIFIER NOT NULL,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        [UpdatedAt] DATETIME2 NULL,
        CONSTRAINT [PK_Carts] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Carts_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Carts_UserId] ON [dbo].[Carts] ([UserId]);
END
GO

-- 17. Bảng Mục giỏ hàng (CartItems)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'CartItems')
BEGIN
    CREATE TABLE [dbo].[CartItems] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [CartId] UNIQUEIDENTIFIER NOT NULL,
        [BookId] UNIQUEIDENTIFIER NOT NULL,
        [Quantity] INT NOT NULL DEFAULT 1,
        [UnitPrice] DECIMAL(18,2) NOT NULL,
        CONSTRAINT [PK_CartItems] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CartItems_Carts_CartId] FOREIGN KEY ([CartId]) 
            REFERENCES [dbo].[Carts] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_CartItems_Books_BookId] FOREIGN KEY ([BookId]) 
            REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_CartItems_BookId] ON [dbo].[CartItems] ([BookId]);
    CREATE UNIQUE NONCLUSTERED INDEX [IX_CartItems_CartId_BookId] ON [dbo].[CartItems] ([CartId], [BookId]);
END
GO

-- 18. Bảng Đơn đặt hàng (Orders)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Orders')
BEGIN
    CREATE TABLE [dbo].[Orders] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [OrderCode] NVARCHAR(50) NOT NULL,
        [UserId] UNIQUEIDENTIFIER NOT NULL,
        [AddressId] UNIQUEIDENTIFIER NULL,
        [SubTotal] DECIMAL(18,2) NOT NULL,
        [DiscountAmount] DECIMAL(18,2) NOT NULL DEFAULT 0,
        [ShippingFee] DECIMAL(18,2) NOT NULL DEFAULT 0,
        [TotalAmount] DECIMAL(18,2) NOT NULL,
        [PaymentMethod] NVARCHAR(MAX) NOT NULL DEFAULT 'COD',
        [PaymentStatus] NVARCHAR(MAX) NOT NULL DEFAULT 'PENDING',
        [OrderStatus] NVARCHAR(450) NOT NULL DEFAULT 'PENDING',
        [Note] NVARCHAR(MAX) NULL,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        [UpdatedAt] DATETIME2 NULL,
        CONSTRAINT [PK_Orders] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Orders_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Orders_Addresses_AddressId] FOREIGN KEY ([AddressId]) 
            REFERENCES [dbo].[Addresses] ([Id]) ON DELETE SET NULL
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Orders_OrderCode] ON [dbo].[Orders] ([OrderCode]);
    CREATE NONCLUSTERED INDEX [IX_Orders_AddressId] ON [dbo].[Orders] ([AddressId]);
    CREATE NONCLUSTERED INDEX [IX_Orders_OrderStatus] ON [dbo].[Orders] ([OrderStatus]);
    CREATE NONCLUSTERED INDEX [IX_Orders_UserId_CreatedAt] ON [dbo].[Orders] ([UserId], [CreatedAt]);
END
GO

-- 19. Bảng Chi tiết đơn hàng (OrderItems)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'OrderItems')
BEGIN
    CREATE TABLE [dbo].[OrderItems] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [OrderId] UNIQUEIDENTIFIER NOT NULL,
        [BookId] UNIQUEIDENTIFIER NOT NULL,
        [ProductNameSnapshot] NVARCHAR(250) NOT NULL,
        [UnitPrice] DECIMAL(18,2) NOT NULL,
        [Quantity] INT NOT NULL,
        [TotalPrice] DECIMAL(18,2) NOT NULL,
        CONSTRAINT [PK_OrderItems] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_OrderItems_Orders_OrderId] FOREIGN KEY ([OrderId]) 
            REFERENCES [dbo].[Orders] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_OrderItems_Books_BookId] FOREIGN KEY ([BookId]) 
            REFERENCES [dbo].[Books] ([Id]) ON DELETE NO ACTION
    );
    CREATE NONCLUSTERED INDEX [IX_OrderItems_BookId] ON [dbo].[OrderItems] ([BookId]);
    CREATE NONCLUSTERED INDEX [IX_OrderItems_OrderId] ON [dbo].[OrderItems] ([OrderId]);
END
GO

-- 20. Bảng Thanh toán (Payments)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Payments')
BEGIN
    CREATE TABLE [dbo].[Payments] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [OrderId] UNIQUEIDENTIFIER NOT NULL,
        [PaymentMethod] NVARCHAR(MAX) NOT NULL DEFAULT 'COD',
        [TransactionCode] NVARCHAR(MAX) NULL,
        [Amount] DECIMAL(18,2) NOT NULL,
        [Status] NVARCHAR(MAX) NOT NULL DEFAULT 'PENDING',
        [PaidAt] DATETIME2 NULL,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_Payments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Payments_Orders_OrderId] FOREIGN KEY ([OrderId]) 
            REFERENCES [dbo].[Orders] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_Payments_OrderId] ON [dbo].[Payments] ([OrderId]);
END
GO

-- 21. Bảng Vận chuyển / Giao hàng (Shipments)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Shipments')
BEGIN
    CREATE TABLE [dbo].[Shipments] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [OrderId] UNIQUEIDENTIFIER NOT NULL,
        [Carrier] NVARCHAR(MAX) NULL,
        [TrackingCode] NVARCHAR(MAX) NULL,
        [ReceiverName] NVARCHAR(MAX) NOT NULL,
        [Phone] NVARCHAR(MAX) NOT NULL,
        [Address] NVARCHAR(MAX) NOT NULL,
        [ShippingFee] DECIMAL(18,2) NOT NULL DEFAULT 0,
        [Status] NVARCHAR(MAX) NOT NULL DEFAULT 'PENDING',
        [ShippedAt] DATETIME2 NULL,
        [DeliveredAt] DATETIME2 NULL,
        CONSTRAINT [PK_Shipments] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Shipments_Orders_OrderId] FOREIGN KEY ([OrderId]) 
            REFERENCES [dbo].[Orders] ([Id]) ON DELETE CASCADE
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Shipments_OrderId] ON [dbo].[Shipments] ([OrderId]);
END
GO

-- 22. Bảng Lịch sử sử dụng Voucher (CouponUsages)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'CouponUsages')
BEGIN
    CREATE TABLE [dbo].[CouponUsages] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [CouponId] UNIQUEIDENTIFIER NOT NULL,
        [UserId] UNIQUEIDENTIFIER NOT NULL,
        [OrderId] UNIQUEIDENTIFIER NOT NULL,
        [DiscountAmount] DECIMAL(18,2) NOT NULL,
        [UsedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_CouponUsages] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_CouponUsages_Coupons_CouponId] FOREIGN KEY ([CouponId]) 
            REFERENCES [dbo].[Coupons] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_CouponUsages_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_CouponUsages_Orders_OrderId] FOREIGN KEY ([OrderId]) 
            REFERENCES [dbo].[Orders] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_CouponUsages_CouponId] ON [dbo].[CouponUsages] ([CouponId]);
    CREATE NONCLUSTERED INDEX [IX_CouponUsages_UserId] ON [dbo].[CouponUsages] ([UserId]);
    CREATE NONCLUSTERED INDEX [IX_CouponUsages_OrderId] ON [dbo].[CouponUsages] ([OrderId]);
END
GO

-- 23. Bảng Đánh giá & Nhận xét sản phẩm (Reviews)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Reviews')
BEGIN
    CREATE TABLE [dbo].[Reviews] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [UserId] UNIQUEIDENTIFIER NOT NULL,
        [BookId] UNIQUEIDENTIFIER NOT NULL,
        [OrderId] UNIQUEIDENTIFIER NULL,
        [Rating] INT NOT NULL DEFAULT 5,
        [Content] NVARCHAR(MAX) NOT NULL,
        [Status] NVARCHAR(MAX) NOT NULL DEFAULT 'APPROVED',
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        [UpdatedAt] DATETIME2 NULL,
        CONSTRAINT [PK_Reviews] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Reviews_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE NO ACTION,
        CONSTRAINT [FK_Reviews_Books_BookId] FOREIGN KEY ([BookId]) 
            REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_Reviews_Orders_OrderId] FOREIGN KEY ([OrderId]) 
            REFERENCES [dbo].[Orders] ([Id]) ON DELETE SET NULL
    );
    CREATE NONCLUSTERED INDEX [IX_Reviews_UserId] ON [dbo].[Reviews] ([UserId]);
    CREATE NONCLUSTERED INDEX [IX_Reviews_BookId] ON [dbo].[Reviews] ([BookId]);
    CREATE NONCLUSTERED INDEX [IX_Reviews_OrderId] ON [dbo].[Reviews] ([OrderId]);
END
GO

-- 24. Bảng Danh sách yêu thích (Wishlists)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Wishlists')
BEGIN
    CREATE TABLE [dbo].[Wishlists] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [UserId] UNIQUEIDENTIFIER NOT NULL,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_Wishlists] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Wishlists_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE
    );
    CREATE UNIQUE NONCLUSTERED INDEX [IX_Wishlists_UserId] ON [dbo].[Wishlists] ([UserId]);
END
GO

-- 25. Bảng Mục yêu thích (WishlistItems)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'WishlistItems')
BEGIN
    CREATE TABLE [dbo].[WishlistItems] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [WishlistId] UNIQUEIDENTIFIER NOT NULL,
        [BookId] UNIQUEIDENTIFIER NOT NULL,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_WishlistItems] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_WishlistItems_Wishlists_WishlistId] FOREIGN KEY ([WishlistId]) 
            REFERENCES [dbo].[Wishlists] ([Id]) ON DELETE CASCADE,
        CONSTRAINT [FK_WishlistItems_Books_BookId] FOREIGN KEY ([BookId]) 
            REFERENCES [dbo].[Books] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_WishlistItems_BookId] ON [dbo].[WishlistItems] ([BookId]);
    CREATE UNIQUE NONCLUSTERED INDEX [IX_WishlistItems_WishlistId_BookId] ON [dbo].[WishlistItems] ([WishlistId], [BookId]);
END
GO

-- 26. Bảng Thông báo người dùng (Notifications)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'Notifications')
BEGIN
    CREATE TABLE [dbo].[Notifications] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [UserId] UNIQUEIDENTIFIER NOT NULL,
        [Title] NVARCHAR(MAX) NOT NULL,
        [Message] NVARCHAR(MAX) NOT NULL,
        [Type] NVARCHAR(MAX) NOT NULL DEFAULT 'SYSTEM',
        [IsRead] BIT NOT NULL DEFAULT 0,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_Notifications] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_Notifications_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE CASCADE
    );
    CREATE NONCLUSTERED INDEX [IX_Notifications_UserId] ON [dbo].[Notifications] ([UserId]);
END
GO

-- 27. Bảng Nhật ký hệ thống (AuditLogs)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = N'AuditLogs')
BEGIN
    CREATE TABLE [dbo].[AuditLogs] (
        [Id] UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
        [UserId] UNIQUEIDENTIFIER NULL,
        [Action] NVARCHAR(MAX) NOT NULL,
        [Entity] NVARCHAR(MAX) NOT NULL,
        [EntityId] NVARCHAR(MAX) NULL,
        [OldValue] NVARCHAR(MAX) NULL,
        [NewValue] NVARCHAR(MAX) NULL,
        [IpAddress] NVARCHAR(MAX) NULL,
        [UserAgent] NVARCHAR(MAX) NULL,
        [CreatedAt] DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
        CONSTRAINT [PK_AuditLogs] PRIMARY KEY ([Id]),
        CONSTRAINT [FK_AuditLogs_Users_UserId] FOREIGN KEY ([UserId]) 
            REFERENCES [dbo].[Users] ([Id]) ON DELETE SET NULL
    );
    CREATE NONCLUSTERED INDEX [IX_AuditLogs_UserId] ON [dbo].[AuditLogs] ([UserId]);
END
GO

-- ----------------------------------------------------------------------------------------------------
-- PHẦN 4: GHI NHẬN MIGRATION EF CORE
-- ----------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT * FROM [dbo].[__EFMigrationsHistory] WHERE [MigrationId] = N'20261008074303_InitialCreate')
BEGIN
    INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20261008074303_InitialCreate', N'8.0.11');
END
GO

-- ----------------------------------------------------------------------------------------------------
-- PHẦN 5: CHÈN DỮ LIỆU MẪU ĐẦY ĐỦ (SEED DATA)
-- ----------------------------------------------------------------------------------------------------

-- 1. Khởi tạo Vai trò (Roles)
DECLARE @AdminRoleId UNIQUEIDENTIFIER = '11111111-1111-1111-1111-111111111111';
DECLARE @EmployeeRoleId UNIQUEIDENTIFIER = '22222222-2222-2222-2222-222222222222';
DECLARE @CustomerRoleId UNIQUEIDENTIFIER = '33333333-3333-3333-3333-333333333333';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Roles] WHERE [Name] = 'ADMIN')
    INSERT INTO [dbo].[Roles] ([Id], [Name], [Description], [CreatedAt])
    VALUES (@AdminRoleId, 'ADMIN', N'Quản trị viên toàn quyền hệ thống', SYSUTCDATETIME());
ELSE
    SELECT @AdminRoleId = [Id] FROM [dbo].[Roles] WHERE [Name] = 'ADMIN';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Roles] WHERE [Name] = 'EMPLOYEE')
    INSERT INTO [dbo].[Roles] ([Id], [Name], [Description], [CreatedAt])
    VALUES (@EmployeeRoleId, 'EMPLOYEE', N'Nhân viên quản lý sách, kho và đơn hàng', SYSUTCDATETIME());
ELSE
    SELECT @EmployeeRoleId = [Id] FROM [dbo].[Roles] WHERE [Name] = 'EMPLOYEE';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Roles] WHERE [Name] = 'CUSTOMER')
    INSERT INTO [dbo].[Roles] ([Id], [Name], [Description], [CreatedAt])
    VALUES (@CustomerRoleId, 'CUSTOMER', N'Khách hàng mua sách', SYSUTCDATETIME());
ELSE
    SELECT @CustomerRoleId = [Id] FROM [dbo].[Roles] WHERE [Name] = 'CUSTOMER';

-- 2. Khởi tạo Quyền hạn (Permissions)
DECLARE @PermList TABLE (Code NVARCHAR(100), Name NVARCHAR(150), IsEmployee BIT);
INSERT INTO @PermList VALUES
    ('PRODUCT_VIEW', N'Xem danh sách sách', 1),
    ('PRODUCT_CREATE', N'Thêm sách mới', 1),
    ('PRODUCT_UPDATE', N'Cập nhật sách', 1),
    ('PRODUCT_DELETE', N'Xóa sách', 0),
    ('ORDER_VIEW', N'Xem đơn hàng', 1),
    ('ORDER_UPDATE', N'Cập nhật trạng thái đơn hàng', 1),
    ('USER_VIEW', N'Xem danh sách người dùng', 0),
    ('USER_UPDATE', N'Cập nhật người dùng', 0),
    ('EMPLOYEE_CREATE', N'Tạo tài khoản nhân viên', 0),
    ('EMPLOYEE_UPDATE', N'Cập nhật nhân viên', 0),
    ('EMPLOYEE_DELETE', N'Khóa/xóa nhân viên', 0),
    ('REPORT_VIEW', N'Xem báo cáo thống kê', 1);

DECLARE @pCode NVARCHAR(100), @pName NVARCHAR(150), @isEmp BIT;
DECLARE perm_cursor CURSOR FOR SELECT Code, Name, IsEmployee FROM @PermList;
OPEN perm_cursor;
FETCH NEXT FROM perm_cursor INTO @pCode, @pName, @isEmp;

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @pId UNIQUEIDENTIFIER;
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Permissions] WHERE [Code] = @pCode)
    BEGIN
        SET @pId = NEWID();
        INSERT INTO [dbo].[Permissions] ([Id], [Code], [Name]) VALUES (@pId, @pCode, @pName);
    END
    ELSE
    BEGIN
        SELECT @pId = [Id] FROM [dbo].[Permissions] WHERE [Code] = @pCode;
    END

    -- Gán quyền cho ADMIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[RolePermissions] WHERE [RoleId] = @AdminRoleId AND [PermissionId] = @pId)
    BEGIN
        INSERT INTO [dbo].[RolePermissions] ([RoleId], [PermissionId]) VALUES (@AdminRoleId, @pId);
    END

    -- Gán quyền cho EMPLOYEE nếu hợp lệ
    IF @isEmp = 1 AND NOT EXISTS (SELECT 1 FROM [dbo].[RolePermissions] WHERE [RoleId] = @EmployeeRoleId AND [PermissionId] = @pId)
    BEGIN
        INSERT INTO [dbo].[RolePermissions] ([RoleId], [PermissionId]) VALUES (@EmployeeRoleId, @pId);
    END

    FETCH NEXT FROM perm_cursor INTO @pCode, @pName, @isEmp;
END
CLOSE perm_cursor;
DEALLOCATE perm_cursor;

-- 3. Khởi tạo Tài khoản mẫu (Users & UserRoles)
-- Mật khẩu đã băm bằng BCrypt tương thích chuẩn .NET 8 BCrypt.Net-Next:
-- ADMIN:    admin@bookstore.com    | Mật khẩu: Admin@123456
-- EMPLOYEE: employee@bookstore.com | Mật khẩu: Employee@123456
-- CUSTOMER: customer1@gmail.com    | Mật khẩu: Password@123

DECLARE @AdminUserId UNIQUEIDENTIFIER = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa';
DECLARE @EmployeeUserId UNIQUEIDENTIFIER = 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb';
DECLARE @CustomerUserId UNIQUEIDENTIFIER = 'cccccccc-cccc-cccc-cccc-cccccccccccc';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'admin@bookstore.com')
BEGIN
    INSERT INTO [dbo].[Users] ([Id], [FullName], [Email], [Phone], [PasswordHash], [Status], [CreatedAt])
    VALUES (@AdminUserId, N'Administrator', 'admin@bookstore.com', '0987654321', 
            '$2a$11$70wtdzI7SN.gb/YmsrW7XuhzQoISHofatepRExVPi.GdVQ76P9gVm', 1, SYSUTCDATETIME());

    INSERT INTO [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (@AdminUserId, @AdminRoleId);
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'employee@bookstore.com')
BEGIN
    INSERT INTO [dbo].[Users] ([Id], [FullName], [Email], [Phone], [PasswordHash], [Status], [CreatedAt])
    VALUES (@EmployeeUserId, N'Nhân Viên Quản Lý', 'employee@bookstore.com', '0911223344', 
            '$2a$11$sxQpf5A3vi5/SePQdlNzTuLbZs7fTOfMpZDMDtU7ZI3RM1rap6PZW', 1, SYSUTCDATETIME());

    INSERT INTO [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (@EmployeeUserId, @EmployeeRoleId);
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'customer1@gmail.com')
BEGIN
    INSERT INTO [dbo].[Users] ([Id], [FullName], [Email], [Phone], [PasswordHash], [Status], [CreatedAt])
    VALUES (@CustomerUserId, N'Nguyễn Văn A', 'customer1@gmail.com', '0909123456', 
            '$2a$11$3vFb4LyiXcimmW/qVk7UgubRVcpF2nN/bKDkAbeEmB/y8z2wMlf7e', 1, SYSUTCDATETIME());

    INSERT INTO [dbo].[UserRoles] ([UserId], [RoleId]) VALUES (@CustomerUserId, @CustomerRoleId);
    
    -- Tạo sẵn giỏ hàng và wishlist cho customer1
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Carts] WHERE [UserId] = @CustomerUserId)
        INSERT INTO [dbo].[Carts] ([Id], [UserId], [CreatedAt]) VALUES (NEWID(), @CustomerUserId, SYSUTCDATETIME());

    IF NOT EXISTS (SELECT 1 FROM [dbo].[Wishlists] WHERE [UserId] = @CustomerUserId)
        INSERT INTO [dbo].[Wishlists] ([Id], [UserId], [CreatedAt]) VALUES (NEWID(), @CustomerUserId, SYSUTCDATETIME());

    -- Tạo địa chỉ mặc định cho customer1
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Addresses] WHERE [UserId] = @CustomerUserId)
        INSERT INTO [dbo].[Addresses] ([Id], [UserId], [ReceiverName], [Phone], [Province], [District], [Ward], [AddressLine], [IsDefault], [CreatedAt])
        VALUES (NEWID(), @CustomerUserId, N'Nguyễn Văn A', '0909123456', N'Hồ Chí Minh', N'Quận 1', N'Phường Bến Nghé', N'123 Lê Lợi', 1, SYSUTCDATETIME());
END

-- 4. Khởi tạo Thể loại sách (Categories)
DECLARE @CatVanHocId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444441';
DECLARE @CatKinhTeId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444442';
DECLARE @CatKyNangId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444443';
DECLARE @CatCongNgheId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444444';
DECLARE @CatThieuNhiId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444445';
DECLARE @CatGiaoDucId UNIQUEIDENTIFIER = '44444444-4444-4444-4444-444444444446';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Categories] WHERE [Slug] = 'van-hoc')
    INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description], [IsActive], [CreatedAt])
    VALUES (@CatVanHocId, N'Văn học', 'van-hoc', N'Tiểu thuyết, truyện ngắn, thơ ca', 1, SYSUTCDATETIME());
ELSE
    SELECT @CatVanHocId = [Id] FROM [dbo].[Categories] WHERE [Slug] = 'van-hoc';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Categories] WHERE [Slug] = 'kinh-te')
    INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description], [IsActive], [CreatedAt])
    VALUES (@CatKinhTeId, N'Kinh tế', 'kinh-te', N'Quản trị kinh doanh, tài chính, marketing', 1, SYSUTCDATETIME());
ELSE
    SELECT @CatKinhTeId = [Id] FROM [dbo].[Categories] WHERE [Slug] = 'kinh-te';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Categories] WHERE [Slug] = 'ky-nang-song')
    INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description], [IsActive], [CreatedAt])
    VALUES (@CatKyNangId, N'Kỹ năng sống', 'ky-nang-song', N'Phát triển bản thân, tư duy, tâm lý', 1, SYSUTCDATETIME());
ELSE
    SELECT @CatKyNangId = [Id] FROM [dbo].[Categories] WHERE [Slug] = 'ky-nang-song';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Categories] WHERE [Slug] = 'cong-nghe')
    INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description], [IsActive], [CreatedAt])
    VALUES (@CatCongNgheId, N'Công nghệ', 'cong-nghe', N'Lập trình, CNTT, AI, phần cứng', 1, SYSUTCDATETIME());
ELSE
    SELECT @CatCongNgheId = [Id] FROM [dbo].[Categories] WHERE [Slug] = 'cong-nghe';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Categories] WHERE [Slug] = 'thieu-nhi')
    INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description], [IsActive], [CreatedAt])
    VALUES (@CatThieuNhiId, N'Thiếu nhi', 'thieu-nhi', N'Truyện tranh, cổ tích, khoa học nhí', 1, SYSUTCDATETIME());
ELSE
    SELECT @CatThieuNhiId = [Id] FROM [dbo].[Categories] WHERE [Slug] = 'thieu-nhi';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Categories] WHERE [Slug] = 'giao-duc')
    INSERT INTO [dbo].[Categories] ([Id], [Name], [Slug], [Description], [IsActive], [CreatedAt])
    VALUES (@CatGiaoDucId, N'Giáo dục', 'giao-duc', N'Sách giáo khoa, luyện thi, ngoại ngữ', 1, SYSUTCDATETIME());
ELSE
    SELECT @CatGiaoDucId = [Id] FROM [dbo].[Categories] WHERE [Slug] = 'giao-duc';

-- 5. Khởi tạo Nhà xuất bản (Publishers)
DECLARE @PubNxbTreId UNIQUEIDENTIFIER = '55555555-5555-5555-5555-555555555551';
DECLARE @PubKimDongId UNIQUEIDENTIFIER = '55555555-5555-5555-5555-555555555552';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Publishers] WHERE [Name] = N'NXB Trẻ')
    INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (@PubNxbTreId, N'NXB Trẻ', N'161B Lý Chính Thắng, Quận 3, TP.HCM', 'hopthu@nxbtre.com.vn', '02839316289', 'https://www.nxbtre.com.vn', 1);
ELSE
    SELECT @PubNxbTreId = [Id] FROM [dbo].[Publishers] WHERE [Name] = N'NXB Trẻ';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Publishers] WHERE [Name] = N'NXB Kim Đồng')
    INSERT INTO [dbo].[Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (@PubKimDongId, N'NXB Kim Đồng', N'55 Quang Trung, Hai Bà Trưng, Hà Nội', 'cskh@nxbkimdong.com.vn', '02439434730', 'https://www.nxbkimdong.com.vn', 1);
ELSE
    SELECT @PubKimDongId = [Id] FROM [dbo].[Publishers] WHERE [Name] = N'NXB Kim Đồng';

-- 6. Khởi tạo Tác giả (Authors)
DECLARE @AuthorNNAId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666661';
DECLARE @AuthorUncleBobId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666662';
DECLARE @AuthorDaleCarnegieId UNIQUEIDENTIFIER = '66666666-6666-6666-6666-666666666663';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Name] = N'Nguyễn Nhật Ánh')
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
    VALUES (@AuthorNNAId, N'Nguyễn Nhật Ánh', N'Nhà văn nổi tiếng của Việt Nam với các tác phẩm dành cho tuổi thanh thiếu niên.', N'Việt Nam', 1);
ELSE
    SELECT @AuthorNNAId = [Id] FROM [dbo].[Authors] WHERE [Name] = N'Nguyễn Nhật Ánh';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Name] = N'Robert C. Martin')
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
    VALUES (@AuthorUncleBobId, N'Robert C. Martin', N'Tác giả nổi tiếng với biệt danh "Uncle Bob", chuyên gia kiến trúc phần mềm hàng đầu thế giới.', N'Mỹ', 1);
ELSE
    SELECT @AuthorUncleBobId = [Id] FROM [dbo].[Authors] WHERE [Name] = N'Robert C. Martin';

IF NOT EXISTS (SELECT 1 FROM [dbo].[Authors] WHERE [Name] = N'Dale Carnegie')
    INSERT INTO [dbo].[Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
    VALUES (@AuthorDaleCarnegieId, N'Dale Carnegie', N'Tác giả và diễn giả bậc thầy người Mỹ, người sáng lập ra các khóa học kỹ năng đắc nhân tâm.', N'Mỹ', 1);
ELSE
    SELECT @AuthorDaleCarnegieId = [Id] FROM [dbo].[Authors] WHERE [Name] = N'Dale Carnegie';

-- 7. Khởi tạo Sách mẫu (Books, BookAuthors, BookCategories, Inventories)
DECLARE @BookMatBiecId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777771';
DECLARE @BookHoaVangId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777772';
DECLARE @BookCleanCodeId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777773';
DECLARE @BookDacNhanTamId UNIQUEIDENTIFIER = '77777777-7777-7777-7777-777777777774';

-- Sách 1: Mắt Biếc
IF NOT EXISTS (SELECT 1 FROM [dbo].[Books] WHERE [Slug] = 'mat-biec')
BEGIN
    INSERT INTO [dbo].[Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Status], [IsDeleted], [CreatedAt]
    ) VALUES (
        @BookMatBiecId, '978-604-1-18234-1', N'Mắt Biếc', 'mat-biec',
        N'Một trong những tác phẩm nổi tiếng và xúc động nhất của nhà văn Nguyễn Nhật Ánh về tình yêu tuổi học trò trong trẻo, hoài niệm.',
        'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80',
        70000, 110000, 95000, 50, 12,
        @PubNxbTreId, 2020, 300, N'Tiếng Việt', 1, 0, SYSUTCDATETIME()
    );

    INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (@BookMatBiecId, @AuthorNNAId);
    INSERT INTO [dbo].[BookCategories] ([BookId], [CategoryId]) VALUES (@BookMatBiecId, @CatVanHocId);
    INSERT INTO [dbo].[Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt]) 
    VALUES (NEWID(), @BookMatBiecId, 50, 0, SYSUTCDATETIME());
END

-- Sách 2: Tôi Thấy Hoa Vàng Trên Cỏ Xanh
IF NOT EXISTS (SELECT 1 FROM [dbo].[Books] WHERE [Slug] = 'toi-thay-hoa-vang-tren-co-xanh')
BEGIN
    INSERT INTO [dbo].[Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Status], [IsDeleted], [CreatedAt]
    ) VALUES (
        @BookHoaVangId, '978-604-1-18235-8', N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'toi-thay-hoa-vang-tren-co-xanh',
        N'Câu chuyện về tuổi thơ nghèo khó nhưng đong đầy tình cảm anh em, bè bạn ở làng quê miền Trung yên bình.',
        'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=600&q=80',
        65000, 125000, 105000, 40, 25,
        @PubNxbTreId, 2021, 380, N'Tiếng Việt', 1, 0, SYSUTCDATETIME()
    );

    INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (@BookHoaVangId, @AuthorNNAId);
    INSERT INTO [dbo].[BookCategories] ([BookId], [CategoryId]) VALUES (@BookHoaVangId, @CatVanHocId);
    INSERT INTO [dbo].[Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt]) 
    VALUES (NEWID(), @BookHoaVangId, 40, 0, SYSUTCDATETIME());
END

-- Sách 3: Clean Code
IF NOT EXISTS (SELECT 1 FROM [dbo].[Books] WHERE [Slug] = 'clean-code')
BEGIN
    INSERT INTO [dbo].[Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Status], [IsDeleted], [CreatedAt]
    ) VALUES (
        @BookCleanCodeId, '978-013-2-35088-4', N'Clean Code: A Handbook of Agile Software Craftsmanship', 'clean-code',
        N'Cuốn sách gối đầu giường của mọi lập trình viên chuyên nghiệp về kỹ năng viết mã nguồn sạch và tối ưu hệ thống.',
        'https://m.media-amazon.com/images/I/41xShlnTZTL.jpg',
        250000, 380000, 350000, 30, 8,
        @PubNxbTreId, 2018, 464, N'Tiếng Anh', 1, 0, SYSUTCDATETIME()
    );

    INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (@BookCleanCodeId, @AuthorUncleBobId);
    INSERT INTO [dbo].[BookCategories] ([BookId], [CategoryId]) VALUES (@BookCleanCodeId, @CatCongNgheId);
    INSERT INTO [dbo].[Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt]) 
    VALUES (NEWID(), @BookCleanCodeId, 30, 0, SYSUTCDATETIME());
END

-- Sách 4: Đắc Nhân Tâm
IF NOT EXISTS (SELECT 1 FROM [dbo].[Books] WHERE [Slug] = 'dac-nhan-tam')
BEGIN
    INSERT INTO [dbo].[Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Status], [IsDeleted], [CreatedAt]
    ) VALUES (
        @BookDacNhanTamId, '978-604-2-00123-9', N'Đắc Nhân Tâm', 'dac-nhan-tam',
        N'Cuốn sách nghệ thuật thu phục lòng người kinh điển của Dale Carnegie, giúp nâng cao kỹ năng giao tiếp và ứng xử hàng ngày.',
        'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=600&q=80',
        50000, 86000, 75000, 100, 45,
        @PubNxbTreId, 2019, 320, N'Tiếng Việt', 1, 0, SYSUTCDATETIME()
    );

    INSERT INTO [dbo].[BookAuthors] ([BookId], [AuthorId]) VALUES (@BookDacNhanTamId, @AuthorDaleCarnegieId);
    INSERT INTO [dbo].[BookCategories] ([BookId], [CategoryId]) VALUES (@BookDacNhanTamId, @CatKyNangId);
    INSERT INTO [dbo].[Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt]) 
    VALUES (NEWID(), @BookDacNhanTamId, 100, 0, SYSUTCDATETIME());
END

-- 8. Khởi tạo Mã Voucher (Coupons)
IF NOT EXISTS (SELECT 1 FROM [dbo].[Coupons] WHERE [Code] = 'BOOK20')
BEGIN
    INSERT INTO [dbo].[Coupons] (
        [Id], [Code], [Name], [Type], [Value], 
        [MinimumOrderAmount], [MaximumDiscountAmount], [UsageLimit], [UsedCount], 
        [StartAt], [EndAt], [IsActive]
    ) VALUES (
        NEWID(), 'BOOK20', N'Giảm 20% đơn từ 100k', 'PERCENT', 20.00,
        100000.00, 50000.00, 200, 0,
        DATEADD(DAY, -1, SYSUTCDATETIME()), DATEADD(YEAR, 1, SYSUTCDATETIME()), 1
    );
END

IF NOT EXISTS (SELECT 1 FROM [dbo].[Coupons] WHERE [Code] = 'FREESHIP')
BEGIN
    INSERT INTO [dbo].[Coupons] (
        [Id], [Code], [Name], [Type], [Value], 
        [MinimumOrderAmount], [MaximumDiscountAmount], [UsageLimit], [UsedCount], 
        [StartAt], [EndAt], [IsActive]
    ) VALUES (
        NEWID(), 'FREESHIP', N'Giảm 30k phí ship đơn từ 150k', 'FIXED_AMOUNT', 30000.00,
        150000.00, 30000.00, 500, 0,
        DATEADD(DAY, -1, SYSUTCDATETIME()), DATEADD(YEAR, 1, SYSUTCDATETIME()), 1
    );
END

-- ----------------------------------------------------------------------------------------------------
-- PHẦN 6: KIỂM TRA TỔNG QUAN SAU KHI CHẠY SCRIPT
-- ----------------------------------------------------------------------------------------------------
PRINT N'====================================================================';
PRINT N'✅ ĐÃ KHỞI TẠO VÀ CẬP NHẬT DATABASE BookStoreDb THÀNH CÔNG!';
PRINT N'====================================================================';
SELECT 'Users' AS TableName, COUNT(*) AS TotalRows FROM [dbo].[Users]
UNION ALL
SELECT 'Roles', COUNT(*) FROM [dbo].[Roles]
UNION ALL
SELECT 'Permissions', COUNT(*) FROM [dbo].[Permissions]
UNION ALL
SELECT 'Categories', COUNT(*) FROM [dbo].[Categories]
UNION ALL
SELECT 'Authors', COUNT(*) FROM [dbo].[Authors]
UNION ALL
SELECT 'Publishers', COUNT(*) FROM [dbo].[Publishers]
UNION ALL
SELECT 'Books', COUNT(*) FROM [dbo].[Books]
UNION ALL
SELECT 'Inventories', COUNT(*) FROM [dbo].[Inventories]
UNION ALL
SELECT 'Coupons', COUNT(*) FROM [dbo].[Coupons];
GO
