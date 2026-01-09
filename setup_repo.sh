#!/bin/bash

# OpsVerse-StudyGroup Repository Setup Script
# Generated from Mega-Prompt.md

set -e

echo "🚀 Setting up OpsVerse-StudyGroup Repository..."

# === 1. CREATE DIRECTORY STRUCTURE ===
echo "📂 Creating directory structure..."

mkdir -p docs/certifications
mkdir -p docs/internal-courses
mkdir -p management/timesheets
mkdir -p career/cv-assets
mkdir -p monopod/modules/{ims,healthcare,infra-guardian,gov-services,fintech,ops-agent,charity,logistics}
mkdir -p monopod/platform/{auth,gateway}
mkdir -p monopod/infra
mkdir -p monopod/.github/workflows

# === 2. CREATE DOCUMENTATION FILES ===
echo "📝 Creating documentation files..."

# Root README.md
cat <<'EOT' > README.md
# 🌟 OpsVerse-StudyGroup: Learn by Building

Welcome to **OpsVerse**, an ambitious "Learn by Building" initiative for full-time engineers upskilling in **Cloud**, **DevOps**, and **AI**.

## 🎯 Mission
Master modern cloud-native development through hands-on projects while preparing for industry certifications.

## 🏗️ The 8 Projects (Monorepo)

### 1. **IMS** - Smart Supply Chain for SMEs
Event-driven inventory management system using .NET 8, RabbitMQ, and the Outbox Pattern.

### 2. **Healthcare** - Offline-First Clinic App
React PWA for African clinics with PouchDB sync and Azure Functions integration.

### 3. **Infra-Guardian** - Self-Healing Compliance Platform
Automated policy enforcement using Azure Policy, Event Grid, and Python Functions.

### 4. **Gov-Services** - Government Service Automation
Durable Functions orchestrating multi-step approval workflows with burst-scale capability.

### 5. **Fintech** - Real-Time Fraud Detection
Stream Analytics with Event Hubs for transaction monitoring and confidential computing.

### 6. **Ops-Agent** - DevOps AI Copilot
RAG-powered chatbot using Azure OpenAI, Vector Search, and LangChain.

### 7. **Charity** - Immutable NGO Ledger
Transparent donation tracking with Azure SQL Ledger and WhatsApp Bot integration.

### 8. **Logistics** - IoT Fleet Monitoring
Real-time truck monitoring using IoT Hub, Digital Twins, and Edge containers.

## 📚 Learning Paths
- **Certifications**: See [docs/certifications/ROADMAP.md](docs/certifications/ROADMAP.md)
- **Internal Courses**: See [docs/internal-courses/SYLLABUS.md](docs/internal-courses/SYLLABUS.md)
- **Progress Tracking**: See [management/TIMESHEET.md](management/TIMESHEET.md)

## 🚀 Getting Started
1. Pick a module from `monopod/modules/`
2. Open the `INSTRUCTIONS_FOR_COPILOT.md` inside
3. Use your AI assistant to execute the plan

**Let's build the future, one commit at a time!** 💪
EOT

# Management/TIMESHEET.md
cat <<'EOT' > management/TIMESHEET.md
# 📊 Team Progress Timesheet

Track your weekly progress, study hours, and blockers.

| Member Name | Week # | Study Hours | Coding Hours | Cert Progress | Blockers |
|-------------|--------|-------------|--------------|---------------|----------|
| Team Member 1 | 1 | 0 | 0 | GitHub Foundations (0%) | None |
| Team Member 2 | 1 | 0 | 0 | GitHub Foundations (0%) | None |
| Team Member 3 | 1 | 0 | 0 | GitHub Foundations (0%) | None |
| Team Member 4 | 1 | 0 | 0 | GitHub Foundations (0%) | None |

## Instructions
- **Study Hours**: Time spent on courses, reading docs, watching videos
- **Coding Hours**: Hands-on project work in the monorepo
- **Cert Progress**: Current certification and completion percentage
- **Blockers**: Technical issues, knowledge gaps, resource needs

Update this weekly during team sync meetings.
EOT

# Certifications Roadmap
cat <<'EOT' > docs/certifications/ROADMAP.md
# 🎓 Certification Roadmap

Our structured path to DevOps mastery through industry-recognized certifications.

