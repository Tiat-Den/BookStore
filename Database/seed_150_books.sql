-- =========================================================================
-- SEED 154 BOOKS ACROSS 9 CATEGORIES (100% UNICODE SAFE WITH REAL COVERS)
-- =========================================================================

SET NOCOUNT ON;
BEGIN TRANSACTION;
BEGIN TRY

-- 1. Ensure all Publishers exist

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Chính Trị Quốc Gia Sự Thật')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Chính Trị Quốc Gia Sự Thật', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Thế Giới')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Thế Giới', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Tri Thức')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Tri Thức', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Tổng Hợp TP.HCM', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Văn Học')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Văn Học', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Phụ Nữ')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Phụ Nữ', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Trẻ')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Trẻ', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Hội Nhà Văn')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Hội Nhà Văn', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Kim Đồng', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Lao Động')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Lao Động', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Hà Nội')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Hà Nội', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Công Thương')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Công Thương', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Thể Dục Thể Thao')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Thể Dục Thể Thao', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Thông Tin & Truyền Thông', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Khoa Học Tự Nhiên')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Khoa Học Tự Nhiên', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Khoa Học Kỹ Thuật')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Khoa Học Kỹ Thuật', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Giáo Dục Việt Nam')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Giáo Dục Việt Nam', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Dân Trí')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Dân Trí', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Đại Học Quốc Gia')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Đại Học Quốc Gia', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Khoa Học Xã Hội')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Khoa Học Xã Hội', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

IF NOT EXISTS (SELECT 1 FROM [Publishers] WHERE [Name] = N'NXB Văn Hóa Thông Tin')
BEGIN
    INSERT INTO [Publishers] ([Id], [Name], [Address], [Email], [Phone], [Website], [IsActive])
    VALUES (NEWID(), N'NXB Văn Hóa Thông Tin', N'Việt Nam', 'contact@nxb.vn', '0281234567', 'https://nxb.vn', 1);
END

-- 2. Variables for linking
DECLARE @BookId UNIQUEIDENTIFIER;
DECLARE @AuthorId UNIQUEIDENTIFIER;
DECLARE @PublisherId UNIQUEIDENTIFIER;
DECLARE @CategoryId UNIQUEIDENTIFIER;

-- Book 1: Tuyên Ngôn Của Đảng Cộng Sản
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tuyen-ngon-cua-dang-cong-san')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Karl Marx & Friedrich Engels';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Karl Marx & Friedrich Engels', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Chính Trị Quốc Gia Sự Thật';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-100-1000', N'Tuyên Ngôn Của Đảng Cộng Sản', 'tuyen-ngon-cua-dang-cong-san', N'Văn kiện cương lĩnh lý luận kinh điển đặt nền tảng cho phong trào công nhân và chủ nghĩa xã hội khoa học quốc tế.', 'https://salt.tikicdn.com/cache/750x750/ts/product/84/4a/9a/00eb8daefb1d56a67347b364b865ff6f.jpg',
        42000, 65000, NULL, 30, 10,
        @PublisherId, 2019, 180, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 30, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/84/4a/9a/00eb8daefb1d56a67347b364b865ff6f.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tuyen-ngon-cua-dang-cong-san';
END

-- Book 2: Tư Bản Luận - Quyển 1
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tu-ban-luan-quyen-1')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Karl Marx';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Karl Marx', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Chính Trị Quốc Gia Sự Thật';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-101-1007', N'Tư Bản Luận - Quyển 1', 'tu-ban-luan-quyen-1', N'Tác phẩm đồ sộ phân tích toàn diện phương thức sản xuất tư bản chủ nghĩa, quy luật giá trị thặng dư và vận động kinh tế.', 'https://salt.tikicdn.com/cache/750x750/ts/product/76/1a/b1/56bb93b482367c6a64b7a07402794755.jpg',
        182000, 280000, 238000, 43, 27,
        @PublisherId, 2020, 203, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 43, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/76/1a/b1/56bb93b482367c6a64b7a07402794755.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tu-ban-luan-quyen-1';
END

-- Book 3: Cộng Hòa (The Republic)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'cong-hoa-the-republic')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Plato';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Plato', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-102-1014', N'Cộng Hòa (The Republic)', 'cong-hoa-the-republic', N'Đối thoại triết học vĩ đại về công lý, trật tự xã hội lý tưởng và vai trò của người cai trị thông thái trong lịch sử nhân loại.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/07/ae/2e/beb579c21e36eab8fac91543675cb303.jpg',
        127000, 195000, 166000, 56, 44,
        @PublisherId, 2021, 226, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 56, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/07/ae/2e/beb579c21e36eab8fac91543675cb303.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'cong-hoa-the-republic';
END

-- Book 4: Chính Trị Luận
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chinh-tri-luan')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Aristotle';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Aristotle', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-103-1021', N'Chính Trị Luận', 'chinh-tri-luan', N'Khảo cứu nền tảng về tổ chức nhà nước, công dân, hiến pháp và các hình thái chính thể cổ điển Hy Lạp.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/1c/89/2c/f01a38e76a90a4da0b3852de8ffa4caf.jpg',
        114000, 175000, NULL, 69, 61,
        @PublisherId, 2022, 249, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 69, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/1c/89/2c/f01a38e76a90a4da0b3852de8ffa4caf.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chinh-tri-luan';
END

-- Book 5: Suy Tưởng (Meditations)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'suy-tuong-meditations')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Marcus Aurelius';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Marcus Aurelius', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-104-1028', N'Suy Tưởng (Meditations)', 'suy-tuong-meditations', N'Những ghi chép chiêm nghiệm sâu sắc của vị hoàng đế La Mã về chủ nghĩa Khắc kỷ, lòng dũng cảm và kiểm soát nội tâm.', 'https://salt.tikicdn.com/cache/750x750/ts/product/c5/32/d7/01360f1d86e7701ddeea387111d4b8f4.jpg',
        88000, 135000, NULL, 82, 78,
        @PublisherId, 2023, 272, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 82, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/c5/32/d7/01360f1d86e7701ddeea387111d4b8f4.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'suy-tuong-meditations';
END

-- Book 6: Quân Vương (The Prince)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'quan-vuong-the-prince')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Niccolò Machiavelli';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Niccolò Machiavelli', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-105-1035', N'Quân Vương (The Prince)', 'quan-vuong-the-prince', N'Cẩm nang kinh điển về thuật trị quốc, nắm giữ và duy trì quyền lực chính trị đầy thực tế và sắc bén.', 'https://salt.tikicdn.com/cache/750x750/ts/product/c9/1a/75/b6d81b3883d17fabb034b4d403b2a0c1.jpg',
        72000, 110000, 94000, 95, 95,
        @PublisherId, 2024, 295, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 95, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/c9/1a/75/b6d81b3883d17fabb034b4d403b2a0c1.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'quan-vuong-the-prince';
END

-- Book 7: Bàn Về Khế Ước Xã Hội
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ban-ve-khe-uoc-xa-hoi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Jean-Jacques Rousseau';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Jean-Jacques Rousseau', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-106-1042', N'Bàn Về Khế Ước Xã Hội', 'ban-ve-khe-uoc-xa-hoi', N'Tác phẩm triết học chính trị đặt nền móng cho khái niệm chủ quyền nhân dân và nhà nước pháp quyền hiện đại.', 'https://salt.tikicdn.com/cache/750x750/ts/product/96/43/9f/964a731dd876015517ea71967a6fdfcb.jpg',
        81000, 125000, 106000, 38, 112,
        @PublisherId, 2019, 318, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 38, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/96/43/9f/964a731dd876015517ea71967a6fdfcb.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ban-ve-khe-uoc-xa-hoi';
END

-- Book 8: Bàn Về Tự Do (On Liberty)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ban-ve-tu-do-on-liberty')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'John Stuart Mill';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'John Stuart Mill', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-107-1049', N'Bàn Về Tự Do (On Liberty)', 'ban-ve-tu-do-on-liberty', N'Luận điểm kinh điển bảo vệ tự do tư tưởng, tự do ngôn luận và giới hạn quyền lực của nhà nước đối với cá nhân.', 'https://salt.tikicdn.com/cache/750x750/ts/product/7e/96/94/5a564dc9553d35228fc7d3e5d0bd9ab0.png',
        62000, 95000, 81000, 51, 129,
        @PublisherId, 2020, 341, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 51, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/7e/96/94/5a564dc9553d35228fc7d3e5d0bd9ab0.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ban-ve-tu-do-on-liberty';
END

-- Book 9: Đạo Đức Kinh
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dao-duc-kinh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Lão Tử';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Lão Tử', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-108-1056', N'Đạo Đức Kinh', 'dao-duc-kinh', N'Tinh hoa triết học phương Đông về quy luật vận hành của Đạo, đức vô vi và nghệ thuật sống hòa hợp với tự nhiên.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/bd/d4/ca/cdf5b6ab6f0bee199341fc51d071358d.jpg',
        78000, 120000, 102000, 64, 146,
        @PublisherId, 2021, 364, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 64, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/bd/d4/ca/cdf5b6ab6f0bee199341fc51d071358d.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dao-duc-kinh';
END

-- Book 10: Luận Ngữ
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'luan-ngu')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Khổng Tử';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Khổng Tử', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-109-1063', N'Luận Ngữ', 'luan-ngu', N'Tập hợp những lời dạy mẫu mực của Khổng Tử về nhân, lễ, nghĩa, trí, tín và đạo lý làm người quân tử.', 'https://salt.tikicdn.com/cache/750x750/ts/product/5b/49/c0/22a7431121ac6a65236766c12cb10009.jpg',
        94000, 145000, 123000, 77, 13,
        @PublisherId, 2022, 387, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 77, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/5b/49/c0/22a7431121ac6a65236766c12cb10009.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'luan-ngu';
END

-- Book 11: Trang Tử Nam Hoa Kinh
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'trang-tu-nam-hoa-kinh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Trang Tử';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Trang Tử', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-110-1070', N'Trang Tử Nam Hoa Kinh', 'trang-tu-nam-hoa-kinh', N'Triết lý tiêu dao, phóng khoáng, vượt thoát mọi ràng buộc danh lợi để đạt đến cảnh giới tự do tuyệt đối.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/ef/5b/54/e52a03f518bd8d1ecfe3d629c688f5f5.jpg',
        104000, 160000, 136000, 90, 30,
        @PublisherId, 2023, 410, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 90, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/ef/5b/54/e52a03f518bd8d1ecfe3d629c688f5f5.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'trang-tu-nam-hoa-kinh';
END

-- Book 12: Sapiens: Lược Sử Loài Người
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'sapiens-luoc-su-loai-nguoi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Yuval Noah Harari';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Yuval Noah Harari', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-111-1077', N'Sapiens: Lược Sử Loài Người', 'sapiens-luoc-su-loai-nguoi', N'Hành trình tiến hóa ngoạn mục của loài người từ sinh vật vô danh đến kẻ thống trị Trái Đất qua lăng kính lịch sử và sinh học.', 'https://salt.tikicdn.com/cache/750x750/ts/product/9e/36/8e/9c3c01f3fa02cba97eafa6ec7de01b8f.png',
        142000, 219000, NULL, 33, 47,
        @PublisherId, 2024, 433, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 33, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/9e/36/8e/9c3c01f3fa02cba97eafa6ec7de01b8f.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'sapiens-luoc-su-loai-nguoi';
END

-- Book 13: Homo Deus: Lược Sử Tương Lai
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'homo-deus-luoc-su-tuong-lai')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Yuval Noah Harari';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Yuval Noah Harari', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-112-1084', N'Homo Deus: Lược Sử Tương Lai', 'homo-deus-luoc-su-tuong-lai', N'Dự báo táo bạo về tương lai của nhân loại khi trí tuệ nhân tạo, công nghệ sinh học biến đổi con người thành thần thánh.', 'https://salt.tikicdn.com/cache/750x750/ts/product/ba/e7/6d/0d1424f638bf0bcf4b39df6b8eaf0027.jpg',
        153000, 235000, 200000, 46, 64,
        @PublisherId, 2019, 456, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 46, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/ba/e7/6d/0d1424f638bf0bcf4b39df6b8eaf0027.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'homo-deus-luoc-su-tuong-lai';
END

-- Book 14: 21 Bài Học Cho Thế Kỷ 21
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = '21-bai-hoc-cho-the-ky-21')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Yuval Noah Harari';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Yuval Noah Harari', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-113-1091', N'21 Bài Học Cho Thế Kỷ 21', '21-bai-hoc-cho-the-ky-21', N'Những vấn đề cấp bách nhất của thế giới hiện đại: biến đổi khí hậu, bùng nổ dữ liệu, tin giả và chiến tranh hạt nhân.', 'https://salt.tikicdn.com/cache/750x750/ts/product/88/3b/35/7d49eeb08bab785d760d79bd53a7e960.png',
        129000, 199000, 169000, 59, 81,
        @PublisherId, 2020, 479, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 59, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/88/3b/35/7d49eeb08bab785d760d79bd53a7e960.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = '21-bai-hoc-cho-the-ky-21';
END

-- Book 15: Phê Phán Lý Tính Thuần Túy
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'phe-phan-ly-tinh-thuan-tuy')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Immanuel Kant';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Immanuel Kant', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-114-1098', N'Phê Phán Lý Tính Thuần Túy', 'phe-phan-ly-tinh-thuan-tuy', N'Kiệt tác triết học phân định ranh giới nhận thức luận của con người và nền tảng của triết học phương Tây cận đại.', 'https://salt.tikicdn.com/cache/750x750/ts/product/3a/a2/1a/ced0ebad46a51c1503a437559e9b2876.jpg',
        208000, 320000, 272000, 72, 98,
        @PublisherId, 2021, 502, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 72, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/3a/a2/1a/ced0ebad46a51c1503a437559e9b2876.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'phe-phan-ly-tinh-thuan-tuy';
END

-- Book 16: Nguồn Gốc Của Các Loài
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nguon-goc-cua-cac-loai')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Charles Darwin';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Charles Darwin', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-115-1105', N'Nguồn Gốc Của Các Loài', 'nguon-goc-cua-cac-loai', N'Công trình khoa học làm thay đổi thế giới về thuyết tiến hóa thông qua quy luật chọn lọc tự nhiên sinh tồn.', 'https://salt.tikicdn.com/cache/750x750/ts/product/ea/98/dc/a2bd50c0d2c49ed634764a225540ebda.png',
        156000, 240000, NULL, 85, 115,
        @PublisherId, 2022, 525, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 85, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/ea/98/dc/a2bd50c0d2c49ed634764a225540ebda.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nguon-goc-cua-cac-loai';
END

-- Book 17: Thế Giới Của Sophie
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'the-gioi-cua-sophie')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Jostein Gaarder';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Jostein Gaarder', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Phụ Nữ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'chinh-tri---triet-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-116-1112', N'Thế Giới Của Sophie', 'the-gioi-cua-sophie', N'Cuốn tiểu thuyết lôi cuốn dẫn dắt độc giả khám phá toàn cảnh lịch sử triết học phương Tây một cách dễ hiểu và hấp dẫn.', 'https://salt.tikicdn.com/cache/750x750/ts/product/f0/63/8e/5a2c0351ed1ca63f9a0853c3fde5b144.jpg',
        120000, 185000, NULL, 98, 132,
        @PublisherId, 2023, 548, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 98, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/f0/63/8e/5a2c0351ed1ca63f9a0853c3fde5b144.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'the-gioi-cua-sophie';
END

-- Book 18: Mắt Biếc
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'mat-biec')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nguyễn Nhật Ánh';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nguyễn Nhật Ánh', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-1-18234-1', N'Mắt Biếc', 'mat-biec', N'Một trong những tác phẩm nổi tiếng và xúc động nhất của nhà văn Nguyễn Nhật Ánh về tình yêu tuổi học trò trong trẻo, hoài niệm.', 'https://salt.tikicdn.com/cache/750x750/ts/product/aa/41/13/35116c017b8294342e46f6fd002ccbea.png',
        72000, 110000, NULL, 41, 149,
        @PublisherId, 2024, 571, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 41, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/aa/41/13/35116c017b8294342e46f6fd002ccbea.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'mat-biec';
END

