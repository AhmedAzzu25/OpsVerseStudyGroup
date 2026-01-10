# Quick Start: Convert TIMESHEET.md to GitHub Project

## 🎯 Goal

Convert the content of `management/TIMESHEET.md` into an actual GitHub Project for tracking team progress.

---

## 📋 3 Ways to Create the Project

### Option 1: Manual (Recommended for Learning) ⭐

**Time**: 2-3 hours | **Best for**: Understanding GitHub Projects

1. **Click "Projects" tab** in your repository
2. **Click "New project"**
3. **Choose "Board" template**
4. Follow the detailed guide: [GITHUB_PROJECT_SETUP_GUIDE.md](GITHUB_PROJECT_SETUP_GUIDE.md)

### Option 2: Guided Browser Walkthrough

**Time**: 1 hour | **Best for**: Step-by-step guidance

I can walk you through creating it in your browser while you watch.

### Option 3: Automated Script (Coming Soon)

**Time**: 30 minutes | **Best for**: Quick setup

Use GitHub CLI to bulk-create issues and setup.

---

## 🚀 Quick Start (Manual)

### Step 1: Go to Projects Page

URL: <https://github.com/AhmedAzzu25/OpsVerseStudyGroup/projects>

**Current State**: No open projects

### Step 2: Create New Project

1. Click **"New project"** (green button)
2. Select **"Board"** template
3. Name: `OpsVerse Study Group - 2026 Q1-Q2`
4. Click **"Create"**

### Step 3: Add Custom Fields

Click **"+ New field"** and add:

| Field Name | Type | Options |
|------------|------|---------|
| **Module** | Single select | IMS, Healthcare, Infra-Guardian, Gov-Services, Fintech, Ops-Agent, Charity, Logistics |
| **Cert Alignment** | Single select | GitHub Foundations, GitHub Actions, Terraform, AZ-204, AZ-400, AZ-305 |
| **Track** | Single select | Track A (17 weeks), Track B (13 weeks), Track C (AKS) |
| **Priority** | Single select | 🔴 High, 🟡 Medium, 🟢 Low |
| **Sprint** | Single select | Sprint 1, Sprint 2, Sprint 3... |
| **Estimate** | Number | (hours) |
| **Task Type** | Single select | 📚 Study, 📖 Course, 💻 Development, 🐛 Bug, 📝 Docs |

### Step 4: Create Initial Issues

#### Quick Start Issues (Do these first!)

**Issue 1: GitHub Foundations Certification**

```
Title: [CERT] GitHub Foundations Study & Exam

Labels: certification, week-1
Module: -
Cert Alignment: GitHub Foundations
Priority: High
Estimate: 20

Body:
## Study Plan
- [ ] Complete Microsoft Learn modules
- [ ] Setup monorepo (hands-on practice)
- [ ] Take practice exam
- [ ] Pass certification

Reference: TIMESHEET.md - Certification Progress
```

**Issue 2: Week 1 - Git & GitHub Fundamentals**

```
Title: [Track A] Week 1 - Git & GitHub Fundamentals

Labels: course, track-a, week-1
Track: Track A
Priority: High
Estimate: 10

Body:
## Deliverables
- [ ] Complete Module 1, Lessons 2-10
- [ ] Setup monorepo structure
- [ ] Create team workflow guide

Reference: SYLLABUS.md - Track A, Week 1
Reference: TIMESHEET.md - Track A Progress
```

**Issue 3: IMS Module Setup**

```
Title: [IMS] Setup .NET 8 Web API Project

Labels: module, ims, development
Module: IMS
Cert Alignment: AZ-204
Priority: High
Estimate: 4

Body:
## Epic 1, Task 1.1

## Acceptance Criteria
- [ ] Create .NET 8 Web API project
- [ ] Configure project structure
- [ ] Add NuGet packages
- [ ] Health check endpoint
- [ ] README with setup

Reference: TIMESHEET.md - IMS Epic 1, Task 1.1
```

### Step 5: Setup Automation

1. Click project **"..."** menu → **"Workflows"**
2. Enable:
   - Auto-add issues with label `opsverse-2026`
   - Auto-move to "In Progress" when assigned
   - Auto-move to "Done" when closed

### Step 6: Link Issues to Project

When creating issues, add them to your project:

- Select the project from dropdown
- Issues automatically appear on board

---

## 📊 What Your Project Will Look Like

### Board View (Kanban)

```
┌─────────────────┬──────────────────┬──────────────────┬──────────────┐
│   📋 BACKLOG    │  🔄 IN PROGRESS  │   👀 REVIEW      │  ✅ DONE     │
├─────────────────┼──────────────────┼──────────────────┼──────────────┤
│ [CERT] GitHub   │                  │                  │              │
│ Foundations     │                  │                  │              │
│                 │                  │                  │              │
│ [Track A] Week 1│                  │                  │              │
│                 │                  │                  │              │
│ [IMS] Setup API │                  │                  │              │
└─────────────────┴──────────────────┴──────────────────┴──────────────┘
```

### Table View

| Title | Status | Module | Cert | Priority | Estimate | Assignee |
|-------|--------|--------|------|----------|----------|----------|
| [CERT] GitHub Foundations | Backlog | - | GitHub Foundations | High | 20h | - |
| [Track A] Week 1 | Backlog | - | - | High | 10h | - |
| [IMS] Setup API | Backlog | IMS | AZ-204 | High | 4h | - |

---

## 🎯 Start Small, Then Grow

**Week 1**: Create 5-10 issues

- 1-2 certification study tasks
- 2-3 course week tasks
- 2-3 development tasks

**Week 2-4**: Add more as you go

- Create issues for upcoming weeks
- Break down modules into detailed tasks
- Adjust based on team velocity

---

## 📚 Full Documentation

For comprehensive step-by-step instructions, see:

- **Detailed Guide**: [GITHUB_PROJECT_SETUP_GUIDE.md](GITHUB_PROJECT_SETUP_GUIDE.md)
- **Timesheet Structure**: [TIMESHEET.md](TIMESHEET.md)

---

## 🤔 Need Help?

**I can help you**:

1. Walk through project creation in the browser
2. Create issue templates
3. Setup automation workflows
4. Bulk create initial issues

**Just ask**: "Help me create the GitHub project" and I'll guide you step-by-step!

---

## ✅ Checklist

- [ ] Navigate to Projects tab
- [ ] Create new Board project
- [ ] Add 7 custom fields
- [ ] Create 3-5 initial issues
- [ ] Setup automation workflows
- [ ] Update TIMESHEET.md weekly
- [ ] Link issues in GitHub to timesheet sections

---

**Next Step**: Click "Projects" → "New project" → Choose "Board" → Let's go! 🚀
