# Quick Test Script - Create First 3 Issues

# Test creating just a few issues to make sure everything works

$RepoOwner = "AhmedAzzu25"
$RepoName = "OpsVerseStudyGroup"

Write-Host "🧪 Testing GitHub CLI Issue Creation" -ForegroundColor Cyan
Write-Host ""

# Check if gh is installed
try {
    $ghVersion = gh --version
    Write-Host "✅ GitHub CLI installed: $($ghVersion[0])" -ForegroundColor Green
}
catch {
    Write-Host "❌ GitHub CLI not found. Install from: https://cli.github.com/" -ForegroundColor Red
    exit 1
}

# Check auth
try {
    gh auth status 2>&1 | Out-Null
    Write-Host "✅ Authenticated with GitHub" -ForegroundColor Green
}
catch {
    Write-Host "⚠️  Not authenticated. Run: gh auth login" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "Creating 3 test issues..." -ForegroundColor Cyan
Write-Host ""

# Issue 1: GitHub Foundations Cert
Write-Host "Creating [CERT] GitHub Foundations..." -ForegroundColor Yellow
gh issue create `
    --repo "$RepoOwner/$RepoName" `
    --title "[CERT] GitHub Foundations Study & Exam" `
    --body @"
## 🎓 Certification Details

- **Name**: GitHub Foundations
- **Hours Required**: 20h
- **Timeline**: Week 1
- **Projects Aligned**: All (Monorepo setup)

## 📚 Study Plan

- [ ] Review exam objectives
- [ ] Complete GitHub Learning Lab
- [ ] Hands-on: Setup monorepo
- [ ] Take practice exam
- [ ] Schedule & pass certification

## 📖 Resources

- See [TIMESHEET.md](https://github.com/$RepoOwner/$RepoName/blob/master/management/TIMESHEET.md)
- GitHub Certifications: https://github.com/certifications

---

**Timesheet Reference**: TIMESHEET.md - Certification Progress
"@ `
    --label "certification,week-1,github"

Write-Host "✅ Created!" -ForegroundColor Green
Start-Sleep -Seconds 1

# Issue 2: Track A Week 1
Write-Host "Creating [Track A] Week 1..." -ForegroundColor Yellow
gh issue create `
    --repo "$RepoOwner/$RepoName" `
    --title "[Track A] Week 1 - Git & GitHub Fundamentals" `
    --body @"
## 📖 Week 1 Details

- **Topic**: Git & GitHub Fundamentals
- **Course Module**: Module 1: Lessons 2-10
- **Project Focus**: Setup Monorepo
- **Deliverable**: Team Workflow Guide

## 📋 Tasks

- [ ] Complete Module 1, Lessons 2-10
- [ ] Setup monorepo structure
- [ ] Create branch protection rules
- [ ] Document team workflow
- [ ] Update TIMESHEET.md

## 📚 Resources

- [Course](https://github.com/MohamedRadwan-DevOps/devops-step-by-step)
- [SYLLABUS.md](https://github.com/$RepoOwner/$RepoName/blob/master/docs/internal-courses/SYLLABUS.md)
- [TIMESHEET.md](https://github.com/$RepoOwner/$RepoName/blob/master/management/TIMESHEET.md)

---

**Timesheet Reference**: TIMESHEET.md - Track A, Week 1
"@ `
    --label "course,track-a,week-1"

Write-Host "✅ Created!" -ForegroundColor Green
Start-Sleep -Seconds 1

# Issue 3: IMS Setup
Write-Host "Creating [IMS] Setup..." -ForegroundColor Yellow
gh issue create `
    --repo "$RepoOwner/$RepoName" `
    --title "[IMS][Epic 1] Setup .NET 8 Web API Project" `
    --body @"
## 🎯 Task Details

- **Module**: IMS (Inventory Management System)
- **Epic**: Epic 1 - Core API Development
- **Task**: Task 1.1
- **Estimated Hours**: 4h

## ✅ Acceptance Criteria

- [ ] Create .NET 8 Web API project
- [ ] Configure project structure (API, Domain, Infrastructure, Application layers)
- [ ] Add necessary NuGet packages
- [ ] Basic health check endpoint working
- [ ] README with setup instructions

## 📚 Resources

- [TIMESHEET.md](https://github.com/$RepoOwner/$RepoName/blob/master/management/TIMESHEET.md) - IMS Epic 1, Task 1.1
- Module path: /monopod/modules/ims/

---

**Timesheet Reference**: TIMESHEET.md - IMS Epic 1, Task 1.1
"@ `
    --label "module,ims,development,epic-1"

Write-Host "✅ Created!" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Test complete! 3 issues created." -ForegroundColor Green
Write-Host ""
Write-Host "View issues: https://github.com/$RepoOwner/$RepoName/issues" -ForegroundColor Cyan
Write-Host ""
Write-Host "If these look good, run the full script:" -ForegroundColor Yellow
Write-Host "  .\create-github-project.ps1 -CreateIssues -Category All" -ForegroundColor White
