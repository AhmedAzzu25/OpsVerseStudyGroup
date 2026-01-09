# OpsVerse Project Scaffolding Script
# This script creates the complete structure for all 7 remaining projects

# Project configurations
$projects = @(
    @{
        Name = "healthcare"
        Title = "Healthcare PWA"
        Description = "Progressive Web App for patient records with offline-first capabilities"
        Tech = "React, TypeScript, PouchDB, CouchDB, Service Workers"
        Domain = "Healthcare / Medical Records"
    },
    @{
        Name = "infra-guardian"
        Title = "Infra-Guardian"
        Description = "Self-healing infrastructure with Azure Policy and automated remediation"
        Tech = "Python, Azure Policy, Azure Functions, Terraform"
        Domain = "Infrastructure / DevOps"
    },
    @{
        Name = "gov-services"
        Title = "Government Services"
        Description = "Citizen services portal with Durable Functions workflow orchestration"
        Tech = ".NET 8, Azure Durable Functions, Cosmos DB, Azure AD B2C"
        Domain = "Government / Public Services"
    },
    @{
        Name = "fintech"
        Title = "Fintech Platform"
        Description = "Real-time fraud detection with Stream Analytics and Event Hubs"
        Tech = ".NET 8, Azure Stream Analytics, Event Hubs, Cosmos DB, ML.NET"
        Domain = "Financial Technology"
    },
    @{
        Name = "ops-agent"
        Title = "Ops-Agent (RAG AI)"
        Description = "DevOps AI assistant with Retrieval-Augmented Generation"
        Tech = "Python, Azure OpenAI, Azure Cognitive Search, LangChain, FastAPI"
        Domain = "AI / DevOps Automation"
    },
    @{
        Name = "charity"
        Title = "Charity Management"
        Description = "Transparent donation tracking with SQL Ledger and WhatsApp Bot"
        Tech = ".NET 8, SQL Ledger, Twilio WhatsApp API, Azure Functions"
        Domain = "Non-Profit / Charity"
    },
    @{
        Name = "logistics"
        Title = "Logistics & Fleet"
        Description = "Fleet management with IoT Hub and Digital Twins"
        Tech = "TypeScript, Azure IoT Hub, Digital Twins, SignalR, Azure Maps"
        Domain = "Logistics / Transportation"
    }
)

