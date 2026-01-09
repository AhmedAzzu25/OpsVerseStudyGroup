# GitHub Copilot Instructions - IMS (Inventory Management System)

## Project Overview
**Module**: Inventory Management System (IMS)  
**Architecture**: Event-Driven Microservices with Outbox Pattern  
**Tech Stack**: .NET 8, RabbitMQ, PostgreSQL, Redis, Docker  
**Domain**: E-Commerce / Retail

---

## Core Functionality
- Real-time inventory tracking across multiple warehouses
- Event-driven stock updates using Outbox pattern
- Low-stock alerts and automatic reorder triggers
- Barcode scanning integration
- Multi-tenant support for different stores

---

## Architecture Principles

### Event-Driven Design
```
Inventory Command → Domain Event → Outbox Table → Message Broker → Consumers
```

When generating code:
- Always use the Outbox pattern for event publishing
- Ensure idempotent event handlers
- Implement saga pattern for distributed transactions
- Use event sourcing for audit trail

### Domain-Driven Design
```
Aggregates: Product, StockMovement, Warehouse, Supplier
Value Objects: SKU, Barcode, Quantity, Location
Events: ProductCreated, StockAdjusted, LowStockDetected, OrderPlaced
```

---

## Coding Standards

### C# Style Guide
```csharp
// ✅ Good: Use records for DTOs and events
public record ProductCreatedEvent(
    Guid ProductId,
    string SKU,
    string Name,
    decimal Price,
    DateTime CreatedAt
);

// ✅ Good: Use primary constructors
public class ProductService(IProductRepository repository, IEventPublisher publisher)
{
    public async Task<Result<Product>> CreateProductAsync(CreateProductCommand command)
    {
        // Implementation
    }
}

// ❌ Bad: Mutable DTOs
public class ProductDto
{
    public Guid Id { get; set; }  // Avoid set;
}
```

### Naming Conventions
- **Commands**: `CreateProductCommand`, `AdjustStockCommand`
- **Events**: `ProductCreatedEvent`, `StockAdjustedEvent`
- **Handlers**: `CreateProductCommandHandler`, `StockAdjustedEventHandler`
- **Repositories**: `IProductRepository`, `ProductRepository`

---

## Technology Stack

### Backend (.NET 8)
```csharp
// Use these packages
- MediatR (CQRS pattern)
- FluentValidation (input validation)
- Serilog (structured logging)
- Polly (resilience and fault tolerance)
- Dapper (micro-ORM for queries)
- Entity Framework Core (write operations)
```

### Message Broker (RabbitMQ)
```csharp
// Exchange: ims.events
// Queues: 
//   - ims.stock.notifications
//   - ims.stock.reorder
//   - ims.audit.events

// Dead Letter Queue: ims.dlq
```

### Database (PostgreSQL)
```sql
-- Schema: ims
-- Tables: products, stock_movements, warehouses, outbox_events
-- Use JSONB for flexible metadata
-- Implement proper indexes on SKU, Barcode, WarehouseId
```

---

## Security Requirements

### Authentication & Authorization
```csharp
// All endpoints require authentication
[Authorize]
[ApiController]
[Route("api/inventory")]
public class InventoryController : ControllerBase { }

// Role-based access
[Authorize(Roles = "InventoryManager,Admin")]
public async Task<IActionResult> AdjustStock(AdjustStockCommand command) { }
```

### Data Protection
- Encrypt sensitive supplier information
- Audit all stock movements
- Implement row-level security for multi-tenant data
- Use Azure Key Vault for connection strings

### Input Validation
```csharp
public class CreateProductCommandValidator : AbstractValidator<CreateProductCommand>
{
    public CreateProductCommandValidator()
    {
        RuleFor(x => x.SKU)
            .NotEmpty()
            .MaximLength(50)
            .Matches("^[A-Z0-9-]+$");
        
        RuleFor(x => x.Price)
            .GreaterThan(0)
            .LessThan(1000000);
    }
}
```

---

## Copilot Instructions

When I ask you to generate code for IMS:

1. **Always use the Outbox pattern** for publishing events
2. **Implement CQRS** - separate read and write models
3. **Add comprehensive logging** using Serilog with structured data
4. **Include unit tests** - use xUnit, FluentAssertions, NSubstitute
5. **Follow DDD principles** - use aggregates, value objects, domain events
6. **Add retry logic** using Polly for external calls
7. **Implement health checks** for dependencies (DB, RabbitMQ, Redis)
8. **Use Result pattern** instead of exceptions for business logic failures
9. **Add OpenTelemetry** for distributed tracing
10. **Document all public APIs** with XML comments

### Code Generation Preferences
- Use minimal API style for simple endpoints
- Prefer async/await for all I/O operations
- Use C# 12 features (primary constructors, collection expressions)
- Add nullable reference type annotations
- Include integration tests for critical flows

### Example Request Format
```
"Generate a command handler for adjusting stock quantity that:
- Validates input
- Loads Product aggregate
- Adjusts quantity
- Publishes StockAdjustedEvent using Outbox pattern
- Includes unit tests"
```

---

## Common Patterns to Use

### Outbox Pattern Implementation
```csharp
await using var transaction = await dbContext.Database.BeginTransactionAsync();
try
{
    // 1. Update aggregate
    product.AdjustStock(quantity);
    await productRepository.UpdateAsync(product);
    
    // 2. Save event to outbox
    var outboxEvent = new OutboxEvent
    {
        EventType = nameof(StockAdjustedEvent),
        Payload = JsonSerializer.Serialize(new StockAdjustedEvent(...)),
        CreatedAt = DateTime.UtcNow
    };
    await outboxRepository.AddAsync(outboxEvent);
    
    // 3. Commit transaction
    await transaction.CommitAsync();
}
catch
{
    await transaction.RollbackAsync();
    throw;
}
```

### Repository Pattern
```csharp
public interface IProductRepository
{
    Task<Product?> GetByIdAsync(Guid id, CancellationToken ct = default);
    Task<Product?> GetBySkuAsync(string sku, CancellationToken ct = default);
    Task AddAsync(Product product, CancellationToken ct = default);
    Task UpdateAsync(Product product, CancellationToken ct = default);
}
```

---

## Testing Guidelines

### Unit Tests
- Test all command handlers
- Test all domain logic in aggregates
- Test all validators
- Aim for 80%+ code coverage

### Integration Tests
- Test API endpoints end-to-end
- Test event publishing and consumption
- Test database operations
- Use TestContainers for PostgreSQL and RabbitMQ

---

## Performance Considerations

- Use Redis for caching frequently accessed products
- Implement pagination for all list endpoints
- Use database indexes on SKU, Barcode, WarehouseId
- Batch process outbox events (don't publish one-by-one)
- Use connection pooling for database connections

---

## Error Handling

```csharp
// Use Result pattern
public record Result<T>
{
    public bool IsSuccess { get; init; }
    public T? Value { get; init; }
    public Error? Error { get; init; }
}

// Return meaningful errors
return Result<Product>.Failure(new Error(
    "PRODUCT_NOT_FOUND",
    $"Product with SKU {sku} not found"
));
```

---

**When in doubt, prioritize:**
1. Data consistency (use transactions)
2. Event reliability (Outbox pattern)
3. Idempotency (handle duplicate events)
4. Observability (logging and tracing)
5. Testability (write tests for all business logic)
