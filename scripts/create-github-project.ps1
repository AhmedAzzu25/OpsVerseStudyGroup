<#
.SYNOPSIS
    Automated GitHub Project Setup Script for OpsVerse Study Group

.DESCRIPTION
    This script automates the creation of GitHub Issues based on the TIMESHEET.md structure:
    - 10 Certification study tasks
    - Course week tasks (Track A: 17, Track B: 13, Track C: 13)
    - 8 MonoPod module epics
    - Detailed IMS module tasks

.PREREQUISITES
    - GitHub CLI (gh) installed: https://cli.github.com/
    - Authenticated with: gh auth login
    - Repository: AhmedAzzu25/OpsVerseStudyGroup

.USAGE
    .\create-github-project.ps1 -CreateProject -CreateIssues -All
    .\create-github-project.ps1 -CreateIssues -Category Certifications
    .\create-github-project.ps1 -CreateIssues -Category CourseWeeks -Track A
#>

param(
    [switch]$CreateProject,
    [switch]$CreateIssues,
    [switch]$All,
    [string]$Category = "All",  # All, Certifications, CourseWeeks, Modules
    [string]$Track = "A"  # A, B, C
)

# Configuration
$RepoOwner = "AhmedAzzu25"
$RepoName = "OpsVerseStudyGroup"
$ProjectName = "OpsVerse Study Group - 2026 Q1-Q2"
$ProjectDescription = "Team progress tracking for certifications, internal courses, and MonoPod project development"

# Colors for output
function Write-Success { param($message) Write-Host "✅ $message" -ForegroundColor Green }
function Write-Info { param($message) Write-Host "ℹ️  $message" -ForegroundColor Cyan }
function Write-Warning { param($message) Write-Host "⚠️  $message" -ForegroundColor Yellow }
function Write-Error { param($message) Write-Host "❌ $message" -ForegroundColor Red }

# Check if GitHub CLI is installed
function Test-GitHubCLI {
    try {
        $ghVersion = gh --version
        Write-Success "GitHub CLI is installed: $($ghVersion[0])"
        return $true
    }
    catch {
        Write-Error "GitHub CLI (gh) is not installed!"
        Write-Info "Install from: https://cli.github.com/"
        return $false
    }
}

# Check if authenticated
function Test-GitHubAuth {
    try {
        $authStatus = gh auth status 2>&1
        if ($authStatus -match "Logged in") {
            Write-Success "Authenticated with GitHub"
            return $true
        }
        else {
            Write-Warning "Not authenticated with GitHub"
            Write-Info "Run: gh auth login"
            return $false
        }
    }
    catch {
        Write-Warning "Not authenticated with GitHub"
        Write-Info "Run: gh auth login"
        return $false
    }
}

# Create GitHub Project (Board)
function New-GitHubProject {
    Write-Info "Creating GitHub Project: $ProjectName"
    
    try {
        # Note: As of 2024, GitHub Projects v2 creation via CLI requires specific commands
        # This creates a classic project, or you can use the web UI for Projects v2
        
        Write-Warning "GitHub Projects (Beta/v2) creation requires using the web UI or GraphQL API"
        Write-Info "Please create the project manually:"
        Write-Info "1. Go to: https://github.com/$RepoOwner/$RepoName/projects"
        Write-Info "2. Click 'New project'"
        Write-Info "3. Choose 'Board' template"
        Write-Info "4. Name: $ProjectName"
        Write-Info "5. Description: $ProjectDescription"
        Write-Info ""
        Write-Info "Once created, press Enter to continue with issue creation..."
        Read-Host
    }
    catch {
        Write-Error "Failed to create project: $_"
    }
}

