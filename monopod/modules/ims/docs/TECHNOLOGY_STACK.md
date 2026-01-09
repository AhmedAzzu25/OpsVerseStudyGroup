# IMS - Technology Stack Specification

## Overview

This document details the complete technology stack for the IMS (Inventory Management System) module.

---

## Backend Stack

### Runtime & Framework

| Technology | Version | Purpose |
|------------|---------|---------|
| **.NET** | 8.0 LTS | Application runtime |
| **C#** | 12 | Programming language |
| **ASP.NET Core** | 8.0 | Web API framework |

**Why .NET 8?**

- Long-term support (LTS) until November 2026
- Excellent performance (minimal GC pauses)
- Native AOT compilation support
- Modern C# 12 features
- Cross-platform (Linux containers)

---

### Core Libraries

#### Application Framework

```xml
<PackageReference Include="MediatR" Version="12.2.0" />
<PackageReference Include="FluentValidation" Version="11.9.0" />
<PackageReference Include="Mapster" Version="7.4.0" />
```

- **MediatR**: CQRS pattern implementation
- **FluentValidation**: Input validation
- **Mapster**: Object-to-object mapping (faster than AutoMapper)

#### Data Access

```xml
<PackageReference Include="Microsoft.EntityFrameworkCore" Version="8.0.0" />
<PackageReference Include="Npgsql.EntityFrameworkCore.PostgreSQL" Version="8.0.0" />
<PackageReference Include="Dapper" Version="2.1.24" />
```

- **Entity Framework Core**: Write operations, change tracking
- **Dapper**: Read operations (queries), high performance
- **Npgsql**: PostgreSQL provider

#### Messaging

```xml
<PackageReference Include="RabbitMQ.Client" Version="6.8.1" />
<PackageReference Include="MassTransit" Version="8.1.3" />
<PackageReference Include="MassTransit.RabbitMQ" Version="8.1.3" />
```

- **MassTransit**: Message bus abstraction
- **RabbitMQ.Client**: Direct RabbitMQ integration

#### Caching

```xml
<PackageReference Include="StackExchange.Redis" Version="2.7.10" />
<PackageReference Include="Microsoft.Extensions.Caching.StackExchangeRedis" Version="8.0.0" />
```

#### Logging & Monitoring

```xml
<PackageReference Include="Serilog.AspNetCore" Version="8.0.0" />
<PackageReference Include="Serilog.Sinks.Console" Version="5.0.1" />
<PackageReference Include="Serilog.Sinks.Seq" Version="7.0.0" />
<PackageReference Include="OpenTelemetry.Exporter.OpenTelemetryProtocol" Version="1.7.0" />
<PackageReference Include="OpenTelemetry.Instrumentation.AspNetCore" Version="1.7.0" />
```

- **Serilog**: Structured logging
- **OpenTelemetry**: Distributed tracing

#### Resilience

```xml
<PackageReference Include="Polly" Version="8.2.0" />
<PackageReference Include="Polly.Extensions.Http" Version="3.0.0" />
```

- **Polly**: Retry, circuit breaker, timeout policies

---

## Database

### Primary Database

| Technology | Version | Purpose |
|------------|---------|---------|
| **PostgreSQL** | 16 | Transactional data store |

**Configuration**:

```json
{
  "ConnectionStrings": {
    "Default": "Host=localhost;Database=ims;Username=ims_user;Password=***;Pooling=true;MinPoolSize=5;MaxPoolSize=50"
  }
}
```

**Schema Design**:

- Schema: `ims`
- Collation: `en_US.UTF-8`
- Timezone: UTC
- Features used: JSONB, Indexes, Partitioning

