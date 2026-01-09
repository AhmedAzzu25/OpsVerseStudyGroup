# 🎯 DP-420: Designing and Implementing Cloud-Native Applications Using Microsoft Azure Cosmos DB - Study Guide

**Exam Code**: DP-420  
**Duration**: 100 minutes  
**Questions**: 40-60 questions  
**Passing Score**: 700/1000  
**Cost**: $165 USD  
**Estimated Study Time**: 35 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Design and Implement Data Models | 35% | 12h | ⏳ |
| 2. Design and Implement Data Distribution | 20% | 7h | ⏳ |
| 3. Integrate Azure Cosmos DB | 15% | 5h | ⏳ |
| 4. Optimize Azure Cosmos DB | 15% | 5h | ⏳ |
| 5. Maintain Azure Cosmos DB | 15% | 6h | ⏳ |

---

## 📚 Domain 1: Design and Implement Data Models (35%) ⭐

### Choose the Right API

```
Use Case Decision Tree:

Document Store → SQL API (default choice)
Key-Value Store → Table API
Graph Database → Gremlin API
Column Family → Cassandra API
MongoDB Compatible → MongoDB API
```

### Partition Key Selection

```csharp
// ✅ Good Partition Key (High Cardinality)
public class Order
{
    [JsonProperty("id")]
    public string Id { get; set; }
    
    [JsonProperty("userId")]  // Good: millions of unique values
    public string UserId { get; set; }
    
    [JsonProperty("orderDate")]
    public DateTime OrderDate { get; set; }
    
    [JsonProperty("totalAmount")]
    public decimal TotalAmount { get; set; }
}

// ❌ Bad Partition Key (Low Cardinality)
[JsonProperty("country")]  // Bad: only ~200 unique values
public string Country { get; set; }

[JsonProperty("status")]  // Bad: only 3-5 unique values (pending, completed, cancelled)
public string Status { get; set; }
```

### Modeling Relationships

```csharp
// Pattern 1: Embed (1:Few relationship)
public class Customer
{
    public string Id { get; set; }
    public string Name { get; set; }
    
    // Embed addresses (typically 1-3 per customer)
    public List<Address> Addresses { get; set; }
}

// Pattern 2: Reference (1:Many or Many:Many)
public class Order
{
    public string Id { get; set; }
    public string CustomerId { get; set; }  // Reference
    public List<string> ProductIds { get; set; }  // References
}

// Pattern 3: Hybrid (Denormalize frequently accessed data)
public class Order
{
    public string Id { get; set; }
    public string CustomerId { get; set; }
    
    // Denormalize for performance
    public string CustomerName { get; set; }
    public string CustomerEmail { get; set; }
}
```

### Indexing Policies

```csharp
// Custom Indexing Policy
var indexingPolicy = new IndexingPolicy
{
    Automatic = true,
    IndexingMode = IndexingMode.Consistent,
    
    // Include specific paths
    IncludedPaths =
    {
        new IncludedPath { Path = "/name/*" },
        new IncludedPath { Path = "/email/*" }
    },
    
    // Exclude paths to reduce RU cost
    ExcludedPaths =
    {
        new ExcludedPath { Path = "/description/*" },
        new ExcludedPath { Path = "/*" }  // Exclude all except included
    },
    
    // Composite indexes for ORDER BY multiple fields
    CompositeIndexes =
    {
        new Collection<CompositePath>
        {
            new CompositePath { Path = "/name", Order = CompositePathSortOrder.Ascending },
            new CompositePath { Path = "/age", Order = CompositePathSortOrder.Descending }
        }
    }
};

Container container = await database.CreateContainerAsync(
    id: "users",
    partitionKeyPath: "/userId",
    throughput: 400,
    requestOptions: new ContainerRequestOptions 
    { 
        IndexingPolicy = indexingPolicy 
    }
);
```

---

## 📚 Domain 2: Design and Implement Data Distribution (20%)

### Partitioning Strategies

```
Logical Partitioning:
  - Partition key determines logical partition
  - Max 20 GB per logical partition
  - Choose key with high cardinality

Physical Partitioning:
  - Cosmos DB automatically manages physical partitions
  - Each physical partition: up to 50 GB, 10,000 RU/s
  - Splits automatically when needed
```

### Multi-Region Configuration

```csharp
// Configure multi-region writes
await client.GetAccount().WriteAsync(
    new AccountProperties
    {
        EnableMultipleWriteLocations = true,
        Locations =
        {
            new AccountRegion { LocationName = "East US", IsZoneRedundant = true },
            new AccountRegion { LocationName = "West Europe", IsZoneRedundant = true },
            new AccountRegion { LocationName = "Southeast Asia", IsZoneRedundant = false }
        }
    }
);

// Set preferred read regions
var clientOptions = new CosmosClientOptions
{
    ApplicationRegion = Regions.EastUS,
    ApplicationPreferredRegions = new List<string>
    {
        Regions.EastUS,
        Regions.WestEurope,
        Regions.SoutheastAsia
    }
};
```

