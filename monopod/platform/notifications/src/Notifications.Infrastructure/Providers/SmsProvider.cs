using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Notifications.Application.Services;
using Notifications.Domain.Entities;

namespace Notifications.Infrastructure.Providers;

public class SmsProvider : INotificationProvider
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<SmsProvider> _logger;

    public NotificationChannel Channel => NotificationChannel.SMS;

    public SmsProvider(IConfiguration configuration, ILogger<SmsProvider> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<bool> SendAsync(Notification notification)
    {
        try
        {
            var accountSid = _configuration["TWILIO:AccountSid"];
            var authToken = _configuration["TWILIO:AuthToken"];
            var fromNumber = _configuration["TWILIO:FromNumber"];

            if (string.IsNullOrEmpty(accountSid) || string.IsNullOrEmpty(authToken))
            {
                _logger.LogWarning("Twilio not configured, skipping SMS send");
                return false;
            }

            // Twilio SDK would be used here in production
            // For now, just log the action
            _logger.LogInformation(
                "SMS would be sent to {Recipient}: {Body}", 
                notification.Recipient, 
                notification.Body);

            await Task.Delay(100); // Simulate API call
            
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send SMS to {Recipient}", notification.Recipient);
            return false;
        }
    }
}
