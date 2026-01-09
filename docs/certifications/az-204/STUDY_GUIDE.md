# 🎯 AZ-204: Developing Solutions for Microsoft Azure - Study Guide

**Exam Code**: AZ-204  
**Duration**: 120 minutes  
**Questions**: 40-60 questions  
**Passing Score**: 700/1000  
**Cost**: $165 USD  
**Estimated Study Time**: 60 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Develop Azure Compute Solutions | 25-30% | 16h | ⏳ |
| 2. Develop for Azure Storage | 15-20% | 10h | ⏳ |
| 3. Implement Azure Security | 20-25% | 13h | ⏳ |
| 4. Monitor, Troubleshoot, and Optimize | 15-20% | 10h | ⏳ |
| 5. Connect to and Consume Azure Services | 15-20% | 11h | ⏳ |

---

## 📚 Domain 1: Develop Azure Compute Solutions (25-30%)

### Azure Functions

```csharp
[FunctionName("HttpTriggerExample")]
public static async Task<IActionResult> Run(
    [HttpTrigger(AuthorizationLevel.Function, "get", "post")] HttpRequest req,
    ILogger log)
{
    log.LogInformation("C# HTTP trigger function processed a request.");
    string name = req.Query["name"];
    return name != null
        ? (ActionResult)new OkObjectResult($"Hello, {name}")
        : new BadRequestObjectResult("Please pass a name");
}
```

### Azure Container Apps

```bash
az containerapp create \
  --name my-container-app \
  --resource-group my-rg \
  --environment my-env \
  --image mcr.microsoft.com/azuredocs/containerapps-helloworld:latest \
  --target-port 80 \
  --ingress 'external'
```

### App Service Deployment Slots

```bash
# Create staging slot
az webapp deployment slot create \
  --name myapp \
  --resource-group myrg \
  --slot staging

# Swap slots
az webapp deployment slot swap \
  --name myapp \
  --resource-group myrg \
  --slot staging
```

---

## 📚 Domain 2: Develop for Azure Storage (15-20%)

### Cosmos DB - Partitioning

```csharp
// Define partition key
[JsonProperty(PropertyName = "id")]
public string Id { get; set; }

[JsonProperty(PropertyName = "userId")]
public string UserId { get; set; }  // Partition key

// Query with partition key
var queryDefinition = new QueryDefinition(
    "SELECT * FROM c WHERE c.userId = @userId")
    .WithParameter("@userId", "user123");

using FeedIterator<Item> feed = container.GetItemQueryIterator<Item>(
    queryDefinition,
    requestOptions: new QueryRequestOptions
    {
        PartitionKey = new PartitionKey("user123")
    });
```

### Blob Storage - SAS Tokens

```csharp
BlobSasBuilder sasBuilder = new BlobSasBuilder()
{
    BlobContainerName = containerName,
    BlobName = blobName,
    Resource = "b",
    StartsOn = DateTimeOffset.UtcNow,
    ExpiresOn = DateTimeOffset.UtcNow.AddHours(1)
};

sasBuilder.SetPermissions(BlobSasPermissions.Read);

string sasToken = sasBuilder.ToSasQueryParameters(credential).ToString();
```

---

## 📚 Domain 3: Implement Azure Security (20-25%)

### Managed Identity

```csharp
// System-assigned managed identity
var credential = new DefaultAzureCredential();

SecretClient secretClient = new SecretClient(
    new Uri("https://myvault.vault.azure.net/"),
    credential);

KeyVaultSecret secret = await secretClient.GetSecretAsync("MySecret");
```

### Key Vault Integration

```bash
# Store secret
az keyvault secret set \
  --vault-name myvault \
  --name "ConnectionString" \
  --value "Server=..."

# Grant access to App Service
az webapp identity assign \
  --name myapp \
  --resource-group myrg

# Set access policy
az keyvault set-policy \
  --name myvault \
  --object-id <managed-identity-id> \
  --secret-permissions get list
```

---

## 📚 Domain 4: Monitor, Troubleshoot, and Optimize (15-20%)

### Application Insights

```csharp
using Microsoft. ApplicationInsights;
using Microsoft.ApplicationInsights.DataContracts;

var telemetryClient = new TelemetryClient();

// Track custom event
telemetryClient.TrackEvent("UserLogin",
    properties: new Dictionary<string, string> { {"UserId", "123"} },
    metrics: new Dictionary<string, double> { {"LoadTime", 1.23} });

// Track exception
try
{
    // code
}
catch (Exception ex)
{
    telemetryClient.TrackException(ex);
}
```

