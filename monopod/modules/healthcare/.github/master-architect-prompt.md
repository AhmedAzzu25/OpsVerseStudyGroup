Master Architect Prompt: Healthcare Operations Platform (Offline-First)
Role: You are a Principal Solutions Architect specializing in HealthTech and Edge Computing. Context: We are designing the "Healthcare Operations" module for the OpsVerse Monorepo. This is a SaaS platform for clinics in regions with unstable internet connectivity (Africa/Egypt). It handles patient records, inventory, and AI-driven document digitization. Constraints:

Architecture: Offline-First PWA (Progressive Web App) with "Store-and-Forward" sync.

Compliance: HIPAA/GDPR standards (Encryption at Rest/Transit).

AI: Azure AI Document Intelligence (for OCR of handwritten prescriptions).

Infrastructure: Azure Static Web Apps + Azure Functions (Serverless).

1. 📐 Architecture & Design Requirements
Please generate the following Mermaid diagrams and design documents:

System Context Diagram (C4 Level 1): Show interactions between Doctors (Offline Tablet), Receptionists (Desktop), Cloud Sync Service, and External Labs.

Sync Architecture Diagram: Visualize the "Store-and-Forward" pattern:

Local Store: PouchDB / RxDB / IndexedDB (Browser).

Sync Agent: Background service worker handling connectivity changes.

Conflict Resolution: Strategy for handling version conflicts (e.g., "Last Write Wins" vs "Manual Merge").

Data Flow (AI OCR): Visualize the pipeline: Upload Image -> Queue -> Azure AI Analysis -> JSON Extraction -> Human Review -> Database Commit.

1. 📂 Monorepo Project Structure
Map out the file structure for monopod/modules/healthcare focusing on the duality of Client/Server:

/src/client-pwa: The Frontend (React/Blazor WASM) with Service Workers.

/src/sync-service: Azure Functions handling data synchronization.

/src/ai-processor: Python/C# function wrapping Azure AI Document Intelligence.

/src/shared: Shared Data Transfer Objects (DTOs) and Validation Logic (must be shared between Client/Server to ensure offline validation).

/iac: Terraform for Azure Static Web Apps, Cosmos DB, and Storage Accounts.

1. 📝 Documentation Strategy (*.md)
Generate the templates for the following required documentation in /modules/healthcare/docs:

README.md: Setup instructions for the local emulator.

ADR-002-Offline-Strategy.md: Decision record explaining the choice of local storage technology and the specific Conflict Resolution Algorithm.

COMPLIANCE.md: Checklist for Data Anonymization and Encryption protocols.

1. 🤖 GitHub Copilot "Meta-Prompts"
Provide a list of 5-7 specific prompts to generate the complex logic:

Example: "Generate a TypeScript Service Worker that caches API GET requests using the 'Stale-While-Revalidate' strategy..."

Example: "Write an Azure Function trigger that processes a blob image, calls the Document Intelligence API, and maps the result to the PatientPrescription entity..."

Example: "Create a Cosmos DB Policy for enforcing encryption at rest using Customer-Managed Keys..."

1. 🚀 "Day 1" Implementation Plan
Provide a step-by-step execution list starting from git checkout -b feature/health-init, focusing on setting up the Local Development Emulator for offline testing.

Output Requirement: Produce a single, cohesive Technical Design Document (TDD) in Markdown format. Ensure the tone represents 25+ years of architectural experience, prioritizing robustness and data integrity over speed.

💡 Why this prompt works for a Senior Architect:
It tackles the hardest problem first: In offline apps, Data Sync and Conflict Resolution are the killers. This prompt forces the AI to define these strategies before writing code.

It separates concerns: It clearly distinguishes between the "Client Side" (PWA) and the "Cloud Side" (Serverless), which is crucial for this architecture.

It emphasizes Compliance: HealthTech requires strict governance; this prompt ensures security is baked into the design docs (COMPLIANCE.md) and infrastructure (Encryption) from Day 1.