-- Book 19: Tôi Thấy Hoa Vàng Trên Cỏ Xanh
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'toi-thay-hoa-vang-tren-co-xanh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nguyễn Nhật Ánh';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nguyễn Nhật Ánh', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-1-18235-8', N'Tôi Thấy Hoa Vàng Trên Cỏ Xanh', 'toi-thay-hoa-vang-tren-co-xanh', N'Câu chuyện về tuổi thơ nghèo khó nhưng đong đầy tình cảm anh em, bè bạn ở làng quê miền Trung.', 'https://salt.tikicdn.com/cache/750x750/ts/product/ac/92/49/3384968eac3888e307a84118b424c1d4.jpg',
        81000, 125000, 106000, 54, 16,
        @PublisherId, 2019, 594, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 54, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/ac/92/49/3384968eac3888e307a84118b424c1d4.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'toi-thay-hoa-vang-tren-co-xanh';
END

-- Book 20: Số Đỏ
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'so-do')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Vũ Trọng Phụng';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Vũ Trọng Phụng', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-119-1133', N'Số Đỏ', 'so-do', N'Kiệt tác văn học trào phúng đỉnh cao vạch trần xã hội thực dân nửa phong kiến thời kỳ Âu hóa qua nhân vật Xuân Tóc Đỏ.', 'https://salt.tikicdn.com/cache/750x750/ts/product/c2/99/c5/205ad9a6d3be6735a882691f3d67e17b.png',
        59000, 90000, NULL, 67, 33,
        @PublisherId, 2020, 617, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 67, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/c2/99/c5/205ad9a6d3be6735a882691f3d67e17b.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'so-do';
END

-- Book 21: Chí Phèo
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chi-pheo')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nam Cao';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nam Cao', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-120-1140', N'Chí Phèo', 'chi-pheo', N'Tác phẩm hiện thực phê phán sâu sắc về bi kịch tha hóa và khát vọng làm người lương thiện của người nông dân nghèo.', 'https://salt.tikicdn.com/cache/750x750/ts/product/d7/5f/4e/50bb49ddd526e17de4ef8116dada8aa4.jpeg',
        49000, 75000, NULL, 80, 50,
        @PublisherId, 2021, 190, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 80, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/d7/5f/4e/50bb49ddd526e17de4ef8116dada8aa4.jpeg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chi-pheo';
END

-- Book 22: Tắt Đèn
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tat-den')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Ngô Tất Tố';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Ngô Tất Tố', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-121-1147', N'Tắt Đèn', 'tat-den', N'Bức tranh ngột ngạt, đau thương về sưu thuế và số phận khốn cùng nhưng bất khuất của chị Dậu nơi làng quê Việt Nam.', 'https://salt.tikicdn.com/cache/750x750/ts/product/0a/17/b1/63d98eeb7d05e678e7c183961a8a5e7a.jpg',
        52000, 80000, NULL, 93, 67,
        @PublisherId, 2022, 213, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 93, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/0a/17/b1/63d98eeb7d05e678e7c183961a8a5e7a.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tat-den';
END

-- Book 23: Nỗi Buồn Chiến Tranh
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'noi-buon-chien-tranh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Bảo Ninh';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Bảo Ninh', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-122-1154', N'Nỗi Buồn Chiến Tranh', 'noi-buon-chien-tranh', N'Góc nhìn chân thực, đa chiều và giàu tính nhân bản về những tổn thương sâu sắc của cuộc chiến tranh trong tâm hồn người lính.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5d/9b/ea/cc61ab0dd4ed7f00589fc7c49d7ca1dd.jpg',
        81000, 125000, NULL, 36, 84,
        @PublisherId, 2023, 236, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 36, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5d/9b/ea/cc61ab0dd4ed7f00589fc7c49d7ca1dd.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'noi-buon-chien-tranh';
END

-- Book 24: Chiếc Thuyền Ngoài Xa
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chiec-thuyen-ngoai-xa')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nguyễn Minh Châu';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nguyễn Minh Châu', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-123-1161', N'Chiếc Thuyền Ngoài Xa', 'chiec-thuyen-ngoai-xa', N'Tập truyện ngắn trăn trở về số phận con người, khoảng cách giữa cái đẹp nghệ thuật và hiện thực cuộc sống lam lũ.', 'https://salt.tikicdn.com/cache/750x750/ts/product/dd/91/6f/b53515a126f472829ea9266459d6abc7.jpg',
        55000, 85000, NULL, 49, 101,
        @PublisherId, 2024, 259, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 49, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/dd/91/6f/b53515a126f472829ea9266459d6abc7.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chiec-thuyen-ngoai-xa';
END

-- Book 25: Rừng Na Uy
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'rung-na-uy')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Haruki Murakami';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Haruki Murakami', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Hội Nhà Văn';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-124-1168', N'Rừng Na Uy', 'rung-na-uy', N'Bản tình ca u buồn, hoài niệm về tình yêu, sự mất mát và nỗi cô đơn của tuổi trẻ Tokyo những năm 1960.', 'https://salt.tikicdn.com/cache/750x750/ts/product/44/61/4c/44c44da5ca1fb84abe6529183e277b5c.jpg',
        94000, 145000, 123000, 62, 118,
        @PublisherId, 2019, 282, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 62, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/44/61/4c/44c44da5ca1fb84abe6529183e277b5c.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'rung-na-uy';
END

-- Book 26: Trăm Năm Cô Đơn
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tram-nam-co-don')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Gabriel García Márquez';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Gabriel García Márquez', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-125-1175', N'Trăm Năm Cô Đơn', 'tram-nam-co-don', N'Đỉnh cao của trường phái hiện thực huyền ảo kể về bi kịch và số phận bảy thế hệ gia tộc Buendía ở làng Macondo.', 'https://salt.tikicdn.com/cache/750x750/ts/product/75/47/f1/5413f2770b6cf2ea3302893620c7d461.png',
        127000, 195000, NULL, 75, 135,
        @PublisherId, 2020, 305, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 75, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/75/47/f1/5413f2770b6cf2ea3302893620c7d461.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tram-nam-co-don';
END

-- Book 27: Ông Già Và Biển Cả
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ong-gia-va-bien-ca')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Ernest Hemingway';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Ernest Hemingway', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-126-1182', N'Ông Già Và Biển Cả', 'ong-gia-va-bien-ca', N'Khúc ca hùng tráng ca ngợi ý chí kiên cường và lòng dũng cảm của con người trước thiên nhiên dữ dội.', 'https://salt.tikicdn.com/cache/750x750/ts/product/54/4d/1f/e091fa3aef56fb6bdf1dd3136007e174.jpg',
        51000, 79000, 67000, 88, 152,
        @PublisherId, 2021, 328, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 88, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/54/4d/1f/e091fa3aef56fb6bdf1dd3136007e174.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ong-gia-va-bien-ca';
END

-- Book 28: Nhà Giả Kim
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nha-gia-kim')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Paulo Coelho';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Paulo Coelho', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Hội Nhà Văn';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-127-1189', N'Nhà Giả Kim', 'nha-gia-kim', N'Hành trình kỳ diệu theo đuổi vận mệnh và lắng nghe tiếng gọi trái tim của chàng chăn cừu Santiago.', 'https://salt.tikicdn.com/cache/750x750/ts/product/a5/c3/b5/01b56afa852e0617cb6629b3121e0957.png',
        58000, 89000, 76000, 31, 19,
        @PublisherId, 2022, 351, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 31, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/a5/c3/b5/01b56afa852e0617cb6629b3121e0957.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nha-gia-kim';
END

-- Book 29: Chiến Tranh Và Hòa Bình
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chien-tranh-va-hoa-binh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Leo Tolstoy';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Leo Tolstoy', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-128-1196', N'Chiến Tranh Và Hòa Bình', 'chien-tranh-va-hoa-binh', N'Thiên sử thi vĩ đại về toàn cảnh xã hội Nga và tinh thần quật cường của nhân dân trong cuộc chiến tranh vệ quốc 1812.', 'https://salt.tikicdn.com/cache/750x750/ts/product/db/1a/94/a94c6831ea2dc0d708e9a03009e14366.png',
        228000, 350000, 298000, 44, 36,
        @PublisherId, 2023, 374, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 44, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/db/1a/94/a94c6831ea2dc0d708e9a03009e14366.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chien-tranh-va-hoa-binh';
END

-- Book 30: Tội Ác Và Trừng Phạt
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'toi-ac-va-trung-phat')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Fyodor Dostoevsky';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Fyodor Dostoevsky', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-129-1203', N'Tội Ác Và Trừng Phạt', 'toi-ac-va-trung-phat', N'Kiệt tác đào sâu vào góc tối tâm lý con người, cuộc giằng xé giữa tội ác và sự chuộc tội của chàng sinh viên Raskolnikov.', 'https://salt.tikicdn.com/cache/750x750/ts/product/52/49/a8/24e57ef11404ddf84a60773b2e6a10f4.jpg',
        129000, 198000, 168000, 57, 53,
        @PublisherId, 2024, 397, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 57, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/52/49/a8/24e57ef11404ddf84a60773b2e6a10f4.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'toi-ac-va-trung-phat';
END

-- Book 31: Những Người Khốn Khổ
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nhung-nguoi-khon-kho')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Victor Hugo';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Victor Hugo', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-130-1210', N'Những Người Khốn Khổ', 'nhung-nguoi-khon-kho', N'Bản anh hùng ca về tình bác ái, lòng vị tha và công lý xã hội qua số phận đầy trắc trở của Jean Valjean.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/31/38/c7/336aebb9b96d0247d3f47ca79bb02bd7.jpg',
        189000, 290000, 247000, 70, 70,
        @PublisherId, 2019, 420, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 70, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/31/38/c7/336aebb9b96d0247d3f47ca79bb02bd7.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nhung-nguoi-khon-kho';
END

-- Book 32: Không Gia Đình
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'khong-gia-dinh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Hector Malot';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Hector Malot', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-131-1217', N'Không Gia Đình', 'khong-gia-dinh', N'Hành trình lưu lạc đầy nghị lực và lòng nhân ái của cậu bé mồ côi Remi trên khắp các nẻo đường nước Pháp.', 'https://salt.tikicdn.com/cache/750x750/ts/product/89/f3/95/5b82db26df0fc84873a5466241588ed6.jpg',
        107000, 165000, 140000, 83, 87,
        @PublisherId, 2020, 443, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 83, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/89/f3/95/5b82db26df0fc84873a5466241588ed6.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'khong-gia-dinh';
END

-- Book 33: Tiếng Chim Hót Trong Bụi Mận Gai
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tieng-chim-hot-trong-bui-man-gai')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Colleen McCullough';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Colleen McCullough', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-132-1224', N'Tiếng Chim Hót Trong Bụi Mận Gai', 'tieng-chim-hot-trong-bui-man-gai', N'Thiên tình sử mãnh liệt, day dứt vượt lên mọi giới hạn giáo quy và lễ giáo nơi thảo nguyên nước Úc.', 'https://salt.tikicdn.com/cache/750x750/ts/product/d2/68/78/688d440b440612f47ce6721c74f33993.jpg',
        117000, 180000, 153000, 96, 104,
        @PublisherId, 2021, 466, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 96, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/d2/68/78/688d440b440612f47ce6721c74f33993.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tieng-chim-hot-trong-bui-man-gai';
END

-- Book 34: Đồi Gió Hú
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'doi-gio-hu')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Emily Brontë';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Emily Brontë', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-133-1231', N'Đồi Gió Hú', 'doi-gio-hu', N'Câu chuyện tình yêu đầy thù hận, đam mê mãnh liệt và ám ảnh giữa Heathcliff và Catherine trên vùng đồng thảo hoang vu.', 'https://salt.tikicdn.com/cache/750x750/ts/product/d1/82/98/eb27c94b6662f39ca7da8863646b1847.png',
        88000, 135000, NULL, 39, 121,
        @PublisherId, 2022, 489, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 39, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/d1/82/98/eb27c94b6662f39ca7da8863646b1847.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'doi-gio-hu';
END

-- Book 35: Chuyện Làng Vũ Đại Ngày Ấy
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chuyen-lang-vu-dai-ngay-ay')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nam Cao';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nam Cao', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'van-hoc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-134-1238', N'Chuyện Làng Vũ Đại Ngày Ấy', 'chuyen-lang-vu-dai-ngay-ay', N'Tuyển tập các truyện ngắn xuất sắc nhất của Nam Cao viết về số phận người nông dân và trí thức nghèo trước Cách mạng.', 'https://salt.tikicdn.com/cache/750x750/ts/product/80/31/73/eebd83580e4684bbbc9ac95bd73bc1c1.jpg',
        62000, 95000, 81000, 52, 138,
        @PublisherId, 2023, 512, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 52, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/80/31/73/eebd83580e4684bbbc9ac95bd73bc1c1.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chuyen-lang-vu-dai-ngay-ay';
END

-- Book 36: Đắc Nhân Tâm
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dac-nhan-tam')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Dale Carnegie';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Dale Carnegie', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-2-00123-9', N'Đắc Nhân Tâm', 'dac-nhan-tam', N'Cuốn sách nghệ thuật thu phục lòng người kinh điển của Dale Carnegie, giúp nâng cao kỹ năng giao tiếp và ứng xử.', 'https://salt.tikicdn.com/cache/750x750/ts/product/19/99/b1/54ecbbbce7bffadf68f623c502bf2b7f.png',
        56000, 86000, 73000, 65, 155,
        @PublisherId, 2024, 535, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 65, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/19/99/b1/54ecbbbce7bffadf68f623c502bf2b7f.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dac-nhan-tam';
END

-- Book 37: Thói Quen Nguyên Tử (Atomic Habits)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'thoi-quen-nguyen-tu-atomic-habits')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'James Clear';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'James Clear', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-136-1252', N'Thói Quen Nguyên Tử (Atomic Habits)', 'thoi-quen-nguyen-tu-atomic-habits', N'Phương pháp khoa học đột phá giúp xây dựng thói quen tốt và từ bỏ thói quen xấu chỉ bằng những thay đổi nhỏ mỗi ngày.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/ce/74/19/92f1fd8499cabe963a8e0559e721398f.jpg',
        123000, 189000, 161000, 78, 22,
        @PublisherId, 2019, 558, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 78, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/ce/74/19/92f1fd8499cabe963a8e0559e721398f.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'thoi-quen-nguyen-tu-atomic-habits';
END

-- Book 38: 7 Thói Quen Của Người Thành Đạt
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = '7-thoi-quen-cua-nguoi-thanh-dat')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Stephen R. Covey';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Stephen R. Covey', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-137-1259', N'7 Thói Quen Của Người Thành Đạt', '7-thoi-quen-cua-nguoi-thanh-dat', N'Cẩm nang quản trị bản thân kinh điển giúp định hướng tư duy chủ động và nâng cao hiệu quả lãnh đạo cuộc đời.', 'https://salt.tikicdn.com/cache/750x750/ts/product/91/6d/cb/4e6518a63f9d03fcc3c2d275f6b24144.jpg',
        127000, 195000, NULL, 91, 39,
        @PublisherId, 2020, 581, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 91, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/91/6d/cb/4e6518a63f9d03fcc3c2d275f6b24144.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = '7-thoi-quen-cua-nguoi-thanh-dat';
END

-- Book 39: Nguyên Lý 80/20
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nguyen-ly-80-20')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Richard Koch';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Richard Koch', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-138-1266', N'Nguyên Lý 80/20', 'nguyen-ly-80-20', N'Bí quyết đạt được nhiều kết quả nhất với ít nỗ lực nhất bằng cách tập trung vào 20% yếu tố then chốt.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/40/c2/0f/61cb9ca7de90e779318e45f9e258407a.jpg',
        90000, 139000, NULL, 34, 56,
        @PublisherId, 2021, 604, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 34, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/40/c2/0f/61cb9ca7de90e779318e45f9e258407a.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nguyen-ly-80-20';
END

-- Book 40: Tư Duy Nhanh Và Chậm
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tu-duy-nhanh-va-cham')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Daniel Kahneman';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Daniel Kahneman', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-139-1273', N'Tư Duy Nhanh Và Chậm', 'tu-duy-nhanh-va-cham', N'Khám phá hai hệ thống chi phối cách chúng ta tư duy, đưa ra phán đoán và những cạm bẫy tâm lý thường gặp.', 'https://salt.tikicdn.com/cache/750x750/ts/product/f4/17/42/7b67443815ef5a83ecb25c6c6995bb16.png',
        155000, 239000, NULL, 47, 73,
        @PublisherId, 2022, 627, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 47, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/f4/17/42/7b67443815ef5a83ecb25c6c6995bb16.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tu-duy-nhanh-va-cham';
