using System.Text;
using BookStore.Infrastructure.Data;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// 1. Database Context
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
    ?? throw new InvalidOperationException("Connection string 'DefaultConnection' not found.");

builder.Services.AddDbContext<BookStoreDbContext>(options =>
    options.UseSqlServer(connectionString));

// 2. Add Services
builder.Services.AddScoped<BookStore.Application.Interfaces.IJwtTokenGenerator, BookStore.Application.Services.JwtTokenGenerator>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IAuthService, BookStore.Infrastructure.Services.AuthService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IBookService, BookStore.Infrastructure.Services.BookService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.ICategoryService, BookStore.Infrastructure.Services.CategoryService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IAuthorService, BookStore.Infrastructure.Services.AuthorService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IPublisherService, BookStore.Infrastructure.Services.PublisherService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.ICartService, BookStore.Infrastructure.Services.CartService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IOrderService, BookStore.Infrastructure.Services.OrderService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IReviewService, BookStore.Infrastructure.Services.ReviewService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IWishlistService, BookStore.Infrastructure.Services.WishlistService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.ICouponService, BookStore.Infrastructure.Services.CouponService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IReportService, BookStore.Infrastructure.Services.ReportService>();
builder.Services.AddScoped<BookStore.Application.Interfaces.IPaymentService, BookStore.Infrastructure.Services.PaymentService>();

// 3. Add Controllers
builder.Services.AddControllers();

// 3. CORS Policy
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

// 4. JWT Authentication
var jwtSecret = builder.Configuration["JwtSettings:Secret"] ?? "BookStore_Default_Secret_Key_For_Development_Only_123456";
var jwtIssuer = builder.Configuration["JwtSettings:Issuer"] ?? "BookStoreApi";
var jwtAudience = builder.Configuration["JwtSettings:Audience"] ?? "BookStoreClient";

builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.RequireHttpsMetadata = false;
    options.SaveToken = true;
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSecret)),
        ValidateIssuer = true,
        ValidIssuer = jwtIssuer,
        ValidateAudience = true,
        ValidAudience = jwtAudience,
        ValidateLifetime = true,
        ClockSkew = TimeSpan.Zero
    };
});

builder.Services.AddAuthorization();

// 5. OpenAPI / Swagger with JWT Support
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "BookStore API",
        Version = "v1",
        Description = "API cho hệ thống website thương mại điện tử BookStore"
    });

    c.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "Nhập JWT token theo format: Bearer {token}",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

var app = builder.Build();

// 6. Database Migration & Seed on Startup
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var logger = services.GetRequiredService<ILogger<Program>>();
    try
    {
        var db = services.GetRequiredService<BookStoreDbContext>();
        logger.LogInformation("Applying migrations to database...");
        await db.Database.MigrateAsync();
        logger.LogInformation("Seeding default data...");
        await DbInitializer.SeedAsync(db);
        logger.LogInformation("Database initialization completed successfully.");
    }
    catch (Exception ex)
    {
        logger.LogError(ex, "An error occurred while migrating or seeding the database.");
    }
}

// 7. HTTP Request Pipeline
app.UseMiddleware<BookStore.Api.Middlewares.ExceptionMiddleware>();

app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "BookStore API v1");
    c.RoutePrefix = "swagger";
});

app.UseHttpsRedirection();

app.UseCors("AllowAll");

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();