### Azure Cache for Redis

```csharp
IDatabase cache = Connection.GetDatabase();

// Set value
await cache.StringSetAsync("key", "value", TimeSpan.FromMinutes(5));

// Get value
string value = await cache.StringGetAsync("key");
```

---

## 📚 Domain 5: Connect to and Consume Azure Services (15-20%)

### Azure Service Bus

```csharp
ServiceBusClient client = new ServiceBusClient(connectionString);
ServiceBusSender sender = client.CreateSender(queueName);

// Send message
ServiceBusMessage message = new ServiceBusMessage("Hello Azure!");
await sender.SendMessageAsync(message);

// Receive message
ServiceBusReceiver receiver = client.CreateReceiver(queueName);
ServiceBusReceivedMessage receivedMessage = await receiver.ReceiveMessageAsync();
await receiver.CompleteMessageAsync(receivedMessage);
```

### Event Grid

```csharp
EventGridPublisherClient client = new EventGridPublisherClient(
    new Uri(topicEndpoint),
    new AzureKeyCredential(topicKey));

EventGridEvent egEvent = new EventGridEvent(
    subject: "user/signup",
    eventType: "User.Signup",
    dataVersion: "1.0",
    data: new { UserId = "123", Email = "user@example.com" });

await client.SendEventAsync(egEvent);
```

---

## 🎯 Hands-On Practice Labs

### Lab 1: Create HTTP-Triggered Azure Function

- Create Function App
- Implement HTTP trigger with input validation
- Test locally and deploy to Azure
- Configure App Settings

### Lab 2: Cosmos DB CRUD Operations

- Create Cosmos DB account (SQL API)
- Implement partition strategy
- Query with SDK
- Implement change feed processor

### Lab 3: Blob Storage with SAS

- Upload blobs programmatically
- Generate SAS tokens
- Implement blob lifecycle management
- Configure CDN

### Lab 4: Secure App with Key Vault

- Create Key Vault
- Store connectionstrings as secrets
- Enable managed identity for App Service
- Access secrets from code

### Lab 5: Application Insights Integration

- Add App Insights to application
- Implement custom metrics
- Create availability tests
- Query logs with KQL

### Lab 6: Service Bus Queue

- Create Service Bus namespace
- Implement sender and receiver
- Handle dead-letter queue
- Implement sessions

---

## 📖 Study Schedule (60 Hours)

### Week 1 (20 hours)

- Domain 1: Azure Compute (Functions, Container Apps, App Service)
- Complete Labs 1

### Week 2 (20 hours)

- Domain 2: Storage (Cosmos DB, Blob, Table)
- Domain 3: Security (Managed Identity, Key Vault)
- Complete Labs 2-4

### Week 3 (20 hours)

- Domain 4: Monitoring (App Insights, Cache)
- Domain 5: Messaging (Service Bus, Event Grid)
- Complete Labs 5-6
- Practice exam

---

## 📝 Practice Exam Questions

1. **Which consistency level provides the lowest latency?**
   - a) Strong
   - b) Bounded Staleness
   - c) Eventual ✅
   - d) Session

2. **What's the maximum execution time for a Consumption plan Function?**
   - a) 5 minutes
   - b) 10 minutes ✅
   - c) 30 minutes
   - d) Unlimited

3. **Which authentication is recommended for App-to-App communication?**
   - a) Username/Password
   - b) SAS Tokens
   - c) Managed Identity ✅
   - d) API Keys

---

## 🔗 Official Resources

- [MS Learn AZ-204 Path](https://learn.microsoft.com/en-us/certifications/exams/az-204/)
- [Azure SDK for .NET](https://azure.github.io/azure-sdk-for-net/)
- [Azure Code Samples](https://github.com/Azure-Samples)

---

## ✅ Exam Preparation Checklist

- [ ] Completed all 5 domains
- [ ] Hands-on with Azure Functions (HTTP, Timer, Blob triggers)
- [ ] Created Cosmos DB with partitioning
- [ ] Implemented Managed Identity
- [ ] Configured Application Insights
- [ ] Worked with Service Bus and Event Grid
- [ ] Practice exam score: 75%+
- [ ] Scheduled exam

**Target Exam Date**: March 1, 2026  
**Study Period**: February 8-28 (21 days)  
**Next Cert**: Terraform Associate
