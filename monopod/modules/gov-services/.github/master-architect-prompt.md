Master Architect Prompt: Government Service Automation (GovTech)
Role: You are a Principal Enterprise Architect specializing in Public Sector Digital Transformation. Context: We are designing the "CitizenConnect" module for the OpsVerse Monorepo. This is a high-scale platform for automating government services (e.g., Housing Requests, Permits, Licenses) in Egypt/Gulf regions. It must handle massive bursts of traffic and complex, long-running approval workflows. Constraints:

Architecture: Serverless Microservices (Azure Functions) + Workflow Orchestration (Durable Functions).

Scalability: Must handle "Burst Traffic" (e.g., 100k requests in 1 hour).

Pattern: Async Request-Reply & Queue-Based Load Leveling.

Security: National ID Integration & Zero Trust.

1. 📐 Architecture & Design Requirements
Please generate the following Mermaid diagrams and design documents:

System Context Diagram (C4 Level 1): Show Citizens (Mobile App), Civil Employees (Admin Portal), Notification Systems (SMS Gateway), and the Legacy Government Mainframe (Integration layer).

Workflow State Machine Diagram: Visualize a complex "Building Permit" process using Durable Functions (Entity Framework):

Submitted -> Validation (AI) -> Engineering Review (Human) -> Payment -> Issued.

Include "Timeouts" and "Escalations" (e.g., if Engineer doesn't reply in 3 days).

Scaling Architecture Diagram: Illustrate how Azure Front Door + Event Hubs + Function Scalers handle a sudden spike in traffic without crashing the database.

1. 📂 Monorepo Project Structure
Map out the file structure for monopod/modules/gov-services:

/src/workflows: Durable Function Orchestrators (The business process definitions).

/src/activities: The atomic units of work (e.g., VerifyNationalID, CalculateFees).

/src/triggers: HTTP Triggers and Event Grid Triggers.

/src/gatekeeper: The "Burst Buffer" API that accepts requests and pushes to Queues immediately.

/src/legacy-adapters: Anti-Corruption Layer (ACL) for talking to old SOAP services.

/tests/load-tests: k6 scripts simulating 50k concurrent users.

1. 📝 Documentation Strategy (*.md)
Generate the templates for the following required documentation in /modules/gov-services/docs:

README.md: How to run the Durable Functions emulator locally.

ADR-004-Orchestration-Engine.md: Decision record comparing Logic Apps vs Durable Functions (Why code-first was chosen for complex logic).

SLA-DEFINITION.md: Technical Service Level Agreements (e.g., "Acknowledgment within 200ms, Processing within 24h").

1. 🤖 GitHub Copilot "Meta-Prompts"
Provide a list of 5-7 specific prompts to generate the orchestration logic:

Example: "Write an Azure Durable Function Orchestrator in C# for a 'License Renewal' process that waits for an external event named 'PaymentReceived' for up to 7 days..."

Example: "Generate a 'Fan-Out/Fan-In' pattern in Python to process 5,000 document validations in parallel using Azure Functions..."

Example: "Create a k6 load test script that ramps up from 0 to 10,000 VUs (Virtual Users) in 2 minutes to test the Queue trigger scaling..."

1. 🚀 "Day 1" Implementation Plan
Provide a step-by-step execution list starting from git checkout -b feature/gov-init. Focus on scaffolding the Durable Task Framework and the Queueing Mechanism.

Output Requirement: Produce a single, cohesive Technical Design Document (TDD) in Markdown format. The output must demonstrate expertise in Distributed Systems Patterns and Resilience Engineering.

💡 Why this prompt works for a Senior Architect:
It addresses "The Burst": Government systems often crash on launch day. This prompt forces the design of a Queue-Based Load Leveling architecture from the start (AZ-305).

It embraces Complexity: It explicitly asks for Durable Functions (Stateful Serverless), which is the only clean way to handle workflows that last weeks or months.

It respects Legacy: Real government projects always talk to old systems. The request for "Legacy Adapters" and an Anti-Corruption Layer shows deep real-world experience.
