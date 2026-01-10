using FeatureFlags.Domain.Models;
using Microsoft.Extensions.Caching.Distributed;
using System.Text.Json;

namespace FeatureFlags.Application.Services;

public class FlagManager
{
    private readonly IDistributedCache _cache;
    private readonly string _region;

    public FlagManager(IDistributedCache cache, IConfiguration configuration)
    {
        _cache = cache;
        _region = Environment.GetEnvironmentVariable("REGION") ?? configuration["Region"] ?? "global";
    }

    public async Task<bool> IsEnabledAsync(string key)
    {
        var flagJson = await _cache.GetStringAsync($"flag:{key}");
        if (flagJson == null)
            return false;

        var flag = JsonSerializer.Deserialize<FeatureFlag>(flagJson);
        if (flag == null)
            return false;

        // Check region override first
        if (flag.RegionOverrides.TryGetValue(_region, out var overrideValue))
            return overrideValue;

        return flag.IsEnabled;
    }

    public async Task SetFlagAsync(FeatureFlag flag)
    {
        var json = JsonSerializer.Serialize(flag);
        await _cache.SetStringAsync($"flag:{flag.Key}", json);
    }

    public async Task<RegionalConfig> GetRegionalConfigAsync()
    {
        return _region switch
        {
            "eu" => new RegionalConfig
            {
                Region = "eu",
                GdprMode = true,
                VatCalculation = true,
                OfflineMode = false,
                Soc2Compliance = false,
                ArabicSupport = false
            },
            "usa" => new RegionalConfig
            {
                Region = "usa",
                GdprMode = false,
                VatCalculation = false,
                OfflineMode = false,
                Soc2Compliance = true,
                ArabicSupport = false
            },
            "gulf" => new RegionalConfig
            {
                Region = "gulf",
                GdprMode = false,
                VatCalculation = true,
                OfflineMode = false,
                Soc2Compliance = false,
                ArabicSupport = true
            },
            "africa" => new RegionalConfig
            {
                Region = "africa",
                GdprMode = false,
                VatCalculation = false,
                OfflineMode = true,
                Soc2Compliance = false,
                ArabicSupport = false
            },
            _ => new RegionalConfig
            {
                Region = "global",
                GdprMode = false,
                VatCalculation = false,
                OfflineMode = false,
                Soc2Compliance = false,
                ArabicSupport = false
            }
        };
    }
}
