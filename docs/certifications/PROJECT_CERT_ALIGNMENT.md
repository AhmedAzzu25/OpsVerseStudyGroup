# 🎯 Project-Certification Alignment Matrix

Strategic mapping between OpsVerse projects and certification exam objectives.

---

## 📊 Overview

| Certification | Total Hours | Aligned Projects | Study Timeline |
|---------------|-------------|------------------|----------------|
| GitHub Foundations | 20h | All (CI/CD setup) | Week 1 |
| GitHub Actions | 25h | IMS, Healthcare, Infra-Guardian | Week 2-3 |
| Terraform Associate | 40h | Infra-Guardian, Fintech, Logistics | Week 4-6 |
| AZ-204 Azure Developer | 60h | Healthcare, Gov-Services, Ops-Agent | Week 7-10 |
| AZ-400 DevOps Expert | 80h | All 8 Projects | Week 11-16 ⭐ |
| AZ-305 Solutions Architect | 100h | All 8 Projects | Week 17-24 |

---

## 🔹 1. GitHub Foundations (20 Hours)

### Exam Topics Covered

- Git basics: branching, merging, pull requests
- GitHub workflow: Issues, Projects, Wikis
- Collaboration: Code reviews, branch protection

### Aligned Projects: **ALL** (Monorepo setup)

- ✅ Set up `monopod` repository structure
- ✅ Create branch protection rules
- ✅ Implement PR templates
- ✅ Use GitHub Issues for task tracking

### Practice Tasks

```bash
# Initialize Git for monorepo
git init
git remote add origin <repo_url>

# Create feature branches per module
git checkout -b feat/ims-module
git checkout -b feat/healthcare-module

# Practice PR workflow
git push origin feat/ims-module
# Create PR via GitHub UI
```

### Certification Focus

- 40% Git fundamentals
- 30% GitHub features
- 30% Collaboration best practices

---

## 🔹 2. GitHub Actions (25 Hours)

### Exam Topics Covered

- Workflow syntax (YAML)
- Triggers: push, pull_request, schedule, workflow_dispatch
- Jobs, steps, actions marketplace
- Secrets management
- Matrix builds, caching, artifacts

### Aligned Projects

| Project | CI/CD Workflow | Complexity |
|---------|----------------|------------|
| **IMS** | .NET build + test + Docker | ⭐⭐⭐ |
| **Healthcare** | React build + Lighthouse CI | ⭐⭐ |
| **Infra-Guardian** | Terraform validate + plan | ⭐⭐⭐ |

### Sample Workflow (IMS Module)

```yaml
# .github/workflows/ims-ci.yml
name: IMS CI/CD

on:
  push:
    branches: [main]
    paths: ['monopod/modules/ims/**']
  pull_request:
    paths: ['monopod/modules/ims/**']

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: '8.0.x'
      
      - name: Restore dependencies
        run: dotnet restore monopod/modules/ims/IMS.sln
      
      - name: Build
        run: dotnet build monopod/modules/ims/IMS.sln --no-restore
      
      - name: Test
        run: dotnet test monopod/modules/ims/IMS.sln --no-build --verbosity normal
      
      - name: Build Docker image
        run: docker build -t ims-api:${{ github.sha }} monopod/modules/ims
```

### Certification Focus

- 50% Workflow authoring
- 30% Actions marketplace
- 20% Advanced features (matrix, caching)

---

## 🔹 3. Terraform Associate (40 Hours)

### Exam Topics Covered

- HCL syntax and structure
- State management (local, remote, locking)
- Variables, outputs, data sources
- Modules and workspaces
- Provider configuration (Azure, AWS)

### Aligned Projects

| Project | Terraform Components | Exam Skills |
|---------|---------------------|-------------|
| **Infra-Guardian** | Azure Policy, Event Grid, Functions | Modules, Variables ⭐⭐⭐ |
| **Fintech** | Event Hub, Stream Analytics, SQL | State Management ⭐⭐⭐ |
| **Logistics** | IoT Hub, Digital Twins, Storage | Data Sources ⭐⭐ |

### Sample Infrastructure (Infra-Guardian)

```hcl
# monopod/modules/infra-guardian/main.tf
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate${var.environment}"
    container_name       = "tfstate"
    key                  = "infra-guardian.tfstate"
  }
}

module "policy_definitions" {
  source = "./modules/policies"
  
  environment = var.environment
  policies = {
    deny_public_ip = true
    enforce_tags   = true
  }
}

module "event_grid" {
  source = "./modules/event-grid"
  
  topic_name          = "policy-violations"
  subscription_name   = "auto-remediate"
  endpoint_url        = module.functions.remediation_url
}
```