| # | Certification | Difficulty | Est. Hours | Recommended Study Links | Status |
|---|---------------|------------|------------|-------------------------|--------|
| 1 | GitHub Foundations | Easy | 20 | [MS Learn - GitHub](https://learn.microsoft.com/en-us/training/github/) | 🎯 |
| 2 | GitHub Actions | Easy | 25 | [GitHub Actions Docs](https://docs.github.com/en/actions) | ⏳ |
| 3 | Terraform Associate | Intermediate | 40 | [HashiCorp Learn](https://learn.hashicorp.com/terraform) | ⏳ |
| 4 | AZ-204 Azure Developer | Intermediate | 60 | [MS Learn AZ-204](https://learn.microsoft.com/en-us/certifications/exams/az-204/) | ⏳ |
| 5 | AZ-400 DevOps Expert | **Milestone** | 80 | [MS Learn AZ-400](https://learn.microsoft.com/en-us/certifications/exams/az-400/) | ⏳ |
| 6 | AZ-305 Solutions Architect | Advanced | 100 | [MS Learn AZ-305](https://learn.microsoft.com/en-us/certifications/exams/az-305/) | ⏳ |

## Study Strategy
1. **Foundations First**: Master GitHub basics before diving into cloud
2. **Hands-on Practice**: Each cert aligns with 1-2 OpsVerse projects
3. **Group Study**: Weekly sync to discuss topics and mock exams
4. **Milestone Celebration**: AZ-400 is our collective goal! 🎉

## Additional Resources
- [Udemy DevOps Courses](https://www.udemy.com/topic/devops/)
- [A Cloud Guru](https://acloudguru.com/)
- [Pluralsight DevOps Path](https://www.pluralsight.com/paths/devops)

**Remember**: Certifications validate skills, but projects prove mastery!
EOT

# Internal Courses Syllabus
cat <<'EOT' > docs/internal-courses/SYLLABUS.md
# 📖 Internal Course Syllabus

Our mentor-led DevOps training tracks aligned with OpsVerse projects.

## Track A: Master DevOps (17 Weeks)

| Week | Topic | Projects | Deliverable |
|------|-------|----------|-------------|
| 1 | Git & GitHub Fundamentals | Setup Monorepo | Team Workflow Guide |
| 2 | Containerization (Docker) | Healthcare Module | Dockerfile + Compose |
| 3 | CI/CD Basics (GitHub Actions) | IMS Module | Build Pipeline |
| 4 | Infrastructure as Code (Terraform) | Infra-Guardian | Azure Resources |
| 5 | Azure Fundamentals | All Modules | Resource Group Setup |
| 6 | Microservices Architecture | IMS + Fintech | Service Mesh Design |
| 7 | Event-Driven Systems | IMS (RabbitMQ) | Event Flow Diagram |
| 8 | API Gateway & Auth | Platform Services | OAuth2 Implementation |
| 9 | Serverless (Azure Functions) | Healthcare Sync | Durable Functions |
| 10 | Stream Processing | Fintech Module | Stream Analytics Query |
| 11 | IoT & Edge Computing | Logistics Module | Edge Deployment |
| 12 | Security & Compliance | Infra-Guardian | Policy-as-Code |
| 13 | Observability (Logs, Metrics, Traces) | All Modules | Dashboard Setup |
| 14 | AI/ML Integration | Ops-Agent | RAG Pipeline |
| 15 | Kubernetes Basics | All Modules | AKS Deployment |
| 16 | Advanced DevOps Patterns | Gov-Services | Saga Pattern |
| 17 | Capstone Project | Charity Module | Production Deployment |

## Track B: Intro to DevOps (13 Weeks)

| Week | Topic | Focus | Lab |
|------|-------|-------|-----|
| 1 | Version Control Essentials | Git Basics | Branching Strategy |
| 2 | Linux Fundamentals | Shell Scripting | Automation Scripts |
| 3 | Networking Basics | DNS, Load Balancing | Network Diagram |
| 4 | Cloud Concepts | Azure Overview | Free Tier Setup |
| 5 | Docker Introduction | Container Basics | Multi-stage Builds |
| 6 | CI/CD Foundations | GitHub Actions | Simple Pipeline |
| 7 | Terraform Basics | IaC Principles | VM Provisioning |
| 8 | Monitoring & Logging | Application Insights | Alert Rules |
| 9 | Security Basics | RBAC, Key Vault | Secret Management |
| 10 | Database Fundamentals | SQL, Cosmos DB | Data Modeling |
| 11 | API Development | REST, GraphQL | Simple API |
| 12 | Agile & DevOps Culture | Scrum, Kanban | Sprint Planning |
| 13 | Career Preparation | Resume, Portfolio | CV + GitHub Profile |

## Weekly Format
- **Monday**: Mentor session (1 hour)
- **Wed/Thu**: Self-paced labs
- **Friday**: Team sync & code review

**Flexibility**: Choose Track A (experienced) or Track B (beginners) based on your background.
EOT

# Career Sync Guide
cat <<'EOT' > career/CAREER_SYNC_GUIDE.md
# 💼 Career Synchronization Guide

Strategically align your OpsVerse learning with job market opportunities.

## The Golden Rule
**Every completed module = New CV bullet point**

## Module → Resume Mapping

### 🔹 IMS Module
**CV Bullet:**
> Designed and implemented event-driven microservices architecture using .NET 8 and RabbitMQ, featuring the Outbox Pattern for guaranteed message delivery and optimistic concurrency control.

**Keywords:** Event Sourcing, CQRS, Message Queuing, Distributed Systems

---

### 🔹 Healthcare Module
**CV Bullet:**
> Built offline-first Progressive Web App (PWA) with PouchDB and Azure Functions sync layer, enabling reliable operation in low-connectivity environments across Africa.

**Keywords:** PWA, Service Workers, Offline-First, Data Synchronization

---

### 🔹 Infra-Guardian Module
**CV Bullet:**
> Developed self-healing compliance platform using Azure Policy and Event Grid, automating policy enforcement and remediation across multi-subscription environments.

**Keywords:** Policy-as-Code, Compliance Automation, Infrastructure Governance

---

### 🔹 Gov-Services Module
**CV Bullet:**
> Architected scalable government workflow system using Azure Durable Functions, handling burst traffic with queue-based load leveling and orchestrating multi-step approval processes.

**Keywords:** Serverless Orchestration, Durable Functions, Workflow Automation

---

### 🔹 Fintech Module
**CV Bullet:**
> Implemented real-time fraud detection pipeline using Azure Stream Analytics and Event Hubs with sliding window aggregations, integrated with Azure SQL Always Encrypted for data protection.

**Keywords:** Stream Processing, Real-Time Analytics, Confidential Computing

---

### 🔹 Ops-Agent Module
**CV Bullet:**
> Created DevOps AI copilot using Retrieval-Augmented Generation (RAG) with Azure OpenAI, LangChain, and vector search for intelligent documentation querying.

**Keywords:** RAG, Azure OpenAI, LangChain, Vector Databases

---

### 🔹 Charity Module
**CV Bullet:**
> Designed transparent donation tracking system using Azure SQL Ledger for immutable audit trails, with WhatsApp Bot integration via Azure Bot Service for donor engagement.

**Keywords:** Blockchain Alternatives, Immutable Ledgers, Bot Development

---

### 🔹 Logistics Module
**CV Bullet:**
> Built IoT fleet monitoring solution using Azure IoT Hub and Digital Twins (DTDL), with edge computing for real-time telemetry processing and predictive maintenance.

**Keywords:** IoT, Digital Twins, Edge Computing, DTDL

---

## LinkedIn Profile Strategy

### Headline Formula
`DevOps Engineer | Azure Certified | Cloud-Native Architecture | Event-Driven Systems`

### About Section Template
```
🚀 Cloud & DevOps Engineer passionate about building scalable, resilient systems.

🔧 Technical Focus:
• Event-Driven Microservices (.NET, RabbitMQ)
• Infrastructure as Code (Terraform, Azure)
• Serverless Architecture (Azure Functions, Durable Orchestrations)
• AI/ML Integration (Azure OpenAI, RAG)

🏗️ Recent Projects:
• [Link to OpsVerse GitHub] - 8-module production-grade monorepo
• Self-healing compliance platform
• Real-time fraud detection pipeline
• IoT fleet monitoring with Digital Twins

📜 Certifications: GitHub, Terraform, AZ-204, AZ-400

Always learning, always building. Open to DevOps/Cloud opportunities.
```

---

## GitHub Profile Optimization

### README.md Highlights
- Pin your best 3 OpsVerse modules
- Add architecture diagrams (Mermaid)
- Include CI/CD badges
- Link live demos (where applicable)

### Repository Structure
Each module should have:
- Clear README with problem statement
- Architecture diagram
- Setup instructions
- Tech stack badges
- Live demo link (if public)

---

## Job Application Timeline

| Module Completed | Apply For | Reasoning |
|------------------|-----------|-----------|
| IMS + Healthcare | Junior DevOps Engineer | Shows backend + frontend versatility |
| Infra-Guardian | Cloud Engineer | Demonstrates infrastructure automation |
| Fintech + Gov-Services | Mid-Level DevOps | Proves experience with complex systems |
| Ops-Agent | AI/ML Engineer (DevOps) | Emerging field, high demand |
| All 8 Modules | Senior/Lead DevOps | Comprehensive portfolio |

---

## Interview Preparation

### STAR Method Examples
**Situation:** While building the IMS module...
**Task:** I needed to ensure message delivery guarantees...
**Action:** Implemented the Outbox Pattern with...
**Result:** Achieved 99.9% delivery success in testing.

### Technical Deep-Dives
Be ready to explain:
- Why you chose RabbitMQ over Kafka for IMS
- How the Outbox Pattern prevents data loss
- Trade-offs between Durable Functions vs Logic Apps
- RAG vs Fine-tuning for the Ops-Agent

---

## Continuous Improvement

### Monthly CV Audit
- [ ] Update project metrics (lines of code, services deployed)
- [ ] Add new certifications
- [ ] Refresh technical skills section
- [ ] Update GitHub contribution graph

### Networking
- Share OpsVerse learnings on LinkedIn (weekly)
- Write technical blog posts (monthly)
- Contribute to open-source DevOps tools
- Join Azure/DevOps communities

---

**Remember:** Your GitHub is your new resume. Make every commit count! 🌟
EOT

# === 3. CREATE META-PROMPTS (INSTRUCTIONS_FOR_COPILOT.md) ===
echo "🧠 Creating meta-prompts for all modules..."

# IMS Module
cat <<'EOT' > monopod/modules/ims/INSTRUCTIONS_FOR_COPILOT.md
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
EOT

# Healthcare Module
cat <<'EOT' > monopod/modules/healthcare/INSTRUCTIONS_FOR_COPILOT.md
# Healthcare Module: Offline-First Clinic App

## Context
Build a **Progressive Web App (PWA)** for clinics in low-connectivity regions of Africa. The app must work fully offline and sync data when internet is available.

## Tech Stack
- **React 18** with TypeScript
- **PouchDB** for local storage
- **Azure Functions** (Node.js/Python) for sync backend
- **Azure Cosmos DB** for cloud storage
- **Workbox** for Service Worker management

## Architecture Requirements

### Frontend (React PWA)
1. **Patient Management**
   - Register new patients
   - View patient history
   - Update patient records

2. **Offline Storage**
   - PouchDB stores all patient data locally
   - Automatic conflict resolution (last-write-wins or custom)

3. **Service Worker**
   - Cache app shell and static assets
   - Background sync for data uploads
   - Push notifications for reminders

### Backend (Azure Functions)
1. **Sync Function** (HTTP Trigger)
   - Receives PouchDB changes from client
   - Writes to Cosmos DB
   - Returns server-side changes

2. **Conflict Resolution**
   - Timestamp-based merging
   - Manual review queue for critical conflicts

## Key Implementation Tasks

### 1. Initialize React PWA
```bash
npx create-react-app healthcare-app --template typescript
npm install pouchdb pouchdb-find workbox-webpack-plugin
```

### 2. Configure Service Worker
Update `src/service-worker.js` to:
- Cache static resources (HTML, CSS, JS)
- Implement background sync for POST requests
- Handle offline/online events

### 3. PouchDB Integration
```typescript
import PouchDB from 'pouchdb';

const localDB = new PouchDB('clinic_db');
const remoteDB = new PouchDB('https://your-cosmos-db-url');

// Bidirectional sync
localDB.sync(remoteDB, { live: true, retry: true });
```

### 4. Azure Function Sync Endpoint
```javascript
module.exports = async function (context, req) {
    const changes = req.body.docs;
    
    // Write to Cosmos DB
    await container.items.bulk(changes);
    
    // Return server changes
    const serverChanges = await getChangesSince(req.body.lastSeq);
    context.res = { body: serverChanges };
};
```

### 5. Patient Form Component
Build a React component with:
- Form validation (React Hook Form)
- Local save to PouchDB
- Sync status indicator (syncing/synced/offline)

## Acceptance Criteria
- [ ] App installs as PWA on mobile
- [ ] Full CRUD operations work offline
- [ ] Data syncs automatically when online
- [ ] Conflict resolution logs displayed
- [ ] Service worker caches app for offline use
- [ ] Responsive design (mobile-first)

## Testing Strategy
- Test offline mode (disable network in DevTools)
- Simulate conflicts (edit same record on two devices)
- Verify sync after reconnection

## Getting Started
Execute this plan incrementally. Start with a basic React app, add PouchDB, then implement Service Worker, and finally integrate Azure Functions.

**Remember:** User experience is key—always show sync status clearly!
EOT

# Infra-Guardian Module
cat <<'EOT' > monopod/modules/infra-guardian/INSTRUCTIONS_FOR_COPILOT.md
# Infra-Guardian: Self-Healing Compliance Platform

## Context
Build an automated compliance and remediation system that enforces Azure policies and auto-heals non-compliant resources.

## Tech Stack
- **Terraform** for IaC
- **Azure Policy** for compliance rules
- **Azure Event Grid** for event routing
- **Python Azure Functions** for remediation logic
- **Azure Monitor** for alerting

## Architecture Requirements

### Policy Layer
1. **Custom Policies**
   - Deny public IP assignments
   - Enforce tag requirements
   - Require encryption at rest
   - Block non-approved regions

2. **Policy Assignments**
   - Management group scope
   - Resource group exclusions
   - Custom parameters per environment

### Event-Driven Remediation
1. **Event Grid Subscription**
   - Filter for policy violation events
   - Route to remediation function

2. **Python Function**
   - Receive policy violation event
   - Execute remediation action
   - Log to Application Insights

## Key Implementation Tasks

### 1. Terraform Structure
```
infra-guardian/
├── policies/
│   ├── deny-public-ip.tf
│   ├── require-tags.tf
│   └── enforce-encryption.tf
├── functions/
│   ├── auto-remediate/
│   │   ├── __init__.py
│   │   └── function.json
│   └── host.json
└── main.tf
```

### 2. Deny Public IP Policy
```hcl
resource "azurerm_policy_definition" "deny_public_ip" {
  name         = "deny-public-ip-assignment"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deny Public IP Assignment"

  policy_rule = jsonencode({
    if = {
      field  = "type"
      equals = "Microsoft.Network/publicIPAddresses"
    }
    then = {
      effect = "deny"
    }
  })
}
```

### 3. Event Grid Trigger Function
```python
import logging
import azure.functions as func
from azure.mgmt.network import NetworkManagementClient

def main(event: func.EventGridEvent):
    logging.info(f'Policy Violation: {event.subject}')
    
    # Parse resource ID
    resource_id = event.subject
    
    # Remediation logic
    if 'port 22' in event.data['details']:
        close_ssh_port(resource_id)
        logging.info('SSH port auto-closed')
```

### 4. Auto-Close SSH Port
```python
def close_ssh_port(nsg_id):
    # Get NSG
    nsg = network_client.network_security_groups.get(...)
    
    # Find SSH rule
    ssh_rule = [r for r in nsg.security_rules if r.destination_port_range == '22']
    
    # Delete rule
    network_client.security_rules.delete(...)
```

## Acceptance Criteria
- [ ] Terraform deploys policy definitions
- [ ] Policy violations trigger Event Grid events
- [ ] Python function remediates violations automatically
- [ ] Logs sent to Application Insights
- [ ] Alert rules for critical violations
- [ ] Compliance dashboard (Azure Policy Compliance)

## Testing Strategy
1. Deploy a public IP (should be denied)
2. Create NSG with port 22 open (should auto-close)
3. Verify Event Grid delivery
4. Check Application Insights logs

## Getting Started
Execute this plan sequentially:
1. Write Terraform for policy definitions
2. Deploy policies to test subscription
3. Create Event Grid subscription
4. Implement Python remediation function
5. Test end-to-end flow

**Remember:** Test in non-production environment first!
EOT

# Gov-Services Module
cat <<'EOT' > monopod/modules/gov-services/INSTRUCTIONS_FOR_COPILOT.md
# Gov-Services: Government Service Automation

## Context
Build a scalable workflow orchestration system for government services (e.g., building permits) that handles burst traffic and multi-step approvals.

## Tech Stack
- **Azure Durable Functions** (Node.js or C#)
- **Queue-Based Load Leveling** with Azure Storage Queues
- **Azure Cosmos DB** for workflow state
- **Application Insights** for monitoring

## Architecture Requirements

### Workflow Orchestration
1. **Building Permit Workflow**
   - Step 1: Zoning approval (5 min timeout)
   - Step 2: Safety inspection (10 min timeout)
   - Step 3: Final approval (5 min timeout)
   - Auto-reject if any step fails or times out

2. **Human-in-the-Loop**
   - Send approval requests to external API
   - Wait for webhook callback
   - Handle timeout with escalation

### Scaling Pattern
1. **Queue Ingestion**
   - Public API writes requests to queue
   - Durable Function consumes from queue
   - Prevents function overload during bursts

2. **State Persistence**
   - Durable entities store application state
   - Query status via REST API

## Key Implementation Tasks

### 1. Initialize Durable Functions
```bash
func init gov-services --worker-runtime node
cd gov-services
func new --name BuildingPermitOrchestrator --template "Durable Functions orchestrator"
```

### 2. Orchestrator Function
```javascript
const df = require("durable-functions");

module.exports = df.orchestrator(function* (context) {
    const application = context.df.getInput();
    
    // Step 1: Zoning approval
    const zoningResult = yield context.df.callActivityWithTimeout(
        "ZoningApproval",
        300000, // 5 min
        application
    );
    
    if (!zoningResult.approved) {
        return { status: "Rejected", reason: "Zoning" };
    }
    
    // Step 2: Safety inspection
    const safetyResult = yield context.df.callActivityWithTimeout(
        "SafetyInspection",
        600000, // 10 min
        application
    );
    
    if (!safetyResult.approved) {
        return { status: "Rejected", reason: "Safety" };
    }
    
    // Step 3: Final approval
    const finalResult = yield context.df.callActivity(
        "FinalApproval",
        application
    );
    
    return { status: "Approved", permitNumber: finalResult.permitId };
});
```

### 3. Activity Functions
```javascript
// ZoningApproval activity
module.exports = async function (context) {
    const application = context.bindings.application;
    
    // Call external zoning API
    const response = await fetch('https://zoning-api/approve', {
        method: 'POST',
        body: JSON.stringify(application)
    });
    
    return await response.json();
};
```

### 4. HTTP Starter (Queue Trigger)
```javascript
module.exports = async function (context, queueItem) {
    const client = df.getClient(context);
    const instanceId = await client.startNew(
        "BuildingPermitOrchestrator",
        undefined,
        queueItem
    );
    
    return client.createCheckStatusResponse(context, instanceId);
};
```

### 5. Public API (Queue Writer)
```javascript
module.exports = async function (context, req) {
    const application = req.body;
    
    // Write to queue
    context.bindings.outputQueue = application;
    
    context.res = {
        status: 202,
        body: { message: "Application submitted" }
    };
};
```

## Acceptance Criteria
- [ ] Orchestrator handles all 3 approval steps
- [ ] Timeouts trigger automatic rejection
- [ ] Queue-based ingestion prevents overload
- [ ] Status query API works
- [ ] Application Insights tracks execution
- [ ] Load test with 1000 concurrent requests

## Testing Strategy
1. Submit normal application (should approve in ~20 min)
2. Submit application that fails zoning (should reject fast)
3. Test timeout by delaying webhook response
4. Load test with queue bursts

## Getting Started
Execute this plan step-by-step:
1. Initialize Durable Functions project
2. Implement orchestrator logic
3. Create activity functions (mock external APIs initially)
4. Add queue-based ingestion
5. Deploy to Azure and test

**Remember:** Durable Functions are stateful—use Durable Entities for complex state!
EOT

# Fintech Module
cat <<'EOT' > monopod/modules/fintech/INSTRUCTIONS_FOR_COPILOT.md
# Fintech: Real-Time Fraud Detection

## Context
Build a real-time fraud detection system that analyzes transaction streams and flags anomalies using Azure Stream Analytics.

## Tech Stack
- **Azure Event Hubs** for ingestion
- **Azure Stream Analytics** for real-time processing
- **Azure SQL Database** with Always Encrypted
- **Terraform** for infrastructure
- **Python** for fraud simulation

## Architecture Requirements

### Data Flow
1. **Transaction Ingestion**
   - Clients send transactions to Event Hub
   - Schema: `{ userId, amount, merchantId, timestamp, location }`

2. **Stream Analytics Job**
   - **Sliding Window**: Detect >5 transactions in 5 minutes
   - **Geofencing**: Flag transactions from blacklisted locations
   - **Anomaly Detection**: Built-in ML model for unusual patterns

3. **Output Sinks**
   - **SQL Database**: Store all transactions
   - **Alerts**: Send high-risk transactions to AlertHub
   - **Dashboard**: Power BI real-time dataset

### Security
1. **Always Encrypted**
   - Encrypt sensitive columns (cardNumber, CVV)
   - Azure Key Vault for key management

2. **Confidential Computing** (Optional)
   - Use DC-series VMs for SQL
   - Encrypt data in use

## Key Implementation Tasks

### 1. Terraform Infrastructure
```hcl
resource "azurerm_eventhub_namespace" "fintech" {
  name                = "fintech-events"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
}

resource "azurerm_stream_analytics_job" "fraud_detection" {
  name                = "fraud-detection"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  transformation_query = file("query.sql")
}
```

### 2. Stream Analytics Query
```sql
-- Detect rapid transactions (sliding window)
SELECT
    userId,
    COUNT(*) AS transactionCount,
    System.Timestamp() AS windowEnd
INTO
    AlertOutput
FROM
    TransactionInput TIMESTAMP BY timestamp
GROUP BY
    userId,
    SlidingWindow(minute, 5)
HAVING
    COUNT(*) > 5

-- Detect blacklisted locations
SELECT
    *
INTO
    BlockedOutput
FROM
    TransactionInput
WHERE
    location IN ('Country1', 'Country2')

-- Store all transactions
SELECT
    *
INTO
    SQLOutput
FROM
    TransactionInput
```

### 3. SQL Table with Always Encrypted
```sql
CREATE TABLE Transactions (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId NVARCHAR(50),
    Amount DECIMAL(18,2),
    MerchantId NVARCHAR(50),
    CardNumber NVARCHAR(16) ENCRYPTED WITH (
        COLUMN_ENCRYPTION_KEY = CEK1,
        ENCRYPTION_TYPE = Deterministic,
        ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256'
    ),
    Timestamp DATETIME2
);
```

### 4. Python Transaction Simulator
```python
from azure.eventhub import EventHubProducerClient, EventData
import json
import random
import time

producer = EventHubProducerClient.from_connection_string(
    conn_str="<connection_string>",
    eventhub_name="transactions"
)

def simulate_fraud():
    # Rapid transactions (same user)
    user_id = "user123"
    for i in range(10):
        transaction = {
            "userId": user_id,
            "amount": random.randint(10, 500),
            "merchantId": f"merchant{i}",
            "timestamp": time.time(),
            "location": "US"
        }
        producer.send_batch([EventData(json.dumps(transaction))])
        time.sleep(0.5)  # 10 transactions in 5 seconds

simulate_fraud()
```

## Acceptance Criteria
- [ ] Event Hub receives transactions
- [ ] Stream Analytics detects fraud patterns
- [ ] Alerts sent to separate output
- [ ] SQL table uses Always Encrypted
- [ ] Terraform deploys all resources
- [ ] Python simulator generates test data
- [ ] Dashboard visualizes fraud rate

## Testing Strategy
1. Send normal transactions (should pass)
2. Trigger rapid transaction fraud (should alert)
3. Send transaction from blacklisted location (should block)
4. Verify encryption in SQL (query should fail without keys)

## Getting Started
Execute this plan sequentially:
1. Write Terraform for Event Hub and Stream Analytics
2. Deploy infrastructure
3. Create SQL table with Always Encrypted
4. Configure Stream Analytics query
5. Build Python simulator
6. Test end-to-end flow

**Remember:** Always Encrypted requires client-side drivers with key access!
EOT

# Ops-Agent Module
cat <<'EOT' > monopod/modules/ops-agent/INSTRUCTIONS_FOR_COPILOT.md
# Ops-Agent: DevOps AI Copilot (RAG)

## Context
Build an AI-powered chatbot that answers DevOps questions by searching through local documentation using Retrieval-Augmented Generation (RAG).

## Tech Stack
- **Python FastAPI** for REST API
- **Azure OpenAI** (GPT-4)
- **LangChain** for RAG pipeline
- **Azure AI Search** (Vector Search)
- **Local Markdown Files** as knowledge base

## Architecture Requirements

### RAG Pipeline
1. **Document Ingestion**
   - Load markdown files from `/docs` folder
   - Split into chunks (512 tokens)
   - Generate embeddings using `text-embedding-ada-002`
   - Store in Azure AI Search vector index

2. **Query Flow**
   - User asks question
   - Generate query embedding
   - Search vector index for top 5 relevant chunks
   - Pass chunks + question to GPT-4
   - Stream response back to user

### Knowledge Base
- OpsVerse project READMEs
- Azure documentation excerpts
- Terraform best practices
- Kubernetes cheat sheets

## Key Implementation Tasks

### 1. Initialize FastAPI Project
```bash
mkdir ops-agent && cd ops-agent
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install fastapi uvicorn langchain openai azure-search-documents
```

### 2. Document Loader
```python
from langchain.document_loaders import DirectoryLoader
from langchain.text_splitter import MarkdownTextSplitter

# Load all markdown files
loader = DirectoryLoader('../../docs', glob="**/*.md")
documents = loader.load()

# Split into chunks
splitter = MarkdownTextSplitter(chunk_size=512, chunk_overlap=50)
chunks = splitter.split_documents(documents)
```

### 3. Vector Store Setup
```python
from langchain.embeddings import AzureOpenAIEmbeddings
from langchain.vectorstores import AzureSearch

embeddings = AzureOpenAIEmbeddings(
    azure_deployment="text-embedding-ada-002",
    openai_api_version="2023-05-15"
)

vector_store = AzureSearch(
    azure_search_endpoint="https://<name>.search.windows.net",
    azure_search_key="<key>",
    index_name="opsverse-docs",
    embedding_function=embeddings.embed_query
)

# Index documents
vector_store.add_documents(chunks)
```

### 4. RAG Chain
```python
from langchain.chains import RetrievalQA
from langchain.chat_models import AzureChatOpenAI

llm = AzureChatOpenAI(
    azure_deployment="gpt-4",
    openai_api_version="2023-05-15",
    temperature=0
)

qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vector_store.as_retriever(search_kwargs={"k": 5})
)
```

### 5. FastAPI Endpoints
```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Question(BaseModel):
    query: str

@app.post("/ask")
async def ask_question(question: Question):
    result = qa_chain.run(question.query)
    return {"answer": result}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}
```

### 6. Streaming Response (Optional)
```python
from fastapi.responses import StreamingResponse

@app.post("/ask/stream")
async def ask_streaming(question: Question):
    async def generate():
        for chunk in qa_chain.stream(question.query):
            yield f"data: {chunk}\n\n"
    
    return StreamingResponse(generate(), media_type="text/event-stream")
```

## Acceptance Criteria
- [ ] Ingest all markdown files from `/docs`
- [ ] Vector search returns relevant chunks
- [ ] RAG pipeline answers DevOps questions accurately
- [ ] FastAPI serves `/ask` endpoint
- [ ] Streaming response works
- [ ] Unit tests for chunking logic
- [ ] Integration tests with Azure OpenAI

## Testing Strategy
### Test Questions
1. "How do I implement the Outbox Pattern in IMS?"
2. "What is the tech stack for the Healthcare module?"
3. "Explain Azure Durable Functions workflow"
4. "How to detect fraud in the Fintech module?"

### Evaluation
- Accuracy: Does answer match source docs?
- Relevance: Are retrieved chunks related to question?
- Latency: Response time < 3 seconds

## Getting Started
Execute this plan step-by-step:
1. Set up FastAPI project
2. Implement document loader and chunking
3. Configure Azure OpenAI and AI Search
4. Build RAG chain
5. Create REST API
6. Test with sample questions

**Remember:** Quality of RAG depends on chunk size and retrieval k!
EOT

# Charity Module
cat <<'EOT' > monopod/modules/charity/INSTRUCTIONS_FOR_COPILOT.md
# Charity: Immutable NGO Ledger

## Context
Build a transparent donation tracking system using Azure SQL Ledger for immutable audit trails, with WhatsApp Bot integration for donor engagement.

## Tech Stack
- **Azure SQL Database** (Ledger feature)
- **Azure Bot Service** (WhatsApp channel)
- **C# .NET 8** for bot logic
- **Power BI** for transparency dashboard

## Architecture Requirements

### Ledger Schema
1. **Donations Table** (Updateable Ledger)
   - Columns: DonationId, DonorName, Amount, CampaignId, Timestamp
   - Ledger tracks all updates (e.g., refunds)

2. **Disbursements Table** (Append-Only Ledger)
   - Columns: DisbursementId, RecipientOrg, Amount, Purpose, Timestamp
   - Cannot be modified once written

3. **Ledger Views**
   - Automatically generated history tables
   - Query: `SELECT * FROM Donations FOR SYSTEM_TIME ALL`

### WhatsApp Bot
1. **Donation Flow**
   - User: "Donate $50 to Campaign123"
   - Bot: Confirms details, generates payment link
   - User: Sends payment receipt photo
   - Bot: Stores in Blob Storage, creates ledger record

2. **Query Flow**
   - User: "Show my donations"
   - Bot: Queries ledger, sends formatted list

## Key Implementation Tasks

### 1. SQL Ledger Setup
```sql
-- Create updateable ledger table
CREATE TABLE Donations (
    DonationId INT IDENTITY(1,1) PRIMARY KEY,
    DonorName NVARCHAR(100),
    Amount DECIMAL(18,2),
    CampaignId NVARCHAR(50),
    Status NVARCHAR(20), -- Pending, Confirmed, Refunded
    CreatedAt DATETIME2 DEFAULT GETUTCDATE()
)
WITH (SYSTEM_VERSIONING = ON, LEDGER = ON);

-- Create append-only ledger table
CREATE TABLE Disbursements (
    DisbursementId INT IDENTITY(1,1) PRIMARY KEY,
    RecipientOrg NVARCHAR(200),
    Amount DECIMAL(18,2),
    Purpose NVARCHAR(500),
    DisbursedAt DATETIME2 DEFAULT GETUTCDATE()
)
WITH (LEDGER = ON (APPEND_ONLY = ON));
```

### 2. Verify Ledger Integrity
```sql
-- Generate ledger digest
EXEC sys.sp_generate_database_ledger_digest;

-- Verify ledger (returns true if no tampering)
EXEC sys.sp_verify_database_ledger;
```

### 3. Bot Dialog (C#)
```csharp
using Microsoft.Bot.Builder;
using Microsoft.Bot.Schema;

public class CharityBot : ActivityHandler
{
    protected override async Task OnMessageActivityAsync(
        ITurnContext<IMessageActivity> turnContext,
        CancellationToken cancellationToken)
    {
        var text = turnContext.Activity.Text.ToLower();
        
        if (text.StartsWith("donate"))
        {
            await HandleDonation(turnContext, text, cancellationToken);
        }
        else if (text == "my donations")
        {
            await ShowDonations(turnContext, cancellationToken);
        }
    }
    
    private async Task HandleDonation(ITurnContext turnContext, string text, CancellationToken ct)
    {
        // Parse: "donate $50 to campaign123"
        var amount = ExtractAmount(text);
        var campaign = ExtractCampaign(text);
        
        await turnContext.SendActivityAsync(
            $"Confirm donation of ${amount} to {campaign}? Reply YES to proceed.",
            cancellationToken: ct
        );
    }
}
```

### 4. WhatsApp Channel Configuration
```json
{
  "type": "whatsapp",
  "settings": {
    "phoneNumber": "+1234567890",
    "apiKey": "<whatsapp_business_api_key>"
  }
}
```

### 5. Receipt Photo Handler
```csharp
private async Task OnPhotoReceived(ITurnContext turnContext, Attachment photo)
{
    // Upload to Blob Storage
    var blobUrl = await UploadToBlob(photo.ContentUrl);
    
    // Create ledger record
    await _sqlService.ExecuteAsync(@"
        INSERT INTO Donations (DonorName, Amount, CampaignId, ReceiptUrl, Status)
        VALUES (@name, @amount, @campaign, @url, 'Pending')
    ", new { name = ..., amount = ..., campaign = ..., url = blobUrl });
    
    await turnContext.SendActivityAsync("Receipt uploaded! Donation pending verification.");
}
```

## Acceptance Criteria
- [ ] SQL Ledger tables created (updateable + append-only)
- [ ] Ledger integrity verification passes
- [ ] WhatsApp bot handles donation commands
- [ ] Receipt photos stored in Blob Storage
- [ ] Ledger history queryable via views
- [ ] Power BI dashboard shows donations/disbursements
- [ ] Unit tests for bot dialogs

## Testing Strategy
1. Send donation command via WhatsApp
2. Upload receipt photo
3. Verify ledger record created
4. Query donation history
5. Attempt to tamper with ledger (should detect)
6. Run integrity verification

## Getting Started
Execute this plan step-by-step:
1. Create Azure SQL Database with Ledger enabled
2. Design and create ledger tables
3. Initialize Bot Framework project (C#)
4. Implement bot dialogs
5. Configure WhatsApp channel
6. Test end-to-end flow

**Remember:** Ledger tables cannot be dropped—plan schema carefully!
EOT

# Logistics Module
cat <<'EOT' > monopod/modules/logistics/INSTRUCTIONS_FOR_COPILOT.md
# Logistics: IoT Fleet Monitoring

## Context
Build a real-time fleet monitoring system for trucks using Azure IoT Hub, Digital Twins, and Edge computing for telemetry processing.

## Tech Stack
- **Azure IoT Hub** for device connectivity
- **Azure Digital Twins** with DTDL models
- **Azure IoT Edge** for edge processing
- **Python** for edge modules
- **Time Series Insights** for analytics

## Architecture Requirements

### Digital Twin Model
1. **Truck Twin**
   - Properties: VIN, Model, Year, Location
   - Telemetry: Temperature, Speed, FuelLevel, EngineStatus
   - Relationships: AssignedDriver, CurrentRoute

2. **Route Twin**
   - Properties: RouteId, StartLocation, EndLocation
   - Relationships: AssignedTrucks

### Edge Processing
1. **Temperature Filter Module**
   - Read telemetry from IoT Hub
   - Filter: Only send if temp > 80°C (anomaly)
   - Reduces cloud bandwidth by 90%

2. **Local Alerting**
   - Edge module detects critical conditions
   - Sends alert to local dashboard (offline capability)

## Key Implementation Tasks

### 1. DTDL Model (Truck)
```json
{
  "@context": "dtmi:dtdl:context;2",
  "@id": "dtmi:com:example:Truck;1",
  "@type": "Interface",
  "displayName": "Truck",
  "contents": [
    {
      "@type": "Property",
      "name": "VIN",
      "schema": "string"
    },
    {
      "@type": "Telemetry",
      "name": "temperature",
      "schema": "double"
    },
    {
      "@type": "Telemetry",
      "name": "speed",
      "schema": "double"
    },
    {
      "@type": "Relationship",
      "name": "assignedDriver",
      "target": "dtmi:com:example:Driver;1"
    }
  ]
}
```

### 2. IoT Hub Device Registration
```python
from azure.iot.hub import IoTHubRegistryManager

registry_manager = IoTHubRegistryManager(CONNECTION_STRING)

# Register truck device
device = registry_manager.create_device_with_sas(
    device_id="truck-001",
    primary_key="...",
    secondary_key="..."
)
```

### 3. Edge Module (Temperature Filter)
```python
# main.py
import asyncio
from azure.iot.device import IoTHubModuleClient, Message

async def main():
    module_client = IoTHubModuleClient.create_from_edge_environment()
    await module_client.connect()
    
    async def message_handler(message):
        data = json.loads(message.data)
        temp = data.get("temperature")
        
        # Filter: Only forward if anomaly
        if temp > 80:
            output_msg = Message(json.dumps(data))
            await module_client.send_message_to_output(output_msg, "temperatureAlert")
            print(f"ALERT: High temperature detected: {temp}°C")
    
    module_client.on_message_received = message_handler
    
    # Keep module running
    await asyncio.Event().wait()

if __name__ == "__main__":
    asyncio.run(main())
```

### 4. Deployment Manifest (IoT Edge)
```json
{
  "modulesContent": {
    "$edgeAgent": {
      "properties.desired": {
        "modules": {
          "temperatureFilter": {
            "version": "1.0",
            "type": "docker",
            "status": "running",
            "restartPolicy": "always",
            "settings": {
              "image": "myregistry.azurecr.io/temp-filter:latest",
              "createOptions": "{}"
            }
          }
        }
      }
    },
    "$edgeHub": {
      "properties.desired": {
        "routes": {
          "sensorToFilter": "FROM /messages/modules/tempSensor/* INTO BrokeredEndpoint(\"/modules/temperatureFilter/inputs/input1\")",
          "filterToIoTHub": "FROM /messages/modules/temperatureFilter/outputs/temperatureAlert INTO $upstream"
        }
      }
    }
  }
}
```

### 5. Digital Twin Update
```python
from azure.digitaltwins.core import DigitalTwinsClient

dt_client = DigitalTwinsClient(ENDPOINT, credential)

# Update truck twin with telemetry
patch = [
    {
        "op": "replace",
        "path": "/temperature",
        "value": 85.5
    }
]

dt_client.update_digital_twin("truck-001", patch)
```

### 6. Device Simulator
```python
from azure.iot.device import IoTHubDeviceClient
import random
import time

device_client = IoTHubDeviceClient.create_from_connection_string(DEVICE_CONN_STR)

while True:
    telemetry = {
        "temperature": random.uniform(60, 100),  # Some will trigger alert
        "speed": random.uniform(0, 90),
        "fuelLevel": random.uniform(0, 100)
    }
    
    message = Message(json.dumps(telemetry))
    device_client.send_message(message)
    print(f"Sent: {telemetry}")
    
    time.sleep(5)
```

## Acceptance Criteria
- [ ] DTDL model deployed to Azure Digital Twins
- [ ] IoT Hub receives telemetry from simulated trucks
- [ ] Edge module filters temperature data
- [ ] Only anomalies sent to cloud (verify reduced bandwidth)
- [ ] Digital Twin updated with latest telemetry
- [ ] Time Series Insights dashboard visualizes data
- [ ] Predictive maintenance alert (optional ML model)

## Testing Strategy
1. Run device simulator (send normal + anomaly data)
2. Verify edge module filters correctly
3. Check Digital Twin reflects latest state
4. Query Time Series Insights for historical data
5. Test offline scenario (disconnect IoT Hub, verify edge alerting)

## Getting Started
Execute this plan step-by-step:
1. Create DTDL model and upload to Digital Twins
2. Set up IoT Hub and register devices
3. Build edge module (Python)
4. Create deployment manifest
5. Deploy to IoT Edge device (or simulated edge)
6. Test with device simulator

**Remember:** Edge modules run in containers—test locally with `iotedgehubdev`!
EOT

echo "✅ Repository setup complete!"
echo ""
echo "📁 Directory structure created"
echo "📝 Documentation files populated"
echo "🧠 Meta-prompts ready for all 8 modules"
echo ""
echo "🚀 Next steps:"
echo "1. Review README.md for project overview"
echo "2. Check management/TIMESHEET.md to track progress"
echo "3. Pick a module and open its INSTRUCTIONS_FOR_COPILOT.md"
echo "4. Start building with your AI assistant!"
echo ""
echo "Happy coding! 🎉"
