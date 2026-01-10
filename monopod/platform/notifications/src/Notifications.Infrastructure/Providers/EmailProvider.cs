using System.Net;
using System.Net.Mail;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Notifications.Application.Services;
using Notifications.Domain.Entities;

namespace Notifications.Infrastructure.Providers;

public class EmailProvider : INotificationProvider
{
    private readonly IConfiguration _configuration;
    private readonly ILogger<EmailProvider> _logger;

    public NotificationChannel Channel => NotificationChannel.Email;

    public EmailProvider(IConfiguration configuration, ILogger<EmailProvider> logger)
    {
        _configuration = configuration;
        _logger = logger;
    }

    public async Task<bool> SendAsync(Notification notification)
    {
        try
        {
            var smtpHost = _configuration["SMTP:Host"] ?? "smtp.sendgrid.net";
            var smtpPort = int.Parse(_configuration["SMTP:Port"] ?? "587");
            var smtpUser = _configuration["SMTP:User"] ?? "";
            var smtpPassword = _configuration["SMTP:Password"] ?? "";
            var fromEmail = _configuration["SMTP:FromEmail"] ?? "noreply@monopod.io";

            using var client = new SmtpClient(smtpHost, smtpPort)
            {
                Credentials = new NetworkCredential(smtpUser, smtpPassword),
                EnableSsl = true
            };

            var message = new MailMessage(fromEmail, notification.Recipient)
            {
                Subject = notification.Subject,
                Body = notification.Body,
                IsBodyHtml = true
            };

            await client.SendMailAsync(message);
            
            _logger.LogInformation("Email sent successfully to {Recipient}", notification.Recipient);
            return true;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Failed to send email to {Recipient}", notification.Recipient);
            return false;
        }
    }
}
