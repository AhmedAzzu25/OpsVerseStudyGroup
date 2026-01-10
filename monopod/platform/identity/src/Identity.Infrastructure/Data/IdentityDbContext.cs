using Identity.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace Identity.Infrastructure.Data;

public class IdentityDbContext : DbContext
{
    public DbSet<User> Users => Set<User>();
    public DbSet<Tenant> Tenants => Set<Tenant>();

    public IdentityDbContext(DbContextOptions<IdentityDbContext> options) : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // User entity configuration
        modelBuilder.Entity<User>(entity =>
        {
            entity.ToTable("users");
            entity.HasKey(u => u.Id);
            
            entity.Property(u => u.Id).HasColumnName("id");
            entity.Property(u => u.TenantId).HasColumnName("tenant_id").IsRequired();
            entity.Property(u => u.Email).HasColumnName("email").HasMaxLength(255).IsRequired();
            entity.Property(u => u.Username).HasColumnName("username").HasMaxLength(100).IsRequired();
            entity.Property(u => u.PasswordHash).HasColumnName("password_hash").HasMaxLength(500).IsRequired();
            entity.Property(u => u.FirstName).HasColumnName("first_name").HasMaxLength(100);
            entity.Property(u => u.LastName).HasColumnName("last_name").HasMaxLength(100);
            entity.Property(u => u.IsActive).HasColumnName("is_active");
            entity.Property(u => u.EmailConfirmed).HasColumnName("email_confirmed");
            entity.Property(u => u.CreatedAt).HasColumnName("created_at");
            entity.Property(u => u.LastLoginAt).HasColumnName("last_login_at");

            // Store roles as JSON array
            entity.Property(u => u.Roles)
                .HasColumnName("roles")
                .HasConversion(
                    v => string.Join(',', v),
                    v => v.Split(',', StringSplitOptions.RemoveEmptyEntries).ToList());

            entity.HasIndex(u => u.Email).IsUnique();
            entity.HasIndex(u => u.Username).IsUnique();
            entity.HasIndex(u => u.TenantId);
        });

        // Tenant entity configuration
        modelBuilder.Entity<Tenant>(entity =>
        {
            entity.ToTable("tenants");
            entity.HasKey(t => t.Id);
            
            entity.Property(t => t.Id).HasColumnName("id");
            entity.Property(t => t.Name).HasColumnName("name").HasMaxLength(200).IsRequired();
            entity.Property(t => t.Slug).HasColumnName("slug").HasMaxLength(100).IsRequired();
            entity.Property(t => t.IsActive).HasColumnName("is_active");
            entity.Property(t => t.CreatedAt).HasColumnName("created_at");
            entity.Property(t => t.ContactEmail).HasColumnName("contact_email").HasMaxLength(255);

            entity.HasIndex(t => t.Slug).IsUnique();
        });

        // Seed default tenant
        modelBuilder.Entity<Tenant>().HasData(
            Tenant.Create("Default Tenant", "default", "admin@monopod.io")
        );
    }
}
