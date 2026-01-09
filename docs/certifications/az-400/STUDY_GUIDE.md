# 🎯 AZ-400: DevOps Engineer Expert - Study Guide

**Exam Code**: AZ-400  
**Duration**: 150 minutes  
**Questions**: 40-60 questions  
**Passing Score**: 700/1000  
**Cost**: $165 USD  
**Prerequisites**: AZ-104 or AZ-204  
**Estimated Study Time**: 80 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Implement Instrumentation Strategy | 5-10% | 6h | ⏳ |
| 2. Implement SRE Strategy | 5-10% | 6h | ⏳ |
| 3. Implement Security & Compliance Plan | 10-15% | 10h | ⏳ |
| 4. Manage Source Control | 10-15% | 10h | ⏳ |
| 5. Facilitate Communication & Collaboration | 10-15% | 10h | ⏳ |
| 6. Define & Implement CI | 20-25% | 18h | ⏳ |
| 7. Define & Implement CD | 10-15% | 10h | ⏳ |
| 8. Implement Dependency Management | 5-10% | 10h | ⏳ |

---

## 📚 Domain 6: Define and Implement CI (20-25%) ⭐ HIGHEST WEIGHT

### Azure Pipelines YAML

```yaml
trigger:
  branches:
    include:
      - main
      - develop
  paths:
    include:
      - src/*
    exclude:
      - docs/*

pool:
  vmImage: 'ubuntu-latest'

variables:
  buildConfiguration: 'Release'
  
stages:
- stage: Build
  jobs:
  - job: BuildJob
    steps:
    - task: UseDotNet@2
      inputs:
        version: '8.x'
    
    - task: DotNetCoreCLI@2
      displayName: 'dotnet build'
      inputs:
        command: 'build'
        projects: '**/*.csproj'
        arguments: '--configuration $(buildConfiguration)'
    
    - task: DotNetCoreCLI@2
      displayName: 'dotnet test'
      inputs:
        command: 'test'
        projects: '**/*Tests.csproj'
        arguments: '--configuration $(buildConfiguration) --collect:"XPlat Code Coverage"'
    
    - task: PublishCodeCoverageResults@1
      inputs:
        codeCoverageTool: 'Cobertura'
        summaryFileLocation: '$(Agent.TempDirectory)/**/coverage.cobertura.xml'

- stage: Security
  jobs:
  - job: SecurityScan
    steps:
    - task: CredScan@3
    
    - task: ComponentGovernanceComponentDetection@0
      inputs:
        scanType: 'Register'
```

### Multi-Stage Pipeline with Approvals

```yaml
stages:
- stage: Build
  jobs:
  - job: BuildApp
    steps:
    - script: echo Building app

- stage: DeployDev
  dependsOn: Build
  jobs:
  - deployment: DeployDev
    environment: 'development'
    strategy:
      runOnce:
        deploy:
          steps:
          - script: echo Deploying to dev

- stage: DeployProd
  dependsOn: DeployDev
  jobs:
  - deployment: DeployProd
    environment: 'production'  # Requires manual approval
    strategy:
      runOnce:
        deploy:
          steps:
          - script: echo Deploying to prod
```

---

## 📚 Domain 3: Implement Security & Compliance (10-15%)

### Azure Key Vault in Pipeline

```yaml
steps:
- task: AzureKeyVault@2
  inputs:
    azureSubscription: 'MyServiceConnection'
    KeyVaultName: 'mykeyvault'
    SecretsFilter: '*'
    RunAsPreJob: true

- script: |
    echo "Using secret: $(MySecret)"
```

### Service Principal Management

```bash
# Create service principal
az ad sp create-for-rbac \
  --name "myapp-sp" \
  --role contributor \
  --scopes /subscriptions/{subscription-id} \
  --sdk-auth

# Assign to Key Vault
az keyvault set-policy \
  --name mykeyvault \
  --spn <app-id> \
  --secret-permissions get list
```

---

## 📚 Domain 7: Define and Implement CD (10-15%)

### Blue-Green Deployment

```yaml
- stage: BlueGreenDeploy
  jobs:
  - deployment: DeployGreen
    environment: production
    strategy:
      runOnce:
        deploy:
          steps:
          - task: AzureWebApp@1
            inputs:
              azureSubscription: 'MyConnection'
              appName: 'myapp'
              deployToSlotOrASE: true
              resourceGroupName: 'myrg'
              slotName: 'green'
              package: '$(Pipeline.Workspace)/**/*.zip'
          
          - task: AzureAppServiceManage@0
            displayName: 'Swap Slots'
            inputs:
              azureSubscription: 'MyConnection'
              action: 'Swap Slots'
              webAppName: 'myapp'
              resourceGroupName: 'myrg'
              sourceSlot: 'green'
```

### Canary Deployment with Kubernetes

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-canary
spec:
  replicas: 1  # 10% of traffic
  selector:
    matchLabels:
      app: myapp
      version: canary
  template:
    metadata:
      labels:
        app: myapp
        version: canary
    spec:
      containers:
      - name: myapp
        image: myapp:v2.0
