# Minimum Compatibility Contract (MCC)

All modules in MonoPod MUST comply with these requirements to ensure consistency, security, and operational excellence.

## 1. API Contract ✅

### OpenAPI Specification

**Requirement**: Provide OpenAPI v3 specification

**Implementation**:

- Generate from code annotations OR provide `openapi.yaml`
- Document all endpoints, request/response schemas, error codes
- Include examples for complex operations

**Example** (.NET with Swashbuckle):

```csharp
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "IMS API",
        Version = "v1",
        Description = "Inventory Management System API"
    });
});
```

### API Versioning

**Requirement**: Version all public APIs

**Pattern**: `/api/{module}/v{version}/{resource}`

**Examples**:

- `/api/ims/v1/products`
- `/api/billing/v2/invoices`

### Standard Error Model

**Requirement**: Consistent error responses across all modules

**Schema**:

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Human-readable error message",
    "traceId": "00-abc123def456...",
    "details": [
      {
        "field": "name",
        "message": "Product name is required"
      }
    ]
  }
}
```

**HTTP Status Codes**:

- `400`: Bad Request (validation errors)
- `401`: Unauthorized (missing/invalid token)
- `403`: Forbidden (insufficient permissions)
- `404`: Not Found
- `409`: Conflict (duplicate resource)
- `500`: Internal Server Error

### Authentication

**Requirement**: Accept and validate JWT tokens from Identity service

**Headers**:

```
Authorization: Bearer {JWT_TOKEN}
```

**Claims to Extract**:

- `sub`: User ID
- `tenant_id`: Tenant ID
- `roles`: User roles

**Enforcement**: ALL endpoints except `/health` and `/openapi.json` require authentication

---

## 2. Event Contract (Recommended) 📡

### Event Naming Convention

**Pattern**: `{module}.{entity}.{action}`

**Examples**:

- `ims.product.created`
- `ims.stock.adjusted`
- `billing.invoice.paid`
- `booking.appointment.cancelled`

### Event Schema

**Requirement**: Structured event format with metadata

**Schema**:

```json
{
  "eventId": "uuid-v4",
  "eventType": "ims.product.created",
  "timestamp": "2026-01-10T03:00:00Z",
  "tenantId": "tenant-123",
  "userId": "user-456",
  "data": {
    "productId": "prod-789",
    "name": "Laptop",
    "price": 999.00
  },
  "metadata": {
    "traceId": "00-abc...",
    "source": "ims-api-v1",
    "version": "1.0"
  }
}
```

### JSON Schema Validation

**Requirement**: Provide JSON Schema for all published events

**Location**: `docs/api/event-schemas/{event-type}.json`

**Example**: `docs/api/event-schemas/ims.product.created.json`

---

## 3. Observability 📊

### Structured Logging

**Requirement**: JSON-formatted logs with standard fields

**Minimum Fields**:

- `timestamp`: ISO 8601 format
- `level`: DEBUG/INFO/WARN/ERROR
- `message`: Log message
- `traceId`: OpenTelemetry trace ID
- `tenantId`: Current tenant (if applicable)
- `userId`: Current user (if applicable)

**Example** (.NET with Serilog):

```csharp
Log.Information("Product created: {ProductId} by {UserId}", productId, userId);
```

**Output**:

```json
{
  "timestamp": "2026-01-10T03:45:00Z",
  "level": "Information",
  "message": "Product created: prod-123 by user-456",
  "traceId": "00-abc...",
  "tenantId": "tenant-789",
  "userId": "user-456",
  "productId": "prod-123"
}
```

**PII Redaction**: Sensitive data (emails, passwords, tokens) MUST be redacted

### Metrics Endpoint

**Requirement**: Expose Prometheus-compatible metrics

**Endpoint**: `/metrics`

**Minimum Metrics**:

- Request count (by endpoint, status code)
- Request duration (histogram)
- Error rate
- Active connections

**Example** (.NET with prometheus-net):

```csharp
app.UseMetricServer(); // Exposes /metrics
app.UseHttpMetrics();  // Tracks HTTP metrics
```

### Trace Correlation

**Requirement**: Propagate OpenTelemetry Trace ID

**Implementation**:

- Extract `traceparent` header from incoming requests
- Log trace ID in all log entries
- Pass trace ID to downstream services

**Header**:

```
traceparent: 00-0af7651916cd43dd8448eb211c80319c-b7ad6b7169203331-01
```

---

## 4. Security & Governance 🔒

### Secrets Management

**Requirement**: NO secrets in code or repository

**Allowed**:

- Environment variables
- Azure Key Vault / HashiCorp Vault
- Kubernetes secrets (External Secrets Operator)

**Forbidden**:

- Hardcoded connection strings
- API keys in `appsettings.json`
- Passwords in code

**Validation**: CI/CD pipeline MUST scan for secrets (git-secrets, TruffleHog)

### Dependency Scanning

**Requirement**: Automated vulnerability scanning

**Tools**: Dependabot, Trivy, Snyk, Semgrep

**Frequency**: Daily on `main` branch, on every PR

**Policy**: NO critical/high vulnerabilities in production

**CI Example** (GitHub Actions):

```yaml
- name: Run Trivy
  uses: aquasecurity/trivy-action@master
  with:
    scan-type: 'fs'
    severity: 'CRITICAL,HIGH'
    exit-code: '1'  # Fail build on findings
