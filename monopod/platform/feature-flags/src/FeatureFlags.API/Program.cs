using FeatureFlags.Application.Services;

var builder = WebApplication.CreateBuilder(args);

var redisUrl = Environment.GetEnvironmentVariable("REDIS_URL") ?? "redis://localhost:6379";

builder.Services.AddStackExchangeRedisCache(options =>
{
    options.Configuration = redisUrl.Replace("redis://", "");
});

builder.Services.AddScoped<FlagManager>();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHealthChecks()
    .AddRedis(redisUrl.Replace("redis://", ""));

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapControllers();
app.MapHealthChecks("/health");
app.MapGet("/", () => new { service = "MonoPod Feature Flags Service", version = "1.0.0" });

app.Run();