### Consistency Levels

```
Strong
  ├─ Linearizability guaranteed
  ├─ Highest latency
  └─ Use: Financial transactions

Bounded Staleness
  ├─ Staleness bounded by time/operations
  ├─ Balance consistency & availability
  └─ Use: Stock trading, gaming leaderboards

Session (DEFAULT)
  ├─ Consistent within client session
  ├─ Read-your-writes guarantee
  └─ Use: Most applications (shopping carts, user profiles)

Consistent Prefix
  ├─ Reads never see out-of-order writes
  └─ Use: Social media feeds

Eventual
  ├─ Lowest latency, highest availability
  └─ Use: Analytics, non-critical data
```

---

## 📚 Domain 3: Integrate Azure Cosmos DB (15%)

### SDK Operations

```csharp
using Microsoft.Azure.Cosmos;

// Initialize client
CosmosClient client = new CosmosClient(endpoint, key);
Database database = await client.CreateDatabaseIfNotExistsAsync("StoreDB");
Container container = database.GetContainer("Products");

// Create item
Product product = new Product
{
    Id = Guid.NewGuid().ToString(),
    CategoryId = "electronics",
    Name = "Laptop",
    Price = 999.99m
};

await container.CreateItemAsync(product, new PartitionKey(product.CategoryId));

// Read item
ItemResponse<Product> response = await container.ReadItemAsync<Product>(
    id: product.Id,
    partitionKey: new PartitionKey(product.CategoryId)
);

// Query with partition key (efficient!)
QueryDefinition query = new QueryDefinition(
    "SELECT * FROM c WHERE c.categoryId = @category AND c.price < @maxPrice")
    .WithParameter("@category", "electronics")
    .WithParameter("@maxPrice", 1000);

using FeedIterator<Product> iterator = container.GetItemQueryIterator<Product>(
    query,
    requestOptions: new QueryRequestOptions
    {
        PartitionKey = new PartitionKey("electronics"),
        MaxItemCount = 10
    }
);

while (iterator.HasMoreResults)
{
    FeedResponse<Product> results = await iterator.ReadNextAsync();
    foreach (var item in results)
    {
        Console.WriteLine($"{item.Name}: ${item.Price}");
    }
    
    Console.WriteLine($"Request Charge: {results.RequestCharge} RUs");
}
```

### Change Feed Processor

```csharp
// Monitor changes and process
Container leaseContainer = database.GetContainer("leases");

var processor = container.GetChangeFeedProcessorBuilder<Product>(
    processorName: "productChangeProcessor",
    onChangesDelegate: async (IReadOnlyCollection<Product> changes, CancellationToken ct) =>
    {
        foreach (var product in changes)
        {
            // Update search index
            await searchIndex.UpdateDocument(product);
            
            // Send event to Event Hub
            await eventHub.SendAsync(new { Type = "ProductUpdated", Data = product });
        }
    })
    .WithInstanceName("instance1")
    .WithLeaseContainer(leaseContainer)
    .WithStartTime(DateTime.UtcNow.AddHours(-1))  // Start from 1 hour ago
    .Build();

await processor.StartAsync();
```

---

## 📚 Domain 4: Optimize Azure Cosmos DB (15%)

### RU Optimization

```csharp
// Measure RU consumption
ItemResponse<Product> response = await container.ReadItemAsync<Product>(id, partitionKey);
Console.WriteLine($"RU Charge: {response.RequestCharge}");

// Optimize queries
// ✅ Good: Query with partition key
var query1 = "SELECT * FROM c WHERE c.categoryId = 'electronics'";  // 3 RUs

// ❌ Bad: Cross-partition query
var query2 = "SELECT * FROM c WHERE c.price < 100";  // 50+ RUs

// Use projections to reduce RU cost
var query3 = "SELECT c.id, c.name FROM c WHERE c.categoryId = 'electronics'";  // 2 RUs
```

### Throughput Management

```csharp
// Provision throughput at container level
await container.ReplaceThroughputAsync(1000);  // 1000 RU/s

// Autoscale throughput
await container.ReplaceThroughputAsync(
    ThroughputProperties.CreateAutoscaleThroughput(4000)  // Max 4000 RU/s
);

// Move to serverless (for dev/test, low traffic)
// Note: Configured at account creation, cannot change later
```