# Certification data
$Certifications = @(
    @{
        Name = "GitHub Foundations"
        Hours = 20
        Timeline = "Week 1"
        Projects = "All (Monorepo setup)"
        Labels = @("certification", "week-1", "github")
    },
    @{
        Name = "GitHub Actions"
        Hours = 25
        Timeline = "Week 2-3"
        Projects = "IMS, Healthcare, Infra-Guardian"
        Labels = @("certification", "week-2", "week-3", "github-actions")
    },
    @{
        Name = "Terraform Associate"
        Hours = 40
        Timeline = "Week 4-6"
        Projects = "Infra-Guardian, Fintech, Logistics"
        Labels = @("certification", "terraform", "iac")
    },
    @{
        Name = "AZ-204 Azure Developer"
        Hours = 60
        Timeline = "Week 7-10"
        Projects = "Healthcare, Gov-Services, Ops-Agent"
        Labels = @("certification", "azure", "az-204")
    },
    @{
        Name = "AZ-400 DevOps Expert"
        Hours = 80
        Timeline = "Week 11-16"
        Projects = "All 8 Projects"
        Labels = @("certification", "azure", "az-400", "milestone")
    },
    @{
        Name = "AZ-305 Solutions Architect"
        Hours = 100
        Timeline = "Week 17-24"
        Projects = "All 8 Projects (Architecture)"
        Labels = @("certification", "azure", "az-305", "architecture")
    },
    @{
        Name = "AZ-104 Azure Administrator"
        Hours = 50
        Timeline = "Optional"
        Projects = "Platform Services"
        Labels = @("certification", "azure", "az-104", "optional")
    },
    @{
        Name = "AZ-500 Azure Security"
        Hours = 50
        Timeline = "Optional"
        Projects = "Security & Compliance"
        Labels = @("certification", "azure", "az-500", "security", "optional")
    },
    @{
        Name = "AKS Specialist (Mohamed Radwan)"
        Hours = 70
        Timeline = "Week 1-13 (Track C)"
        Projects = "Kubernetes Deployments"
        Labels = @("certification", "aks", "kubernetes", "track-c")
    },
    @{
        Name = "AI-900 Azure AI Fundamentals"
        Hours = 20
        Timeline = "Optional"
        Projects = "Ops-Agent (AI/ML)"
        Labels = @("certification", "azure", "ai-900", "ai", "optional")
    }
)

# Create certification issues
function New-CertificationIssues {
    Write-Info "Creating certification study issues..."
    
    foreach ($cert in $Certifications) {
        $title = "[CERT] $($cert.Name) Study & Exam"
        $body = @"
## 🎓 Certification Details

- **Name**: $($cert.Name)
- **Hours Required**: $($cert.Hours)h
- **Timeline**: $($cert.Timeline)
- **Projects Aligned**: $($cert.Projects)

## 📚 Study Plan

- [ ] Review exam objectives and skills measured
- [ ] Complete Microsoft Learn modules (if Azure cert)
- [ ] Hands-on practice with aligned projects
- [ ] Take practice exams
- [ ] Review weak areas
- [ ] Schedule certification exam
- [ ] Pass certification ✅

## 📖 Resources

- See [TIMESHEET.md](../management/TIMESHEET.md) - Certification Progress
- See [PROJECT_CERT_ALIGNMENT.md](../docs/certifications/PROJECT_CERT_ALIGNMENT.md)
- Microsoft Learn: https://learn.microsoft.com/certifications/

## 🎯 Success Criteria

- [ ] Study materials reviewed
- [ ] Practice exam score ≥ 80%
- [ ] Official exam passed

---

**Timesheet Reference**: TIMESHEET.md - Certification Progress section
"@

        $labels = $cert.Labels -join ","
        
        try {
            Write-Info "Creating issue: $title"
            gh issue create `
                --repo "$RepoOwner/$RepoName" `
                --title "$title" `
                --body "$body" `
                --label "$labels"
            
            Write-Success "Created: $title"
            Start-Sleep -Milliseconds 500  # Rate limiting
        }
        catch {
            Write-Error "Failed to create issue '$title': $_"
        }
    }
}

