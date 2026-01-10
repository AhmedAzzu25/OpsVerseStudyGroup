namespace Identity.Domain.Entities;

public class Tenant
{
    public Guid Id { get; private set; }
    public string Name { get; private set; }
    public string Slug { get; private set; }
    public bool IsActive { get; private set; }
    public DateTime CreatedAt { get; private set; }
    public string? ContactEmail { get; private set; }
    
    private Tenant() { } // EF Core

    public static Tenant Create(string name, string slug, string? contactEmail = null)
    {
        if (string.IsNullOrWhiteSpace(name))
            throw new ArgumentException("Tenant name is required", nameof(name));

        if (string.IsNullOrWhiteSpace(slug))
            throw new ArgumentException("Tenant slug is required", nameof(slug));

        return new Tenant
        {
            Id = Guid.NewGuid(),
            Name = name,
            Slug = slug.ToLowerInvariant(),
            ContactEmail = contactEmail,
            IsActive = true,
            CreatedAt = DateTime.UtcNow
        };
    }

    public void Activate() => IsActive = true;
    public void Deactivate() => IsActive = false;
    
    public void UpdateContactEmail(string email)
    {
        ContactEmail = email;
    }
}
