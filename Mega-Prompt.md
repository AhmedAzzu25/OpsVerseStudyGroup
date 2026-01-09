Role: You are a Technical Program Manager and Solutions Architect. Task: Generate a Bash Script (setup_repo.sh) to scaffold a complete study group repository named OpsVerse-StudyGroup. Context: This repository is for a team of engineers working full-time who are upskilling in Cloud, DevOps, and AI. They follow a specific roadmap (10 certs) and build a unified Monorepo ("OpsVerse").

Requirements: Please write a script that performs the following actions:

1. 📂 Directory Structure
Create the following folder hierarchy:

docs/certifications (Path & Resources)

docs/internal-courses (The Mentor's DevOps tracks)

management/timesheets (Tracking progress)

career/cv-assets (Templates for resumes)

monopod (The Main Codebase)

monopod/modules (The 8 Domains: ims, healthcare, infra-guardian, gov-services, fintech, ops-agent, charity, logistics)

monopod/platform (Shared services: auth, gateway)

monopod/infra (Terraform)

monopod/.github/workflows (CI/CD)

2. 📝 Documentation Files (Populate with Content)
Create these specific Markdown files with the content described:

README.md (Root): An inspiring introduction to the "OpsVerse" initiative. Explain that this is a "Learn by Building" repo. List the 8 projects briefly.

management/TIMESHEET.md: Create a tracking table with columns: Member Name, Week #, Study Hours, Coding Hours, Cert Progress, Blockers.

docs/certifications/ROADMAP.md: Create a table listing the certification order:

GitHub Foundations (Easy)

GitHub Actions (Easy)

Terraform Associate (Intermediate)

AZ-204 Azure Developer (Intermediate)

AZ-400 DevOps Expert (The Milestone)

AZ-305 Solutions Architect (Advanced) Add a column for "Recommended Study Links" (placeholder for MS Learn/Udemy).

docs/internal-courses/SYLLABUS.md: Create a schedule for the internal mentor resources:

Track A: Master DevOps (17 Weeks) - List placeholders for Week 1-17.

Track B: Intro to DevOps (13 Weeks) - List placeholders for Week 1-13.

career/CAREER_SYNC_GUIDE.md: Write a guide on how to sync study with job hunting.

Rule: "Finish IMS Module -> Add 'Event-Driven Microservices' to CV."

Rule: "Finish Infra Module -> Add 'Policy-as-Code' to CV."

3. 🧠 The "Meta-Prompts" (Project Generators)
Crucial Step: Inside EACH module folder in monopod/modules/, create a file named INSTRUCTIONS_FOR_COPILOT.md. Populate these files with the specific architectural context for that project so a member can checkout the branch, open this file, and tell Copilot "Execute this plan."

monopod/modules/ims/INSTRUCTIONS_FOR_COPILOT.md:

Context: Smart Supply Chain for SMEs.

Tech: .NET 8 API, Event-Driven (RabbitMQ), Optimistic Concurrency.

Task: "Scaffold a Clean Architecture solution with Domain, Application, Infrastructure layers. Implement the 'Outbox Pattern'."

monopod/modules/healthcare/INSTRUCTIONS_FOR_COPILOT.md:

Context: Offline-First Clinic App for Africa.

Tech: React PWA, PouchDB (Local), Azure Functions (Sync).

Task: "Generate a React PWA structure with a Service Worker for caching. Create a Sync logic to upload local JSON documents to Cosmos DB when online."

monopod/modules/infra-guardian/INSTRUCTIONS_FOR_COPILOT.md:

Context: Self-Healing Compliance Platform.

Tech: Azure Policy, Event Grid, Python Functions.

Task: "Write a Terraform script to deploy a 'Deny-Public-IP' policy. Write a Python function triggered by Event Grid to auto-close Port 22."

monopod/modules/gov-services/INSTRUCTIONS_FOR_COPILOT.md:

Context: Government Service Automation (Burst Scale).

Tech: Azure Durable Functions, Queue-Based Load Leveling.

Task: "Create a Durable Function Orchestrator for a 'Building Permit' workflow involving 3 approval steps and a timeout."

monopod/modules/fintech/INSTRUCTIONS_FOR_COPILOT.md:

Context: Real-Time Fraud Detection.

Tech: Azure Stream Analytics, Event Hubs, Confidential Computing.

Task: "Generate a Stream Analytics query with a Sliding Window to detect fraud. Write Terraform for an SQL DB with 'Always Encrypted'."

monopod/modules/ops-agent/INSTRUCTIONS_FOR_COPILOT.md:

Context: DevOps AI Copilot (RAG).

Tech: Azure OpenAI, Vector Search, LangChain.

Task: "Scaffold a Python FastAPI service. Implement a RAG pipeline that searches local Markdown files and answers DevOps questions."

monopod/modules/charity/INSTRUCTIONS_FOR_COPILOT.md:

Context: Immutable NGO Ledger.

Tech: Azure SQL Ledger, Azure Bot Service (WhatsApp).

Task: "Generate SQL scripts to create Updateable Ledger Tables. Create a C# Bot Dialog that accepts photos from WhatsApp."

monopod/modules/logistics/INSTRUCTIONS_FOR_COPILOT.md:

Context: IoT Fleet Monitoring.

Tech: Azure IoT Hub, Digital Twins, Edge Containers.

Task: "Create a DTDL model for a 'Truck'. Write a Python script for an IoT Edge module that filters temperature data."

Final Output: Ensure the script uses mkdir -p to be safe and cat <<EOT >> filename to populate the files with rich text content.