END

-- Book 41: Sức Mạnh Của Hiện Tại
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'suc-manh-cua-hien-tai')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Eckhart Tolle';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Eckhart Tolle', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-140-1280', N'Sức Mạnh Của Hiện Tại', 'suc-manh-cua-hien-tai', N'Kim chỉ nam chuyển hóa tâm thức, buông bỏ lo âu về quá khứ và tương lai để sống trọn vẹn trong khoảnh khắc thực tại.', 'https://salt.tikicdn.com/cache/750x750/ts/product/24/b0/43/e63f0f6adfb7a34ab79e6b82828e566b.jpg',
        94000, 145000, NULL, 60, 90,
        @PublisherId, 2023, 200, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 60, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/24/b0/43/e63f0f6adfb7a34ab79e6b82828e566b.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'suc-manh-cua-hien-tai';
END

-- Book 42: Tâm Lý Học Về Tiền
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tam-ly-hoc-ve-tien')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Morgan Housel';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Morgan Housel', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-141-1287', N'Tâm Lý Học Về Tiền', 'tam-ly-hoc-ve-tien', N'Những bài học vượt thời gian về sự giàu có, lòng tham và hạnh phúc qua lăng kính hành vi tài chính con người.', 'https://salt.tikicdn.com/cache/750x750/ts/product/c9/a2/67/8a62c3864870fbdda164d50b6219e582.png',
        107000, 165000, 140000, 73, 107,
        @PublisherId, 2024, 223, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 73, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/c9/a2/67/8a62c3864870fbdda164d50b6219e582.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tam-ly-hoc-ve-tien';
END

-- Book 43: Nghệ Thuật Tinh Tế Của Việc Đếch Quan Tâm
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nghe-thuat-tinh-te-cua-viec-dech-quan-tam')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Mark Manson';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Mark Manson', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-142-1294', N'Nghệ Thuật Tinh Tế Của Việc Đếch Quan Tâm', 'nghe-thuat-tinh-te-cua-viec-dech-quan-tam', N'Góc nhìn phản trực giác hài hước về việc lựa chọn những điều thực sự quan trọng để có một cuộc sống hạnh phúc.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/33/e6/a4/349a506f15a34548c5aa5101816ff010.jpg',
        81000, 125000, 106000, 86, 124,
        @PublisherId, 2019, 246, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 86, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/33/e6/a4/349a506f15a34548c5aa5101816ff010.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nghe-thuat-tinh-te-cua-viec-dech-quan-tam';
END

-- Book 44: Dám Bị Ghét
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dam-bi-ghet')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Kishimi Ichiro & Koga Fumitake';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Kishimi Ichiro & Koga Fumitake', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Lao Động';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-143-1301', N'Dám Bị Ghét', 'dam-bi-ghet', N'Triết học tâm lý học Adler truyền cảm hứng tự do lựa chọn cuộc sống của chính mình mà không cần tìm kiếm sự thừa nhận.', 'https://salt.tikicdn.com/cache/750x750/ts/product/f1/ec/3f/438fa50e15075da8fcd2c3463c0e0b5d.png',
        77000, 119000, 101000, 99, 141,
        @PublisherId, 2020, 269, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 99, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/f1/ec/3f/438fa50e15075da8fcd2c3463c0e0b5d.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dam-bi-ghet';
END

-- Book 45: Dám Hạnh Phúc
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dam-hanh-phuc')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Kishimi Ichiro & Koga Fumitake';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Kishimi Ichiro & Koga Fumitake', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Lao Động';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-144-1308', N'Dám Hạnh Phúc', 'dam-hanh-phuc', N'Phần tiếp theo làm rõ con đường can đảm yêu thương và hành động để chạm đến hạnh phúc thực sự trong đời sống.', 'https://salt.tikicdn.com/cache/750x750/ts/product/47/bf/82/36d16def99eafa5db9b2e3cf2efd0f43.jpg',
        84000, 129000, 110000, 42, 158,
        @PublisherId, 2021, 292, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 42, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/47/bf/82/36d16def99eafa5db9b2e3cf2efd0f43.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dam-hanh-phuc';
END

-- Book 46: 48 Nguyên Tắc Chủ Chốt Của Quyền Lực
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = '48-nguyen-tac-chu-chot-cua-quyen-luc')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Robert Greene';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Robert Greene', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-145-1315', N'48 Nguyên Tắc Chủ Chốt Của Quyền Lực', '48-nguyen-tac-chu-chot-cua-quyen-luc', N'Tổng kết tinh hoa lịch sử hàng ngàn năm về chiến lược quyền lực, tâm lý thao túng và bảo vệ bản thân.', 'https://salt.tikicdn.com/cache/750x750/ts/product/38/14/3c/1dd7810e7b2067f4b4edceae1167b1f7.jpg',
        169000, 260000, 221000, 55, 25,
        @PublisherId, 2022, 315, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 55, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/38/14/3c/1dd7810e7b2067f4b4edceae1167b1f7.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = '48-nguyen-tac-chu-chot-cua-quyen-luc';
END

-- Book 47: Tâm Lý Học Đám Đông
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tam-ly-hoc-dam-dong')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Gustave Le Bon';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Gustave Le Bon', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-146-1322', N'Tâm Lý Học Đám Đông', 'tam-ly-hoc-dam-dong', N'Công trình kinh điển lý giải cơ chế hành vi tập thể, cảm xúc lây lan và sự suy giảm lý trí của cá nhân khi hòa vào đám đông.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/39/98/b3/1213224d700e9c2a6959a3b0e38fca9a.jpg',
        75000, 115000, 98000, 68, 42,
        @PublisherId, 2023, 338, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 68, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/39/98/b3/1213224d700e9c2a6959a3b0e38fca9a.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tam-ly-hoc-dam-dong';
END

-- Book 48: Đọc Vị Bất Kỳ Ai
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'doc-vi-bat-ky-ai')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'David J. Lieberman';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'David J. Lieberman', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Hà Nội';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-147-1329', N'Đọc Vị Bất Kỳ Ai', 'doc-vi-bat-ky-ai', N'Kỹ thuật tâm lý thực tế giúp nắm bắt suy nghĩ, phát hiện nói dối và thấu hiểu động cơ thật của người đối diện.', 'https://salt.tikicdn.com/cache/750x750/ts/product/15/33/54/2feaadff1eb890076b852314f4818662.png',
        71000, 109000, NULL, 81, 59,
        @PublisherId, 2024, 361, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 81, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/15/33/54/2feaadff1eb890076b852314f4818662.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'doc-vi-bat-ky-ai';
END

-- Book 49: Thao Túng Tâm Lý (Gaslighting)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'thao-tung-tam-ly-gaslighting')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Shannon Thomas';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Shannon Thomas', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Công Thương';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-148-1336', N'Thao Túng Tâm Lý (Gaslighting)', 'thao-tung-tam-ly-gaslighting', N'Nhận diện các dấu hiệu lạm dụng tâm lý độc hại và phương pháp chữa lành, thiết lập lại ranh giới cá nhân lành mạnh.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/90/49/97/ec88ab408c1997378344486c94dbac40.jpg',
        94000, 145000, 123000, 94, 76,
        @PublisherId, 2019, 384, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 94, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/90/49/97/ec88ab408c1997378344486c94dbac40.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'thao-tung-tam-ly-gaslighting';
END

-- Book 50: Tìm Lại Lẽ Sống
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tim-lai-le-song')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Viktor E. Frankl';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Viktor E. Frankl', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-149-1343', N'Tìm Lại Lẽ Sống', 'tim-lai-le-song', N'Hồi ký xúc động từ trại tập trung Đức quốc xã minh chứng cho ý nghĩa cuộc sống và sức mạnh phi thường của tinh thần.', 'https://salt.tikicdn.com/cache/750x750/ts/product/a6/d3/d7/a392a68fe6b3eda004259bc9022c8a1e.jpg',
        75000, 115000, 98000, 37, 93,
        @PublisherId, 2020, 407, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 37, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/a6/d3/d7/a392a68fe6b3eda004259bc9022c8a1e.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tim-lai-le-song';
END

-- Book 51: Nghệ Thuật Giao Tiếp Để Thành Công
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nghe-thuat-giao-tiep-de-thanh-cong')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Leil Lowndes';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Leil Lowndes', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-150-1350', N'Nghệ Thuật Giao Tiếp Để Thành Công', 'nghe-thuat-giao-tiep-de-thanh-cong', N'92 thủ thuật đơn giản nhưng hiệu quả để tạo ấn tượng đẹp, kết nối tự tin và thuyết phục người khác trong mọi hoàn cảnh.', 'https://salt.tikicdn.com/cache/750x750/ts/product/43/ec/5c/821f53fd27347afd84c696a82264d2f9.jpg',
        88000, 135000, 115000, 50, 110,
        @PublisherId, 2021, 430, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 50, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/43/ec/5c/821f53fd27347afd84c696a82264d2f9.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nghe-thuat-giao-tiep-de-thanh-cong';
END

-- Book 52: Trí Tuệ Cảm Xúc 2.0 (EQ)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tri-tue-cam-xuc-2-0-eq')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Travis Bradberry';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Travis Bradberry', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'ky-nang-song';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-151-1357', N'Trí Tuệ Cảm Xúc 2.0 (EQ)', 'tri-tue-cam-xuc-2-0-eq', N'Chương trình rèn luyện 4 kỹ năng cốt lõi của EQ giúp kiểm soát cảm xúc bản thân và thấu hiểu người xung quanh.', 'https://salt.tikicdn.com/cache/750x750/ts/product/d4/f7/a7/e9a5030ed25b10d9fb7a26fa04952d8d.jpg',
        97000, 149000, 127000, 63, 127,
        @PublisherId, 2022, 453, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 63, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/d4/f7/a7/e9a5030ed25b10d9fb7a26fa04952d8d.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tri-tue-cam-xuc-2-0-eq';
END

-- Book 53: Tự Truyện Alex Ferguson
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tu-truyen-alex-ferguson')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Alex Ferguson';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Alex Ferguson', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-152-1364', N'Tự Truyện Alex Ferguson', 'tu-truyen-alex-ferguson', N'Hồi ký chân thực về 26 năm dẫn dắt Manchester United đỉnh cao, thuật dùng người và quản trị phòng thay đồ xuất chúng.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/22/0c/9a/34f987352d8420404197fa57682cd0aa.jpg',
        120000, 185000, 157000, 76, 144,
        @PublisherId, 2023, 476, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 76, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/22/0c/9a/34f987352d8420404197fa57682cd0aa.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tu-truyen-alex-ferguson';
END

-- Book 54: Kobe Bryant: The Mamba Mentality
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'kobe-bryant-the-mamba-mentality')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Kobe Bryant';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Kobe Bryant', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-153-1371', N'Kobe Bryant: The Mamba Mentality', 'kobe-bryant-the-mamba-mentality', N'Tư duy Mamba huyền thoại: tinh thần làm việc không ngừng nghỉ, kỷ luật thép và khát khao chiến thắng đến tột cùng.', 'https://covers.openlibrary.org/b/id/9261036-L.jpg',
        163000, 250000, 213000, 89, 11,
        @PublisherId, 2024, 499, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 89, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/9261036-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'kobe-bryant-the-mamba-mentality';
END

-- Book 55: Michael Jordan: Cú Nhảy Vĩ Đại
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'michael-jordan-cu-nhay-vi-dai')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Roland Lazenby';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Roland Lazenby', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-154-1378', N'Michael Jordan: Cú Nhảy Vĩ Đại', 'michael-jordan-cu-nhay-vi-dai', N'Tiểu sử toàn diện về hành trình vươn lên thành biểu tượng thể thao toàn cầu của huyền thoại bóng rổ số 23.', 'https://salt.tikicdn.com/cache/750x750/ts/product/2b/59/de/be68d392f4ca63519ef5f7c04d745bcf.png',
        189000, 290000, 247000, 32, 28,
        @PublisherId, 2019, 522, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 32, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/2b/59/de/be68d392f4ca63519ef5f7c04d745bcf.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'michael-jordan-cu-nhay-vi-dai';
END

-- Book 56: Dẫn Dắt Từ Bên Trong: 11 Chiếc Nhẫn
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dan-dat-tu-ben-trong-11-chiec-nhan')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Phil Jackson';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Phil Jackson', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-155-1385', N'Dẫn Dắt Từ Bên Trong: 11 Chiếc Nhẫn', 'dan-dat-tu-ben-trong-11-chiec-nhan', N'Triết lý lãnh đạo độc đáo kết hợp thiền định và tinh thần đồng đội giúp giành 11 chức vô địch NBA lừng lẫy.', 'https://salt.tikicdn.com/cache/750x750/ts/product/1b/5a/92/5d72e2cbdec77493823371442dddebe0.jpg',
        114000, 175000, NULL, 45, 45,
        @PublisherId, 2020, 545, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 45, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/1b/5a/92/5d72e2cbdec77493823371442dddebe0.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dan-dat-tu-ben-trong-11-chiec-nhan';
END

-- Book 57: Không Thể Tổn Thương (Can't Hurt Me)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'khong-the-ton-thuong-can-t-hurt-me')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'David Goggins';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'David Goggins', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-156-1392', N'Không Thể Tổn Thương (Can''t Hurt Me)', 'khong-the-ton-thuong-can-t-hurt-me', N'Câu chuyện phi thường của cựu đặc nhiệm Navy SEAL vượt qua nghịch cảnh để chinh phục giới hạn thể lực và ý chí.', 'https://salt.tikicdn.com/cache/750x750/ts/product/6d/65/37/a2c1d9726875e738c09515fd790dda73.jpg',
        137000, 210000, NULL, 58, 62,
        @PublisherId, 2021, 568, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 58, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/6d/65/37/a2c1d9726875e738c09515fd790dda73.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'khong-the-ton-thuong-can-t-hurt-me';
END

-- Book 58: Arnold: Siêu Thể Lực & Ý Chí
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'arnold-sieu-the-luc-y-chi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Arnold Schwarzenegger';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Arnold Schwarzenegger', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-157-1399', N'Arnold: Siêu Thể Lực & Ý Chí', 'arnold-sieu-the-luc-y-chi', N'7 nguyên tắc sống và tập luyện kiên định giúp Arnold trở thành nhà vô địch thể hình, ngôi sao điện ảnh và chính khách.', 'https://salt.tikicdn.com/cache/750x750/ts/product/e2/f0/8d/f6f59755b775e2fc51389b9c69fe9731.jpg',
        156000, 240000, NULL, 71, 79,
        @PublisherId, 2022, 591, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 71, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/e2/f0/8d/f6f59755b775e2fc51389b9c69fe9731.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'arnold-sieu-the-luc-y-chi';
END

-- Book 59: Tôi Nói Gì Khi Nói Về Chạy Bộ
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'toi-noi-gi-khi-noi-ve-chay-bo')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Haruki Murakami';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Haruki Murakami', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Hội Nhà Văn';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-158-1406', N'Tôi Nói Gì Khi Nói Về Chạy Bộ', 'toi-noi-gi-khi-noi-ve-chay-bo', N'Những suy tư mộc mạc và chân thành của nhà văn Murakami về đam mê chạy cự ly dài và mối liên hệ với sáng tạo văn chương.', 'https://salt.tikicdn.com/cache/750x750/ts/product/61/b3/8f/a82a7d056cbf14b5846e105a81d8efbe.jpg',
        62000, 95000, 81000, 84, 96,
        @PublisherId, 2023, 614, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 84, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/61/b3/8f/a82a7d056cbf14b5846e105a81d8efbe.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'toi-noi-gi-khi-noi-ve-chay-bo';
END

-- Book 60: Sinh Ra Để Chạy (Born to Run)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'sinh-ra-de-chay-born-to-run')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Christopher McDougall';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Christopher McDougall', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-159-1413', N'Sinh Ra Để Chạy (Born to Run)', 'sinh-ra-de-chay-born-to-run', N'Bí mật của bộ tộc Tarahumara chạy hàng trăm km không chấn thương và nguồn gốc tiến hóa chạy bộ của loài người.', 'https://salt.tikicdn.com/cache/750x750/ts/product/98/74/92/3101787de7bb01d62497587b50528f93.png',
        107000, 165000, 140000, 97, 113,
        @PublisherId, 2024, 187, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 97, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/98/74/92/3101787de7bb01d62497587b50528f93.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'sinh-ra-de-chay-born-to-run';
