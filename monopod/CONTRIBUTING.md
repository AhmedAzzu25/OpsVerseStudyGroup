# Contributing to MonoPod

Thank you for your interest in contributing to MonoPod! This document provides guidelines and standards for development.

## 📋 Table of Contents

- [Minimum Compatibility Contract (MCC)](#minimum-compatibility-contract-mcc)
- [Development Workflow](#development-workflow)
- [Code Standards](#code-standards)
- [Testing Requirements](#testing-requirements)
- [Documentation Standards](#documentation-standards)
- [PR Process](#pr-process)
- [Module Development](#module-development)

## 🎯 Minimum Compatibility Contract (MCC)

All modules MUST implement these requirements:

### 1. API Contract

✅ **OpenAPI/Swagger Specification**

- Provide `openapi.yaml` or generate from code
- API versioning (e.g., `/api/modulename/v1/`)
- Standard error response model:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Product name is required",
    "traceId": "00-abc123...",
    "details": []
  }
}
```

✅ **Authentication**

- Accept JWT tokens from Identity service
- Validate token signature
- Extract tenant ID from claims

### 2. Event Contract (Recommended)

✅ **Event Naming Convention**

```
{module}.{entity}.{action}
Examples:
  ims.product.created
  booking.appointment.cancelled
  billing.invoice.paid
```

✅ **Event Schema**

- Use JSON Schema for validation
- Include metadata: `eventId`, `timestamp`, `tenantId`, `userId`
- Store schemas in `docs/api/event-schemas/`

### 3. Observability

✅ **Structured Logging**

- Use JSON format
- Include: `timestamp`, `level`, `message`, `traceId`, `tenantId`
- Sensitive data must be redacted

Example (.NET):

```csharp
_logger.LogInformation("Product created: {ProductId} by {UserId}", productId, userId);
```

✅ **Metrics Endpoint**

- Expose Prometheus-compatible metrics at `/metrics`
- Include: request count, duration, error rate
- Module-specific business metrics

✅ **Trace Correlation**

- Propagate `TraceId` from incoming requests
- Use OpenTelemetry standards
- Log trace ID in all log entries

### 4. Security & Governance

✅ **Secrets Management**

- NO secrets in code or repository
- Use environment variables or Key Vault
- Validate in CI/CD

✅ **Dependency Scanning**

- Run SAST in CI (Semgrep, SonarQube)
- Dependency vulnerability scanning (Trivy, Dependabot)
- No critical/high vulnerabilities in production

✅ **RBAC Roles**

- Minimum roles: `Admin`, `Manager`, `Viewer`
- Fine-grained permissions per module
- Implement authorization policies

### 5. Testing

Minimum TWO types of tests:

✅ **Unit Tests** OR **Component Tests**

- Test domain logic
- Mock external dependencies
- >80% code coverage for critical paths

✅ **Integration Tests** OR **E2E Tests**

- Test API contracts
- Use TestContainers for databases
- Validate OpenAPI spec compliance

### 6. Delivery

✅ **Dockerfile**

- Multi-stage build (optimize size)
- Non-root user
- Health check endpoint

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:8080/health || exit 1
```

✅ **One-Command Run**

- Provide `docker-compose.yml` for module + dependencies
- Document in module README

✅ **Release Notes**

- Maintain `CHANGELOG.md`
- Follow [Keep a Changelog](https://keepachangelog.com/) format

### 7. Documentation

✅ **Module README**

- Quick start
- API endpoints
- Configuration
- Dependencies

✅ **Architecture Decision Records (ADRs)**

- Document significant decisions
- Use template in `/docs/adr/template.md`

✅ **Runbook**

- How to run locally
- Common issues & solutions
- Operational procedures

---

## 🔄 Development Workflow

### 1. Fork & Clone

```bash
git clone https://github.com/AhmedAzzu25/OpsVerseStudyGroup.git
cd OpsVerseStudyGroup/monopod
```

### 2. Create Feature Branch

```bash
git checkout -b feature/module-name-feature-description
```

Branch naming:

- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation only
- `refactor/` - Code refactoring
- `test/` - Test additions

### 3. Develop

Follow MCC requirements and code standards for your tech stack.

### 4. Test Locally

```bash
# Run unit tests
cd modules/your-module
dotnet test  # or npm test, pytest, etc.

# Run with docker-compose
docker-compose up -d
curl http://localhost:PORT/health
```

### 5. Commit

Use conventional commits:

```bash
git commit -m "feat(ims): add demand forecasting AI endpoint"
git commit -m "fix(billing): correct VAT calculation for Gulf region"
git commit -m "docs(crm): update API examples in README"
```

Format: `type(scope): description`

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

### 6. Push & Open PR

```bash
git push origin feature/module-name-feature-description
```

Open PR on GitHub with:

- Clear title and description
- Link to related issues
- Screenshots/demos if UI changes
- Checklist of MCC requirements met

---

## 🎨 Code Standards

### .NET (Profile A)

**Style**: Follow [C# Coding Conventions](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/coding-style/coding-conventions)

**Key Points**:

- Use C# 12 features (primary constructors, collection expressions)
- Nullable reference types enabled
- Async/await for I/O operations
- Result pattern for error handling (avoid exceptions for flow control)
- CQRS pattern: separate Commands and Queries

**Example**:

```csharp
public record CreateProductCommand(string Name, decimal Price);

public class CreateProductHandler(IProductRepository repository)
{
    public async Task<Result<ProductId>> Handle(CreateProductCommand command)
    {
        if (string.IsNullOrWhiteSpace(command.Name))
            return Result<ProductId>.Failure("Product name is required");
        
        var product = Product.Create(command.Name, command.Price);
        await repository.AddAsync(product);
        
        return Result<ProductId>.Success(product.Id);
    }
}
```

### Node.js (Profile B)

**Style**: Follow [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)

**Key Points**:

- TypeScript strict mode
- Async/await over callbacks
- Dependency injection via NestJS
- DTOs for validation (class-validator)

**Example**:

```typescript
@Controller('products')
export class ProductsController {
  constructor(private readonly productsService: ProductsService) {}

  @Post()
  async create(@Body() createProductDto: CreateProductDto) {
    return this.productsService.create(createProductDto);
  }
}
```

### Python (Profile C)

**Style**: Follow [PEP 8](https://pep8.org/)

**Key Points**:

- Type hints
- Pydantic for validation
- Async endpoints (FastAPI)

**Example**:

```python
from pydantic import BaseModel
from fastapi import FastAPI, HTTPException

class ProductCreate(BaseModel):
    name: str
    price: float

@app.post("/products")
async def create_product(product: ProductCreate):
    if not product.name:
        raise HTTPException(status_code=400, detail="Name required")
    return {"id": "123", **product.dict()}
```

### Go (Profile D)

**Style**: Follow [Effective Go](https://go.dev/doc/effective_go)

**Key Points**:

- Error handling (not panic)
- Context propagation
- Struct-based handlers

---

## 🧪 Testing Requirements

### Unit Tests

Test pure business logic without external dependencies.

**Coverage**: Aim for >80% on critical paths

**Example (.NET)**:

```csharp
[Fact]
public void Product_Create_ShouldRequirePositivePrice()
{
    // Arrange & Act
    var result = Product.Create("Laptop", -100);
    
    // Assert
    Assert.True(result.IsFailure);
    Assert.Contains("Price must be positive", result.Error);
}
```

### Integration Tests

Test API with real dependencies (database, cache) using containers.

**Example (.NET with TestContainers)**:

```csharp
public class ProductsApiTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;
    
    [Fact]
    public async Task POST_Products_ShouldCreateProduct()
    {
        var response = await _client.PostAsJsonAsync("/api/ims/v1/products", 
            new { name = "Laptop", price = 999 });
        
        response.EnsureSuccessStatusCode();
        var product = await response.Content.ReadFromJsonAsync<ProductDto>();
        Assert.NotNull(product.Id);
    }
}
```

### E2E Tests

Validate OpenAPI contract compliance.

**Example (Schemathesis)**:

```python
import schemathesis

schema = schemathesis.from_uri("http://localhost:5001/openapi.json")

@schema.parametrize()
def test_api_contract(case):
    case.call_and_validate()
```

---

## 📝 Documentation Standards

### Module README Template

```markdown
# Module Name

Brief description.

## Features

- Feature 1
- Feature 2

## Quick Start

\`\`\`bash
docker-compose up -d
curl http://localhost:PORT/health
\`\`\`

## API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /api/module/v1/resources | List resources |
| POST | /api/module/v1/resources | Create resource |

## Configuration

| Variable | Description | Default |
|----------|-------------|---------|
| DATABASE_URL | Connection string | - |

## Testing

\`\`\`bash
dotnet test
\`\`\`

## Dependencies

- PostgreSQL 15+
- Redis 7+

## See Also

- [Architecture](docs/ARCHITECTURE.md)
- [Runbook](docs/runbook.md)
```

### ADR Template

See `/docs/adr/template.md`

---

## 🔍 PR Process

### PR Checklist

Before submitting, ensure:

- [ ] Code follows style guide for chosen tech stack
- [ ] MCC requirements met (API, events, observability, security, tests, delivery, docs)
- [ ] Tests pass locally
- [ ] Documentation updated (README, API specs, runbook if needed)
- [ ] No secrets committed
- [ ] Conventional commit messages used
- [ ] PR description explains what/why

### Code Review

Reviewers will check:

1. **Functionality**: Does it work as intended?
2. **MCC Compliance**: All requirements met?
3. **Code Quality**: Readable, maintainable, follows standards?
4. **Tests**: Adequate coverage?
5. **Security**: No vulnerabilities introduced?
6. **Documentation**: Clear and complete?

### Approval & Merge

- Require 1 approval for module changes
- Require 2 approvals for platform service or gateway changes
- CI/CD must pass (build, test, security scans)
- Squash merge to keep history clean

---

## 🧩 Module Development

### Creating a New Module

1. **Choose a scaffold** from existing modules (recommend `ims` as template)

```bash
cp -r modules/ims modules/your-module
```

1. **Implement MCC requirements**
   - Update `openapi.yaml`
   - Configure authentication
   - Add structured logging
   - Implement health check

2. **Add to docker-compose.yml**

```yaml
your-module:
  build: ./modules/your-module
  ports:
    - "5010:80"
  environment:
    - DATABASE_URL=${YOUR_MODULE_DB_URL}
  depends_on:
    - postgres
    - identity
```

1. **Register in API Gateway**

Add routes in `apps/gateway/appsettings.json` (YARP) or equivalent.

1. **Create CI/CD workflow**

Copy `.github/workflows/ims-ci.yml` and adapt.

1. **Document**
   - Update module README
   - Add ADRs for design decisions
   - Create runbook

---

## 🙋 Questions?

- Check existing [documentation](docs/)
- Search [GitHub Issues](https://github.com/AhmedAzzu25/OpsVerseStudyGroup/issues)
- Start a [Discussion](https://github.com/AhmedAzzu25/OpsVerseStudyGroup/discussions)

---

**Thank you for contributing to MonoPod!** 🎉