```

### RBAC Roles

**Requirement**: Implement role-based access control

**Minimum Roles**:

- `Admin`: Full access to all resources
- `Manager`: Read/write within tenant
- `Viewer`: Read-only access

**Implementation** (.NET example):

```csharp
[Authorize(Roles = "Admin,Manager")]
public async Task<IActionResult> CreateProduct(...)

[Authorize(Roles = "Admin,Manager,Viewer")]
public async Task<IActionResult> GetProduct(...)
```

**Claims-based**: Fine-grained permissions beyond roles

---

## 5. Testing 🧪

**Requirement**: At least TWO types of tests

### Option 1: Unit + Integration

**Unit Tests**:

- Test domain logic
- Mock external dependencies
- Target: >80% coverage on business logic

**Integration Tests**:

- Test API endpoints with real database (TestContainers)
- Validate OpenAPI contract
- Test authentication/authorization

### Option 2: Component + E2E

**Component Tests**:

- Test module in isolation with mocked dependencies

**E2E Tests**:

- Test full user workflows across modules

### Test Requirements

**Naming**: Clear test names (Arrange-Act-Assert pattern)

**Example** (.NET):

```csharp
[Fact]
public async Task CreateProduct_WithValidData_ShouldReturnCreatedProduct()
{
    // Arrange
    var product = new CreateProductCommand("Laptop", 999);
    
    // Act
    var result = await _handler.Handle(product);
    
    // Assert
    Assert.True(result.IsSuccess);
    Assert.NotNull(result.Value.ProductId);
}
```

**CI Integration**: Tests MUST run in CI/CD pipeline

---

## 6. Delivery 🚢

### Dockerfile

**Requirement**: Multi-stage Dockerfile for optimized images

**Requirements**:

- Use official base images (Alpine, Distroless)
- Non-root user
- Health check
- Security scanning pass

**Example** (.NET):

```dockerfile
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine
WORKDIR /app
COPY --from=build /app .
USER $APP_UID
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget -qO- http://localhost:8080/health || exit 1
ENTRYPOINT ["dotnet", "IMS.API.dll"]
```

### One-Command Run

**Requirement**: Developers can run the module with a single command

**Preferred**: `docker-compose.yml` in module directory

**Example**:

```yaml
services:
  ims:
    build: .
    ports:
      - "5001:80"
    environment:
      - DATABASE_URL=postgresql://user:pass@postgres:5432/ims
    depends_on:
      - postgres
  postgres:
    image: postgres:15-alpine
    environment:
      - POSTGRES_PASSWORD=password
```

**Command**: `docker-compose up -d`

### Release Notes

**Requirement**: Maintain `CHANGELOG.md`

**Format**: [Keep a Changelog](https://keepachangelog.com/)

**Example**:

```markdown
## [1.2.0] - 2026-01-10

### Added
- AI demand forecasting endpoint
- Low-stock auto-reorder workflow

### Fixed
- Stock adjustment transaction race condition

### Changed
- Upgraded to .NET 8.0.1
```

---

## 7. Documentation 📖

### Module README

**Requirement**: README.md with quick start guide

**Sections**:

1. Title and description
2. Features
3. Quick start (docker-compose up)
4. API endpoints (table)
5. Configuration (environment variables)
6. Testing
7. Dependencies

### Architecture Decision Records (ADRs)

**Requirement**: Document significant design decisions

**Location**: `docs/adr/`

**Template**: `docs/adr/template.md`

**Example**: `docs/adr/001-use-outbox-pattern.md`

### Runbook

**Requirement**: Operational procedures

**Location**: `docs/runbook.md`

**Sections**:

- How to run locally
- How to deploy
- Common issues and solutions
- Monitoring and alerting
- Incident response

---

## MCC Compliance Checklist

Before merging to `main`, verify:

- [ ] **API**: OpenAPI spec provided, versioned endpoints, standard error model
- [ ] **Events**: Event naming follows convention, JSON schemas provided
- [ ] **Logs**: Structured JSON logs with traceId, PII redacted
- [ ] **Metrics**: `/metrics` endpoint exposed with HTTP metrics
- [ ] **Traces**: OpenTelemetry trace ID propagated
- [ ] **Secrets**: No secrets in code, externalized to env vars/vault
- [ ] **Scanning**: SAST + dependency scan passing in CI
- [ ] **RBAC**: Roles implemented (Admin, Manager, Viewer)
- [ ] **Tests**: Unit + Integration tests (or Component + E2E)
- [ ] **Docker**: Dockerfile with health check, non-root user
- [ ] **Compose**: `docker-compose.yml` for one-command run
- [ ] **Changelog**: `CHANGELOG.md` updated
- [ ] **README**: Module README with quick start
- [ ] **ADRs**: Significant decisions documented
- [ ] **Runbook**: Operational procedures documented

---

## Enforcement

**Pull Request Template**: `.github/pull_request_template.md` includes MCC checklist

**CI/CD**: Automated checks for:

- OpenAPI spec generation
- Test coverage threshold
- Security scans
- Docker image build
- Health check validation

**Code Review**: Reviewers verify MCC compliance before approval

---

**Last Updated**: 2026-01-10  
**Version**: 1.0
