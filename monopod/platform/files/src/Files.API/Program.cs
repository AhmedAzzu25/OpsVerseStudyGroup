using Files.Application.Services;
using Files.Infrastructure.Data;
using Files.Infrastructure.Storage;
using Microsoft.EntityFrameworkCore;
using Minio;

var builder = WebApplication.CreateBuilder(args);

var connectionString = Environment.GetEnvironmentVariable("DATABASE_URL") 
    ?? "Host=localhost;Database=files;Username=postgres;Password=password";

builder.Services.AddDbContext<FilesDbContext>(options =>
    options.UseNpgsql(connectionString));

// MinIO Client
var minioEndpoint = Environment.GetEnvironmentVariable("STORAGE__Endpoint") ?? "localhost:9000";
var minioAccessKey = Environment.GetEnvironmentVariable("STORAGE__AccessKey") ?? "minioadmin";
var minioSecretKey = Environment.GetEnvironmentVariable("STORAGE__SecretKey") ?? "minioadmin";

builder.Services.AddMinio(client => client
    .WithEndpoint(minioEndpoint)
    .WithCredentials(minioAccessKey, minioSecretKey)
    .WithSSL(false)
    .Build());

builder.Services.AddScoped<IStorageProvider, MinIOStorageProvider>();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHealthChecks().AddNpgSql(connectionString);

var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    await scope.ServiceProvider.GetRequiredService<FilesDbContext>().Database.MigrateAsync();
}

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapControllers();
app.MapHealthChecks("/health");
app.MapGet("/", () => new { service = "MonoPod Files Service", version = "1.0.0" });

app.Run();