END

-- Book 61: Dinh Dưỡng Thể Thao Đỉnh Cao
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dinh-duong-the-thao-dinh-cao')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Anita Bean';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Anita Bean', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thể Dục Thể Thao';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-160-1420', N'Dinh Dưỡng Thể Thao Đỉnh Cao', 'dinh-duong-the-thao-dinh-cao', N'Cẩm nang dinh dưỡng khoa học cung cấp năng lượng, tối ưu hóa cơ bắp và phục hồi thể lực cho vận động viên.', 'https://salt.tikicdn.com/cache/750x750/ts/product/1b/07/d6/86a9a1ea5f1825be124ae70841dd718d.JPG',
        127000, 195000, 166000, 40, 130,
        @PublisherId, 2019, 210, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 40, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/1b/07/d6/86a9a1ea5f1825be124ae70841dd718d.JPG', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dinh-duong-the-thao-dinh-cao';
END

-- Book 62: Yoga Căn Bản Và Nâng Cao
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'yoga-can-ban-va-nang-cao')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'B.K.S. Iyengar';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'B.K.S. Iyengar', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thể Dục Thể Thao';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-161-1427', N'Yoga Căn Bản Và Nâng Cao', 'yoga-can-ban-va-nang-cao', N'Hướng dẫn chuẩn mực các tư thế Asana và kỹ thuật hít thở Pranayama giúp cân bằng thể xác và tinh thần.', 'https://salt.tikicdn.com/cache/750x750/ts/product/d1/66/f7/f1e43b4876b942a098eec3f4f9121d6d.png',
        143000, 220000, 187000, 53, 147,
        @PublisherId, 2020, 233, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 53, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/d1/66/f7/f1e43b4876b942a098eec3f4f9121d6d.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'yoga-can-ban-va-nang-cao';
END

-- Book 63: Khoa Học Về Giấc Ngủ Cho Vận Động Viên
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'khoa-hoc-ve-giac-ngu-cho-van-dong-vien')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nick Littlehales';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nick Littlehales', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-162-1434', N'Khoa Học Về Giấc Ngủ Cho Vận Động Viên', 'khoa-hoc-ve-giac-ngu-cho-van-dong-vien', N'Phương pháp ngủ R90 tối ưu hóa chu kỳ phục hồi thể chất và não bộ dành cho các ngôi sao thể thao đẳng cấp thế giới.', 'https://salt.tikicdn.com/cache/750x750/ts/product/95/f1/a2/43892106637eec54b455202e15b85526.jpg',
        88000, 135000, 115000, 66, 14,
        @PublisherId, 2021, 256, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 66, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/95/f1/a2/43892106637eec54b455202e15b85526.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'khoa-hoc-ve-giac-ngu-cho-van-dong-vien';
END

-- Book 64: Pep Guardiola: Cuộc Tiến Hóa Chiến Thuật
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'pep-guardiola-cuoc-tien-hoa-chien-thuat')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Martí Perarnau';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Martí Perarnau', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-163-1441', N'Pep Guardiola: Cuộc Tiến Hóa Chiến Thuật', 'pep-guardiola-cuoc-tien-hoa-chien-thuat', N'Phân tích chiều sâu tư duy chiến thuật bóng đá hiện đại và triết lý kiểm soát bóng đỉnh cao của Pep Guardiola.', 'https://salt.tikicdn.com/cache/750x750/ts/product/65/f6/0e/8aebabb6a531f1ae521b56366203359c.jpg',
        140000, 215000, 183000, 79, 31,
        @PublisherId, 2022, 279, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 79, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/65/f6/0e/8aebabb6a531f1ae521b56366203359c.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'pep-guardiola-cuoc-tien-hoa-chien-thuat';
END

-- Book 65: Calisthenics: Nghệ Thuật Thể Hình Tự Thân
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'calisthenics-nghe-thuat-the-hinh-tu-than')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Paul Wade';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Paul Wade', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thể Dục Thể Thao';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-164-1448', N'Calisthenics: Nghệ Thuật Thể Hình Tự Thân', 'calisthenics-nghe-thuat-the-hinh-tu-than', N'Phương pháp rèn luyện sức mạnh tuyệt đỉnh chỉ bằng trọng lượng cơ thể không cần dụng cụ phòng gym đắt đỏ.', 'https://salt.tikicdn.com/cache/750x750/ts/product/dd/42/ab/f614a5e5b1e2ce597851ce01075db3fd.png',
        107000, 165000, NULL, 92, 48,
        @PublisherId, 2023, 302, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 92, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/dd/42/ab/f614a5e5b1e2ce597851ce01075db3fd.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'calisthenics-nghe-thuat-the-hinh-tu-than';
END

-- Book 66: Cẩm Nang Bơi Lội Đỉnh Cao
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'cam-nang-boi-loi-dinh-cao')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Terry Laughlin';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Terry Laughlin', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thể Dục Thể Thao';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-165-1455', N'Cẩm Nang Bơi Lội Đỉnh Cao', 'cam-nang-boi-loi-dinh-cao', N'Phương pháp Total Immersion giúp bơi lội nhẹ nhàng, lướt nước êm ái và tiết kiệm sức bền tối đa.', 'https://salt.tikicdn.com/cache/750x750/ts/product/95/9d/5e/a364abba1f6d26a4434157c3c108a6a4.png',
        94000, 145000, NULL, 35, 65,
        @PublisherId, 2024, 325, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 35, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/95/9d/5e/a364abba1f6d26a4434157c3c108a6a4.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'cam-nang-boi-loi-dinh-cao';
END

-- Book 67: Tâm Lý Học Trong Thể Thao Đỉnh Cao
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tam-ly-hoc-trong-the-thao-dinh-cao')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'George Mumford';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'George Mumford', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Lao Động';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-166-1462', N'Tâm Lý Học Trong Thể Thao Đỉnh Cao', 'tam-ly-hoc-trong-the-thao-dinh-cao', N'Liệu pháp chánh niệm giúp các vận động viên vượt qua áp lực thi đấu và đạt trạng thái thăng hoa tinh thần.', 'https://salt.tikicdn.com/cache/750x750/ts/product/58/03/e4/582c448ac46d0e4a5ac113be8a7ba152.jpg',
        101000, 155000, NULL, 48, 82,
        @PublisherId, 2019, 348, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 48, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/58/03/e4/582c448ac46d0e4a5ac113be8a7ba152.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tam-ly-hoc-trong-the-thao-dinh-cao';
END

-- Book 68: Cristiano Ronaldo: Khát Vọng Tột Cùng
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'cristiano-ronaldo-khat-vong-tot-cung')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Guillem Balague';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Guillem Balague', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-167-1469', N'Cristiano Ronaldo: Khát Vọng Tột Cùng', 'cristiano-ronaldo-khat-vong-tot-cung', N'Hành trình từ cậu bé Madeira nghèo khó trở thành cỗ máy săn bàn vĩ đại nhờ ý chí tập luyện phi thường.', 'https://salt.tikicdn.com/cache/750x750/ts/product/5f/b8/9f/94ee43c17a3a4950c9e3abac21c3a7c2.png',
        127000, 195000, 166000, 61, 99,
        @PublisherId, 2020, 371, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 61, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/5f/b8/9f/94ee43c17a3a4950c9e3abac21c3a7c2.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'cristiano-ronaldo-khat-vong-tot-cung';
END

-- Book 69: Bóng Đá: Một Tôn Giáo Toàn Cầu
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'bong-da-mot-ton-giao-toan-cau')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'David Goldblatt';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'David Goldblatt', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'the-thao';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-168-1476', N'Bóng Đá: Một Tôn Giáo Toàn Cầu', 'bong-da-mot-ton-giao-toan-cau', N'Khảo cứu lịch sử xã hội, kinh tế và chính trị đằng sau môn thể thao vua có sức lay động hàng tỷ trái tim.', 'https://salt.tikicdn.com/cache/750x750/ts/product/a7/9c/a1/dc90f2d3a59d6ef5476fecf217cc1e9b.jpg',
        169000, 260000, 221000, 74, 116,
        @PublisherId, 2021, 394, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 74, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/a7/9c/a1/dc90f2d3a59d6ef5476fecf217cc1e9b.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'bong-da-mot-ton-giao-toan-cau';
END

-- Book 70: Clean Architecture: Kiến Trúc Phần Mềm Sạch
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'clean-architecture-kien-truc-phan-mem-sach')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Robert C. Martin';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Robert C. Martin', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-169-1483', N'Clean Architecture: Kiến Trúc Phần Mềm Sạch', 'clean-architecture-kien-truc-phan-mem-sach', N'Cẩm nang kinh điển của Uncle Bob về các nguyên tắc kiến trúc phần mềm sạch, linh hoạt và độc lập với framework.', 'https://salt.tikicdn.com/cache/750x750/ts/product/95/5e/0e/9f816390625782c1a51a9030567b99ce.png',
        208000, 320000, 272000, 87, 133,
        @PublisherId, 2022, 417, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 87, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/95/5e/0e/9f816390625782c1a51a9030567b99ce.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'clean-architecture-kien-truc-phan-mem-sach';
END

-- Book 71: Lược Sử Thời Gian
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'luoc-su-thoi-gian')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Stephen Hawking';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Stephen Hawking', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-170-1490', N'Lược Sử Thời Gian', 'luoc-su-thoi-gian', N'Công trình giải thích các khái niệm vật lý thiên văn từ vụ nổ Big Bang đến lỗ đen vũ trụ một cách lôi cuốn và dễ hiểu.', 'https://salt.tikicdn.com/cache/750x750/ts/product/17/00/e9/f44d8827f41031fbadfe039e33471498.png',
        94000, 145000, 123000, 30, 150,
        @PublisherId, 2023, 440, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 30, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/17/00/e9/f44d8827f41031fbadfe039e33471498.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'luoc-su-thoi-gian';
END

-- Book 72: Vũ Trụ (Cosmos)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'vu-tru-cosmos')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Carl Sagan';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Carl Sagan', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-171-1497', N'Vũ Trụ (Cosmos)', 'vu-tru-cosmos', N'Bản hùng ca tráng lệ về khoa học vũ trụ, nguồn gốc sự sống và sứ mệnh tìm kiếm tri thức của nền văn minh nhân loại.', 'https://salt.tikicdn.com/cache/750x750/ts/product/ba/46/0d/2f589395b64327a090c2d6bffbe057b9.jpg',
        163000, 250000, 213000, 43, 17,
        @PublisherId, 2024, 463, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 43, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/ba/46/0d/2f589395b64327a090c2d6bffbe057b9.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'vu-tru-cosmos';
END

-- Book 73: Vũ Trụ Trong Vỏ Hạt Dẻ
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'vu-tru-trong-vo-hat-de')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Stephen Hawking';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Stephen Hawking', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-172-1504', N'Vũ Trụ Trong Vỏ Hạt Dẻ', 'vu-tru-trong-vo-hat-de', N'Khám phá biên giới của vật lý lý thuyết: thuyết tương đối rộng, cơ học lượng tử và lý thuyết siêu dây bí ẩn.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/d1/4a/3c/faa1946b0e80e106b8962efed7fd2749.jpg',
        120000, 185000, 157000, 56, 34,
        @PublisherId, 2019, 486, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 56, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/d1/4a/3c/faa1946b0e80e106b8962efed7fd2749.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'vu-tru-trong-vo-hat-de';
END

-- Book 74: Định Lý Cuối Cùng Của Fermat
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dinh-ly-cuoi-cung-cua-fermat')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Simon Singh';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Simon Singh', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-173-1511', N'Định Lý Cuối Cùng Của Fermat', 'dinh-ly-cuoi-cung-cua-fermat', N'Hành trình 350 năm trí tuệ nhân loại theo đuổi lời giải cho câu đố toán học hóc búa nhất lịch sử.', 'https://salt.tikicdn.com/cache/750x750/ts/product/2c/45/4d/271c780af4f4c234844674fbce537a46.jpg',
        88000, 135000, 115000, 69, 51,
        @PublisherId, 2020, 509, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 69, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/2c/45/4d/271c780af4f4c234844674fbce537a46.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dinh-ly-cuoi-cung-cua-fermat';
END

-- Book 75: Chắc Bạn Đùa, Chắc Bác Feynman!
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chac-ban-dua-chac-bac-feynman')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Richard P. Feynman';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Richard P. Feynman', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-174-1518', N'Chắc Bạn Đùa, Chắc Bác Feynman!', 'chac-ban-dua-chac-bac-feynman', N'Những câu chuyện phiêu lưu dí dỏm, thông minh và đầy cảm hứng của nhà vật lý đoạt giải Nobel Richard Feynman.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/02/a2/e8/916495871ef577c96e4163f01a17b382.jpg',
        98000, 150000, NULL, 82, 68,
        @PublisherId, 2021, 532, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 82, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/02/a2/e8/916495871ef577c96e4163f01a17b382.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chac-ban-dua-chac-bac-feynman';
END

-- Book 76: The Pragmatic Programmer: Người Lập Trình Thực Dụng
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'the-pragmatic-programmer-nguoi-lap-trinh-thuc-dung')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Andrew Hunt & David Thomas';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Andrew Hunt & David Thomas', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-175-1525', N'The Pragmatic Programmer: Người Lập Trình Thực Dụng', 'the-pragmatic-programmer-nguoi-lap-trinh-thuc-dung', N'Cẩm nang tư duy lập trình chuyên nghiệp giúp nâng tầm kỹ năng viết mã sạch, bền vững và thích ứng nhanh.', 'https://salt.tikicdn.com/cache/750x750/ts/product/e1/1b/95/979ea1f2a44a70454becb358cc94c0f5.jpg',
        182000, 280000, 238000, 95, 85,
        @PublisherId, 2022, 555, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 95, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/e1/1b/95/979ea1f2a44a70454becb358cc94c0f5.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'the-pragmatic-programmer-nguoi-lap-trinh-thuc-dung';
END

-- Book 77: Code Complete: Hướng Dẫn Toàn Diện Về Lập Trình
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'code-complete-huong-dan-toan-dien-ve-lap-trinh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Steve McConnell';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Steve McConnell', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-176-1532', N'Code Complete: Hướng Dẫn Toàn Diện Về Lập Trình', 'code-complete-huong-dan-toan-dien-ve-lap-trinh', N'Bách khoa toàn thư thực hành công nghệ phần mềm từ khâu thiết kế kiến trúc đến kiểm thử và bảo trì mã nguồn.', 'https://salt.tikicdn.com/cache/750x750/ts/product/2d/ac/cf/82de55bcd2cfd2143e40bd0fe8d6dd00.jpg',
        254000, 390000, 332000, 38, 102,
        @PublisherId, 2023, 578, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 38, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/2d/ac/cf/82de55bcd2cfd2143e40bd0fe8d6dd00.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'code-complete-huong-dan-toan-dien-ve-lap-trinh';
END

-- Book 78: Design Patterns: Các Mẫu Thiết Kế Hướng Đối Tượng
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'design-patterns-cac-mau-thiet-ke-huong-doi-tuong')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Erich Gamma & Gang of Four';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Erich Gamma & Gang of Four', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-177-1539', N'Design Patterns: Các Mẫu Thiết Kế Hướng Đối Tượng', 'design-patterns-cac-mau-thiet-ke-huong-doi-tuong', N'23 mẫu thiết kế phần mềm kinh điển giải quyết các bài toán kiến trúc hướng đối tượng linh hoạt và tái sử dụng cao.', 'https://salt.tikicdn.com/cache/750x750/ts/product/99/f9/b0/21936caf17383c0c89d14a7dccb13b5c.jpg',
        221000, 340000, 289000, 51, 119,
        @PublisherId, 2024, 601, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 51, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/99/f9/b0/21936caf17383c0c89d14a7dccb13b5c.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'design-patterns-cac-mau-thiet-ke-huong-doi-tuong';
END