```

---

## 📚 Domain 4: Manage Source Control (10-15%)

### Branch Policies (Azure Repos)

```json
{
  "isEnabled": true,
  "isBlocking": true,
  "type": {
    "id": "fa4e907d-c16b-4a4c-9dfa-4906e5d171dd",
    "displayName": "Minimum number of reviewers"
  },
  "settings": {
    "minimumApproverCount": 2,
    "creatorVoteCounts": false,
    "allowDownvotes": false,
    "resetOnSourcePush": true
  }
}
```

### Git Hooks for Policy Enforcement

```bash
#!/bin/sh
# .git/hooks/pre-commit

# Check for secrets
if git diff --cached | grep -E 'password|secret|api_key'; then
    echo "ERROR: Potential secret detected!"
    exit 1
fi

# Run linter
npm run lint
```

---

## 📚 Domain 8: Implement Dependency Management (5-10%)

### Package Feed (Azure Artifacts)

```yaml
steps:
- task: NuGetAuthenticate@1

- task: DotNetCoreCLI@2
  displayName: 'dotnet restore'
  inputs:
    command: 'restore'
    feedsToUse: 'select'
    vstsFeed: 'MyProject/MyFeed'

- task: DotNetCoreCLI@2
  displayName: 'dotnet pack'
  inputs:
    command: 'pack'
    packagesToPack: '**/*.csproj'
    versioningScheme: 'byBuildNumber'

- task: NuGetCommand@2
  displayName: 'nuget push'
  inputs:
    command: 'push'
    packagesToPush: '$(Build.ArtifactStagingDirectory)/**/*.nupkg'
    nuGetFeedType: 'internal'
    publishVstsFeed: 'MyProject/MyFeed'
```

---

## 📚 Domain 1: Implement Instrumentation (5-10%)

### Application Insights Integration

```csharp
// Configure telemetry
builder.Services.AddApplicationInsightsTelemetry(
    options =>
    {
        options.ConnectionString = builder.Configuration["ApplicationInsights:ConnectionString"];
    });

// Custom telemetry
var telemetryClient = app.Services.GetRequiredService<TelemetryClient>();
telemetryClient.TrackEvent("UserAction", 
    properties: new Dictionary<string, string> { { "Action", "Login" } });
```

### KQL Queries for Monitoring

```kusto
// Failed requests in last hour
requests
| where timestamp > ago(1h)
| where success == false
| summarize count() by resultCode, bin(timestamp, 5m)
| render timechart

// Dependency failures
dependencies
| where timestamp > ago(24h)
| where success == false
| summarize count() by name, type
| order by count_ desc
```

---

## 🎯 Hands-On Practice Labs

### Lab 1: Multi-Stage CI/CD Pipeline

Create complete pipeline: Build → Test → Security Scan → Deploy Dev → Deploy Prod

### Lab 2: Blue-Green Deployment

Implement slot swapping with App Service

### Lab 3: Secret Management

Configure Key Vault integration in pipeline

### Lab 4: Branch Policies

Set up branch protection with required reviewers

### Lab 5: Package Management

Create private NuGet feed in Azure Artifacts

### Lab 6: Infrastructure as Code

Deploy Azure resources using ARM/Bicep in pipeline

### Lab 7: Monitoring Dashboard

Create Application Insights dashboard with KQL queries

---

## 📖 Study Schedule (80 Hours)

### Week 1-2 (28 hours)

- Domain 6: CI implementation (biggest domain!)
- Complete Labs 1, 3

### Week 3 (20 hours)

- Domain 7: CD strategies
- Domain 3: Security & compliance
- Complete Labs 2, 4

### Week 4 (20 hours)

- Domains 4, 5, 8: Source control, collaboration, dependencies  
- Complete Labs 5, 6

### Week 5 (12 hours)

- Domains 1, 2: Instrumentation, SRE
- Complete Lab 7
- Practice exams

---

## 📝 Practice Exam Questions

1. **Which deployment strategy has zero downtime?**
   - a) Recreate
   - b) Blue-Green ✅
   - c) Rolling
   - d) Big Bang

2. **What's required for manual approval in pipeline?**
   - a) Approval gate
   - b) Environment with approval ✅
   - c) Manual task
   - d) Wait task

3. **How to securely store secrets in pipeline?**
   - a) Pipeline variables
   - b) Azure Key Vault ✅
   - c) Config file
   - d) Environment variables

---

## 🔗 Official Resources

- [MS Learn AZ-400 Path](https://learn.microsoft.com/en-us/certifications/exams/az-400/)
- [Azure Pipelines Docs](https://learn.microsoft.com/en-us/azure/devops/pipelines/)
- [DevOps Labs](https://azuredevopslabs.com/)

---

## ✅ Exam Preparation Checklist

- [ ] Created 10+ Azure Pipelines
- [ ] Implemented CI/CD for real project
- [ ] Configured branch policies
- [ ] Set up Azure Artifacts feed
- [ ] Integrated Key Vault in pipeline
- [ ] Implemented blue-green deployment
- [ ] Created Application Insights dashboards
- [ ] Practice exam score: 75%+

**Target Exam Date**: May 14, 2026 ⭐  
**Study Period**: April 16 - May 14 (28 days)  
**Next Cert**: DP-420 Cosmos DB