### Certification Focus

- 30% Terraform basics (commands, workflow)
- 25% Configuration syntax (HCL)
- 20% State management
- 15% Modules
- 10% Providers and provisioners

---

## 🔹 4. AZ-204 Azure Developer (60 Hours)

### Exam Topics Covered

- Azure Functions (HTTP, Timer, Durable)
- Cosmos DB, Blob Storage, Service Bus
- Azure AD authentication (MSAL)
- Application Insights monitoring
- Azure Container Instances/Apps

### Aligned Projects

| Project | AZ-204 Services | Exam Weight |
|---------|-----------------|-------------|
| **Healthcare** | Functions (sync), Cosmos DB, Blob Storage | 40% ⭐⭐⭐ |
| **Gov-Services** | Durable Functions, Storage Queues | 30% ⭐⭐⭐ |
| **Ops-Agent** | Azure OpenAI, Cognitive Search, Container Apps | 20% ⭐⭐ |
| **Charity** | Bot Service, SQL Database, Blob Storage | 10% ⭐ |

### Key Implementation: Healthcare Sync Function

```javascript
// Azure Function - Patient Sync (AZ-204: Develop Azure compute solutions)
const { CosmosClient } = require("@azure/cosmos");

module.exports = async function (context, req) {
    // Topic: Azure Functions (15-20% of exam)
    const client = new CosmosClient(process.env.COSMOS_CONNECTION);
    const database = client.database("clinic-db");
    const container = database.container("patients");
    
    // Topic: Cosmos DB operations (10-15% of exam)
    const { resources } = await container.items
        .query({
            query: "SELECT * FROM c WHERE c._ts > @lastSync",
            parameters: [{ name: "@lastSync", value: req.body.lastSync }]
        })
        .fetchAll();
    
    // Topic: Blob Storage (5-10% of exam) - for attachments
    const blobServiceClient = BlobServiceClient.fromConnectionString(
        process.env.STORAGE_CONNECTION
    );
    
    context.res = {
        status: 200,
        body: { changes: resources }
    };
    
    // Topic: Application Insights (monitoring - 10-15% of exam)
    context.log(`Synced ${resources.length} patient records`);
};
```

### Certification Focus (AZ-204 Breakdown)

- **20%** Develop Azure compute solutions (Functions, Container Apps)
- **15%** Develop for Azure storage (Blob, Cosmos, Queue)
- **20%** Implement Azure security (Key Vault, Managed Identity, MSAL)
- **15%** Monitor, troubleshoot, optimize (App Insights, logging)
- **15%** Connect to and consume Azure services (Service Bus, Event Grid)
- **15%** Implement API Management

---

## 🔹 5. AZ-400 DevOps Expert (80 Hours) ⭐ MILESTONE

### Exam Topics Covered

- DevOps transformation strategies
- Source control (Git, branching strategies)
- CI/CD pipelines (GitHub Actions, Azure Pipelines)
- Dependency management
- Infrastructure as Code (Terraform, Bicep)
- Security and compliance (Policy, DevSecOps)
- Monitoring and feedback loops

### Aligned Projects: **ALL 8 MODULES**

| Project | AZ-400 Domain | Skills Demonstrated |
|---------|---------------|---------------------|
| **IMS** | CI/CD + Dependency Mgmt | Docker, NuGet packages, pipeline stages ⭐⭐⭐ |
| **Healthcare** | Continuous Delivery | Progressive deployment, feature flags ⭐⭐ |
| **Infra-Guardian** | Policy as Code | Azure Policy, compliance automation ⭐⭐⭐ |
| **Gov-Services** | Release Management | Load testing, burst handling, rollback ⭐⭐ |
| **Fintech** | Security in DevOps | Secret scanning, Always Encrypted, threat modeling ⭐⭐⭐ |
| **Ops-Agent** | Monitoring & Feedback | App Insights, AI telemetry, alerting ⭐⭐ |
| **Charity** | Compliance & Auditing | Immutable logs, audit trails, SOC2 readiness ⭐⭐ |
| **Logistics** | IoT DevOps | Over-the-air updates, edge deployment ⭐⭐ |

### End-to-End Pipeline Example (IMS)