-- Book 79: Refactoring: Cải Thiện Thiết Kế Mã Nguồn Hiện Có
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'refactoring-cai-thien-thiet-ke-ma-nguon-hien-co')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Martin Fowler';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Martin Fowler', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-178-1546', N'Refactoring: Cải Thiện Thiết Kế Mã Nguồn Hiện Có', 'refactoring-cai-thien-thiet-ke-ma-nguon-hien-co', N'Kỹ thuật tái cấu trúc mã nguồn thông minh giúp hệ thống phần mềm dễ đọc, dễ bảo trì và hạn chế tối đa lỗi.', 'https://salt.tikicdn.com/cache/750x750/ts/product/4a/f8/45/307a119c45d539b1d699c83789df7733.png',
        202000, 310000, 264000, 64, 136,
        @PublisherId, 2019, 624, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 64, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/4a/f8/45/307a119c45d539b1d699c83789df7733.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'refactoring-cai-thien-thiet-ke-ma-nguon-hien-co';
END

-- Book 80: Trí Tuệ Nhân Tạo: Kỷ Nguyên Mới (AI Superpowers)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tri-tue-nhan-tao-ky-nguyen-moi-ai-superpowers')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Kai-Fu Lee';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Kai-Fu Lee', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-179-1553', N'Trí Tuệ Nhân Tạo: Kỷ Nguyên Mới (AI Superpowers)', 'tri-tue-nhan-tao-ky-nguyen-moi-ai-superpowers', N'Cái nhìn sâu sắc về cuộc đua AI toàn cầu giữa Thung lũng Silicon và Trung Quốc cùng tác động sâu rộng tới việc làm.', 'https://salt.tikicdn.com/cache/750x750/ts/product/a2/9e/f2/056e2e70a7a0f8f2cc7d1e1a7bcc9f09.png',
        120000, 185000, NULL, 77, 153,
        @PublisherId, 2020, 197, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 77, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/a2/9e/f2/056e2e70a7a0f8f2cc7d1e1a7bcc9f09.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tri-tue-nhan-tao-ky-nguyen-moi-ai-superpowers';
END

-- Book 81: Học Máy Cơ Bản (Machine Learning)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'hoc-may-co-ban-machine-learning')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Vũ Hữu Tiệp';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Vũ Hữu Tiệp', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Khoa Học Tự Nhiên';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-180-1560', N'Học Máy Cơ Bản (Machine Learning)', 'hoc-may-co-ban-machine-learning', N'Giáo trình dễ tiếp cận về các thuật toán machine learning căn bản kèm ứng dụng thực tế bằng ngôn ngữ Python.', 'https://salt.tikicdn.com/cache/750x750/ts/product/de/73/f7/59682ccef23c831ab1c1f02839259ad6.jpg',
        150000, 230000, 196000, 90, 20,
        @PublisherId, 2021, 220, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 90, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/de/73/f7/59682ccef23c831ab1c1f02839259ad6.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'hoc-may-co-ban-machine-learning';
END

-- Book 82: Thiết Kế Hệ Thống Quy Mô Lớn (System Design)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'thiet-ke-he-thong-quy-mo-lon-system-design')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Alex Xu';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Alex Xu', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-181-1567', N'Thiết Kế Hệ Thống Quy Mô Lớn (System Design)', 'thiet-ke-he-thong-quy-mo-lon-system-design', N'Hướng dẫn giải quyết các bài toán thiết kế hệ thống phân tán phục vụ hàng triệu người dùng đồng thời.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5d/e8/39/29f195392c541d89736c150258046252.jpg',
        234000, 360000, 306000, 33, 37,
        @PublisherId, 2022, 243, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 33, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/5d/e8/39/29f195392c541d89736c150258046252.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'thiet-ke-he-thong-quy-mo-lon-system-design';
END

-- Book 83: DevOps Handbook: Cẩm Nang Vận Hành & Phát Triển
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'devops-handbook-cam-nang-van-hanh-phat-trien')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Gene Kim & Jez Humble';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Gene Kim & Jez Humble', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-182-1574', N'DevOps Handbook: Cẩm Nang Vận Hành & Phát Triển', 'devops-handbook-cam-nang-van-hanh-phat-trien', N'Chiến lược tích hợp văn hóa DevOps, tự động hóa CI/CD nhằm gia tăng tốc độ và độ tin cậy khi triển khai phần mềm.', 'https://salt.tikicdn.com/cache/750x750/ts/product/aa/19/7f/fa555c8c3fbf30773c1dd296728cd856.jpg',
        192000, 295000, 251000, 46, 54,
        @PublisherId, 2023, 266, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 46, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/aa/19/7f/fa555c8c3fbf30773c1dd296728cd856.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'devops-handbook-cam-nang-van-hanh-phat-trien';
END

-- Book 84: Gen: Lịch Sử Và Tương Lai Của Di Truyền Học
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'gen-lich-su-va-tuong-lai-cua-di-truyen-hoc')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Siddhartha Mukherjee';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Siddhartha Mukherjee', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-183-1581', N'Gen: Lịch Sử Và Tương Lai Của Di Truyền Học', 'gen-lich-su-va-tuong-lai-cua-di-truyen-hoc', N'Hành trình khám phá mã di truyền định hình bản chất con người và những trăn trở đạo đức trong kỷ nguyên chỉnh sửa gen.', 'https://salt.tikicdn.com/cache/750x750/ts/product/95/a4/fc/0fcf42fed2367db07215c01634f5ae29.jpg',
        179000, 275000, 234000, 59, 71,
        @PublisherId, 2024, 289, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 59, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/95/a4/fc/0fcf42fed2367db07215c01634f5ae29.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'gen-lich-su-va-tuong-lai-cua-di-truyen-hoc';
END

-- Book 85: Internet Of Things (IoT): Kết Nối Vạn Vật
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'internet-of-things-iot-ket-noi-van-vat')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Samuel Greengard';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Samuel Greengard', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Khoa Học Kỹ Thuật';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-184-1588', N'Internet Of Things (IoT): Kết Nối Vạn Vật', 'internet-of-things-iot-ket-noi-van-vat', N'Toàn cảnh mạng lưới thiết bị thông minh và cách IoT đang biến đổi đô thị, y tế và nền sản xuất toàn cầu.', 'https://salt.tikicdn.com/cache/750x750/ts/product/60/67/aa/c334dbe741914985a4e82949b4006be4.jpg',
        94000, 145000, NULL, 72, 88,
        @PublisherId, 2019, 312, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 72, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/60/67/aa/c334dbe741914985a4e82949b4006be4.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'internet-of-things-iot-ket-noi-van-vat';
END

-- Book 86: An Toàn Thông Tin Và Phòng Chống Tấn Công Mạng
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'an-toan-thong-tin-va-phong-chong-tan-cong-mang')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Kevin D. Mitnick';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Kevin D. Mitnick', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thông Tin & Truyền Thông';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'cong-nghe';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-185-1595', N'An Toàn Thông Tin Và Phòng Chống Tấn Công Mạng', 'an-toan-thong-tin-va-phong-chong-tan-cong-mang', N'Giải mã nghệ thuật tấn công tâm lý xã hội (social engineering) và các biện pháp phòng vệ an ninh mạng vững chắc.', 'https://salt.tikicdn.com/cache/750x750/ts/product/71/ca/ac/33f74888883621db42193e5af7db9128.jpg',
        140000, 215000, 183000, 85, 105,
        @PublisherId, 2020, 335, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 85, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/71/ca/ac/33f74888883621db42193e5af7db9128.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'an-toan-thong-tin-va-phong-chong-tan-cong-mang';
END

-- Book 87: Cha Giàu Cha Nghèo (Rich Dad Poor Dad)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'cha-giau-cha-ngheo-rich-dad-poor-dad')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Robert Kiyosaki';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Robert Kiyosaki', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-186-1602', N'Cha Giàu Cha Nghèo (Rich Dad Poor Dad)', 'cha-giau-cha-ngheo-rich-dad-poor-dad', N'Cuốn sách tài chính cá nhân bán chạy nhất mọi thời đại mở ra tư duy tự do tài chính và đầu tư tài sản sinh lời.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/17/02/d1/52dde080f00d414a2d441c544c76d9c9.jpg',
        81000, 125000, 106000, 98, 122,
        @PublisherId, 2021, 358, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 98, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/17/02/d1/52dde080f00d414a2d441c544c76d9c9.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'cha-giau-cha-ngheo-rich-dad-poor-dad';
END

-- Book 88: Người Giàu Nhất Thành Babylon
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nguoi-giau-nhat-thanh-babylon')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'George S. Clason';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'George S. Clason', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-187-1609', N'Người Giàu Nhất Thành Babylon', 'nguoi-giau-nhat-thanh-babylon', N'Những quy tắc tích lũy của cải và quản lý tiền bạc khôn ngoan từ nền văn minh Babylon cổ đại còn nguyên giá trị.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/23/f8/75/5e90d6e0eabaebd068c815cf1c1f7396.jpg',
        55000, 85000, NULL, 41, 139,
        @PublisherId, 2022, 381, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 41, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/23/f8/75/5e90d6e0eabaebd068c815cf1c1f7396.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nguoi-giau-nhat-thanh-babylon';
END

-- Book 89: Nhà Đầu Tư Thông Minh (The Intelligent Investor)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nha-dau-tu-thong-minh-the-intelligent-investor')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Benjamin Graham';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Benjamin Graham', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-188-1616', N'Nhà Đầu Tư Thông Minh (The Intelligent Investor)', 'nha-dau-tu-thong-minh-the-intelligent-investor', N'Kim chỉ nam đầu tư giá trị kinh điển giúp nhà đầu tư xây dựng biên độ an toàn và tránh cạm bẫy tâm lý thị trường.', 'https://salt.tikicdn.com/cache/750x750/ts/product/34/57/19/b8cb61b658c18cfd5927256a7a65c5c1.jpg',
        182000, 280000, 238000, 54, 156,
        @PublisherId, 2023, 404, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 54, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/34/57/19/b8cb61b658c18cfd5927256a7a65c5c1.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nha-dau-tu-thong-minh-the-intelligent-investor';
END

-- Book 90: Cổ Phiếu Thường, Lợi Nhuận Phi Thường
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'co-phieu-thuong-loi-nhuan-phi-thuong')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Philip A. Fisher';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Philip A. Fisher', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Lao Động';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-189-1623', N'Cổ Phiếu Thường, Lợi Nhuận Phi Thường', 'co-phieu-thuong-loi-nhuan-phi-thuong', N'15 tiêu chí chọn lọc doanh nghiệp tăng trưởng dài hạn vượt trội của một trong những nhà đầu tư vĩ đại nhất phố Wall.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/e2/8d/5e/1d32ea884ecaea45182dae14f5708122.jpg',
        101000, 155000, 132000, 67, 23,
        @PublisherId, 2024, 427, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 67, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/e2/8d/5e/1d32ea884ecaea45182dae14f5708122.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'co-phieu-thuong-loi-nhuan-phi-thuong';
END

-- Book 91: Chiến Lược Đại Dương Xanh
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chien-luoc-dai-duong-xanh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'W. Chan Kim & Renée Mauborgne';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'W. Chan Kim & Renée Mauborgne', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-190-1630', N'Chiến Lược Đại Dương Xanh', 'chien-luoc-dai-duong-xanh', N'Mô hình chiến lược kiến tạo thị trường mới chưa ai khai phá thay vì cạnh tranh khốc liệt trong đại dương đỏ.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/26/50/bc/4c256f7ef7671d65ee3c2117ac10b901.jpg',
        127000, 195000, 166000, 80, 40,
        @PublisherId, 2019, 450, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 80, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/26/50/bc/4c256f7ef7671d65ee3c2117ac10b901.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chien-luoc-dai-duong-xanh';
END

-- Book 92: Khởi Nghiệp Tinh Gọn (The Lean Startup)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'khoi-nghiep-tinh-gon-the-lean-startup')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Eric Ries';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Eric Ries', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-191-1637', N'Khởi Nghiệp Tinh Gọn (The Lean Startup)', 'khoi-nghiep-tinh-gon-the-lean-startup', N'Quy trình thử nghiệm giả thuyết, học hỏi có kiểm chứng và lặp lại liên tục giúp khởi nghiệp tiết kiệm tối đa nguồn lực.', 'https://salt.tikicdn.com/cache/750x750/ts/product/99/df/29/8ef1fb67e07d24037c10a128c9fe647c.jpg',
        114000, 175000, 149000, 93, 57,
        @PublisherId, 2020, 473, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 93, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/99/df/29/8ef1fb67e07d24037c10a128c9fe647c.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'khoi-nghiep-tinh-gon-the-lean-startup';
END

-- Book 93: Từ Tốt Đến Vĩ Đại (Good to Great)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tu-tot-den-vi-dai-good-to-great')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Jim Collins';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Jim Collins', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-192-1644', N'Từ Tốt Đến Vĩ Đại (Good to Great)', 'tu-tot-den-vi-dai-good-to-great', N'Nghiên cứu công phu về các yếu tố giúp những công ty bình thường vươn lên đạt thành tích vượt trội và bền vững.', 'https://salt.tikicdn.com/cache/750x750/ts/product/9f/43/08/e3f28bf84edb7d1524be9db4b41cd71f.jpg',
        124000, 190000, 162000, 36, 74,
        @PublisherId, 2021, 496, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 36, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/9f/43/08/e3f28bf84edb7d1524be9db4b41cd71f.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tu-tot-den-vi-dai-good-to-great';
END

-- Book 94: Xây Dựng Để Trường Tồn (Built to Last)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'xay-dung-de-truong-ton-built-to-last')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Jim Collins & Jerry I. Porras';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Jim Collins & Jerry I. Porras', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-193-1651', N'Xây Dựng Để Trường Tồn (Built to Last)', 'xay-dung-de-truong-ton-built-to-last', N'Các nguyên tắc cốt lõi giúp các tập đoàn hàng đầu thế giới giữ vững bản sắc và phát triển qua nhiều thập kỷ.', 'https://salt.tikicdn.com/cache/750x750/ts/product/34/fa/21/8cf840b92ac0ef892301513b33bc3592.jpg',
        127000, 195000, 166000, 49, 91,
        @PublisherId, 2022, 519, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 49, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/34/fa/21/8cf840b92ac0ef892301513b33bc3592.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'xay-dung-de-truong-ton-built-to-last';
END

-- Book 95: Marketing 5.0: Công Nghệ Dành Cho Nhân Loại
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'marketing-5-0-cong-nghe-danh-cho-nhan-loai')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Philip Kotler';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Philip Kotler', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-194-1658', N'Marketing 5.0: Công Nghệ Dành Cho Nhân Loại', 'marketing-5-0-cong-nghe-danh-cho-nhan-loai', N'Ứng dụng công nghệ Big Data, AI, IoT và thực tế ảo vào chiến lược tiếp thị lấy con người làm trọng tâm.', 'https://salt.tikicdn.com/cache/750x750/ts/product/b8/1c/9e/9f8345f111c13d0ad79915ee371098c5.jpg',
        137000, 210000, 179000, 62, 108,
        @PublisherId, 2023, 542, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 62, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/b8/1c/9e/9f8345f111c13d0ad79915ee371098c5.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'marketing-5-0-cong-nghe-danh-cho-nhan-loai';
END

-- Book 96: Quản Trị Học Hiện Đại
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'quan-tri-hoc-hien-dai')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Peter F. Drucker';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Peter F. Drucker', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-195-1665', N'Quản Trị Học Hiện Đại', 'quan-tri-hoc-hien-dai', N'Tập hợp các nguyên lý quản lý tổ chức, đánh giá hiệu suất và lãnh đạo con người của cha đẻ quản trị học thế giới.', 'https://salt.tikicdn.com/cache/750x750/ts/product/04/6c/25/1e9549f86d3b45f990a807a2f180312a.png',
        156000, 240000, 204000, 75, 125,
        @PublisherId, 2024, 565, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 75, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/04/6c/25/1e9549f86d3b45f990a807a2f180312a.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'quan-tri-hoc-hien-dai';
END

-- Book 97: Không Đến Một (Zero to One)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'khong-den-mot-zero-to-one')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Peter Thiel';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Peter Thiel', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-196-1672', N'Không Đến Một (Zero to One)', 'khong-den-mot-zero-to-one', N'Bí quyết sáng tạo công nghệ đột phá để xây dựng vị thế độc quyền tích cực và thay đổi tương lai thế giới.', 'https://salt.tikicdn.com/cache/750x750/ts/product/04/b1/0f/dff2097fe38ec0d70ba4bed424b42e8d.jpg',
        88000, 135000, NULL, 88, 142,
        @PublisherId, 2019, 588, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 88, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/ts/product/04/b1/0f/dff2097fe38ec0d70ba4bed424b42e8d.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'khong-den-mot-zero-to-one';
