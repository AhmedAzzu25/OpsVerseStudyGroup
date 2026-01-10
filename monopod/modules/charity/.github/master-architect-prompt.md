Master Architect Prompt: Smart NGO & Donation Transparency Platform
Role: You are a Principal Solutions Architect specializing in "Tech for Good" and Data Integrity. Context: We are designing the "TrustLink" module for the OpsVerse Monorepo. This is a management system for NGOs in Africa/Egypt to manage donors, cases, and funds. The critical requirement is Transparency: donors must see exactly where their money went, with a guarantee that records haven't been altered. Constraints:

Architecture: Immutable Ledger Pattern.

Core Tech: Azure SQL Database Ledger (Blockchain-backed tables), Azure Bot Service (WhatsApp Integration), Power BI Embedded.

Interface: Web Dashboard (Admin) + WhatsApp Bot (Field Workers/Donors).

Security: Row-Level Security (RLS) to ensure branches only see their own data.

1. 📐 Architecture & Design Requirements
Please generate the following Mermaid diagrams and design documents:

System Context Diagram (C4 Level 1): Show Donors (Mobile/WhatsApp), Field Workers (WhatsApp/Tablet), Admin (Web), and the Immutable Ledger.

Donation Traceability Flow: Visualize the journey of a single Dollar/EGP:

Donation Received -> Logged in Ledger -> Assigned to Case #123 -> Goods Purchased -> Proof of Delivery Uploaded -> Notification to Donor.

Chatbot Architecture: Illustrate how Azure Bot Service acts as the interface for Field Workers to upload photos/coordinates of cases directly into the system via WhatsApp.

1. 📂 Monorepo Project Structure
Map out the file structure for monopod/modules/charity:

/src/api: Core CRUD for Donors/Cases.

/src/ledger-access: Specialized data layer interacting with Azure SQL Ledger tables (Append-Only).

/src/bot-adapter: C# / Node.js logic for the Azure Bot Framework (Dialogs, Media handling).

/src/public-portal: A lightweight "Transparency Dashboard" allowing public verification of fund allocation.

/iac: Terraform to deploy SQL Database with Ledger enabled.

1. 📝 Documentation Strategy (*.md)
Generate the templates for the following required documentation in /modules/charity/docs:

README.md: How to configure the WhatsApp Sandbox for local bot testing.

ADR-005-Ledger-Technology.md: Decision record explaining why Azure SQL Ledger was chosen over public Blockchain (Cost, Performance, Complexity).

TRANSPARENCY-MODEL.md: Definitions of what data is public (Aggregates) vs private (Beneficiary PII).

1. 🤖 GitHub Copilot "Meta-Prompts"
Provide a list of 5-7 specific prompts to generate the integrity logic:

Example: "Generate T-SQL code to create an 'Updatable Ledger Table' for the Donations entity ensuring that history is cryptographically protected..."

Example: "Write an Azure Bot Framework dialog flow in C# that asks a Field Worker for 'Case ID', then requests a photo upload, and saves the image to Blob Storage..."

Example: "Create a Row-Level Security (RLS) policy in SQL that prevents 'Cairo Branch' users from viewing 'Alexandria Branch' beneficiaries..."

1. 🚀 "Day 1" Implementation Plan
Provide a step-by-step execution list starting from git checkout -b feature/charity-init. Focus on provisioning the Azure SQL Ledger and connecting a simple Console App to write a tamper-proof record.

Output Requirement: Produce a single, cohesive Technical Design Document (TDD) in Markdown format. The output must demonstrate expertise in Data Governance, Cryptography applications, and Multi-channel interfaces.

💡 Why this prompt works for a Senior Architect:
It uses "Ledger" correctly: Instead of hype-driven "Blockchain," it uses Azure SQL Ledger. This is a practical, enterprise-grade skill that maps directly to Azure Data certifications.

It solves the "Last Mile" problem: NGOs struggle to get data from the field. By specifying WhatsApp Integration (via Azure Bot Service), you are solving a UX problem with an Architectural solution.

It enforces Privacy: The request for Row-Level Security (RLS) demonstrates deep SQL knowledge and data isolation practices required for sensitive humanitarian data.