# Track A course weeks
$TrackAWeeks = @(
    @{ Week = 1; Topic = "Git & GitHub Fundamentals"; Module = "Module 1: Lessons 2-10"; Project = "Setup Monorepo"; Deliverable = "Team Workflow Guide" },
    @{ Week = 2; Topic = "Containerization (Docker)"; Module = "Module 2: Lesson 9"; Project = "Healthcare Module"; Deliverable = "Dockerfile + Compose" },
    @{ Week = 3; Topic = "CI/CD Basics (GitHub Actions)"; Module = "Module 2: Lessons 1-8"; Project = "IMS Module"; Deliverable = "Build Pipeline" },
    @{ Week = 4; Topic = "Infrastructure as Code (Terraform)"; Module = "Module 5: Lessons 1-6"; Project = "Infra-Guardian"; Deliverable = "Azure Resources" },
    @{ Week = 5; Topic = "Azure Fundamentals"; Module = "Module 1: Lesson 4 + Module 5"; Project = "All Modules"; Deliverable = "Resource Group Setup" },
    @{ Week = 6; Topic = "Microservices Architecture"; Module = "Module 4: Lessons 1-4"; Project = "IMS + Fintech"; Deliverable = "Service Mesh Design" },
    @{ Week = 7; Topic = "Event-Driven Systems"; Module = "Module 6: Lessons 1-2"; Project = "IMS (RabbitMQ)"; Deliverable = "Event Flow Diagram" },
    @{ Week = 8; Topic = "API Gateway & Auth"; Module = "Module 4: Lessons 5-6"; Project = "Platform Services"; Deliverable = "OAuth2 Implementation" },
    @{ Week = 9; Topic = "Serverless (Azure Functions)"; Module = "Module 3: Lesson 4"; Project = "Healthcare Sync"; Deliverable = "Durable Functions" },
    @{ Week = 10; Topic = "Stream Processing"; Module = "Module 7: Lessons 1-2"; Project = "Fintech Module"; Deliverable = "Stream Analytics Query" },
    @{ Week = 11; Topic = "IoT & Edge Computing"; Module = "Module 4: Lesson 4"; Project = "Logistics Module"; Deliverable = "Edge Deployment" },
    @{ Week = 12; Topic = "Security & Compliance"; Module = "Module 8: Lessons 1-6"; Project = "Infra-Guardian"; Deliverable = "Policy-as-Code" },
    @{ Week = 13; Topic = "Observability (Logs, Metrics, Traces)"; Module = "Module 7: Lessons 2-5"; Project = "All Modules"; Deliverable = "Dashboard Setup" },
    @{ Week = 14; Topic = "AI/ML Integration"; Module = "Module 8: Lesson 3"; Project = "Ops-Agent"; Deliverable = "RAG Pipeline" },
    @{ Week = 15; Topic = "Kubernetes Basics"; Module = "Module 2: Lesson 9 + Module 3"; Project = "All Modules"; Deliverable = "AKS Deployment" },
    @{ Week = 16; Topic = "Advanced DevOps Patterns"; Module = "Module 1: Lessons 1,9-11"; Project = "Gov-Services"; Deliverable = "Saga Pattern" },
    @{ Week = 17; Topic = "Capstone Project"; Module = "All Modules Review"; Project = "Charity Module"; Deliverable = "Production Deployment" }
)

