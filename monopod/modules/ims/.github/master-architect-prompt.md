Master Architect Prompt: Smart Supply Chain (IMS) Module
Role: You are a Principal Cloud Architect and DevOps Lead. Context: We are initializing the "Smart Supply Chain & Inventory" (IMS) module within the OpsVerse Monorepo. This is a mission-critical, multi-tenant SaaS application designed for SMEs in the Gulf/Africa/Egypt regions. Constraints:

Architecture: Event-Driven Microservices (using the Outbox Pattern).

Infrastructure: Azure (Terraform).

CI/CD: GitHub Actions (Golden Path).

Governance: Strict MCC (Minimum Compatibility Contract).

AI: Integrated forecasting agents.

1. 📐 Architecture & Design Requirements
Please generate the following Mermaid diagrams and design documents:

System Context Diagram (C4 Level 1): Show how Store Managers, POS Terminals, and Suppliers interact with the IMS system.

Container Diagram (C4 Level 2): Detail the internal components:

IMS API (Core): .NET 8 / Node.js (Clean Architecture).

Stock Worker: Background service processing inventory events.

Forecasting Agent: Python/AI service for demand prediction.

Data Stores: SQL (Transactional) + Redis (Locking) + CosmosDB (Read Models).

Event Bus: Azure Event Grid / RabbitMQ.

Data Flow Diagram: Visualize the "Stock Reservation" flow handling Optimistic Concurrency to prevent overselling.

1. 📂 Monorepo Project Structure
Map out the file structure for monopod/modules/ims following Domain-Driven Design (DDD). It must include:

/src/api: The REST/GraphQL entry point.

/src/domain: Pure business logic (Entities, Value Objects).

/src/infrastructure: DB implementations, External Adapters.

/src/workers: Event consumers (e.g., StockUpdatedConsumer).

/tests: Unit, Integration, and Load tests (k6).

/iac: Terraform module specific to IMS resources.

1. 📝 Documentation Strategy (*.md)
Generate the templates for the following required documentation in /modules/ims/docs:

README.md: Module overview, how to run locally, architecture summary.

ADR-001-Concurrency.md: Decision record explaining why we chose Optimistic Concurrency + Redis Distributed Locks.

API-CONTRACT.md: Skeleton for OpenAPI 3.0 specs.

1. 🤖 GitHub Copilot "Meta-Prompts"
Provide a list of 5-7 specific prompts that I can feed to GitHub Copilot (or Cursor) to generate the actual code. These prompts must be context-aware.

Example: "Scaffold a .NET 8 Web API solution using Clean Architecture with these specific layers..."

Example: "Generate a Terraform module for an Azure SQL Database with Geo-Redundancy and Private Endpoints..."

1. 🚀 "Day 1" Implementation Plan
Provide a step-by-step list of commands/actions to initialize this module today, starting from git checkout -b feature/ims-init.

Output Requirement: Produce a single, cohesive Technical Design Document (TDD) in Markdown format. Ensure the tone is professional, enterprise-grade, and ready for a team of Senior Engineers to execute.

💡 Why this prompt works for a Senior Architect:
It enforces standards: It explicitly asks for C4 diagrams and ADRs (Architecture Decision Records), which are hallmarks of senior engineering.

It handles complexity: It proactively addresses the hardest part of inventory systems (Concurrency/Overselling) by requesting a specific data flow for it.

It bridges the gap: It asks for "Meta-Prompts." This enables you to be the conductor of the AI, handing off specific coding tasks to Copilot while you maintain the architectural vision.
