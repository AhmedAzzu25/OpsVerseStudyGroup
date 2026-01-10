using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using Notifications.Application.Services;
using Notifications.Infrastructure.Data;
using Notifications.Infrastructure.Providers;

var builder = WebApplication.CreateBuilder(args);

// Database
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection") 
    ?? Environment.GetEnvironmentVariable("DATABASE_URL")
    ?? "Host=localhost;Database=notifications;Username=postgres;Password=password";

builder.Services.AddDbContext<NotificationsDbContext>(options =>
    options.UseNpgsql(connectionString));

// Notification Providers
builder.Services.AddScoped<INotificationProvider, EmailProvider>();
builder.Services.AddScoped<INotificationProvider, SmsProvider>();
builder.Services.AddScoped<INotificationProvider, WhatsAppProvider>();

// Controllers
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "MonoPod Notifications API",
        Version = "v1",
        Description = "Multi-channel notification service (Email, SMS, WhatsApp)"
    });
});

// Health checks
builder.Services.AddHealthChecks()
    .AddNpgSql(connectionString);

// CORS
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});

var app = builder.Build();

// Auto-migrate database
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<NotificationsDbContext>();
    await db.Database.MigrateAsync();
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseCors();
app.MapControllers();
app.MapHealthChecks("/health");

app.MapGet("/", () => new
{
    service = "MonoPod Notifications Service",
    version = "1.0.0",
    channels = new[] { "Email", "SMS", "WhatsApp" }
});

app.Run();
