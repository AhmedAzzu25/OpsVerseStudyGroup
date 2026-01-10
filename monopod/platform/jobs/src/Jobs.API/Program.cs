using Hangfire;
using Hangfire.PostgreSql;

var builder = WebApplication.CreateBuilder(args);

var connectionString = Environment.GetEnvironmentVariable("DATABASE_URL") 
    ?? "Host=localhost;Database=jobs;Username=postgres;Password=password";

// Hangfire
builder.Services.AddHangfire(config => config
    .SetDataCompatibilityLevel(CompatibilityLevel.Version_180)
    .UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UsePostgreSqlStorage(c => c.UseNpgsqlConnection(connectionString)));

builder.Services.AddHangfireServer();

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHealthChecks().AddNpgSql(connectionString);

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Hangfire Dashboard
app.UseHangfireDashboard("/hangfire", new DashboardOptions
{
    Authorization = new[] { new AllowAllAuthorizationFilter() }
});

app.MapControllers();
app.MapHealthChecks("/health");
app.MapGet("/", () => new { service = "MonoPod Jobs Service", version = "1.0.0", dashboard = "/hangfire" });

// Schedule recurring jobs
RecurringJob.AddOrUpdate("process-outbox-events", 
    () => Console.WriteLine("Processing outbox events..."), 
    Cron.Minutely());

app.Run();

public class AllowAllAuthorizationFilter : Hangfire.Dashboard.IDashboardAuthorizationFilter
{
    public bool Authorize(Hangfire.Dashboard.DashboardContext context) => true;
}
