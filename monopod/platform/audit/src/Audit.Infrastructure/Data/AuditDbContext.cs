using Microsoft.EntityFrameworkCore;
using Audit.Domain.Entities;

namespace Audit.Infrastructure.Data;

public class AuditDbContext : DbContext
{
    public DbSet<AuditEntry> AuditEntries => Set<AuditEntry>();

    public AuditDbContext(DbContextOptions<AuditDbContext> options) : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<AuditEntry>(entity =>
        {
            entity.ToTable("audit_entries");
            entity.HasKey(a => a.Id);
            entity.Property(a => a.EntityName).HasMaxLength(200).IsRequired();
            entity.Property(a => a.EntityId).HasMaxLength(100).IsRequired();
            entity.Property(a => a.Action).HasMaxLength(50).IsRequired();
            entity.Property(a => a.OldValues).HasColumnType("jsonb");
            entity.Property(a => a.NewValues).HasColumnType("jsonb");
            entity.HasIndex(a => new { a.TenantId, a.EntityName, a.PerformedAt });
        });
    }
}
