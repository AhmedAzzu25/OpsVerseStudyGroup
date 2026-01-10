using Files.Application.Services;
using Minio;
using Minio.DataModel.Args;

namespace Files.Infrastructure.Storage;

public class MinionStorageProvider : IStorageProvider
{
    private readonly IMinioClient _minioClient;
    private const string BucketName = "monopod-files";

    public MinIOStorageProvider(IMinioClient minioClient)
    {
        _minioClient = minioClient;
        EnsureBucketExists().Wait();
    }

    private async Task EnsureBucketExists()
    {
        var exists = await _minioClient.BucketExistsAsync(new BucketExistsArgs().WithBucket(BucketName));
        if (!exists)
        {
            await _minioClient.MakeBucketAsync(new MakeBucketArgs().WithBucket(BucketName));
        }
    }

    public async Task<string> UploadAsync(Stream stream, string fileName, string contentType)
    {
        var objectName = $"{Guid.NewGuid()}/{fileName}";
        
        await _minioClient.PutObjectAsync(new PutObjectArgs()
            .WithBucket(BucketName)
            .WithObject(objectName)
            .WithStreamData(stream)
            .WithObjectSize(stream.Length)
            .WithContentType(contentType));

        return objectName;
    }

    public async Task<Stream> DownloadAsync(string storagePath)
    {
        var memoryStream = new MemoryStream();
        
        await _minioClient.GetObjectAsync(new GetObjectArgs()
            .WithBucket(BucketName)
            .WithObject(storagePath)
            .WithCallbackStream(stream => stream.CopyTo(memoryStream)));

        memoryStream.Position = 0;
        return memoryStream;
    }

    public async Task DeleteAsync(string storagePath)
    {
        await _minioClient.RemoveObjectAsync(new RemoveObjectArgs()
            .WithBucket(BucketName)
            .WithObject(storagePath));
    }

    public async Task<string> GetPresignedUrlAsync(string storagePath, TimeSpan expiry)
    {
        var args = new PresignedGetObjectArgs()
            .WithBucket(BucketName)
            .WithObject(storagePath)
            .WithExpiry((int)expiry.TotalSeconds);

        return await _minioClient.PresignedGetObjectAsync(args);
    }
}
