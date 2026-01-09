# IMS - Coding Standards & Style Guide

## General Principles

1. **Write code for humans first, computers second**
2. **Prefer explicit over implicit**
3. **Keep it simple, stupid (KISS)**
4. **Don't repeat yourself (DRY)**
5. **You aren't gonna need it (YAGNI)**

---

## C# Coding Standards

### File Organization

```csharp
// 1. Using directives (System first, then third-party, then project)
using System;
using System.Collections.Generic;
using Microsoft.Extensions.Logging;
using IMS.Domain.Aggregates;

// 2. Namespace
namespace IMS.Application.Commands;

// 3. Class/interface/record
public sealed class CreateProductCommandHandler { }
```

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Namespace | PascalCase | `IMS.Domain.Events` |
| Class | PascalCase | `ProductService` |
| Interface | IPascalCase | `IProductRepository` |
| Method | PascalCase | `AdjustStock()` |
| Property | PascalCase | `CurrentStock` |
| Field (private) | _camelCase | `_logger` |
| Parameter | camelCase | `productId` |
| Local Variable | camelCase | `adjustedQuantity` |
| Constant | PascalCase | `MaxRetryCount` |

### Records for DTOs and Events (Preferred)

```csharp
// ✅ Good: Immutable, concise
public record ProductDto(
    Guid Id,
    string SKU,
    string Name,
    decimal Price,
    int CurrentStock
);

public record ProductCreatedEvent(
    Guid ProductId,
    string SKU,
    DateTime CreatedAt
) : IDomainEvent;

// ❌ Bad: Mutable class
public class ProductDto
{
    public Guid Id { get; set; }
    public string SKU { get; set; }
}
```

### Primary Constructors (C# 12)

```csharp
// ✅ Good: Clean dependency injection
public class ProductService(
    IProductRepository repository,
    IEventPublisher publisher,
    ILogger<ProductService> logger)
{
    public async Task<Result<Product>> CreateAsync(CreateProductCommand command)
    {
        logger.LogInformation("Creating product: {SKU}", command.SKU);
        // Use repository, publisher directly
    }
}

// ❌ Bad: Verbose constructor
public class ProductService
{
    private readonly IProductRepository _repository;
    private readonly IEventPublisher _publisher;
    
    public ProductService(IProductRepository repository, IEventPublisher publisher)
    {
        _repository = repository;
        _publisher = publisher;
    }
}
```

### Async/Await

```csharp
// ✅ Good: Always use async for I/O
public async Task<Product?> GetProductAsync(Guid id, CancellationToken ct)
{
    return await _repository.FindByIdAsync(id, ct);
}

// ✅ Good: Pass CancellationToken
public async Task ProcessAsync(CancellationToken ct = default)
{
    while (!ct.IsCancellationRequested)
    {
        await Task.Delay(1000, ct);
    }
}

// ❌ Bad: Sync over async
public Product GetProduct(Guid id)
{
    return _repository.FindByIdAsync(id).Result;  // DEADLOCK RISK!
}
```

### Nullable Reference Types

```csharp
#nullable enable

// ✅ Good: Explicit nullability
public async Task<Product?> FindBySkuAsync(string sku)  // Can return null
{
    return await _dbContext.Products
        .FirstOrDefaultAsync(p => p.SKU == sku);
}

public async Task<Product> GetByIdAsync(Guid id)  // Never returns null
{
    var product = await FindBySkuAsync(id);
    return product ?? throw new NotFoundException($"Product {id} not found");
}

// ✅ Good: Null checking
if (product is not null)
{
    // Use product
}
```

### Pattern Matching

```csharp
// ✅ Good: Use pattern matching
public string GetMovementDescription(StockMovement movement) => movement.Type switch
{
    MovementType.In => $"Received {movement.Quantity} units",
    MovementType.Out => $"Shipped {movement.Quantity} units",
    MovementType.Adjustment => $"Adjusted by {movement.Quantity} units",
    _ => "Unknown movement"
};

// ✅ Good: Is/is not patterns
if (result is { IsSuccess: true, Value: var product })
{
    // Use product
}
```

### Collection Expressions (C# 12)

```csharp
// ✅ Good: Concise collection initialization
List<string> skus = ["LAPTOP-001", "MOUSE-002", "KEYBOARD-003"];

int[] quantities = [10, 20, 30, 40];

// Spread operator
string[] allSkus = [..activeSkus, ..discontinuedSkus];
```

---

## CQRS Pattern

### Commands

```csharp
// Command: Intent to change state
public record CreateProductCommand(
    string SKU,
    string Name,
    decimal Price,
    int InitialStock
) : ICommand<Result<Guid>>;

// Command Handler
public class CreateProductCommandHandler(
    IProductRepository repository,
    IEventPublisher publisher,
    IValidator<CreateProductCommand> validator)
    : ICommandHandler<CreateProductCommand, Result<Guid>>
{
    public async Task<Result<Guid>> Handle(
        CreateProductCommand command,
        CancellationToken ct)
    {
        // 1. Validate
        var validationResult = await validator.ValidateAsync(command, ct);
        if (!validationResult.IsValid)
            return Result<Guid>.Failure(validationResult.Errors);
        
        // 2. Create aggregate
        var product = Product.Create(
            SKU.Create(command.SKU),
            command.Name,
            command.Price,
            command.InitialStock
        );
        
        // 3. Save
        await repository.AddAsync(product, ct);
        
        // 4. Publish events (via Outbox)
        await publisher.PublishAsync(product.DomainEvents, ct);
        
        return Result<Guid>.Success(product.Id);
    }
}
```

