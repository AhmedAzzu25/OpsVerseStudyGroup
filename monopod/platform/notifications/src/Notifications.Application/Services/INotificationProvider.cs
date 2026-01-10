using Notifications.Domain.Entities;

namespace Notifications.Application.Services;

public interface INotificationProvider
{
    NotificationChannel Channel { get; }
    Task<bool> SendAsync(Notification notification);
}
