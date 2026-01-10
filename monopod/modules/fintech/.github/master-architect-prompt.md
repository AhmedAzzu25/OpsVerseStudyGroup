Master Architect Prompt: FinTech Risk & Real-Time Compliance
Role: You are a Principal Data Architect and Security Lead for a Digital Bank. Context: We are designing the "FinGuard" module for the OpsVerse Monorepo. This is a mission-critical subsystem that processes financial transactions in real-time to detect fraud (Risk) and ensure regulatory reporting (Compliance) across Europe and the Gulf. Constraints:

Architecture: Real-Time Stream Processing (Kappa Architecture).

Performance: < 200ms latency for fraud decisions.

Throughput: Must handle 10,000 transactions per second (TPS).

Security: "Confidential Computing" standards (Always Encrypted, Private Links).

1. 📐 Architecture & Design Requirements
Please generate the following Mermaid diagrams and design documents:

Data Flow Diagram (The Hot Path): Visualize the journey of a transaction:

POS Terminal -> API Gateway -> Event Hubs (Ingestion) -> Stream Analytics (Fraud Rules) -> Cosmos DB (Hot Store) -> Decision (Approve/Reject).

Network Security Diagram: Illustrate the "Zero Trust" network:

Show how Azure Functions and SQL Databases are isolated inside VNETs with Private Endpoints.

Show the "Bastion Host" for secure admin access.

Geo-Redundancy Diagram: Show how data is replicated between West Europe (Primary) and UAE North (Secondary) considering data residency laws (sharding by region).

1. 📂 Monorepo Project Structure
Map out the file structure for monopod/modules/fintech, focusing on DataOps:

/src/ingestor: High-performance API (Go or .NET 8) sending events to Event Hubs.

/src/stream-jobs: SQL queries for Azure Stream Analytics (ASA) or PySpark scripts.

/src/risk-engine: The rules engine (e.g., "If amount > $5k AND location changed").

/src/compliance-reporter: Batch jobs generating nightly regulatory XML reports.

/tests/security: Automated penetration testing scripts (OWASP ZAP).

1. 📝 Documentation Strategy (*.md)
Generate the templates for the following required documentation in /modules/fintech/docs:

README.md: How to generate synthetic transaction data for load testing.

THREAT-MODEL.md: A formal STRIDE analysis of the system (Spoofing, Tampering, etc.) and mitigations.

DATA-DICTIONARY.md: Definition of the Transaction Schema (ISO 8583 mapping) and Privacy classification (PII/Non-PII).

1. 🤖 GitHub Copilot "Meta-Prompts"
Provide a list of 5-7 specific prompts to generate the streaming logic:

Example: "Write an Azure Stream Analytics query using a 'Sliding Window' of 5 minutes to detect if the same Credit Card ID performs more than 3 transactions from different cities..."

Example: "Generate a Terraform script to deploy an Azure SQL Database with 'Always Encrypted' enabled and a Customer-Managed Key stored in Key Vault..."

Example: "Create a C# service that encrypts PII fields (Name, PAN) at the application level before sending the object to the Event Hub..."

1. 🚀 "Day 1" Implementation Plan
Provide a step-by-step execution list starting from git checkout -b feature/fintech-init. Focus on provisioning the Event Hub namespace and a basic Stream Analytics Job.

Output Requirement: Produce a single, cohesive Technical Design Document (TDD) in Markdown format. The output must demonstrate expertise in Data Privacy, Latency Optimization, and Financial Regulations (PCI-DSS/GDPR).

💡 Why this prompt works for a Senior Architect:
It emphasizes Speed: In FinTech, "Slow" equals "Broken." The request for Stream Analytics and Sliding Windows proves you understand real-time constraints.

It demands Security: You aren't just building a database; you are building a vault. The request for Private Endpoints, VNETs, and Always Encrypted is mandatory for this level.

It uses Standard Models: Referencing STRIDE (Threat Modeling) and ISO 8583 (Financial Transaction Standard) signals high domain expertise.
