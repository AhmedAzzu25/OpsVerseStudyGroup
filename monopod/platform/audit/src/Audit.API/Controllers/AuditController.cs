using Audit.Infrastructure.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Audit.API.Controllers;

[ApiController]
[Route("api/audit/v1")]
public class AuditController : ControllerBase
{
    private readonly AuditDbContext _context;

    public AuditController(AuditDbContext context)
    {
        _context = context;
    }

    [HttpGet]
    public async Task<IActionResult> GetAuditLog(
        [FromQuery] string? entityName = null,
        [FromQuery] string? action = null,
        [FromQuery] DateTime? from = null,
        [FromQuery] DateTime? to = null,
        [FromQuery] int page = 1,
        [FromQuery] int pageSize = 50)
    {
        var query = _context.AuditEntries.AsQueryable();

        if (!string.IsNullOrEmpty(entityName))
            query = query.Where(a => a.EntityName == entityName);

        if (!string.IsNullOrEmpty(action))
            query = query.Where(a => a.Action == action);

        if (from.HasValue)
            query = query.Where(a => a.PerformedAt >= from.Value);

        if (to.HasValue)
            query = query.Where(a => a.PerformedAt <= to.Value);

        var total = await query.CountAsync();
        var entries = await query
            .OrderByDescending(a => a.PerformedAt)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();

        return Ok(new
        {
            total,
            page,
            pageSize,
            data = entries
        });
    }

    [HttpGet("export")]
    public async Task<IActionResult> ExportForCompliance(
        [FromQuery] DateTime from,
        [FromQuery] DateTime to)
    {
        var entries = await _context.AuditEntries
            .Where(a => a.PerformedAt >= from && a.PerformedAt <= to)
            .OrderBy(a => a.PerformedAt)
            .ToListAsync();

        var csv = new System.Text.StringBuilder();
        csv.AppendLine("Timestamp,Entity,EntityId,Action,PerformedBy,IPAddress");
        
        foreach (var entry in entries)
        {
            csv.AppendLine($"{entry.PerformedAt:O},{entry.EntityName},{entry.EntityId},{entry.Action},{entry.PerformedBy},{entry.IpAddress}");
        }

        return File(System.Text.Encoding.UTF8.GetBytes(csv.ToString()), "text/csv", $"audit-export-{from:yyyyMMdd}-{to:yyyyMMdd}.csv");
    }
}