END

-- Book 98: Dốc Hết Trái Tim (Pour Your Heart Into It)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'doc-het-trai-tim-pour-your-heart-into-it')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Howard Schultz';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Howard Schultz', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-197-1679', N'Dốc Hết Trái Tim (Pour Your Heart Into It)', 'doc-het-trai-tim-pour-your-heart-into-it', N'Hành trình kỳ diệu xây dựng đế chế cà phê Starbucks từ một cửa hàng nhỏ ở Seattle trở thành thương hiệu toàn cầu.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/ed/90/4a/260bbfef14e60956d36ce3736f84b315.jpg',
        107000, 165000, 140000, 31, 159,
        @PublisherId, 2020, 611, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 31, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/ed/90/4a/260bbfef14e60956d36ce3736f84b315.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'doc-het-trai-tim-pour-your-heart-into-it';
END

-- Book 99: Tỷ Phú Bán Giày (Delivering Happiness)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ty-phu-ban-giay-delivering-happiness')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Tony Hsieh';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Tony Hsieh', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-198-1686', N'Tỷ Phú Bán Giày (Delivering Happiness)', 'ty-phu-ban-giay-delivering-happiness', N'Văn hóa doanh nghiệp độc đáo lấy dịch vụ khách hàng phi thường và hạnh phúc của nhân viên làm cốt lõi của Zappos.', 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/7d/ca/0d/2d4ea05f12d198b45a667c59514af045.jpg',
        94000, 145000, 123000, 44, 26,
        @PublisherId, 2021, 184, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 44, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://salt.tikicdn.com/cache/750x750/media/catalog/product/product/7d/ca/0d/2d4ea05f12d198b45a667c59514af045.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ty-phu-ban-giay-delivering-happiness';
END

-- Book 100: Điều Quan Trọng Nhất (The Most Important Thing)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dieu-quan-trong-nhat-the-most-important-thing')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Howard Marks';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Howard Marks', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Lao Động';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-199-1693', N'Điều Quan Trọng Nhất (The Most Important Thing)', 'dieu-quan-trong-nhat-the-most-important-thing', N'Tư duy cấp hai và sự thông thái trong việc đánh giá rủi ro thị trường từ huyền thoại đầu tư quỹ Oaktree Capital.', 'https://covers.openlibrary.org/b/id/10001222-L.jpg',
        140000, 215000, 183000, 57, 43,
        @PublisherId, 2022, 207, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 57, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/10001222-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dieu-quan-trong-nhat-the-most-important-thing';
END

-- Book 101: Kinh Tế Học Hài Hước (Freakonomics)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'kinh-te-hoc-hai-huoc-freakonomics')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Steven D. Levitt & Stephen J. Dubner';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Steven D. Levitt & Stephen J. Dubner', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-200-1700', N'Kinh Tế Học Hài Hước (Freakonomics)', 'kinh-te-hoc-hai-huoc-freakonomics', N'Khám phá mặt khuất thú vị đằng sau các hiện tượng xã hội qua lăng kính kinh tế học hành vi và số liệu thực tế.', 'https://covers.openlibrary.org/b/id/11172914-L.jpg',
        91000, 140000, 119000, 70, 60,
        @PublisherId, 2023, 230, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 70, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/11172914-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'kinh-te-hoc-hai-huoc-freakonomics';
END

-- Book 102: Chiến Lược Cạnh Tranh (Competitive Strategy)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chien-luoc-canh-tranh-competitive-strategy')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Michael E. Porter';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Michael E. Porter', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-201-1707', N'Chiến Lược Cạnh Tranh (Competitive Strategy)', 'chien-luoc-canh-tranh-competitive-strategy', N'Mô hình 5 lực lượng cạnh tranh kinh điển phân tích cấu trúc ngành và định vị lợi thế chiến lược cho doanh nghiệp.', 'https://covers.openlibrary.org/b/id/19091-L.jpg',
        189000, 290000, 247000, 83, 77,
        @PublisherId, 2024, 253, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 83, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/19091-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chien-luoc-canh-tranh-competitive-strategy';
END

-- Book 103: Kế Hoạch Tài Chính Cá Nhân Vững Vàng
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ke-hoach-tai-chinh-ca-nhan-vung-vang')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Dave Ramsey';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Dave Ramsey', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Lao Động';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'kinh-te';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-202-1714', N'Kế Hoạch Tài Chính Cá Nhân Vững Vàng', 'ke-hoach-tai-chinh-ca-nhan-vung-vang', N'7 bước từng bước giải quyết nợ nần, xây dựng quỹ khẩn cấp và tích lũy gia sản vững chắc cho gia đình.', 'https://covers.openlibrary.org/b/id/6873839-L.jpg',
        98000, 150000, 128000, 96, 94,
        @PublisherId, 2019, 276, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 96, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/6873839-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ke-hoach-tai-chinh-ca-nhan-vung-vang';
END

-- Book 104: Dế Mèn Phiêu Lưu Ký
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'de-men-phieu-luu-ky')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Tô Hoài';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Tô Hoài', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-203-1721', N'Dế Mèn Phiêu Lưu Ký', 'de-men-phieu-luu-ky', N'Tác phẩm văn học thiếu nhi kinh điển của Việt Nam giáo dục lòng nhân ái, tình bạn đẹp và tinh thần trượng nghĩa.', 'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-makwct08qwu909',
        42000, 65000, NULL, 39, 111,
        @PublisherId, 2020, 299, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 39, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://down-vn.img.susercontent.com/file/vn-11134207-7ra0g-makwct08qwu909', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'de-men-phieu-luu-ky';
END

-- Book 105: Hoàng Tử Bé (Le Petit Prince)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'hoang-tu-be-le-petit-prince')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Antoine de Saint-Exupéry';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Antoine de Saint-Exupéry', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-204-1728', N'Hoàng Tử Bé (Le Petit Prince)', 'hoang-tu-be-le-petit-prince', N'Câu chuyện cổ tích triết lý trong sáng về tình yêu thương, sự gắn kết và vẻ đẹp thuần khiết nhìn bằng trái tim.', 'https://covers.openlibrary.org/b/id/10708272-L.jpg',
        51000, 78000, 66000, 52, 128,
        @PublisherId, 2021, 322, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 52, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/10708272-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'hoang-tu-be-le-petit-prince';
END

-- Book 106: Chuyện Con Mèo Dạy Hải Âu Bay
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chuyen-con-meo-day-hai-au-bay')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Luis Sepúlveda';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Luis Sepúlveda', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Hội Nhà Văn';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-205-1735', N'Chuyện Con Mèo Dạy Hải Âu Bay', 'chuyen-con-meo-day-hai-au-bay', N'Bài học cảm động sâu sắc về giữ trọn lời hứa, lòng bao dung và tình thương yêu không phân biệt giống loài.', 'https://covers.openlibrary.org/b/id/277600-L.jpg',
        45000, 69000, 59000, 65, 145,
        @PublisherId, 2022, 345, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 65, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/277600-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chuyen-con-meo-day-hai-au-bay';
END

-- Book 107: Cây Cam Ngọt Của Tôi
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'cay-cam-ngot-cua-toi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'José Mauro de Vasconcelos';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'José Mauro de Vasconcelos', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Hội Nhà Văn';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-206-1742', N'Cây Cam Ngọt Của Tôi', 'cay-cam-ngot-cua-toi', N'Câu chuyện cảm động rơi nước mắt về tuổi thơ đầy mất mát nhưng chan chứa tình người của cậu bé Zezé 5 tuổi.', 'https://covers.openlibrary.org/b/id/10413035-L.jpg',
        62000, 95000, NULL, 78, 12,
        @PublisherId, 2023, 368, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 78, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/10413035-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'cay-cam-ngot-cua-toi';
END

-- Book 108: Truyện Cổ Andersen Toàn Tập
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'truyen-co-andersen-toan-tap')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Hans Christian Andersen';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Hans Christian Andersen', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-207-1749', N'Truyện Cổ Andersen Toàn Tập', 'truyen-co-andersen-toan-tap', N'Tuyển tập những câu chuyện cổ tích bất hủ: Cô bé bán diêm, Nàng tiên cá, Chú vịt con xấu xí nuôi dưỡng tâm hồn trẻ thơ.', 'https://covers.openlibrary.org/b/id/320591-L.jpg',
        120000, 185000, NULL, 91, 29,
        @PublisherId, 2024, 391, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 91, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/320591-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'truyen-co-andersen-toan-tap';
END

-- Book 109: Truyện Cổ Grimm Tuyển Chọn
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'truyen-co-grimm-tuyen-chon')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Anh Em Grimm';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Anh Em Grimm', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-208-1756', N'Truyện Cổ Grimm Tuyển Chọn', 'truyen-co-grimm-tuyen-chon', N'Kho tàng truyện cổ dân gian Đức với Bạch Tuyết, Cô bé quàng khăn đỏ, Lọ Lem đầy màu sắc kỳ ảo và tính giáo dục.', 'https://covers.openlibrary.org/b/id/8236293-L.jpg',
        104000, 160000, 136000, 34, 46,
        @PublisherId, 2019, 414, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 34, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/8236293-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'truyen-co-grimm-tuyen-chon';
END

-- Book 110: Harry Potter Và Hòn Đá Phù Thủy
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'harry-potter-va-hon-da-phu-thuy')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'J.K. Rowling';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'J.K. Rowling', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-209-1763', N'Harry Potter Và Hòn Đá Phù Thủy', 'harry-potter-va-hon-da-phu-thuy', N'Khởi đầu chuyến phiêu lưu huyền diệu vào thế giới phép thuật Hogwarts của cậu bé Harry Potter và những người bạn.', 'https://covers.openlibrary.org/b/id/15155833-L.jpg',
        107000, 165000, 140000, 47, 63,
        @PublisherId, 2020, 437, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 47, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/15155833-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'harry-potter-va-hon-da-phu-thuy';
END

-- Book 111: Bách Khoa Toàn Thư Cho Trẻ Em
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'bach-khoa-toan-thu-cho-tre-em')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'DK Publishing';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'DK Publishing', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-210-1770', N'Bách Khoa Toàn Thư Cho Trẻ Em', 'bach-khoa-toan-thu-cho-tre-em', N'Bách khoa toàn thư minh họa sống động mở rộng chân trời tri thức về tự nhiên, khoa học, lịch sử và không gian.', 'https://covers.openlibrary.org/b/id/552038-L.jpg',
        208000, 320000, NULL, 60, 80,
        @PublisherId, 2021, 460, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 60, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/552038-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'bach-khoa-toan-thu-cho-tre-em';
END

-- Book 112: Đất Rừng Phương Nam
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dat-rung-phuong-nam')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Đoàn Giỏi';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Đoàn Giỏi', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-211-1777', N'Đất Rừng Phương Nam', 'dat-rung-phuong-nam', N'Bức tranh thiên nhiên Nam Bộ trù phú, hoang sơ và hào sảng qua hành trình tìm cha đầy thử thách của cậu bé An.', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1630665274i/12362461.jpg',
        64000, 98000, NULL, 73, 97,
        @PublisherId, 2022, 483, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 73, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1630665274i/12362461.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dat-rung-phuong-nam';
END

-- Book 113: Vừa Nhắm Mắt Vừa Mở Cửa Sổ
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'vua-nham-mat-vua-mo-cua-so')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nguyễn Ngọc Thuần';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nguyễn Ngọc Thuần', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-212-1784', N'Vừa Nhắm Mắt Vừa Mở Cửa Sổ', 'vua-nham-mat-vua-mo-cua-so', N'Thế giới tuổi thơ êm đềm, ngọt ngào giúp trẻ học cách lắng nghe và cảm nhận cuộc sống bằng mọi giác quan.', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1630508593i/10872535.jpg',
        55000, 85000, 72000, 86, 114,
        @PublisherId, 2023, 506, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 86, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1630508593i/10872535.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'vua-nham-mat-vua-mo-cua-so';
END

-- Book 114: Chú Bé Rắc Rối
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chu-be-rac-roi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nguyễn Nhật Ánh';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nguyễn Nhật Ánh', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-213-1791', N'Chú Bé Rắc Rối', 'chu-be-rac-roi', N'Những trò nghịch ngợm ngộ nghĩnh, hài hước và tình bạn trong sáng tuổi học trò tinh nghịch của hai cậu bạn Nghi và An.', 'https://cdn.hstatic.net/products/200000481913/c55fc9d2-59b5-4284-bb78-07e3e5949f47_87b62df155ec4b338fc3b32dcd39643e_master.jpg',
        49000, 75000, 64000, 99, 131,
        @PublisherId, 2024, 529, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 99, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://cdn.hstatic.net/products/200000481913/c55fc9d2-59b5-4284-bb78-07e3e5949f47_87b62df155ec4b338fc3b32dcd39643e_master.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chu-be-rac-roi';
END

-- Book 115: Alice Ở Xứ Sở Thần Tiên
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'alice-o-xu-so-than-tien')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Lewis Carroll';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Lewis Carroll', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-214-1798', N'Alice Ở Xứ Sở Thần Tiên', 'alice-o-xu-so-than-tien', N'Cuộc phiêu lưu kỳ thú của cô bé Alice vào thế giới ngầm đầy những sinh vật kỳ lạ, hài hước và phi lý trí tưởng tượng.', 'https://covers.openlibrary.org/b/id/13805873-L.jpg',
        58000, 89000, 76000, 42, 148,
        @PublisherId, 2019, 552, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 42, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/13805873-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'alice-o-xu-so-than-tien';
END

-- Book 116: Peter Pan: Cậu Bé Không Lớn
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'peter-pan-cau-be-khong-lon')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'J.M. Barrie';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'J.M. Barrie', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-215-1805', N'Peter Pan: Cậu Bé Không Lớn', 'peter-pan-cau-be-khong-lon', N'Chuyến bay thần tiên tới hòn đảo Neverland huyền thoại nơi những giấc mơ tuổi thơ bay bổng không bao giờ tàn phai.', 'https://covers.openlibrary.org/b/id/8237052-L.jpg',
        51000, 79000, 67000, 55, 15,
        @PublisherId, 2020, 575, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 55, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/8237052-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'peter-pan-cau-be-khong-lon';
END

-- Book 117: Những Cuộc Phiêu Lưu Của Pinocchio
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nhung-cuoc-phieu-luu-cua-pinocchio')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Carlo Collodi';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Carlo Collodi', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-216-1812', N'Những Cuộc Phiêu Lưu Của Pinocchio', 'nhung-cuoc-phieu-luu-cua-pinocchio', N'Bài học quý giá về lòng hiếu thảo, tính trung thực và nghị lực để chú bé người gỗ trở thành một con người thật sự.', 'https://covers.openlibrary.org/b/id/8597022-L.jpg',
        49000, 75000, 64000, 68, 32,
        @PublisherId, 2021, 598, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 68, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/8597022-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nhung-cuoc-phieu-luu-cua-pinocchio';
END

-- Book 118: Cậu Bé Rừng Xanh (The Jungle Book)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'cau-be-rung-xanh-the-jungle-book')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Rudyard Kipling';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Rudyard Kipling', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-217-1819', N'Cậu Bé Rừng Xanh (The Jungle Book)', 'cau-be-rung-xanh-the-jungle-book', N'Cuộc sống hoang dã của Mowgli giữa bầy sói rừng già Ấn Độ với những bài học sâu sắc về luật rừng và lòng trung thành.', 'https://covers.openlibrary.org/b/id/3344204-L.jpg',
        53000, 82000, 70000, 81, 49,
        @PublisherId, 2022, 621, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 81, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/3344204-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'cau-be-rung-xanh-the-jungle-book';
END