**Extensions Required**:

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";  -- UUID generation
CREATE EXTENSION IF NOT EXISTS "pg_trgm";    -- Fuzzy text search
```

---

## Message Broker

### RabbitMQ

| Component | Version | Purpose |
|-----------|---------|---------|
| **RabbitMQ** | 3.12 | Event messaging |
| **Management Plugin** | 3.12 | Web UI for monitoring |

**Exchange Configuration**:

```
Exchange: ims.events (type: topic)
Queues:
  - ims.stock.notifications (routing: stock.*)
  - ims.stock.reorder (routing: stock.low)
  - ims.audit.events (routing: #)
  - ims.dlq (dead letter queue)
```

**Connection Settings**:

```json
{
  "RabbitMQ": {
    "Host": "localhost",
    "Port": 5672,
    "Username": "ims_user",
    "Password": "***",
    "VirtualHost": "/",
    "PrefetchCount": 10,
    "RetryCount": 3
  }
}
```

---

## Caching Layer

### Redis

| Component | Version | Purpose |
|-----------|---------|---------|
| **Redis** | 7.2 | Distributed cache |

**Usage**:

- Product details cache (TTL: 10 minutes)
- Stock levels cache (TTL: 1 minute)
- Distributed locks for critical sections
- Pub/Sub for cache invalidation

**Configuration**:

```json
{
  "Redis": {
    "Configuration": "localhost:6379",
    "InstanceName": "IMS:",
    "AbortOnConnectFail": false,
    "ConnectRetry": 3
  }
}
```

---

## API Documentation

### Swagger/OpenAPI

```xml
<PackageReference Include="Swashbuckle.AspNetCore" Version="6.5.0" />
<PackageReference Include="Swashbuckle.AspNetCore.Annotations" Version="6.5.0" />
```

**Configuration**:

```csharp
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "IMS API",
        Version = "v1",
        Description = "Inventory Management System API"
    });
    
    // Include XML comments
    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    options.IncludeXmlComments(xmlPath);
});
```

---

## Testing Stack

### Unit Testing

```xml
<PackageReference Include="xUnit" Version="2.6.4" />
<PackageReference Include="xUnit.runner.visualstudio" Version="2.5.6" />
<PackageReference Include="FluentAssertions" Version="6.12.0" />
<PackageReference Include="NSubstitute" Version="5.1.0" />
```

### Integration Testing

```xml
<PackageReference Include="Microsoft.AspNetCore.Mvc.Testing" Version="8.0.0" />
<PackageReference Include="Testcontainers.PostgreSql" Version="3.6.0" />
<PackageReference Include="Testcontainers.RabbitMQ" Version="3.6.0" />
<PackageReference Include="Testcontainers.Redis" Version="3.6.0" />
```

- **Testcontainers**: Spin up real databases for integration tests

---

## DevOps & Deployment

### Containerization

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["IMS.API/IMS.API.csproj", "IMS.API/"]
RUN dotnet restore
COPY . .
RUN dotnet build -c Release -o /app/build

FROM build AS publish
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "IMS.API.dll"]
```

### Kubernetes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ims-api
spec:
  replicas: 3
  selector:
    matchLabels:
      app: ims-api
  template:
    metadata:
      labels:
        app: ims-api
    spec:
      containers:
      - name: ims-api
        image: ims-api:latest
        ports:
        - containerPort: 8080
        env:
        - name: ASPNETCORE_ENVIRONMENT
          value: "Production"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
```

---

## Monitoring & Observability

### Application Performance Monitoring

| Tool | Purpose |
|------|---------|
| **Application Insights** | Azure APM, telemetry |
| **Seq** | Centralized log aggregation |
| **Grafana** | Metrics dashboards |
| **Prometheus** | Metrics collection |

### Health Checks

```csharp
builder.Services.AddHealthChecks()
    .AddNpgSql(connectionString, name: "database")
    .AddRabbitMQ(rabbitConnectionString, name: "rabbitmq")
    .AddRedis(redisConnectionString, name: "redis");
```

---

## Development Tools

### IDEs & Editors

- **Visual Studio 2022** (primary)
- **Visual Studio Code** (lightweight)
- **JetBrains Rider** (alternative)

### Extensions Required

- C# Dev Kit (VS Code)
- GitHub Copilot
- ReSharper / Roslyn Analyzers

### CLI Tools

```bash
# .NET CLI
dotnet --version  # Should be 8.0+

# EF Core tools
dotnet tool install --global dotnet-ef

# Code formatting
dotnet tool install --global dotnet-format
```

---

## Configuration Management

### appsettings.json Structure

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning"
    }
  },
  "ConnectionStrings": {
    "Default": "Host=localhost;Database=ims;..."
  },
  "RabbitMQ": { /* ... */ },
  "Redis": { /* ... */ },
  "OutboxProcessor": {
    "IntervalSeconds": 5,
    "BatchSize": 100
  }
}
```

### Environment Variables (Production)

```bash
ASPNETCORE_ENVIRONMENT=Production
ConnectionStrings__Default=*** (from Key Vault)
RabbitMQ__Password=*** (from Key Vault)
Redis__Configuration=*** (from Key Vault)
```

---

## Security Stack

### Authentication

```xml
<PackageReference Include="Microsoft.AspNetCore.Authentication.JwtBearer" Version="8.0.0" />
<PackageReference Include="Azure.Identity" Version="1.10.4" />
<PackageReference Include="Azure.Security.KeyVault.Secrets" Version="4.5.0" />
```

### Encryption

- **TLS 1.3** for all communications
- **Azure Key Vault** for secrets management
- **Data Protection API** for sensitive data at rest

---

## Package Management

### NuGet Feed

```xml
<!-- nuget.config -->
<packageSources>
  <add key="nuget.org" value="https://api.nuget.org/v3/index.json" />
  <add key="azure-artifacts" value="https://pkgs.dev.azure.com/..." />
</packageSources>
```

### Version Policy

- Use **floating versions** for development dependencies
- **Pin exact versions** for production dependencies
- Review and update quarterly

---

## Performance Benchmarks

### Expected Performance

| Metric | Target |
|--------|--------|
| API Response Time (P95) | < 100ms |
| Database Query Time (P95) | < 50ms |
| Event Publishing Lag | < 1s |
| Throughput | 1000 req/s per instance |
| Memory Usage | < 512 MB per instance |

---

**Document Version**: 1.0  
**Last Updated**: January 9, 2026  
**Maintained By**: OpsVerse DevOps Team
