using Microsoft.EntityFrameworkCore;
using Files.Domain.Entities;

namespace Files.Infrastructure.Data;

public class FilesDbContext : DbContext
{
    public DbSet<FileMetadata> Files => Set<FileMetadata>();

    public FilesDbContext(DbContextOptions<FilesDbContext> options) : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<FileMetadata>(entity =>
        {
            entity.ToTable("files");
            entity.HasKey(f => f.Id);
            entity.Property(f => f.FileName).HasMaxLength(500).IsRequired();
            entity.Property(f => f.ContentType).HasMaxLength(200);
            entity.Property(f => f.StoragePath).HasMaxLength(1000).IsRequired();
            entity.HasIndex(f => f.TenantId);
            entity.HasIndex(f => f.UploadedAt);
        });
    }
}