### Queries

```csharp
// Query: Request for data
public record GetProductBySkuQuery(string SKU) : IQuery<ProductDto?>;

// Query Handler (can use Dapper for performance)
public class GetProductBySkuQueryHandler(IDbConnection db)
    : IQueryHandler<GetProductBySkuQuery, ProductDto?>
{
    public async Task<ProductDto?> Handle(
        GetProductBySkuQuery query,
        CancellationToken ct)
    {
        const string sql = """
            SELECT id, sku, name, price, current_stock
            FROM ims.products
            WHERE sku = @SKU
            """;
        
        return await db.QuerySingleOrDefaultAsync<ProductDto>(
            sql,
            new { query.SKU }
        );
    }
}
```

---

## Error Handling

### Result Pattern (Preferred over Exceptions)

```csharp
// Result type
public record Result<T>
{
    public bool IsSuccess { get; init; }
    public T? Value { get; init; }
    public Error? Error { get; init; }
    
    public static Result<T> Success(T value) => new() { IsSuccess = true, Value = value };
    public static Result<T> Failure(Error error) => new() { Error = error };
}

public record Error(string Code, string Message);

// Usage
public async Task<Result<Product>> AdjustStockAsync(Guid productId, int quantity)
{
    var product = await _repository.FindByIdAsync(productId);
    if (product is null)
        return Result<Product>.Failure(new Error("NOT_FOUND", "Product not found"));
    
    if (product.CurrentStock + quantity < 0)
        return Result<Product>.Failure(new Error("INSUFFICIENT_STOCK", "Not enough stock"));
    
    product.AdjustStock(quantity);
    await _repository.UpdateAsync(product);
    
    return Result<Product>.Success(product);
}
```

### When to Use Exceptions

- Infrastructure failures (database connection lost)
- Unrecoverable errors
- Framework/library requirements

```csharp
// ✅ Good: Use for unrecoverable errors
public async Task<Product> GetByIdAsync(Guid id)
{
    var product = await _repository.FindByIdAsync(id);
    return product ?? throw new NotFoundException($"Product {id} not found");
}

// ❌ Bad: Don't use for business logic validation
public void AdjustStock(int quantity)
{
    if (CurrentStock + quantity < 0)
        throw new InvalidOperationException("Insufficient stock");  // BAD!
}
```

---

## Logging Standards

### Structured Logging with Serilog

```csharp
// ✅ Good: Structured logging
_logger.LogInformation(
    "Stock adjusted for product {ProductId} from {OldStock} to {NewStock}",
    product.Id,
    oldStock,
    newStock
);

// ✅ Good: Log objects
_logger.LogInformation("Product created: {@Product}", product);

// ❌ Bad: String interpolation
_logger.LogInformation($"Stock adjusted for {product.Id}");  // Not structured!
```

### Log Levels

- **Trace**: Very detailed, development only
- **Debug**: Detailed diagnostic info
- **Information**: General flow of application
- **Warning**: Abnormal but expected (retry scenarios)
- **Error**: Error events (still functioning)
- **Critical**: System crashes, data loss

---

## Testing Standards

### Unit Test Structure (AAA Pattern)

```csharp
[Fact]
public async Task AdjustStock_WhenSufficientStock_ShouldUpdateQuantity()
{
    // Arrange
    var product = Product.Create(SKU.Create("TEST-001"), "Test", 10.0m, 100);
    var repository = Substitute.For<IProductRepository>();
    repository.FindByIdAsync(Arg.Any<Guid>()).Returns(product);
    var sut = new AdjustStockCommandHandler(repository);
    
    // Act
    var result = await sut.Handle(new AdjustStockCommand(product.Id, -10), default);
    
    // Assert
    result.IsSuccess.Should().BeTrue();
    product.CurrentStock.Should().Be(90);
}
```

### Test Naming

```
MethodName_StateUnderTest_ExpectedBehavior

Examples:
- AdjustStock_WhenInsufficientStock_ShouldReturnError
- CreateProduct_WithValidData_ShouldPublishProductCreatedEvent
- GetByKey_WhenProductNotFound_ShouldReturnNull
```

---

## Documentation Standards

### XML Comments for Public APIs

```csharp
/// <summary>
/// Adjusts the stock quantity for a product.
/// </summary>
/// <param name="product Id">The unique identifier of the product.</param>
/// <param name="quantity">The quantity to adjust (positive for increase, negative for decrease).</param>
/// <param name="reason">The reason for the adjustment.</param>
/// <returns>A result indicating success or failure with error details.</returns>
/// <exception cref="ArgumentException">Thrown when quantity would result in negative stock.</exception>
public async Task<Result<Product>> AdjustStockAsync(
    Guid productId,
    int quantity,
    string reason)
{
    // Implementation
}
```

---

## Code Review Checklist

Before submitting code, ensure:

- [ ] All new code has unit tests (min 80% coverage)
- [ ] Public APIs have XML documentation
- [ ] Used async/await for I/O operations
- [ ] Passed CancellationToken to async methods
- [ ] Used Result pattern for business logic errors
- [ ] Added structured logging at appropriate levels
- [ ] Used nullable reference types
- [ ] No compiler warnings
- [ ] Code formatted (dotnet format)
- [ ] No hard-coded values (use configuration)

---

**Version**: 1.0  
**Last Updated**: January 9, 2026
