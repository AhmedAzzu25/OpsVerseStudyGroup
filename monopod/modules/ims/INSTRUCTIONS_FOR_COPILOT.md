# IMS Module: Smart Supply Chain for SMEs

## Context
Build an **Inventory Management System** for small-to-medium enterprises that handles high-volume transactions with guaranteed consistency.

## Tech Stack
- **.NET 8 Web API** (Minimal APIs or Controllers)
- **Event-Driven Architecture** with RabbitMQ
- **PostgreSQL** with Optimistic Concurrency Control
- **Outbox Pattern** for reliable event publishing

## Architecture Requirements

### Clean Architecture Layers
1. **Domain Layer**
   - Entities: `Product`, `StockMovement`, `Supplier`
   - Value Objects: `SKU`, `Quantity`, `Price`
   - Domain Events: `StockAdjusted`, `ProductCreated`, `ReorderTriggered`

2. **Application Layer**
   - Commands: `CreateProduct`, `AdjustStock`, `RecordSale`
   - Queries: `GetProductBySKU`, `GetLowStockProducts`
   - Event Handlers: `OnStockAdjusted`, `OnReorderTriggered`

3. **Infrastructure Layer**
   - EF Core DbContext with Outbox table
   - RabbitMQ Event Bus implementation
   - Repository pattern with Unit of Work

4. **API Layer**
   - REST endpoints: `/api/products`, `/api/stock`, `/api/suppliers`
   - Swagger/OpenAPI documentation
   - Health checks

## Key Implementation Tasks

### 1. Scaffold Solution
```bash
dotnet new sln -n IMS
dotnet new webapi -n IMS.API
dotnet new classlib -n IMS.Domain
dotnet new classlib -n IMS.Application
dotnet new classlib -n IMS.Infrastructure
```

### 2. Implement Outbox Pattern
Create an `OutboxMessage` entity:
```csharp
public class OutboxMessage
{
    public Guid Id { get; set; }
    public string EventType { get; set; }
    public string Payload { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime? ProcessedAt { get; set; }
}
```

### 3. Event Publishing Flow
1. User calls API endpoint
2. Command handler saves entity + outbox record in single transaction
3. Background service polls outbox table
4. Publishes events to RabbitMQ
5. Marks outbox records as processed

### 4. Optimistic Concurrency
Add `RowVersion` to entities:
```csharp
public class Product
{
    public int Id { get; set; }
    public string SKU { get; set; }
    public int StockQuantity { get; set; }
    
    [Timestamp]
    public byte[] RowVersion { get; set; }
}
```

## Acceptance Criteria
- [ ] CRUD operations for Products
- [ ] Stock adjustment with concurrency handling
- [ ] Events published via Outbox Pattern
- [ ] RabbitMQ consumer service (separate project)
- [ ] Unit tests for domain logic
- [ ] Integration tests with TestContainers

## Getting Started
Execute this plan step-by-step. Start with the solution scaffold, then implement Domain layer, followed by Infrastructure, and finally API.

**Remember:** Consistency is critical—never publish events outside a transaction!
