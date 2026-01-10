using Microsoft.Extensions.Logging;
using Notifications.Application.Services;
using Notifications.Domain.Entities;

namespace Notifications.Infrastructure.Providers;

public class WhatsAppProvider : INotificationProvider
{
    private readonly ILogger<WhatsAppProvider> _logger;

    public NotificationChannel Channel => NotificationChannel.WhatsApp;

    public WhatsAppProvider(ILogger<WhatsAppProvider> logger)
    {
        _logger = logger;
    }

    public async Task<bool> SendAsync(Notification notification)
    {
        try
        {
            // WhatsApp Business API would be used here
            _logger.LogInformation(
                "WhatsApp message would be sent to {Recipient}: {Body}", 
                notification.Recipient, 
                notification.Body);

            await Task.Delay(100); // Simulate API call
            
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send WhatsApp message to {Recipient}", notification.Recipient);
            return false;
        }
    }
}