```yaml
# Complete CI/CD Pipeline (AZ-400: Design and implement build and release pipelines)
name: IMS Complete DevOps Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  AZURE_SUBSCRIPTION: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
  REGISTRY: ghcr.io
  IMAGE_NAME: opsverse/ims-api

jobs:
  # 1. Code Quality & Security Scanning
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      # AZ-400: Implement security and compliance
      - name: Run Dependency Check
        uses: dependency-check/Dependency-Check_Action@main
      
      - name: Secret Scanning
        uses: trufflesecurity/trufflehog@main
      
      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@master
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}

  # 2. Build & Test
  build:
    needs: security-scan
    runs-on: ubuntu-latest
    strategy:
      matrix:
        dotnet-version: ['8.0.x']
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup .NET ${{ matrix.dotnet-version }}
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: ${{ matrix.dotnet-version }}
      
      - name: Restore dependencies
        run: dotnet restore
      
      - name: Build
        run: dotnet build --configuration Release
      
      # AZ-400: Implement continuous testing
      - name: Unit Tests
        run: dotnet test --filter Category=Unit --logger trx
      
      - name: Integration Tests
        run: dotnet test --filter Category=Integration
      
      # AZ-400: Package management
      - name: Publish Artifacts
        run: dotnet publish -c Release -o ./artifacts

  # 3. Container Build & Push
  containerize:
    needs: build
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    steps:
      - uses: actions/checkout@v3
      
      # AZ-400: Containerization strategy
      - name: Log in to Container Registry
        uses: docker/login-action@v2
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      
      - name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: |
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
            ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:latest
          cache-from: type=gha
          cache-to: type=gha,mode=max

  # 4. Infrastructure Deployment
  infrastructure:
    needs: containerize
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v3
      
      # AZ-400: Infrastructure as Code
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Terraform Init
        run: terraform init
        working-directory: ./monopod/infra
      
      - name: Terraform Plan
        run: terraform plan -out=tfplan
        working-directory: ./monopod/infra
      
      - name: Terraform Apply
        run: terraform apply -auto-approve tfplan
        working-directory: ./monopod/infra

  # 5. Deploy to Azure
  deploy:
    needs: [containerize, infrastructure]
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      # AZ-400: Release management
      - name: Deploy to Azure Container Apps
        uses: azure/container-apps-deploy-action@v1
        with:
          resource-group: opsverse-rg
          container-app-name: ims-api
          image: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}

  # 6. Post-Deployment Verification
  smoke-test:
    needs: deploy
    runs-on: ubuntu-latest
    steps:
      # AZ-400: Monitoring and feedback
      - name: Health Check
        run: |
          curl -f https://ims-api.azurecontainerapps.io/health || exit 1
      
      - name: Performance Test
        run: |
          npm install -g artillery
          artillery run ./tests/load-test.yml
```

### Certification Focus (AZ-400 Breakdown)

- **25%** Design and implement processes and communications
- **20%** Design and implement source control
- **35%** Design and implement build and release pipelines ⭐
- **20%** Develop security and compliance plan

### Study Plan for AZ-400

1. **Weeks 11-12**: Source control + branching strategies (all modules)
2. **Weeks 13-14**: CI/CD pipelines (IMS, Healthcare, Infra-Guardian)
3. **Weeks 15**: Security & compliance (Fintech, Infra-Guardian)
4. **Week 16**: Mock exams + final review

---

## 🔹 6. AZ-305 Solutions Architect (100 Hours)

### Exam Topics Covered

- Design identity, governance, and monitoring solutions
- Design data storage solutions
- Design business continuity solutions
- Design infrastructure solutions (compute, networking, migrations)

### Aligned Projects: **ALL 8 MODULES (Architecture Focus)**

| Architectural Pattern | Project Examples | AZ-305 Skill Area |
|----------------------|------------------|-------------------|
| **Event-Driven Architecture** | IMS (Outbox), Fintech (Stream) | Design data storage ⭐⭐⭐ |
| **Microservices** | IMS, Platform (Auth, Gateway) | Design infrastructure ⭐⭐⭐ |
| **Serverless** | Healthcare, Gov-Services, Infra-Guardian | Design compute solutions ⭐⭐ |
| **Offline-First** | Healthcare (PouchDB sync) | Design business continuity ⭐⭐ |
| **IoT Architecture** | Logistics (Digital Twins, Edge) | Design infrastructure ⭐⭐ |
| **AI/ML Integration** | Ops-Agent (RAG pipeline) | Design data solutions ⭐⭐ |
| **Compliance & Governance** | Infra-Guardian, Charity | Design governance ⭐⭐⭐ |

### Architecture Decision Records (ADRs)