# Create structure for each project
foreach ($proj in $projects) {
    $basePath = "E:\STG\monopod\modules\$($proj.Name)"
    
    Write-Host "Creating structure for $($proj.Title)..." -ForegroundColor Cyan
    
    # Create directories
    New-Item -ItemType Directory -Force -Path "$basePath\.github" | Out-Null
    New-Item -ItemType Directory -Force -Path "$basePath\docs" | Out-Null
    
    # Create copilot-instructions.md
    $copilotContent = @"
# GitHub Copilot Instructions - $($proj.Title)

## Project Overview
**Module**: $($proj.Title)  
**Tech Stack**: $($proj.Tech)  
**Domain**: $($proj.Domain)

---

## Purpose
$($proj.Description)

---

## Technology Stack
$($proj.Tech)

---

## Key Architectural Patterns
- See [ARCHITECTURE.md](../docs/ARCHITECTURE.md) for detailed design
- Follow coding standards in [CODING_STANDARDS.md](../docs/CODING_STANDARDS.md)
- Reference technology details in [TECHNOLOGY_STACK.md](../docs/TECHNOLOGY_STACK.md)
- Ensure security compliance per [SECURITY_CHECKLIST.md](../docs/SECURITY_CHECKLIST.md)

---

## Copilot Guidelines

When generating code for $($proj.Name):

1. **Follow the architectural patterns** defined in ARCHITECTURE.md
2. **Adhere to coding standards** in CODING_STANDARDS.md
3. **Use approved technologies** from TECHNOLOGY_STACK.md
4. **Include comprehensive tests** (unit + integration)
5. **Add structured logging** with appropriate log levels
6. **Implement security best practices** from SECURITY_CHECKLIST.md
7. **Document all public APIs** with clear comments
8. **Handle errors gracefully** with proper error types
9. **Optimize for performance** - async/await, caching, indexing
10. **Add OpenTelemetry** for observability

---

## Security Requirements
- All endpoints require authentication
- Input validation on all user inputs
- Secrets stored in Azure Key Vault
- TLS 1.3 for all communications
- Audit logging for sensitive operations

---

## Code Quality Standards
- Unit test coverage: 80%+
- No critical security vulnerabilities
- Code review required (min 2 approvers)
- All tests passing before merge
- Documentation updated with code changes

---

**For detailed instructions, see the docs/ folder.**
"@
    Set-Content -Path "$basePath\.github\copilot-instructions.md" -Value $copilotContent

    # Create ARCHITECTURE.md placeholder
    $archContent = @"
# $($proj.Title) - Architecture & Design

## System Overview
**Name**: $($proj.Title)  
**Domain**: $($proj.Domain)  
**Purpose**: $($proj.Description)

---

## Architecture Diagram
\`\`\`mermaid
graph TB
    Client[Client Applications]
    API[API Layer]
    Logic[Business Logic]
    Data[Data Store]
    
    Client --> API
    API --> Logic
    Logic --> Data
\`\`\`

---

## Technology Stack
$($proj.Tech)

---

## Key Components
- **API Layer**: RESTful API for client communication
- **Business Logic**: Core application logic and rules
- **Data Store**: Persistent storage layer
- **External Integrations**: Third-party services

---

## Data Model
\`\`\`
[To be defined based on requirements]
\`\`\`

---

## API Design
### Endpoints
\`\`\`
GET /api/resource           List resources
POST /api/resource          Create resource
GET /api/resource/{id}      Get specific resource
PUT /api/resource/{id}      Update resource
DELETE /api/resource/{id}   Delete resource
\`\`\`

---

## Security Architecture
- Authentication: Azure AD / JWT tokens
- Authorization: Role-based access control
- Data encryption: At rest and in transit
- Audit logging: All operations tracked

---

## Deployment
- Container-based deployment (Docker)
- Kubernetes orchestration (AKS)
- Azure-native services where applicable

---

**Status**: 📝 Draft - To be completed during implementation  
**Last Updated**: January 9, 2026
"@
    Set-Content -Path "$basePath\docs\ARCHITECTURE.md" -Value $archContent

    # Create README.md
    $readmeContent = @"
# $($proj.Title)

$($proj.Description)

---

## 📋 Documentation

- [Architecture & Design](docs/ARCHITECTURE.md)
- [Coding Standards](docs/CODING_STANDARDS.md)
- [Technology Stack](docs/TECHNOLOGY_STACK.md)
- [Security Checklist](docs/SECURITY_CHECKLIST.md)
- [GitHub Copilot Instructions](.github/copilot-instructions.md)

---

## 🚀 Quick Start

\`\`\`bash
# Prerequisites
# - [List prerequisites based on tech stack]

# Clone and navigate
cd monopod/modules/$($proj.Name)

# Install dependencies
# [Add installation commands]

# Run application
# [Add run commands]
\`\`\`

---

## 🎯 Key Features
- [Feature 1]
- [Feature 2]
- [Feature 3]

---

## 📚 Related Certifications
This module aligns with:
- [Relevant certifications from roadmap]

---

**Status**: 🏗️ Ready for Development  
**Maintainer**: OpsVerse Team
"@
    Set-Content -Path "$basePath\README.md" -Value $readmeContent

    # Create placeholder docs
    @"
# $($proj.Title) - Coding Standards

**Status**: 📝 To be defined during implementation

Follow general OpsVerse coding standards plus technology-specific guidelines for: $($proj.Tech)

See [IMS Coding Standards](../ims/docs/CODING_STANDARDS.md) as reference template.

---

**Last Updated**: January 9, 2026
"@ | Set-Content -Path "$basePath\docs\CODING_STANDARDS.md"

    @"
# $($proj.Title) - Technology Stack

## Primary Technologies
$($proj.Tech)

---

## Detailed Specification
**Status**: 📝 To be defined during implementation

See [IMS Technology Stack](../ims/docs/TECHNOLOGY_STACK.md) as reference template.

---

**Last Updated**: January 9, 2026
"@ | Set-Content -Path "$basePath\docs\TECHNOLOGY_STACK.md"

    @"
# $($proj.Title) - Security Checklist

**Status**: 📝 To be completed before production deployment

See [IMS Security Checklist](../ims/docs/SECURITY_CHECKLIST.md) as comprehensive reference.

---

## Quick Checklist
- [ ] Authentication implemented
- [ ] Authorization on all endpoints
- [ ] Input validation
- [ ] Secrets in Key Vault
- [ ] TLS 1.3 enforced
- [ ] Logging configured
- [ ] Security scanning enabled
- [ ] Compliance verified

---

**Last Updated**: January 9, 2026
"@ | Set-Content -Path "$basePath\docs\SECURITY_CHECKLIST.md"

    Write-Host "✅ Created structure for $($proj.Title)" -ForegroundColor Green
}

Write-Host "`n🎉 All projects scaffolded successfully!" -ForegroundColor Green
Write-Host "📁 Location: E:\STG\monopod\modules\" -ForegroundColor Cyan