# Create course week issues
function New-CourseWeekIssues {
    param([string]$TrackName)
    
    Write-Info "Creating Track $TrackName course week issues..."
    
    if ($TrackName -eq "A") {
        $weeks = $TrackAWeeks
        $trackLabel = "track-a"
        $trackFull = "Track A (Master DevOps - 17 weeks)"
    }
    # Add Track B and C data if needed
    
    foreach ($week in $weeks) {
        $title = "[Track $TrackName] Week $($week.Week) - $($week.Topic)"
        $body = @"
## 📖 Week $($week.Week) Details

- **Topic**: $($week.Topic)
- **Course Module**: $($week.Module)
- **Project Focus**: $($week.Project)
- **Track**: $trackFull

## 📋 Deliverables

- [ ] Complete course module: $($week.Module)
- [ ] Complete labs and demos
- [ ] Work on project: $($week.Project)
- [ ] Create deliverable: $($week.Deliverable)
- [ ] Update TIMESHEET.md progress

## 📚 Resources

- [Course Link](https://github.com/MohamedRadwan-DevOps/devops-step-by-step)
- See [SYLLABUS.md](../docs/internal-courses/SYLLABUS.md) - Track $TrackName, Week $($week.Week)
- See [TIMESHEET.md](../management/TIMESHEET.md) - Internal Courses Progress

## ✅ Success Criteria

- [ ] Course module completed
- [ ] Hands-on labs finished
- [ ] Deliverable created and documented
- [ ] Team member checked off in timesheet

---

**Timesheet Reference**: TIMESHEET.md - Track $TrackName, Week $($week.Week)
"@

        $labels = "course,$trackLabel,week-$($week.Week)"
        
        try {
            Write-Info "Creating issue: $title"
            gh issue create `
                --repo "$RepoOwner/$RepoName" `
                --title "$title" `
                --body "$body" `
                --label "$labels"
            
            Write-Success "Created: $title"
            Start-Sleep -Milliseconds 500
        }
        catch {
            Write-Error "Failed to create issue '$title': $_"
        }
    }
}

# MonoPod modules
$Modules = @(
    @{ Name = "IMS"; FullName = "Inventory Management System"; TechStack = ".NET 8, PostgreSQL, RabbitMQ"; Domain = "Enterprise Resource Planning" },
    @{ Name = "Healthcare"; FullName = "Medical Records System"; TechStack = "Node.js, React, Cosmos DB"; Domain = "Healthcare IT" },
    @{ Name = "Infra-Guardian"; FullName = "Cloud Compliance Monitor"; TechStack = "Python, Azure Functions"; Domain = "DevOps/SRE" },
    @{ Name = "Gov-Services"; FullName = "E-Government Platform"; TechStack = "Node.js, Durable Functions"; Domain = "Public Sector" },
    @{ Name = "Fintech"; FullName = "Financial Analytics Platform"; TechStack = ".NET 8, Event Hub, SQL"; Domain = "Financial Technology" },
    @{ Name = "Ops-Agent"; FullName = "AI Operations Assistant"; TechStack = "Python, Azure OpenAI, RAG"; Domain = "AI/ML Operations" },
    @{ Name = "Charity"; FullName = "Donation Management Platform"; TechStack = "Node.js, Bot Service, SQL"; Domain = "Non-Profit" },
    @{ Name = "Logistics"; FullName = "Supply Chain IoT Platform"; TechStack = "Python, IoT Hub, Digital Twins"; Domain = "IoT/Supply Chain" }
)

# Create module epic issues
function New-ModuleIssues {
    Write-Info "Creating MonoPod module epic issues..."
    
    foreach ($module in $Modules) {
        $title = "[$($module.Name)] Complete $($module.FullName) Module"
        $body = @"
## 🚀 Module Overview

- **Name**: $($module.FullName)
- **Short Name**: $($module.Name)
- **Domain**: $($module.Domain)
- **Tech Stack**: $($module.TechStack)

## 📋 Development Epics

- [ ] **Epic 1**: Core API Development
- [ ] **Epic 2**: Database & Data Models
- [ ] **Epic 3**: Authentication & Authorization
- [ ] **Epic 4**: Business Logic Implementation
- [ ] **Epic 5**: Testing (Unit, Integration, E2E)
- [ ] **Epic 6**: CI/CD Pipeline
- [ ] **Epic 7**: Deployment & Infrastructure
- [ ] **Epic 8**: Documentation

## 🎓 Certification Alignment

This module helps prepare for:
- GitHub Actions (CI/CD)
- AZ-204 (Azure Services)
- AZ-400 (DevOps Lifecycle)
- AZ-305 (Architecture Patterns)

## 📚 Resources

- See [TIMESHEET.md](../management/TIMESHEET.md) - MonoPod Project Progress
- Module path: `/monopod/modules/$($module.Name.ToLower())/`
- Architecture: `/monopod/docs/architecture/`

## ✅ Success Criteria

- [ ] All epics completed
- [ ] API fully functional with Swagger docs
- [ ] Database deployed and seeded
- [ ] CI/CD pipeline passing
- [ ] Deployed to Azure
- [ ] Comprehensive documentation

---

**Timesheet Reference**: TIMESHEET.md - MonoPod Module: $($module.Name)
"@

        $labels = "module,$($module.Name.ToLower()),epic"
        
        try {
            Write-Info "Creating issue: $title"
            gh issue create `
                --repo "$RepoOwner/$RepoName" `
                --title "$title" `
                --body "$body" `
                --label "$labels"
            
            Write-Success "Created: $title"
            Start-Sleep -Milliseconds 500
        }
        catch {
            Write-Error "Failed to create issue '$title': $_"
        }
    }
}

# IMS detailed tasks
$IMSTasks = @(
    @{ Epic = 1; Task = "1.1"; Title = "Setup .NET 8 Web API Project"; Estimate = 4 },
    @{ Epic = 1; Task = "1.2"; Title = "Configure PostgreSQL Connection"; Estimate = 3 },
    @{ Epic = 1; Task = "1.3"; Title = "Implement Entity Framework Models"; Estimate = 6 },
    @{ Epic = 1; Task = "1.4"; Title = "Create Repository Pattern"; Estimate = 5 },
    @{ Epic = 1; Task = "1.5"; Title = "Build CRUD Endpoints for Products"; Estimate = 8 },
    @{ Epic = 1; Task = "1.6"; Title = "Build CRUD Endpoints for Orders"; Estimate = 8 },
    @{ Epic = 1; Task = "1.7"; Title = "Add Validation and Error Handling"; Estimate = 6 },
    @{ Epic = 2; Task = "2.1"; Title = "Setup RabbitMQ Docker Container"; Estimate = 3 },
    @{ Epic = 2; Task = "2.2"; Title = "Implement Outbox Pattern"; Estimate = 8 },
    @{ Epic = 2; Task = "2.3"; Title = "Create Event Publishers"; Estimate = 6 },
    @{ Epic = 2; Task = "2.4"; Title = "Create Event Consumers"; Estimate = 6 },
    @{ Epic = 2; Task = "2.5"; Title = "Add Event Replay Capability"; Estimate = 8 }
)

# Create IMS detailed task issues
function New-IMSTaskIssues {
    Write-Info "Creating IMS detailed task issues..."
    
    foreach ($task in $IMSTasks) {
        $title = "[IMS][Epic $($task.Epic)] $($task.Title)"
        $body = @"
## 🎯 Task Details

- **Module**: IMS (Inventory Management System)
- **Epic**: Epic $($task.Epic)
- **Task**: Task $($task.Task)
- **Estimated Hours**: $($task.Estimate)h

## ✅ Acceptance Criteria

- [ ] Implementation completed
- [ ] Unit tests written and passing
- [ ] Code reviewed and approved
- [ ] Documentation updated

## 📚 Resources

- See [TIMESHEET.md](../management/TIMESHEET.md) - IMS Epic $($task.Epic), Task $($task.Task)
- Module path: `/monopod/modules/ims/`

## 🔗 Related

- Parent Epic: [IMS] Complete Inventory Management System Module

---

**Timesheet Reference**: TIMESHEET.md - IMS Epic $($task.Epic), Task $($task.Task)
"@

        $labels = "module,ims,development,epic-$($task.Epic)"
        
        try {
            Write-Info "Creating issue: $title"
            gh issue create `
                --repo "$RepoOwner/$RepoName" `
                --title "$title" `
                --body "$body" `
                --label "$labels"
            
            Write-Success "Created: $title"
            Start-Sleep -Milliseconds 500
        }
        catch {
            Write-Error "Failed to create issue '$title': $_"
        }
    }
}

# Main execution
function Main {
    Write-Info "=== GitHub Project Setup Script ==="
    Write-Info "Repository: $RepoOwner/$RepoName"
    Write-Info ""
    
    # Check prerequisites
    if (-not (Test-GitHubCLI)) { return }
    if (-not (Test-GitHubAuth)) { return }
    
    # Create project if requested
    if ($CreateProject -or $All) {
        New-GitHubProject
    }
    
    # Create issues if requested
    if ($CreateIssues -or $All) {
        switch ($Category.ToLower()) {
            "certifications" {
                New-CertificationIssues
            }
            "courseweeks" {
                New-CourseWeekIssues -TrackName $Track
            }
            "modules" {
                New-ModuleIssues
            }
            "ims" {
                New-IMSTaskIssues
            }
            "all" {
                New-CertificationIssues
                New-CourseWeekIssues -TrackName "A"
                New-ModuleIssues
                New-IMSTaskIssues
            }
            default {
                Write-Warning "Unknown category: $Category"
                Write-Info "Valid categories: Certifications, CourseWeeks, Modules, IMS, All"
            }
        }
    }
    
    Write-Success "=== Script Complete ==="
    Write-Info "Next steps:"
    Write-Info "1. Go to: https://github.com/$RepoOwner/$RepoName/issues"
    Write-Info "2. Review created issues"
    Write-Info "3. Add issues to your GitHub Project"
    Write-Info "4. Update TIMESHEET.md weekly"
}

# Run main function
Main
