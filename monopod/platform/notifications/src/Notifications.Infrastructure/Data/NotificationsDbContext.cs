using Microsoft.EntityFrameworkCore;
using Notifications.Domain.Entities;

namespace Notifications.Infrastructure.Data;

public class NotificationsDbContext : DbContext
{
    public DbSet<Notification> Notifications => Set<Notification>();

    public NotificationsDbContext(DbContextOptions<NotificationsDbContext> options) : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Notification>(entity =>
        {
            entity.ToTable("notifications");
            entity.HasKey(n => n.Id);
            
            entity.Property(n => n.Id).HasColumnName("id");
            entity.Property(n => n.TenantId).HasColumnName("tenant_id").IsRequired();
            entity.Property(n => n.Recipient).HasColumnName("recipient").HasMaxLength(500).IsRequired();
            entity.Property(n => n.Channel).HasColumnName("channel").IsRequired();
            entity.Property(n => n.Subject).HasColumnName("subject").HasMaxLength(500);
            entity.Property(n => n.Body).HasColumnName("body").IsRequired();
            entity.Property(n => n.Status).HasColumnName("status").IsRequired();
            entity.Property(n => n.CreatedAt).HasColumnName("created_at");
            entity.Property(n => n.SentAt).HasColumnName("sent_at");
            entity.Property(n => n.ErrorMessage).HasColumnName("error_message").HasMaxLength(1000);
            entity.Property(n => n.RetryCount).HasColumnName("retry_count");

            entity.HasIndex(n => n.TenantId);
            entity.HasIndex(n => n.Status);
            entity.HasIndex(n => n.CreatedAt);
        });
    }
}
