using System.Security.Cryptography;
using System.Text;

namespace Identity.Domain.Entities;

public class User
{
    public Guid Id { get; private set; }
    public Guid TenantId { get; private set; }
    public string Email { get; private set; }
    public string Username { get; private set; }
    public string PasswordHash { get; private set; }
    public string FirstName { get; private set; }
    public string LastName { get; private set; }
    public bool IsActive { get; private set; }
    public bool EmailConfirmed { get; private set; }
    public DateTime CreatedAt { get; private set; }
    public DateTime? LastLoginAt { get; private set; }
    
    private readonly List<string> _roles = new();
    public IReadOnlyCollection<string> Roles => _roles.AsReadOnly();

    private User() { } // EF Core

    public static User Create(
        Guid tenantId,
        string email,
        string username,
        string password,
        string firstName,
        string lastName)
    {
        if (string.IsNullOrWhiteSpace(email))
            throw new ArgumentException("Email is required", nameof(email));
        
        if (string.IsNullOrWhiteSpace(password))
            throw new ArgumentException("Password is required", nameof(password));

        var user = new User
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            Email = email.ToLowerInvariant(),
            Username = username?.ToLowerInvariant() ?? email.ToLowerInvariant(),
            FirstName = firstName,
            LastName = lastName,
            IsActive = true,
            EmailConfirmed = false,
            CreatedAt = DateTime.UtcNow
        };

        user.SetPassword(password);
        user.AddRole("User"); // Default role

        return user;
    }

    public void SetPassword(string password)
    {
        if (password.Length < 8)
            throw new ArgumentException("Password must be at least 8 characters", nameof(password));

        PasswordHash = HashPassword(password);
    }

    public bool ValidatePassword(string password)
    {
        return PasswordHash == HashPassword(password);
    }

    public void AddRole(string role)
    {
        if (!_roles.Contains(role))
        {
            _roles.Add(role);
        }
    }

    public void RemoveRole(string role)
    {
        _roles.Remove(role);
    }

    public void Activate() => IsActive = true;
    public void Deactivate() => IsActive = false;
    public void ConfirmEmail() => EmailConfirmed = true;
    
    public void RecordLogin()
    {
        LastLoginAt = DateTime.UtcNow;
    }

    private static string HashPassword(string password)
    {
        using var sha256 = SHA256.Create();
        var bytes = Encoding.UTF8.GetBytes(password + "MonoPod_Salt_2026"); // Use proper salt in production
        var hash = sha256.ComputeHash(bytes);
        return Convert.ToBase64String(hash);
    }
}
