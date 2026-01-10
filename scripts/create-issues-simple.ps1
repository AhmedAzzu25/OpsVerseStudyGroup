# Fixed GitHub Issues Creation Script
# This version uses a simpler approach that works reliably

$RepoOwner = "AhmedAzzu25"
$RepoName = "OpsVerseStudyGroup"

Write-Host "🚀 Creating GitHub Issues (Fixed Version)" -ForegroundColor Cyan
Write-Host ""

# Create labels first
Write-Host "📋 Creating labels..." -ForegroundColor Yellow
$labels = @(
    @{name = "certification"; color = "0075ca"; description = "Certification study tasks" },
    @{name = "course"; color = "7057ff"; description = "Course week tasks" },
    @{name = "module"; color = "008672"; description = "MonoPod module development" },
    @{name = "ims"; color = "d876e3"; description = "IMS module" },
    @{name = "healthcare"; color = "d876e3"; description = "Healthcare module" },
    @{name = "epic"; color = "d73a4a"; description = "Epic-level tasks" },
    @{name = "development"; color = "1d76db"; description = "Development tasks" },
    @{name = "track-a"; color = "fbca04"; description = "Track A course" },
    @{name = "azure"; color = "0e8a16"; description = "Azure related" },
    @{name = "github"; color = "000000"; description = "GitHub related" }
)

foreach ($label in $labels) {
    try {
        gh label create $label.name --color $label.color --description $label.description --repo "$RepoOwner/$RepoName" 2>$null
        Write-Host "  ✅ Created label: $($label.name)" -ForegroundColor Green
    }
    catch {
        # Label might already exist, ignore
    }
}

Write-Host ""
Write-Host "📝 Creating issues..." -ForegroundColor Cyan
Write-Host ""

# Issue 1: GitHub Foundations
$body1 = "## 🎓 Certification Details`n`n- **Name**: GitHub Foundations`n- **Hours Required**: 20h`n- **Timeline**: Week 1`n- **Projects Aligned**: All (Monorepo setup)`n`n## 📚 Study Plan`n`n- [ ] Review exam objectives`n- [ ] Complete GitHub Learning Lab`n- [ ] Hands-on: Setup monorepo`n- [ ] Take practice exam`n- [ ] Schedule & pass certification`n`n## 📖 Resources`n`n- See [TIMESHEET.md](https://github.com/$RepoOwner/$RepoName/blob/master/management/TIMESHEET.md)`n- GitHub Certifications: https://github.com/certifications`n`n---`n`n**Timesheet Reference**: TIMESHEET.md - Certification Progress"

gh issue create --repo "$RepoOwner/$RepoName" --title "[CERT] GitHub Foundations Study & Exam" --body "$body1" --label "certification"
Write-Host "✅ [CERT] GitHub Foundations" -ForegroundColor Green

# Issue 2: GitHub Actions
$body2 = "## 🎓 Certification Details`n`n- **Name**: GitHub Actions`n- **Hours Required**: 25h`n- **Timeline**: Week 2-3`n- **Projects Aligned**: IMS, Healthcare, Infra-Guardian`n`n## 📚 Study Plan`n`n- [ ] Learn YAML workflow syntax`n- [ ] Complete hands-on labs with IMS CI/CD`n- [ ] Practice with matrix builds and caching`n- [ ] Take practice exam`n- [ ] Pass certification`n`n**Timesheet Reference**: TIMESHEET.md - Certification Progress"

gh issue create --repo "$RepoOwner/$RepoName" --title "[CERT] GitHub Actions Certification" --body "$body2" --label "certification"
Write-Host "✅ [CERT] GitHub Actions" -ForegroundColor Green

# Issue 3: AZ-400 DevOps Expert
$body3 = "## 🎓 Certification Details`n`n- **Name**: AZ-400 DevOps Expert`n- **Hours Required**: 80h`n- **Timeline**: Week 11-16`n- **Projects Aligned**: All 8 Projects`n`n## 📚 Study Plan`n`n- [ ] Complete all 8 MonoPod modules with CI/CD`n- [ ] Study DevOps transformation strategies`n- [ ] Practice security and compliance`n- [ ] Take practice exams`n- [ ] Pass certification ⭐`n`n**Timesheet Reference**: TIMESHEET.md - Certification Progress"

gh issue create --repo "$RepoOwner/$RepoName" --title "[CERT] AZ-400 DevOps Expert Study & Exam" --body "$body3" --label "certification,azure"
Write-Host "✅ [CERT] AZ-400 DevOps Expert" -ForegroundColor Green

# Issue 4: Track A Week 1
$body4 = "## 📖 Week 1 Details`n`n- **Topic**: Git & GitHub Fundamentals`n- **Course Module**: Module 1: Lessons 2-10`n- **Project Focus**: Setup Monorepo`n`n## 📋 Deliverables`n`n- [ ] Complete Module 1, Lessons 2-10`n- [ ] Setup monorepo structure`n- [ ] Create branch protection rules`n- [ ] Team Workflow Guide document`n`n**Timesheet Reference**: TIMESHEET.md - Track A, Week 1"

gh issue create --repo "$RepoOwner/$RepoName" --title "[Track A] Week 1 - Git & GitHub Fundamentals" --body "$body4" --label "course,track-a"
Write-Host "✅ [Track A] Week 1" -ForegroundColor Green

# Issue 5: Track A Week 3
$body5 = "## 📖 Week 3 Details`n`n- **Topic**: CI/CD Basics (GitHub Actions)`n- **Course Module**: Module 2: Lessons 1-8`n- **Project Focus**: IMS Module`n`n## 📋 Deliverables`n`n- [ ] Complete Module 2, Lessons 1-8`n- [ ] Create IMS CI/CD pipeline`n- [ ] Build Pipeline working`n`n**Timesheet Reference**: TIMESHEET.md - Track A, Week 3"