-- Book 119: Góc Sân Và Khoảng Trời
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'goc-san-va-khoang-troi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Trần Đăng Khoa';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Trần Đăng Khoa', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-218-1826', N'Góc Sân Và Khoảng Trời', 'goc-san-va-khoang-troi', N'Những vần thơ thiếu nhi hồn nhiên, mộc mạc và đẹp như tranh vẽ về quê hương, hạt gạo, vầng trăng của thần đồng thơ ca.', 'https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fdb640b1b43b42768906d964a4bb8150~tplv-o3syd03w52-origin-jpeg.jpeg?',
        44000, 68000, 58000, 94, 66,
        @PublisherId, 2023, 194, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 94, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://p16-oec-va.ibyteimg.com/tos-maliva-i-o3syd03w52-us/fdb640b1b43b42768906d964a4bb8150~tplv-o3syd03w52-origin-jpeg.jpeg?', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'goc-san-va-khoang-troi';
END

-- Book 120: Kính Vạn Hoa - Tập 1
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'kinh-van-hoa-tap-1')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nguyễn Nhật Ánh';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nguyễn Nhật Ánh', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'thieu-nhi';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-219-1833', N'Kính Vạn Hoa - Tập 1', 'kinh-van-hoa-tap-1', N'Bộ ba Quý róm, Tiểu Long và nhỏ Hạnh cùng những câu chuyện trường lớp muôn màu muôn vẻ không bao giờ quên.', 'https://www.netabooks.vn/Data/Sites/1/Product/47488/thumbs/kinh-van-hoa-tap-1-ki-niem-65-nam-nxb-kim-dong-bia-cung.jpg',
        60000, 92000, 78000, 37, 83,
        @PublisherId, 2024, 217, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 37, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://www.netabooks.vn/Data/Sites/1/Product/47488/thumbs/kinh-van-hoa-tap-1-ki-niem-65-nam-nxb-kim-dong-bia-cung.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'kinh-van-hoa-tap-1';
END

-- Book 121: Tôi Tài Giỏi, Bạn Cũng Thế!
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'toi-tai-gioi-ban-cung-the')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Adam Khoo';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Adam Khoo', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Phụ Nữ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-220-1840', N'Tôi Tài Giỏi, Bạn Cũng Thế!', 'toi-tai-gioi-ban-cung-the', N'Phương pháp tăng tốc học tập, rèn luyện trí nhớ và kích hoạt tiềm năng não bộ để đạt điểm cao trong học tập.', 'https://cdn.hstatic.net/products/200000481913/6413ba95-cca4-4b6c-bf71-1acd0934009c_68d084c1fb174017a74e7d83de027a70_0e7b68d6caf348c9a56a80370ea1e377_master.jpg',
        107000, 165000, 140000, 50, 100,
        @PublisherId, 2019, 240, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 50, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://cdn.hstatic.net/products/200000481913/6413ba95-cca4-4b6c-bf71-1acd0934009c_68d084c1fb174017a74e7d83de027a70_0e7b68d6caf348c9a56a80370ea1e377_master.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'toi-tai-gioi-ban-cung-the';
END

-- Book 122: Phương Pháp Học Tập Không Giới Hạn (Limitless)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'phuong-phap-hoc-tap-khong-gioi-han-limitless')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Jim Kwik';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Jim Kwik', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-221-1847', N'Phương Pháp Học Tập Không Giới Hạn (Limitless)', 'phuong-phap-hoc-tap-khong-gioi-han-limitless', N'Kỹ thuật nâng cấp não bộ, học nhanh gấp 3 lần và cải thiện khả năng tập trung cao độ từ chuyên gia trí nhớ hàng đầu.', 'https://covers.openlibrary.org/b/id/9360116-L.jpg',
        142000, 219000, 186000, 63, 117,
        @PublisherId, 2020, 263, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 63, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/9360116-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'phuong-phap-hoc-tap-khong-gioi-han-limitless';
END

-- Book 123: Rèn Luyện Trí Nhớ Vô Địch
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ren-luyen-tri-nho-vo-dich')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Kevin Horsley';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Kevin Horsley', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-222-1854', N'Rèn Luyện Trí Nhớ Vô Địch', 'ren-luyen-tri-nho-vo-dich', N'Các kỹ thuật ghi nhớ đỉnh cao của đại kiện tướng thế giới giúp ghi nhớ số liệu, từ vựng và bài giảng nhanh chóng.', 'https://covers.openlibrary.org/b/id/10102079-L.jpg',
        81000, 125000, 106000, 76, 134,
        @PublisherId, 2021, 286, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 76, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/10102079-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ren-luyen-tri-nho-vo-dich';
END

-- Book 124: Phương Pháp Giáo Dục Montessori
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'phuong-phap-giao-duc-montessori')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Maria Montessori';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Maria Montessori', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Giáo Dục Việt Nam';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-223-1861', N'Phương Pháp Giáo Dục Montessori', 'phuong-phap-giao-duc-montessori', N'Nguyên lý tôn trọng sự phát triển tự nhiên của trẻ, khuyến khích tính tự lập và khả năng tự học sáng tạo.', 'https://covers.openlibrary.org/b/id/8242822-L.jpg',
        114000, 175000, 149000, 89, 151,
        @PublisherId, 2022, 309, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 89, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/8242822-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'phuong-phap-giao-duc-montessori';
END

-- Book 125: English Grammar In Use (Bản Dịch Song Ngữ)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'english-grammar-in-use-ban-dich-song-ngu')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Raymond Murphy';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Raymond Murphy', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Giáo Dục Việt Nam';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-224-1868', N'English Grammar In Use (Bản Dịch Song Ngữ)', 'english-grammar-in-use-ban-dich-song-ngu', N'Giáo trình ngữ pháp tiếng Anh thông dụng và chuẩn mực nhất thế giới dành cho người học từ cơ bản đến trung cấp.', 'https://covers.openlibrary.org/b/id/8454904-L.jpg',
        120000, 185000, 157000, 32, 18,
        @PublisherId, 2023, 332, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 32, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/8454904-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'english-grammar-in-use-ban-dich-song-ngu';
END

-- Book 126: Hack Não 1500 Từ Tiếng Anh
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'hack-nao-1500-tu-tieng-anh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Step Up Education';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Step Up Education', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Dân Trí';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-225-1875', N'Hack Não 1500 Từ Tiếng Anh', 'hack-nao-1500-tu-tieng-anh', N'Phương pháp âm thanh tương tự và truyện chêm giúp nạp nhanh 1500 từ vựng cốt lõi giao tiếp và thi cử.', 'https://product.hstatic.net/200000481913/product/763b029e-f49b-410f-81eb-25d66a6a737f_5ab66857798a4b5d9269af7463ebba6c_master.jpg',
        192000, 295000, 251000, 45, 35,
        @PublisherId, 2024, 355, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 45, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://product.hstatic.net/200000481913/product/763b029e-f49b-410f-81eb-25d66a6a737f_5ab66857798a4b5d9269af7463ebba6c_master.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'hack-nao-1500-tu-tieng-anh';
END

-- Book 127: Chiến Lược Luyện Thi IELTS 8.0
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'chien-luoc-luyen-thi-ielts-8-0')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Cambridge University';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Cambridge University', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Giáo Dục Việt Nam';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-226-1882', N'Chiến Lược Luyện Thi IELTS 8.0', 'chien-luoc-luyen-thi-ielts-8-0', N'Phân tích chi tiết phương pháp làm bài và bẫy đề thi cho cả 4 kỹ năng Nghe - Nói - Đọc - Viết trong kỳ thi IELTS.', 'https://lookaside.fbsbx.com/lookaside/crawler/media/?media_id=483251627335379',
        143000, 220000, 187000, 58, 52,
        @PublisherId, 2019, 378, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 58, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://lookaside.fbsbx.com/lookaside/crawler/media/?media_id=483251627335379', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'chien-luoc-luyen-thi-ielts-8-0';
END

-- Book 128: Tự Học Tiếng Nhật Cho Người Mới Bắt Đầu
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'tu-hoc-tieng-nhat-cho-nguoi-moi-bat-dau')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'The Windy';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'The Windy', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Đại Học Quốc Gia';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-227-1889', N'Tự Học Tiếng Nhật Cho Người Mới Bắt Đầu', 'tu-hoc-tieng-nhat-cho-nguoi-moi-bat-dau', N'Lộ trình làm quen với hai bảng chữ cái Hiragana, Katakana, chữ Hán căn bản và các mẫu câu giao tiếp hằng ngày.', 'https://mcbooks.vn/wp-content/uploads/2019/04/bia-truoc-4.png',
        85000, 130000, 111000, 71, 69,
        @PublisherId, 2020, 401, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 71, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://mcbooks.vn/wp-content/uploads/2019/04/bia-truoc-4.png', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'tu-hoc-tieng-nhat-cho-nguoi-moi-bat-dau';
END

-- Book 129: Giáo Dục Và Ý Nghĩa Cuộc Sống
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'giao-duc-va-y-nghia-cuoc-song')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'J. Krishnamurti';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'J. Krishnamurti', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-228-1896', N'Giáo Dục Và Ý Nghĩa Cuộc Sống', 'giao-duc-va-y-nghia-cuoc-song', N'Triết lý giáo dục khai phóng giải thoát con người khỏi định kiến, sợ hãi để thấu hiểu bản thân và tình yêu cuộc sống.', 'https://product.hstatic.net/200000481913/product/33276427-d006-46b4-8151-c694f9ee9fcb_768ff4819f054475886ce55c641bf309_master.jpg',
        72000, 110000, NULL, 84, 86,
        @PublisherId, 2021, 424, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 84, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://product.hstatic.net/200000481913/product/33276427-d006-46b4-8151-c694f9ee9fcb_768ff4819f054475886ce55c641bf309_master.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'giao-duc-va-y-nghia-cuoc-song';
END

-- Book 130: Nghệ Thuật Đọc Sách (How to Read a Book)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nghe-thuat-doc-sach-how-to-read-a-book')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Mortimer J. Adler';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Mortimer J. Adler', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-229-1903', N'Nghệ Thuật Đọc Sách (How to Read a Book)', 'nghe-thuat-doc-sach-how-to-read-a-book', N'Hướng dẫn 4 cấp độ đọc sách từ sơ cấp đến tổng hợp giúp tiếp thu tri thức một cách chủ động và sâu sắc.', 'https://covers.openlibrary.org/b/id/405381-L.jpg',
        114000, 175000, NULL, 97, 103,
        @PublisherId, 2022, 447, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 97, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/405381-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nghe-thuat-doc-sach-how-to-read-a-book';
END

-- Book 131: Sơ Đồ Tư Duy - Mindmap
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'so-do-tu-duy-mindmap')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Tony Buzan';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Tony Buzan', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-230-1910', N'Sơ Đồ Tư Duy - Mindmap', 'so-do-tu-duy-mindmap', N'Công cụ tư duy hình ảnh mạnh mẽ giúp giải phóng sức sáng tạo, tổ chức ý tưởng và ghi nhớ thông tin logic.', 'https://covers.openlibrary.org/b/id/3876254-L.jpg',
        94000, 145000, NULL, 40, 120,
        @PublisherId, 2023, 470, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 40, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/3876254-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'so-do-tu-duy-mindmap';
END

-- Book 132: Học Cách Học (Learning How to Learn)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'hoc-cach-hoc-learning-how-to-learn')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Barbara Oakley';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Barbara Oakley', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-231-1917', N'Học Cách Học (Learning How to Learn)', 'hoc-cach-hoc-learning-how-to-learn', N'Khoa học thần kinh về cách bộ não tiếp thu kiến thức và chiến thuật vượt qua thói quen trì hoãn học tập.', 'https://covers.openlibrary.org/b/id/9185178-L.jpg',
        101000, 155000, 132000, 53, 137,
        @PublisherId, 2024, 493, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 53, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/9185178-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'hoc-cach-hoc-learning-how-to-learn';
END

-- Book 133: Kỹ Năng Thuyết Trình Hiện Đại (Presentation Zen)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ky-nang-thuyet-trinh-hien-dai-presentation-zen')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Garr Reynolds';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Garr Reynolds', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Trẻ';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-232-1924', N'Kỹ Năng Thuyết Trình Hiện Đại (Presentation Zen)', 'ky-nang-thuyet-trinh-hien-dai-presentation-zen', N'Nghệ thuật thiết kế bài giảng và slide thuyết trình tinh gọn, cuốn hút theo phong cách trực quan tối giản.', 'https://covers.openlibrary.org/b/id/8575604-L.jpg',
        120000, 185000, 157000, 66, 154,
        @PublisherId, 2019, 516, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 66, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/8575604-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ky-nang-thuyet-trinh-hien-dai-presentation-zen';
END

-- Book 134: Giáo Trình Tâm Lý Học Sư Phạm
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'giao-trinh-tam-ly-hoc-su-pham')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nhiều Tác Giả';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nhiều Tác Giả', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Giáo Dục Việt Nam';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-233-1931', N'Giáo Trình Tâm Lý Học Sư Phạm', 'giao-trinh-tam-ly-hoc-su-pham', N'Kiến thức tâm lý học lứa tuổi phục vụ giảng dạy, khích lệ động lực học tập và xử lý tình huống lớp học.', 'https://bizweb.dktcdn.net/100/180/408/files/combo-tam-ly-hoc.jpg?v=1710755620214',
        75000, 115000, 98000, 79, 21,
        @PublisherId, 2020, 539, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 79, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://bizweb.dktcdn.net/100/180/408/files/combo-tam-ly-hoc.jpg?v=1710755620214', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'giao-trinh-tam-ly-hoc-su-pham';
END

-- Book 135: Bí Quyết Ôn Thi Đại Học Thủ Khoa
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'bi-quyet-on-thi-dai-hoc-thu-khoa')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nhiều Tác Giả';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nhiều Tác Giả', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Giáo Dục Việt Nam';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-234-1938', N'Bí Quyết Ôn Thi Đại Học Thủ Khoa', 'bi-quyet-on-thi-dai-hoc-thu-khoa', N'Kinh nghiệm lập thời gian biểu, phương pháp phân tích đề và tâm lý phòng thi của các thủ khoa toàn quốc.', 'https://xemsachhay.com/wp-content/uploads/2018/04/47428_53971.jpg',
        88000, 135000, 115000, 92, 38,
        @PublisherId, 2021, 562, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 92, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://xemsachhay.com/wp-content/uploads/2018/04/47428_53971.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'bi-quyet-on-thi-dai-hoc-thu-khoa';
END

-- Book 136: Khuyến Học (Fukuzawa Yukichi)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'khuyen-hoc-fukuzawa-yukichi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Fukuzawa Yukichi';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Fukuzawa Yukichi', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-235-1945', N'Khuyến Học (Fukuzawa Yukichi)', 'khuyen-hoc-fukuzawa-yukichi', N'Cuốn sách khai sáng tư tưởng canh tân giáo dục và tinh thần độc lập tự cường của thời kỳ Minh Trị Nhật Bản.', 'https://covers.openlibrary.org/b/id/9042679-L.jpg',
        62000, 95000, NULL, 35, 55,
        @PublisherId, 2022, 585, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 35, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/9042679-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'khuyen-hoc-fukuzawa-yukichi';
END

-- Book 137: Nuôi Dưỡng Trí Tò Mò Khoa Học Ở Trẻ
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'nuoi-duong-tri-to-mo-khoa-hoc-o-tre')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Carl Wieman';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Carl Wieman', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Giáo Dục Việt Nam';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'giao-duc';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-236-1952', N'Nuôi Dưỡng Trí Tò Mò Khoa Học Ở Trẻ', 'nuoi-duong-tri-to-mo-khoa-hoc-o-tre', N'Phương pháp tiếp cận STEM kích thích tư duy phản biện và khả năng giải quyết vấn đề sáng tạo cho học sinh.', 'https://photo.znews.vn/w1250/Uploaded/neg_iflemly/2017_04_04/bia_lon_len_cung_thien_nhien.JPG',
        91000, 140000, 119000, 48, 72,
        @PublisherId, 2023, 608, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 48, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://photo.znews.vn/w1250/Uploaded/neg_iflemly/2017_04_04/bia_lon_len_cung_thien_nhien.JPG', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'nuoi-duong-tri-to-mo-khoa-hoc-o-tre';
END

-- Book 138: Đại Việt Sử Ký Toàn Thư (Trọn Bộ)
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'dai-viet-su-ky-toan-thu-tron-bo')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Ngô Sĩ Liên';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Ngô Sĩ Liên', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Khoa Học Xã Hội';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-237-1959', N'Đại Việt Sử Ký Toàn Thư (Trọn Bộ)', 'dai-viet-su-ky-toan-thu-tron-bo', N'Bộ quốc sử đồ sộ ghi chép toàn diện lịch sử nước ta từ thời Hồng Bàng đến thời kỳ Hậu Lê với giá trị khảo cứu vô giá.', 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1447140100i/13561648.jpg',
        247000, 380000, NULL, 61, 89,
        @PublisherId, 2024, 181, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 61, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1447140100i/13561648.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'dai-viet-su-ky-toan-thu-tron-bo';
