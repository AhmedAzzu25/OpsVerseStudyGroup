namespace Files.Domain.Entities;

public class FileMetadata
{
    public Guid Id { get; private set; }
    public Guid TenantId { get; private set; }
    public string FileName { get; private set; }
    public string ContentType { get; private set; }
    public long SizeBytes { get; private set; }
    public string StoragePath { get; private set; }
    public Guid UploadedBy { get; private set; }
    public DateTime UploadedAt { get; private set; }
    public bool IsPublic { get; private set; }

    private FileMetadata() { }

    public static FileMetadata Create(
        Guid tenantId,
        string fileName,
        string contentType,
        long sizeBytes,
        string storagePath,
        Guid uploadedBy,
        bool isPublic = false)
    {
        return new FileMetadata
        {
            Id = Guid.NewGuid(),
            TenantId = tenantId,
            FileName = fileName,
            ContentType = contentType,
            SizeBytes = sizeBytes,
            StoragePath = storagePath,
            UploadedBy = uploadedBy,
            UploadedAt = DateTime.UtcNow,
            IsPublic = isPublic
        };
    }

    public void MakePublic() => IsPublic = true;
    public void MakePrivate() => IsPublic = false;
}
