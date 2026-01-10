namespace Notifications.Domain.Entities;

public class Notification
{
    public Guid Id { get; private set; }
    public Guid TenantId { get; private set; }
    public string Recipient { get; private set; }
    public NotificationChannel Channel { get; private set; }
    public string Subject { get; private set; }
    public string Body { get; private set; }
    public NotificationStatus Status { get; private set; }
    public DateTime CreatedAt { get; private set; }
    public DateTime? SentAt { get; private set; }
    public string? ErrorMessage { get; private set; }
    public int RetryCount { get; private set; }

    private Notification() { } // EF Core

    public static Notification Create(
        Guid tenantId,
        string recipient,
        NotificationChannel channel,
        string subject,
        string body)
    {
        return new Notification
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            Recipient = recipient,
            Channel = channel,
            Subject = subject,
            Body = body,
            Status = NotificationStatus.Pending,
            CreatedAt = DateTime.UtcNow,
            RetryCount = 0
        };
    }

    public void MarkAsSent()
    {
        Status = NotificationStatus.Sent;
        SentAt = DateTime.UtcNow;
    }

    public void MarkAsFailed(string error)
    {
        Status = NotificationStatus.Failed;
        ErrorMessage = error;
        RetryCount++;
    }

    public void Retry()
    {
        Status = NotificationStatus.Pending;
        ErrorMessage = null;
    }
}

public enum NotificationChannel
{
    Email,
    SMS,
    WhatsApp,
    Push
}

public enum NotificationStatus
{
    Pending,
    Sent,
    Failed
}
