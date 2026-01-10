# IMS - Intelligent Inventory Management System

**Status**: ✅ Reference Implementation (Fully Functional)

## Overview

IMS is a production-ready inventory management system featuring:

- Product catalog management
- Multi-warehouse stock tracking  
- Sales order processing
- AI-powered demand forecasting
- Low-stock alerts with automation
- Event-driven architecture (Outbox pattern)

**Tech Stack**: .NET 8, PostgreSQL, RabbitMQ, Redis, Docker

---

## Quick Start

### Prerequisites

- Docker & Docker Compose
- .NET 8 SDK (for local development)
- Git

### Run with Docker

```bash
cd modules/ims
docker-compose up -d
```

Access:

- **API**: <http://localhost:5001>
- **Swagger UI**: <http://localhost:5001/swagger>
- **Health**: <http://localhost:5001/health>

### Run Locally (Development)

```bash
cd modules/ims/src/IMS.API
dotnet run
```

---

## Features

### Product Management

- Create, read, update, delete products
- SKU-based identification
- Price management
- Category organization

### Stock Management

- Multi-warehouse support
- Stock adjustments (in/out)
- Real-time stock levels
- Audit trail for all movements

### Sales Processing

- Record sales orders
- Automatic stock deduction
- Sales analytics

### AI Features

- **Demand Forecasting**: Predict future demand based on historical sales
- **Auto-Reorder**: Suggest purchase orders when stock is low
- **Anomaly Detection**: Flag unusual stock movements

### Alerts & Automation

- Low-stock threshold alerts
- Event publishing for automation (n8n workflows)
- Email/SMS notifications (via Notifications service)

---

## API Endpoints

### Products

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/ims/v1/products` | List all products (paginated) |
| GET | `/api/ims/v1/products/{id}` | Get product by ID |
| POST | `/api/ims/v1/products` | Create new product |
| PUT | `/api/ims/v1/products/{id}` | Update product |
| DELETE | `/api/ims/v1/products/{id}` | Delete product |

### Stock

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/ims/v1/stock` | Get stock levels |
| POST | `/api/ims/v1/stock/adjust` | Adjust stock (in/out) |
| GET | `/api/ims/v1/stock/low` | Get low-stock items |

### Sales

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/ims/v1/sales` | Record a sale |
| GET | `/api/ims/v1/sales` | List sales (paginated) |

### AI

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/ims/v1/ai/forecast` | Get demand forecast |
| POST | `/api/ims/v1/ai/reorder` | Get reorder suggestions |

### Warehouses

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/ims/v1/warehouses` | List warehouses |
| POST | `/api/ims/v1/warehouses` | Create warehouse |

---

## Configuration

Environment variables:

```env
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/ims
  
# Redis
REDIS_URL=redis://localhost:6379

# RabbitMQ
RABBITMQ_URL=amqp://guest:guest@localhost:5672

# Identity Service
IDENTITY_AUTHORITY=http://localhost:5000/identity
IDENTITY_AUDIENCE=ims-api

# AI (Azure OpenAI)
AZURE_OPENAI_ENDPOINT=https://your-openai.openai.azure.com
AZURE_OPENAI_KEY=your-key
AZURE_OPENAI_DEPLOYMENT=gpt-4

# Feature Flags
LOW_STOCK_THRESHOLD=10
ENABLE_AI_FORECASTING=true
```

---

## Architecture

### Domain-Driven Design

**Aggregates**:

- `Product`: Product catalog entity
- `Warehouse`: Storage location
- `StockMovement`: Stock in/out transactions
- `Sale`: Sales order

**Value Objects**:

- `Money`: Price with currency
- `SKU`: Stock keeping unit identifier
- `Quantity`: Amount with unit of measure

**Domain Events**:

- `ProductCreated`
- `StockAdjusted`
- `LowStockDetected`
- `SaleRecorded`

### CQRS Pattern

**Commands** (write operations):

```csharp
CreateProductCommand
UpdateProductCommand
AdjustStockCommand
RecordSaleCommand
```

**Queries** (read operations):

```csharp
GetProductQuery
ListProductsQuery
GetStockLevelsQuery
```

### Outbox Pattern

Reliable event publishing:

```
1. Business transaction (e.g., create product)
2. Write event to outbox_events table (same DB transaction)
3. Background job publishes events to RabbitMQ
4. Mark as published
```

---

## Testing

### Run All Tests

```bash
cd tests/IMS.Tests
dotnet test
```

### Test Coverage

- **Unit Tests**: Domain logic, business rules
- **Integration Tests**: API endpoints, database operations
- **E2E Tests**: Full workflows with TestContainers

**Coverage**: >85% on critical paths

---

## Events Published

| Event | Trigger | Payload |
|-------|---------|---------|
| `ims.product.created` | New product added | `{productId, name, sku, price}` |
| `ims.product.updated` | Product modified | `{productId, changes}` |
| `ims.stock.adjusted` | Stock in/out | `{productId, warehouseId, quantity, newLevel}` |
| `ims.stock.low_threshold` | Stock below threshold | `{productId, currentStock, threshold}` |
| `ims.sale.recorded` | Sale processed | `{saleId, items, totalAmount}` |

---

## Dependencies

- ASP.NET Core 8.0
- Entity Framework Core 8.0
- PostgreSQL 15+
- RabbitMQ 3.12+
- Redis 7+
- MediatR (CQRS)
- FluentValidation
- Serilog (structured logging)
- Hangfire (background jobs)
- Swashbuckle (OpenAPI)

---

## Security

- **Authentication**: JWT tokens from Identity service
- **Authorization**: Role-based (Admin, InventoryManager, Viewer)
- **Tenant Isolation**: Automatic filtering by TenantId
- **Input Validation**: FluentValidation on all commands
- **SQL Injection**: Parameterized queries via EF Core

---

## Observability

### Logging

- **Format**: Structured JSON (Serilog)
- **Destination**: Console + File + Loki (via docker-compose)
- **Correlation**: TraceId in all logs

### Metrics

- **Endpoint**: `/metrics` (Prometheus format)
- **Metrics**: Request count, duration, error rate
- **Dashboards**: Grafana (see `docs/grafana-dashboard.json`)

### Health Checks

- **Endpoint**: `/health`
- **Checks**: Database, Redis, RabbitMQ
- **Format**: Standard Health Checks API

---

## Deployment

### Docker

```bash
docker build -t ims-api:latest .
docker run -p 5001:80 ims-api:latest
```

### Kubernetes

```bash
kubectl apply -f k8s/
```

See `docs/deployment.md` for details.

---

## Documentation

- **Architecture**: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
- **ADRs**: [docs/adr/](docs/adr/)
- **API Spec**: [docs/openapi.yaml](docs/openapi.yaml)
- **Runbook**: [docs/runbook.md](docs/runbook.md)

---

## MCC Compliance ✅

- [x] API Contract: OpenAPI spec
- [x] Event Contract: Event schemas
- [x] Observability: Logs, metrics, traces
- [x] Security: JWT auth, RBAC, secrets externalized
- [x] Testing: Unit + Integration tests
- [x] Delivery: Dockerfile, docker-compose
- [x] Documentation: README, ADRs, runbook

---

## Roadmap

### Current (v1.0)

- ✅ Product CRUD
- ✅ Stock management
- ✅ Basic AI forecasting
- ✅ Event publishing

### Next (v1.1)

- Purchase order management
- Supplier management
- Advanced AI (price optimization)
- Multi-currency support

---

**Version**: 1.0.0  
**Last Updated**: 2026-01-10  
**Maintainer**: MonoPod Team
