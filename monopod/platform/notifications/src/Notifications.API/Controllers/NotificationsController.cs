using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Notifications.Application.Services;
using Notifications.Domain.Entities;
using Notifications.Infrastructure.Data;

namespace Notifications.API.Controllers;

[ApiController]
[Route("api/notifications/v1")]
public class NotificationsController : ControllerBase
{
    private readonly NotificationsDbContext _context;
    private readonly IEnumerable<INotificationProvider> _providers;
    private readonly ILogger<NotificationsController> _logger;

    public NotificationsController(
        NotificationsDbContext context,
        IEnumerable<INotificationProvider> providers,
        ILogger<NotificationsController> logger)
    {
        _context = context;
        _providers = providers;
        _logger = logger;
    }

    [HttpPost("send")]
    public async Task<IActionResult> Send([FromBody] SendNotificationRequest request)
    {
        // Get tenant from claims (simplified for now)
        var tenantId = Guid.Parse(User.FindFirst("tenant_id")?.Value ?? Guid.Empty.ToString());

        var notification = Notification.Create(
            tenantId == Guid.Empty ? Guid.NewGuid() : tenantId,
            request.Recipient,
            request.Channel,
            request.Subject,
            request.Body
        );

        _context.Notifications.Add(notification);
        await _context.SaveChangesAsync();

        // Send asynchronously
        _ = Task.Run(async () =>
        {
            var provider = _providers.FirstOrDefault(p => p.Channel == request.Channel);
            if (provider != null)
            {
                var success = await provider.SendAsync(notification);
                if (success)
                {
                    notification.MarkAsSent();
                }
                else
                {
                    notification.MarkAsFailed("Provider failed to send");
                }
                await _context.SaveChangesAsync();
            }
        });

        return Accepted(new { notificationId = notification.Id, status = "queued" });
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetStatus(Guid id)
    {
        var notification = await _context.Notifications.FindAsync(id);
        if (notification == null)
        {
            return NotFound();
        }

        return Ok(new
        {
            notification.Id,
            notification.Channel,
            notification.Status,
            notification.CreatedAt,
            notification.SentAt,
            notification.ErrorMessage
        });
    }

    [HttpGet]
    public async Task<IActionResult> List([FromQuery] int page = 1, [FromQuery] int pageSize = 20)
    {
        var notifications = await _context.Notifications
            .OrderByDescending(n => n.CreatedAt)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .Select(n => new
            {
                n.Id,
                n.Recipient,
                n.Channel,
                n.Subject,
                n.Status,
                n.CreatedAt,
                n.SentAt
            })
            .ToListAsync();

        return Ok(notifications);
    }
}

public record SendNotificationRequest(
    string Recipient,
    NotificationChannel Channel,
    string Subject,
    string Body);