END

-- Book 139: Việt Nam Sử Lược
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'viet-nam-su-luoc')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Trần Trọng Kim';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Trần Trọng Kim', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-238-1966', N'Việt Nam Sử Lược', 'viet-nam-su-luoc', N'Cuốn sách thông sử Việt Nam đầu tiên viết bằng chữ quốc ngữ với lối hành văn mạch lạc, hấp dẫn và khách quan.', 'https://img.newshop.vn/uploads/products/59733/viet-nam-su-luoc-YWIo.jpg',
        107000, 165000, 140000, 74, 106,
        @PublisherId, 2019, 204, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 74, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://img.newshop.vn/uploads/products/59733/viet-nam-su-luoc-YWIo.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'viet-nam-su-luoc';
END

-- Book 140: Văn Minh Việt Nam
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'van-minh-viet-nam')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nguyễn Văn Huyên';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nguyễn Văn Huyên', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Hội Nhà Văn';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-239-1973', N'Văn Minh Việt Nam', 'van-minh-viet-nam', N'Công trình nghiên cứu kinh điển về cấu trúc xã hội, làng xã, gia đình và tín ngưỡng dân gian truyền thống người Việt.', 'https://product.hstatic.net/200000481913/product/0651bc9b-eb7f-46bb-8685-b22d59586739_5741f93730f1423eaf57dadf7d76fd94_master.jpg',
        120000, 185000, NULL, 87, 123,
        @PublisherId, 2020, 227, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 87, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://product.hstatic.net/200000481913/product/0651bc9b-eb7f-46bb-8685-b22d59586739_5741f93730f1423eaf57dadf7d76fd94_master.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'van-minh-viet-nam';
END

-- Book 141: Lịch Sử Việt Nam Từ Cội Nguồn Đến Thế Kỷ XXI
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'lich-su-viet-nam-tu-coi-nguon-den-the-ky-xxi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Đào Duy Anh';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Đào Duy Anh', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Hóa Thông Tin';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-240-1980', N'Lịch Sử Việt Nam Từ Cội Nguồn Đến Thế Kỷ XXI', 'lich-su-viet-nam-tu-coi-nguon-den-the-ky-xxi', N'Khái quát tiến trình dựng nước và giữ nước oai hùng của dân tộc Việt qua hàng ngàn năm lịch sử hào hùng.', 'https://product.hstatic.net/200000481913/product/cf81b699-fc8b-4254-8ba8-26ec618bee5b_4780f885138a4b6d9b664cd3bd631c3d_master.jpg',
        137000, 210000, 179000, 30, 140,
        @PublisherId, 2021, 250, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 30, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://product.hstatic.net/200000481913/product/cf81b699-fc8b-4254-8ba8-26ec618bee5b_4780f885138a4b6d9b664cd3bd631c3d_master.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'lich-su-viet-nam-tu-coi-nguon-den-the-ky-xxi';
END

-- Book 142: Lược Sử Nước Việt Bằng Tranh
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'luoc-su-nuoc-viet-bang-tranh')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Hiếu Minh & Huyền Trang';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Hiếu Minh & Huyền Trang', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Kim Đồng';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-241-1987', N'Lược Sử Nước Việt Bằng Tranh', 'luoc-su-nuoc-viet-bang-tranh', N'Biên niên sử nước Việt được minh họa bằng những nét vẽ sống động, gần gũi và hào hùng cho mọi thế hệ bạn đọc.', 'https://cantholib.org.vn/uploads/news/2025/luoc-su-nuoc-viet-bang-tranh_500_407.jpg',
        81000, 125000, 106000, 43, 157,
        @PublisherId, 2022, 273, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 43, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://cantholib.org.vn/uploads/news/2025/luoc-su-nuoc-viet-bang-tranh_500_407.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'luoc-su-nuoc-viet-bang-tranh';
END

-- Book 143: Sử Ký Tư Mã Thiên
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'su-ky-tu-ma-thien')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Tư Mã Thiên';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Tư Mã Thiên', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-242-1994', N'Sử Ký Tư Mã Thiên', 'su-ky-tu-ma-thien', N'Kiệt tác sử học và văn học vĩ đại ghi chép lịch sử Trung Hoa cổ đại với bút pháp sắc sảo và tầm nhìn triết học sâu xa.', 'https://down-vn.img.susercontent.com/file/12272be652a8c91b52775c415731ec8d',
        192000, 295000, 251000, 56, 24,
        @PublisherId, 2023, 296, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 56, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://down-vn.img.susercontent.com/file/12272be652a8c91b52775c415731ec8d', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'su-ky-tu-ma-thien';
END

-- Book 144: Con Đường Tơ Lụa: Lịch Sử Mới Của Thế Giới
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'con-duong-to-lua-lich-su-moi-cua-the-gioi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Peter Frankopan';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Peter Frankopan', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-243-2001', N'Con Đường Tơ Lụa: Lịch Sử Mới Của Thế Giới', 'con-duong-to-lua-lich-su-moi-cua-the-gioi', N'Tái hiện trục xoay chuyển quyền lực thế giới qua mạng lưới thương mại cổ xưa kết nối các nền văn minh Á - Âu.', 'https://covers.openlibrary.org/b/id/8963642-L.jpg',
        208000, 320000, 272000, 69, 41,
        @PublisherId, 2024, 319, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 69, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/8963642-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'con-duong-to-lua-lich-su-moi-cua-the-gioi';
END

-- Book 145: Sụp Đổ: Các Xã Hội Đã Thất Bại Hay Thành Công Như Thế Nào
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'sup-do-cac-xa-hoi-da-that-bai-hay-thanh-cong-nhu-the-nao')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Jared Diamond';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Jared Diamond', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-244-2008', N'Sụp Đổ: Các Xã Hội Đã Thất Bại Hay Thành Công Như Thế Nào', 'sup-do-cac-xa-hoi-da-that-bai-hay-thanh-cong-nhu-the-nao', N'Khảo cứu những nguyên nhân dẫn đến sự suy tàn của các nền văn minh cổ đại: môi trường, dân số và xung đột.', 'https://covers.openlibrary.org/b/id/12915198-L.jpg',
        172000, 265000, 225000, 82, 58,
        @PublisherId, 2019, 342, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 82, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/12915198-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'sup-do-cac-xa-hoi-da-that-bai-hay-thanh-cong-nhu-the-nao';
END

-- Book 146: Súng, Vi Trùng Và Thép
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'sung-vi-trung-va-thep')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Jared Diamond';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Jared Diamond', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-245-2015', N'Súng, Vi Trùng Và Thép', 'sung-vi-trung-va-thep', N'Lý giải nguồn gốc sự bất bình đẳng về tốc độ phát triển giữa các xã hội loài người qua yếu tố địa lý và sinh thái.', 'https://covers.openlibrary.org/b/id/7884018-L.jpg',
        159000, 245000, NULL, 95, 75,
        @PublisherId, 2020, 365, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 95, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/7884018-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'sung-vi-trung-va-thep';
END

-- Book 147: Bức Tường Berlin: Lịch Sử Và Di Sản
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'buc-tuong-berlin-lich-su-va-di-san')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Frederick Taylor';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Frederick Taylor', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-246-2022', N'Bức Tường Berlin: Lịch Sử Và Di Sản', 'buc-tuong-berlin-lich-su-va-di-san', N'Bức tranh sống động về biểu tượng chia cắt thời Chiến tranh Lạnh và khát vọng tự do cháy bỏng của nhân loại.', 'https://covers.openlibrary.org/b/id/36063-L.jpg',
        127000, 195000, 166000, 38, 92,
        @PublisherId, 2021, 388, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 38, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/36063-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'buc-tuong-berlin-lich-su-va-di-san';
END

-- Book 148: Sự Suy Tàn Và Sụp Đổ Của Đế Chế La Mã
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'su-suy-tan-va-sup-do-cua-de-che-la-ma')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Edward Gibbon';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Edward Gibbon', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Thế Giới';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-247-2029', N'Sự Suy Tàn Và Sụp Đổ Của Đế Chế La Mã', 'su-suy-tan-va-sup-do-cua-de-che-la-ma', N'Kiệt tác sử học phương Tây mổ xẻ các nguyên nhân nội tại và ngoại bang dẫn đến hồi kết của đế chế La Mã huy hoàng.', 'https://covers.openlibrary.org/b/id/5978577-L.jpg',
        228000, 350000, 298000, 51, 109,
        @PublisherId, 2022, 411, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 51, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/5978577-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'su-suy-tan-va-sup-do-cua-de-che-la-ma';
END

-- Book 149: Khảo Cứu Phong Tục Bắc Kỳ
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'khao-cuu-phong-tuc-bac-ky')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Phan Kế Bính';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Phan Kế Bính', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-248-2036', N'Khảo Cứu Phong Tục Bắc Kỳ', 'khao-cuu-phong-tuc-bac-ky', N'Ghi chép tường tận về phong tục hôn nhân, tang ma, lễ tết và nếp sinh hoạt truyền thống của người dân xứ Bắc xưa.', 'https://www.sachbaokhang.vn/uploads/files/2024/05/18/443732196_1588075925345375_636333350961053957_n.jpg',
        75000, 115000, 98000, 64, 126,
        @PublisherId, 2023, 434, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 64, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://www.sachbaokhang.vn/uploads/files/2024/05/18/443732196_1588075925345375_636333350961053957_n.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'khao-cuu-phong-tuc-bac-ky';
END

-- Book 150: Hà Nội Ba Mươi Sáu Phố Phường
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ha-noi-ba-muoi-sau-pho-phuong')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Thạch Lam';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Thạch Lam', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Văn Học';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-249-2043', N'Hà Nội Ba Mươi Sáu Phố Phường', 'ha-noi-ba-muoi-sau-pho-phuong', N'Tập tùy bút đượm chất thơ về vẻ đẹp cổ kính, ẩm thực thanh lịch và linh hồn văn hóa nghìn năm của đất kinh kỳ.', 'https://c3chuvanan.edu.vn/wp-content/uploads/2024/10/bai_tap_sach_ha_noi_bam_sau_pho_phuong_20230915154442.jpg',
        42000, 65000, 55000, 77, 143,
        @PublisherId, 2024, 457, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 77, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://c3chuvanan.edu.vn/wp-content/uploads/2024/10/bai_tap_sach_ha_noi_bam_sau_pho_phuong_20230915154442.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ha-noi-ba-muoi-sau-pho-phuong';
END

-- Book 151: Văn Hóa Ẩm Thực Việt Nam
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'van-hoa-am-thuc-viet-nam')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Nguyễn Nhã';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Nguyễn Nhã', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-250-2050', N'Văn Hóa Ẩm Thực Việt Nam', 'van-hoa-am-thuc-viet-nam', N'Hành trình khám phá triết lý âm dương, ngũ hành và bản sắc độc đáo trong các món ăn truyền thống ba miền Việt Nam.', 'https://giangvien.net/uploads/news/2024_06/XH30(1).webp',
        114000, 175000, 149000, 90, 10,
        @PublisherId, 2019, 480, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 90, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://giangvien.net/uploads/news/2024_06/XH30(1).webp', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'van-hoa-am-thuc-viet-nam';
END

-- Book 152: Lịch Sử Văn Minh Phương Tây
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'lich-su-van-minh-phuong-tay')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Will Durant';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Will Durant', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tri Thức';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-251-2057', N'Lịch Sử Văn Minh Phương Tây', 'lich-su-van-minh-phuong-tay', N'Công trình đồ sộ phác họa những bước tiến tư tưởng, nghệ thuật và khoa học của nền văn minh phương Tây từ cổ đại.', 'https://covers.openlibrary.org/b/id/463315-L.jpg',
        221000, 340000, 289000, 33, 27,
        @PublisherId, 2020, 503, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 33, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/463315-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'lich-su-van-minh-phuong-tay';
END

-- Book 153: Hồ Chí Minh: Một Cuộc Đời
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'ho-chi-minh-mot-cuoc-doi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'William J. Duiker';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'William J. Duiker', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Chính Trị Quốc Gia Sự Thật';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-252-2064', N'Hồ Chí Minh: Một Cuộc Đời', 'ho-chi-minh-mot-cuoc-doi', N'Công trình tiểu sử công phu được giới học thuật quốc tế đánh giá cao về cuộc đời và sự nghiệp của Chủ tịch Hồ Chí Minh.', 'https://covers.openlibrary.org/b/id/546322-L.jpg',
        189000, 290000, 247000, 46, 44,
        @PublisherId, 2021, 526, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 46, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://covers.openlibrary.org/b/id/546322-L.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'ho-chi-minh-mot-cuoc-doi';
END

-- Book 154: Gia Định Thành Thông Chí
IF NOT EXISTS (SELECT 1 FROM [Books] WHERE [Slug] = 'gia-dinh-thanh-thong-chi')
BEGIN
    -- Ensure Author
    SET @AuthorId = NULL;
    SELECT @AuthorId = [Id] FROM [Authors] WHERE [Name] = N'Trịnh Hoài Đức';
    IF @AuthorId IS NULL
    BEGIN
        SET @AuthorId = NEWID();
        INSERT INTO [Authors] ([Id], [Name], [Biography], [Nationality], [IsActive])
        VALUES (@AuthorId, N'Trịnh Hoài Đức', N'Tác giả nổi tiếng trong lĩnh vực chuyên môn.', N'Việt Nam', 1);
    END

    -- Ensure Publisher
    SET @PublisherId = NULL;
    SELECT @PublisherId = [Id] FROM [Publishers] WHERE [Name] = N'NXB Tổng Hợp TP.HCM';
    IF @PublisherId IS NULL
    BEGIN
        SELECT TOP 1 @PublisherId = [Id] FROM [Publishers];
    END

    -- Category
    SET @CategoryId = NULL;
    SELECT @CategoryId = [Id] FROM [Categories] WHERE [Slug] = 'lich-su---van-hoa';

    SET @BookId = NEWID();
    INSERT INTO [Books] (
        [Id], [ISBN], [Title], [Slug], [Description], [CoverImageUrl],
        [ImportPrice], [SalePrice], [DiscountPrice], [StockQuantity], [SoldQuantity],
        [PublisherId], [PublishedYear], [PageCount], [Language], [Dimensions], [Weight],
        [Status], [IsDeleted], [CreatedAt], [UpdatedAt]
    ) VALUES (
        @BookId, '978-604-253-2071', N'Gia Định Thành Thông Chí', 'gia-dinh-thanh-thong-chi', N'Pho tư liệu lịch sử và địa chí quý báu nhất về quá trình khai hoang, định cư và phát triển vùng đất phương Nam.', 'https://nguoikesu.com/images/book/1a67a4ad5e2f0b2f9ddec4f11987763a.jpg',
        140000, 215000, NULL, 59, 61,
        @PublisherId, 2022, 549, N'Tiếng Việt', N'14 x 20.5 cm', 0.45,
        1, 0, SYSUTCDATETIME(), SYSUTCDATETIME()
    );

    IF @CategoryId IS NOT NULL
        INSERT INTO [BookCategories] ([BookId], [CategoryId]) VALUES (@BookId, @CategoryId);

    IF @AuthorId IS NOT NULL
        INSERT INTO [BookAuthors] ([BookId], [AuthorId]) VALUES (@BookId, @AuthorId);

    INSERT INTO [Inventories] ([Id], [BookId], [Quantity], [ReservedQuantity], [UpdatedAt])
    VALUES (NEWID(), @BookId, 59, 0, SYSUTCDATETIME());
END
ELSE
BEGIN
    UPDATE [Books]
    SET [CoverImageUrl] = 'https://nguoikesu.com/images/book/1a67a4ad5e2f0b2f9ddec4f11987763a.jpg', [UpdatedAt] = SYSUTCDATETIME()
    WHERE [Slug] = 'gia-dinh-thanh-thong-chi';
END

COMMIT TRANSACTION;
PRINT 'Successfully seeded all books into BookStoreDb!';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
    RAISERROR(@ErrMsg, 16, 1);
END CATCH;
