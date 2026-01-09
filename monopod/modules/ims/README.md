# IMS Module - README

## 🏗️ Inventory Management System (IMS)

Event-driven microservice for real-time inventory tracking across multiple warehouses.

---

## 📋 Quick Links

### Documentation

- [Architecture & Design](docs/ARCHITECTURE.md) - System design, diagrams, domain model
- [Coding Standards](docs/CODING_STANDARDS.md) - C# style guide, patterns, best practices
- [Technology Stack](docs/TECHNOLOGY_STACK.md) - Complete tech stack specification
- [Security Checklist](docs/SECURITY_CHECKLIST.md) - Security guidelines and compliance

### GitHub Copilot

- [Copilot Instructions](.github/copilot-instructions.md) - AI assistant guidelines for this project

---

## 🚀 Getting Started

### Prerequisites

- .NET 8 SDK
- Docker Desktop
- PostgreSQL 16
- RabbitMQ 3.12
- Redis 7.2

### Quick Start

```bash
# Clone repository
git clone https://github.com/OpsVerse/StudyGroup.git
cd monopod/modules/ims

# Start dependencies (Docker)
docker-compose up -d

# Restore packages
dotnet restore

# Run migrations
dotnet ef database update

# Run application
dotnet run --project src/IMS.API

# Access Swagger UI
open http://localhost:5000/swagger
```

---

## 🎯 Key Features

- ✅ Real-time inventory tracking
- ✅ Event-driven architecture (Outbox pattern)
- ✅ Multi-warehouse support
- ✅ Low-stock alerts
- ✅ Barcode scanning integration
- ✅ Audit trail for all movements
- ✅ Multi-tenant support

---

## 🏗️ Project Structure

```
ims/
├── .github/
│   └── copilot-instructions.md
├── docs/
│   ├── ARCHITECTURE.md
│   ├── CODING_STANDARDS.md
│   ├── TECHNOLOGY_STACK.md
│   └── SECURITY_CHECKLIST.md
├── src/
│   ├── IMS.API/
│   ├── IMS.Application/
│   ├── IMS.Domain/
│   └── IMS.Infrastructure/
├── tests/
│   ├── IMS.UnitTests/
│   └── IMS.IntegrationTests/
├── docker-compose.yml
└── README.md
```

---

## 📚 Related Certifications

This module aligns with:

- ✅ AZ-  204 (Azure Developer) - Event-driven patterns, messaging
- ✅ AZ-400 (DevOps Engineer) - CI/CD, testing, monitoring
- ✅ AZ-305 (Solutions Architect) - Microservices architecture

See: [Certification Roadmap](../../../docs/certifications/ROADMAP.md)

---

## 🤝 Contributing

1. Read [Coding Standards](docs/CODING_STANDARDS.md)
2. Create feature branch
3. Write tests
4. Submit PR with 2 reviewers

---

**Status**: 🏗️ Ready for Development  
**Maintainer**: OpsVerse Team  
**Last Updated**: January 9, 2026
