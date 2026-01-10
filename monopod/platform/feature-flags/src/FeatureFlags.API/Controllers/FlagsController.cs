using FeatureFlags.Application.Services;
using FeatureFlags.Domain.Models;
using Microsoft.AspNetCore.Mvc;

namespace FeatureFlags.API.Controllers;

[ApiController]
[Route("api/feature-flags/v1")]
public class FlagsController : ControllerBase
{
    private readonly FlagManager _flagManager;

    public FlagsController(FlagManager flagManager)
    {
        _flagManager = flagManager;
    }

    [HttpGet("{key}")]
    public async Task<IActionResult> GetFlag(string key)
    {
        var isEnabled = await _flagManager.IsEnabledAsync(key);
        return Ok(new { key, isEnabled });
    }

    [HttpPut("{key}")]
    public async Task<IActionResult> SetFlag(string key, [FromBody] SetFlagRequest request)
    {
        var flag = new FeatureFlag
        {
            Key = key,
            IsEnabled = request.IsEnabled,
            Description = request.Description,
            RegionOverrides = request.RegionOverrides ?? new()
        };

        await _flagManager.SetFlagAsync(flag);
        return Ok(new { message = "Flag updated successfully" });
    }

    [HttpGet("regional-config")]
    public async Task<IActionResult> GetRegionalConfig()
    {
        var config = await _flagManager.GetRegionalConfigAsync();
        return Ok(config);
    }
}

public record SetFlagRequest(
    bool IsEnabled,
    string? Description = null,
    Dictionary<string, bool>? RegionOverrides = null);