Create ADRs for each module to practice architecture documentation:

#### Example: IMS - Why RabbitMQ over Azure Service Bus?

**Decision**: Use RabbitMQ for IMS event messaging

**Context**:

- Need guaranteed message delivery
- Local development without cloud dependencies
- Cost optimization for SME scenario

**Alternatives Considered**:

1. Azure Service Bus (managed, higher cost)
2. Apache Kafka (over-engineered for SME scale)
3. RabbitMQ (self-hosted, flexible)

**Decision Rationale**:

- **Cost**: $0 for dev, ~$50/month production vs $250+ for Service Bus
- **Features**: Outbox pattern works equally well with any broker
- **Skills**: Transferable knowledge (works on any cloud)

**Consequences**:

- Must manage RabbitMQ deployment (Docker/K8s)
- Need monitoring setup (Prometheus + Grafana)
- Gain deeper understanding of message broker internals

*This type of thinking is EXACTLY what AZ-305 tests!*

### Certification Focus (AZ-305 Breakdown)

- **25%** Design identity, governance, and monitoring solutions
- **25%** Design data storage solutions
- **15%** Design business continuity solutions
- **35%** Design infrastructure solutions

---

## 📅 Integrated Study Timeline

### Phase 1: Foundations (Weeks 1-3)

- **Week 1**: GitHub Foundations cert + Monorepo setup
- **Week 2-3**: GitHub Actions cert + CI/CD for 3 modules

### Phase 2: Infrastructure (Weeks 4-6)

- **Weeks 4-6**: Terraform Associate cert + Deploy Infra-Guardian, Fintech, Logistics

### Phase 3: Development (Weeks 7-10)

- **Weeks 7-10**: AZ-204 cert + Build Healthcare, Gov-Services, Ops-Agent

### Phase 4: DevOps Mastery (Weeks 11-16) ⭐

- **Weeks 11-16**: AZ-400 cert + Complete all 8 modules with full CI/CD

### Phase 5: Architecture (Weeks 17-24)

- **Weeks 17-24**: AZ-305 cert + Refactor for production, write ADRs

---

## 🎯 Success Metrics

Track your progress weekly:

| Week | Cert Progress | Projects Completed | Skills Unlocked |
|------|---------------|-------------------|-----------------|
| 1 | GitHub Foundations ✅ | Monorepo setup | Git workflow |
| 3 | GitHub Actions ✅ | IMS, Healthcare CI/CD | YAML pipelines |
| 6 | Terraform ✅ | Infra deployed | IaC patterns |
| 10 | AZ-204 ✅ | 6/8 modules | Azure services |
| 16 | AZ-400 ✅ | All 8 modules | Full DevOps lifecycle |
| 24 | AZ-305 ✅ | Production-ready | Solution architecture |

---

## 💡 Pro Tips

### Exam Preparation Strategy

1. **Hands-On First**: Build the project, THEN study the cert
2. **Documentation**: Your README becomes your study guide
3. **Teach Others**: Explain each module to teammates (Feynman technique)
4. **Practice Exams**: Use MS Learn practice assessments after each module

### Project-Based Learning Loop

```
Build Project → Encounter Problem → Research Solution → Pass Cert Exam
     ↑                                                          ↓
     ←──────────────── Apply New Knowledge ←────────────────────
```

### Resume Building

After each certification:

- Update LinkedIn with badge
- Add project to portfolio
- Write blog post explaining architecture
- Present to team during Friday sync

---

## 📚 Additional Exam Resources

### Official Microsoft Learning Paths

- [AZ-204](https://learn.microsoft.com/en-us/certifications/exams/az-204/)
- [AZ-400](https://learn.microsoft.com/en-us/certifications/exams/az-400/)
- [AZ-305](https://learn.microsoft.com/en-us/certifications/exams/az-305/)

### Third-Party Platforms

- **A Cloud Guru**: Video courses with hands-on labs
- **Pluralsight**: Skill assessments + learning paths
- **Udemy**: Practice exams (Scott Duffy, Alan Rodrigues)
- **WhizLabs**: Mock exams with detailed explanations

### Community Resources

- [r/AzureCertification](https://reddit.com/r/AzureCertification) - Exam tips
- [Azure DevOps Community](https://dev.azure.com/azuredevopscommunity) - Best practices
- [HashiCorp Community](https://discuss.hashicorp.com/) - Terraform help

---

**🎉 Remember**: Your OpsVerse projects aren't just code—they're your living study guide! Every line you write is exam prep.

**Let's build and certify! 💪**
