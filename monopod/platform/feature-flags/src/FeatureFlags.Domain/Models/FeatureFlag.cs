namespace FeatureFlags.Domain.Models;

public class FeatureFlag
{
    public string Key { get; set; } = string.Empty;
    public bool IsEnabled { get; set; }
    public string? Description { get; set; }
    public Dictionary<string, bool> RegionOverrides { get; set; } = new();
}

public class RegionalConfig
{
    public string Region { get; set; } = string.Empty;
    public bool GdprMode { get; set; }
    public bool VatCalculation { get; set; }
    public bool OfflineMode { get; set; }
    public bool Soc2Compliance { get; set; }
    public bool ArabicSupport { get; set; }
}
