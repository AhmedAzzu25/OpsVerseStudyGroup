using Files.Application.Services;
using Files.Domain.Entities;
using Files.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Files.API.Controllers;

[ApiController]
[Route("api/files/v1")]
public class FilesController : ControllerBase
{
    private readonly FilesDbContext _context;
    private readonly IStorageProvider _storage;
    private readonly ILogger<FilesController> _logger;

    public FilesController(FilesDbContext context, IStorageProvider storage, ILogger<FilesController> logger)
    {
        _context = context;
        _storage = storage;
        _logger = logger;
    }

    [HttpPost("upload")]
    public async Task<IActionResult> Upload(IFormFile file)
    {
        if (file == null || file.Length == 0)
            return BadRequest("No file provided");

        var tenantId = Guid.Parse(User.FindFirst("tenant_id")?.Value ?? Guid.NewGuid().ToString());
        var userId = Guid.Parse(User.FindFirst("sub")?.Value ?? Guid.NewGuid().ToString());

        using var stream = file.OpenReadStream();
        var storagePath = await _storage.UploadAsync(stream, file.FileName, file.ContentType);

        var metadata = FileMetadata.Create(
            tenantId,
            file.FileName,
            file.ContentType,
            file.Length,
            storagePath,
            userId);

        _context.Files.Add(metadata);
        await _context.SaveChangesAsync();

        _logger.LogInformation("File uploaded: {FileId} - {FileName}", metadata.Id, file.FileName);

        return CreatedAtAction(nameof(GetFile), new { id = metadata.Id }, new
        {
            metadata.Id,
            metadata.FileName,
            metadata.ContentType,
            metadata.SizeBytes,
            metadata.UploadedAt
        });
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetFile(Guid id)
    {
        var file = await _context.Files.FindAsync(id);
        if (file == null)
            return NotFound();

        return Ok(new
        {
            file.Id,
            file.FileName,
            file.ContentType,
            file.SizeBytes,
            file.UploadedAt,
            file.IsPublic
        });
    }

    [HttpGet("{id}/download")]
    public async Task<IActionResult> Download(Guid id)
    {
        var file = await _context.Files.FindAsync(id);
        if (file == null)
            return NotFound();

        var stream = await _storage.DownloadAsync(file.StoragePath);
        return File(stream, file.ContentType, file.FileName);
    }

    [HttpGet("{id}/url")]
    public async Task<IActionResult> GetPresignedUrl(Guid id, [FromQuery] int expiryMinutes = 60)
    {
        var file = await _context.Files.FindAsync(id);
        if (file == null)
            return NotFound();

        var url = await _storage.GetPresignedUrlAsync(file.StoragePath, TimeSpan.FromMinutes(expiryMinutes));
        return Ok(new { url, expiresIn = expiryMinutes });
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var file = await _context.Files.FindAsync(id);
        if (file == null)
            return NotFound();

        await _storage.DeleteAsync(file.StoragePath);
        _context.Files.Remove(file);
        await _context.SaveChangesAsync();

        _logger.LogInformation("File deleted: {FileId}", id);
        return NoContent();
    }
}