gh issue create --repo "$RepoOwner/$RepoName" --title "[Track A] Week 3 - CI/CD Basics (GitHub Actions)" --body "$body5" --label "course,track-a"
Write-Host "✅ [Track A] Week 3" -ForegroundColor Green

# Issue 6: IMS Epic
$body6 = "## 🚀 Module Overview`n`n- **Name**: Inventory Management System`n- **Tech Stack**: .NET 8, PostgreSQL, RabbitMQ`n- **Domain**: Enterprise Resource Planning`n`n## 📋 Development Epics`n`n- [ ] Epic 1: Core API Development`n- [ ] Epic 2: Event-Driven Architecture`n- [ ] Epic 3: Authentication & Authorization`n- [ ] Epic 4: Testing`n- [ ] Epic 5: CI/CD Pipeline`n- [ ] Epic 6: Documentation`n`n**Timesheet Reference**: TIMESHEET.md - MonoPod Module: IMS"

gh issue create --repo "$RepoOwner/$RepoName" --title "[IMS] Complete Inventory Management System Module" --body "$body6" --label "module,ims,epic"
Write-Host "✅ [IMS] Complete Module" -ForegroundColor Green

# Issue 7: IMS Task 1.1
$body7 = "## 🎯 Task Details`n`n- **Module**: IMS`n- **Epic**: Epic 1 - Core API Development`n- **Task**: Task 1.1`n- **Estimated Hours**: 4h`n`n## ✅ Acceptance Criteria`n`n- [ ] Create .NET 8 Web API project`n- [ ] Configure project structure`n- [ ] Add NuGet packages`n- [ ] Health check endpoint working`n`n**Timesheet Reference**: TIMESHEET.md - IMS Epic 1, Task 1.1"

gh issue create --repo "$RepoOwner/$RepoName" --title "[IMS][Epic 1] Setup .NET 8 Web API Project" --body "$body7" --label "module,ims,development"
Write-Host "✅ [IMS] Task 1.1" -ForegroundColor Green

# Issue 8: IMS Task 1.5
$body8 = "## 🎯 Task Details`n`n- **Module**: IMS`n- **Epic**: Epic 1`n- **Task**: Task 1.5`n- **Estimated Hours**: 8h`n`n## ✅ Acceptance Criteria`n`n- [ ] GET /api/products - List all products`n- [ ] GET /api/products/{id} - Get by ID`n- [ ] POST /api/products - Create product`n- [ ] PUT /api/products/{id} - Update product`n- [ ] DELETE /api/products/{id} - Delete product`n`n**Timesheet Reference**: TIMESHEET.md - IMS Epic 1, Task 1.5"

gh issue create --repo "$RepoOwner/$RepoName" --title "[IMS][Epic 1] Build CRUD Endpoints for Products" --body "$body8" --label "module,ims,development"
Write-Host "✅ [IMS] Task 1.5" -ForegroundColor Green

# Issue 9: Healthcare Module
$body9 = "## 🚀 Module Overview`n`n- **Name**: Medical Records System`n- **Tech Stack**: Node.js, React, Cosmos DB`n- **Domain**: Healthcare IT`n`n## 📋 Development Epics`n`n- [ ] Epic 1: Core API Development`n- [ ] Epic 2: Patient Management`n- [ ] Epic 3: Offline-First Sync`n- [ ] Epic 4: Azure Functions Integration`n- [ ] Epic 5: Testing`n- [ ] Epic 6: CI/CD & Deployment`n`n**Timesheet Reference**: TIMESHEET.md - MonoPod Module: Healthcare"

gh issue create --repo "$RepoOwner/$RepoName" --title "[Healthcare] Complete Medical Records System Module" --body "$body9" --label "module,healthcare,epic"
Write-Host "✅ [Healthcare] Complete Module" -ForegroundColor Green

# Issue 10: Ops-Agent Module
$body10 = "## 🚀 Module Overview`n`n- **Name**: AI Operations Assistant`n- **Tech Stack**: Python, Azure OpenAI, RAG`n- **Domain**: AI/ML Operations`n`n## 📋 Development Epics`n`n- [ ] Epic 1: RAG Pipeline Setup`n- [ ] Epic 2: Azure OpenAI Integration`n- [ ] Epic 3: Vector Database (Cognitive Search)`n- [ ] Epic 4: Agent Logic`n- [ ] Epic 5: Testing`n- [ ] Epic 6: Deployment`n`n**Timesheet Reference**: TIMESHEET.md - MonoPod Module: Ops-Agent"

gh issue create --repo "$RepoOwner/$RepoName" --title "[Ops-Agent] Complete AI Operations Assistant Module" --body "$body10" --label "module,epic"
Write-Host "✅ [Ops-Agent] Complete Module" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 Successfully created 10 sample issues!" -ForegroundColor Green
Write-Host ""
Write-Host "View at: https://github.com/$RepoOwner/$RepoName/issues" -ForegroundColor Cyan
Write-Host ""
Write-Host "These 10 issues include:" -ForegroundColor Yellow
Write-Host "  - 3 Certifications (GitHub Foundations, GitHub Actions, AZ-400)"
Write-Host "  - 2 Course Weeks (Week 1, Week 3)"
Write-Host "  - 3 Module Epics (IMS, Healthcare, Ops-Agent)"
Write-Host "  - 2 IMS Tasks (Setup API, CRUD Endpoints)"