### Caching Strategies

```csharp
// Integrated cache (preview)
var clientOptions = new CosmosClientOptions
{
    CosmosClientTelemetryOptions = new CosmosClientTelemetryOptions
    {
        DisableDistributedTracing = false
    },
    EnableContentResponseOnWrite = false  // Reduce bandwidth
};

// Application-level caching
private static MemoryCache cache = new MemoryCache(new MemoryCacheOptions());

public async Task<Product> GetProductAsync(string id, string categoryId)
{
    string cacheKey = $"{categoryId}:{id}";
    
    if (cache.TryGetValue(cacheKey, out Product cachedProduct))
    {
        return cachedProduct;
    }
    
    var product = await container.ReadItemAsync<Product>(id, new PartitionKey(categoryId));
    cache.Set(cacheKey, product.Resource, TimeSpan.FromMinutes(5));
    
    return product.Resource;
}
```

---

## 📚 Domain 5: Maintain Azure Cosmos DB (15%)

### Backup and Restore

```
Continuous Backup (Recommended):
  ✅ Point-in-time restore (up to 30 days)
  ✅ No impact on performance
  ✅ No RU consumption
  
Periodic Backup:
  ✅ Scheduled backups (every 4 hours default)
  ✅ Retention: 8 hours to 30 days
  ❌ No point-in-time restore
```

### Monitoring with Azure Monitor

```kusto
// Query Cosmos DB metrics
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.DOCUMENTDB"
| where Category == "DataPlaneRequests"
| where requestCharge_s > 100
| summarize AvgRU = avg(todouble(requestCharge_s)) by bin(TimeGenerated, 5m), OperationName
| render timechart

// Monitor throttling
AzureDiagnostics
| where ResourceProvider == "MICROSOFT.DOCUMENTDB"
| where statusCode_s == 429  // Rate limiting
| summarize count() by bin(TimeGenerated, 1m)
```

### Security Best Practices

```csharp
// Use Azure AD authentication (recommended)
var credential = new DefaultAzureCredential();
CosmosClient client = new CosmosClient(endpoint, credential);

// Rotate keys
// az cosmosdb keys regenerate --name myaccount --resource-group myrg --key-kind primary

// IP firewall
// az cosmosdb update --name myaccount --resource-group myrg \
//   --ip-range-filter "40.76.54.131,52.176.6.30,10.0.0.0/24"

// Private endpoints
// Connect via VNet, no public internet exposure
```

---

## 🎯 Hands-On Practice Labs

### Lab 1: Partition Key Design

Design optimal partition keys for e-commerce scenario

### Lab 2: Multi-Region Setup

Configure geo-replication with manual failover

### Lab 3: Change Feed Processing

Build real-time notification system

### Lab 4: Query Optimization

Reduce RU consumption for common queries

### Lab 5: Backup & Recovery

Test point-in-time restore

---

## 📖 Study Schedule (35 Hours)

### Week 1 (14 hours)

- Domain 1: Data modeling, partitioning
- Complete Labs 1-2

### Week 2 (14 hours)

- Domain 2-3: Distribution, integration
- Complete Labs 3-4

### Week 3 (7 hours)

- Domains 4-5: Optimization, maintenance
- Complete Lab 5
- Practice exam

---

## 📝 Practice Exam Questions

1. **Which consistency level guarantees read-your-writes?**
   - a) Eventual
   - b) Session ✅
   - c) Consistent Prefix
   - d) Strong

2. **What's the max size of a logical partition?**
   - a) 10 GB
   - b) 20 GB ✅
   - c) 50 GB
   - d) 100 GB

3. **Which feature enables point-in-time restore?**
   - a) Periodic backup
   - b) Continuous backup ✅
   - c) Manual backup
   - d) Azure Backup

---

## 🔗 Official Resources

- [MS Learn DP-420](https://learn.microsoft.com/en-us/certifications/exams/dp-420/)
- [Cosmos DB Docs](https://learn.microsoft.com/en-us/azure/cosmos-db/)
- [Partition Key Selection](https://learn.microsoft.com/en-us/azure/cosmos-db/partitioning-overview)

---

## ✅ Exam Preparation Checklist

- [ ] Designed partition keys for 5+ scenarios
- [ ] Configured multi-region replication
- [ ] Implemented change feed processor
- [ ] Optimized queries (reduced RU cost)
- [ ] Understand all 5 consistency levels
- [ ] Set up continuous backup
- [ ] Created composite indexes
- [ ] Practice exam score: 75%+

**Target Exam Date**: May 29, 2026  
**Study Period**: May 15-29 (14 days)  
**Next Cert**: AZ-305 Solutions Architect Expert
