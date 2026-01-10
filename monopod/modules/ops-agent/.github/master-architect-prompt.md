Master Architect Prompt: DevOps AI Copilot (The "OpsAgent")
Role: You are a Principal AI Engineer and Platform Engineering Lead. Context: We are building the "OpsAgent" module for the OpsVerse Monorepo. This is an internal AI assistant designed to help our developers and ops teams debug CI/CD failures, generate compliant Terraform code, and query cloud logs using natural language. Constraints:

Architecture: RAG (Retrieval-Augmented Generation) pipeline.

Core Tech: Azure OpenAI Service (GPT-4), Azure AI Search (Vector Store), Cosmos DB (Memory).

Interfaces: CLI Tool (ops-cli) and a VS Code Extension.

Security: The AI must respect RBAC (cannot reveal secrets or Prod data to unauthorized users).

1. 📐 Architecture & Design Requirements
Please generate the following Mermaid diagrams and design documents:

RAG Architecture Diagram: Visualize the knowledge pipeline:

Ingestion: Git Docs / Terraform Modules / Runbooks -> Chunking -> Embedding Model -> Vector Database.

Query: User Question -> Similarity Search -> Context Injection -> GPT-4 -> Answer.

Agent Logic Flow: Show how the agent decides to use "Tools":

User asks: "Why did the build fail?"

Agent Action: Calls GitHub API to fetch logs.

Agent Action: Analyzes logs against KnownErrors database.

Agent Response: Explains the error and suggests a fix.

Security Data Flow: Illustrate how we scrub Secrets/PII from prompts before sending them to OpenAI.

1. 📂 Monorepo Project Structure
Map out the file structure for monopod/modules/ops-agent:

/src/backend-api: Python (FastAPI) or C# Semantic Kernel service handling the LLM logic.

/src/vector-indexer: Background job that watches the Monorepo for changes and updates embeddings.

/src/cli: Go or Rust CLI tool that developers run (e.g., ops ask "how do I deploy to stage?").

/src/vscode-ext: TypeScript code for the IDE side panel.

/knowledge-base: Markdown files specifically formatted for AI ingestion (Golden Paths, Standards).

1. 📝 Documentation Strategy (*.md)
Generate the templates for the following required documentation in /modules/ops-agent/docs:

MODEL-CARD.md: Definition of the AI Model, its temperature settings, limitations, and "System Prompt".

PROMPT-ENGINEERING-GUIDE.md: Best practices used within the code (Chain-of-Thought, ReAct pattern).

PRIVACY-POLICY.md: Explicit statement on data retention (e.g., "Prompts are not used to train the public model").

1. 🤖 GitHub Copilot "Meta-Prompts"
Provide a list of 5-7 specific prompts to generate the AI logic:

Example: "Write a Python function using LangChain/Semantic Kernel that takes a user query, searches Azure AI Search for the top 3 relevant 'Terraform Modules', and formats a prompt for GPT-4..."

Example: "Generate a PII Scrubber function that uses Regex to replace credit card numbers and API keys with [REDACTED] before sending text to the LLM..."

Example: "Create a Go CLI command structure using 'Cobra' that accepts a string argument, sends it to the backend API, and streams the response to the terminal..."

1. 🚀 "Day 1" Implementation Plan
Provide a step-by-step execution list starting from git checkout -b feature/ops-agent-init. Focus on setting up the Azure OpenAI resource and the basic "Hello World" RAG pipeline.

Output Requirement: Produce a single, cohesive Technical Design Document (TDD) in Markdown format. The output must demonstrate expertise in LLM Ops (LLMOps), Vector Embeddings, and Developer Experience (DevEx).

💡 Why this prompt works for a Senior Architect:
It focuses on "RAG" (Retrieval-Augmented Generation): This is the standard for Enterprise AI. It ensures the AI answers based on your docs, not just general internet knowledge.

It demands Security: Sending code/logs to AI is risky. The request for PII Scrubbing and RBAC shows you understand Enterprise Risk.

It builds Tools, not just Apps: Creating a CLI and VS Code Extension is a pure Platform Engineering move, distinguishing you as someone who improves the productivity of the entire team.
