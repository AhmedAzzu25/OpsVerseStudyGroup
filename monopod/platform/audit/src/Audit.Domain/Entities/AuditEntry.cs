namespace Audit.Domain.Entities;

public class AuditEntry
{
    public Guid Id { get; private set; }
    public Guid TenantId { get; private set; }
    public string EntityName { get; private set; }
    public string EntityId { get; private set; }
    public string Action { get; private set; } // Created, Updated, Deleted
    public Guid PerformedBy { get; private set; }
    public DateTime PerformedAt { get; private set; }
    public string? OldValues { get; private set; }
    public string? NewValues { get; private set; }
    public string? IpAddress { get; private set; }
    public string? UserAgent { get; private set; }

    private AuditEntry() { }

    public static AuditEntry Create(
        Guid tenantId,
        string entityName,
        string entityId,
        string action,
        Guid performedBy,
        string? oldValues = null,
        string? newValues = null,
        string? ipAddress = null,
        string? userAgent = null)
    {
        return new AuditEntry
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            EntityName = entityName,
            EntityId = entityId,
            Action = action,
            PerformedBy = performedBy,
            PerformedAt = DateTime.UtcNow,
            OldValues = oldValues,
            NewValues = newValues,
            IpAddress = ipAddress,
            UserAgent = userAgent
        };
    }
}
