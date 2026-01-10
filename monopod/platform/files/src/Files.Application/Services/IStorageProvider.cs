namespace Files.Application.Services;

public interface IStorageProvider
{
    Task<string> UploadAsync(Stream stream, string fileName, string contentType);
    Task<Stream> DownloadAsync(string storagePath);
    Task DeleteAsync(string storagePath);
    Task<string> GetPresignedUrlAsync(string storagePath, TimeSpan expiry);
}
