Master Architect Prompt: Smart Infrastructure & Compliance Platform
Role: You are a Principal Cloud Security Architect and Site Reliability Engineer (SRE). Context: We are initializing the "InfraGuardian" module within the OpsVerse Monorepo. This is a SaaS platform designed to monitor, audit, and automatically heal cloud infrastructure for regulated industries (Gov/Banking/Healthcare) across Europe and the Gulf. Constraints:

Architecture: Event-Driven Security Automation (The "Remediation Loop").

Core Tech: Azure Policy, Terraform, Azure Event Grid, Azure Functions.

Compliance Standards: Support for GDPR (Europe) and NESA/SAMA (Gulf).

Philosophy: "Drift is a Security Incident."

1. 📐 Architecture & Design Requirements
Please generate the following Mermaid diagrams and design documents:

System Context Diagram (C4 Level 1): Illustrate interactions between the Cloud Environment (Azure/AWS), the Compliance Officer (Dashboard), and the Remediation Engine.

The "Self-Healing" Flow Diagram: Visualize the specific loop:

Resource Change Detected (via Event Grid).

Policy Engine Evaluation (Azure Policy/OPA).

Non-Compliance Alert Triggered.

Remediation Function executes (e.g., closing an exposed Port 22).

Audit Log updated.

State Management Diagram: How we track the "Desired State" (Terraform) vs "Actual State" (Cloud) and visualize the Drift.

1. 📂 Monorepo Project Structure
Map out the file structure for monopod/modules/infra-guardian, treating Policy as Code:

/src/policies: JSON/Bicep definitions for Azure Policies (segregated by Regulatory Standard e.g., /gdpr, /iso27001).

/src/remediation-functions: Serverless functions (Python/PowerShell) that perform specific fixes (e.g., Fn-TagResources, Fn-EnforceEncryption).

/src/drift-analyzer: Service that compares Terraform State vs Real World.

/src/dashboard-api: API for the Compliance UI.

/tests/policy-tests: Automated tests validating that policies actually block bad deployments.

1. 📝 Documentation Strategy (*.md)
Generate the templates for the following required documentation in /modules/infra-guardian/docs:

README.md: Architecture overview and "How to onboard a new subscription."

ADR-003-Remediation-Strategy.md: Decision record on when to "Auto-Remediate" vs "Alert Only" (Risk acceptance criteria).

COMPLIANCE-MATRIX.md: A mapping table of Technical Controls <-> Regulatory Articles (e.g., "Azure Policy X satisfies GDPR Article Y").

1. 🤖 GitHub Copilot "Meta-Prompts"
Provide a list of 5-7 specific prompts to generate the automation logic:

Example: "Generate an Azure Policy definition in JSON that denies the creation of Public IPs on Network Interfaces unless tagged 'External'..."

Example: "Write an Azure Function in Python triggered by Event Grid that detects if a Storage Account has 'Public Access' enabled and immediately sets it to 'Disabled'..."

Example: "Create a GitHub Actions workflow that runs 'Pester' tests against my Azure Policy definitions before deploying them..."

1. 🚀 "Day 1" Implementation Plan
Provide a step-by-step execution list starting from git checkout -b feature/guardian-init. Focus on setting up the Event Grid Subscription to listen to Azure Resource Groups.

Output Requirement: Produce a single, cohesive Technical Design Document (TDD) in Markdown format. The output must demonstrate deep knowledge of Cloud Governance and Security Operations (SecOps).

💡 Why this prompt works for a Senior Architect:
It shifts left: It treats "Compliance" not as a PDF document, but as Code (/src/policies) that runs in the pipeline.

It focuses on Automation: The core value here isn't finding problems, it's fixing them (Self-Healing). The diagrams requested enforce this logic.

It creates specialized artifacts: The COMPLIANCE-MATRIX.md is exactly what a CTO or Auditor needs to see to trust your system.
