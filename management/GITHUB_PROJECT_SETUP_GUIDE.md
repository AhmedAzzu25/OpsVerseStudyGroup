# GitHub Project Setup Guide

Step-by-step guide to convert the TIMESHEET.md into a GitHub Project.

## Prerequisites

- GitHub account with access to: <https://github.com/AhmedAzzu25/OpsVerseStudyGroup>
- Timesheet created at: `management/TIMESHEET.md`

---

## Step 1: Create New Project

1. Go to: <https://github.com/AhmedAzzu25/OpsVerseStudyGroup/projects>
2. Click **"New project"** button
3. Choose **"Board"** template (for Kanban view)
4. Name: `OpsVerse Study Group - 2026 Q1-Q2`
5. Description: `Team progress tracking for certifications, internal courses, and MonoPod project development`
6. Click **"Create project"**

---

## Step 2: Configure Project Views

### View 1: Board (Default Kanban)

Already created. Configure columns:

1. Click the **"..."** menu on the project
2. Select **"Settings"**
3. Ensure these columns exist:
   - 📋 Backlog
   - 🔄 In Progress
   - 👀 In Review
   - ✅ Done

### View 2: Table (All Tasks)

1. Click **"+ New view"**
2. Select **"Table"**
3. Name: `All Tasks`
4. This will show all items in spreadsheet format

### View 3: Roadmap (Timeline)

1. Click **"+ New view"**
2. Select **"Roadmap"**
3. Name: `Certification Timeline`
4. Configure date fields for start/end dates

---

## Step 3: Add Custom Fields

Click **"+ New field"** to add each of these:

### Field 1: Module

- **Type**: Single select
- **Options**:
  - IMS
  - Healthcare
  - Infra-Guardian
  - Gov-Services
  - Fintech
  - Ops-Agent
  - Charity
  - Logistics
  - Platform Services
  - Infrastructure
  - Observability

### Field 2: Cert Alignment

- **Type**: Single select
- **Options**:
  - GitHub Foundations
  - GitHub Actions
  - Terraform Associate
  - AZ-204
  - AZ-400
  - AZ-305
  - AZ-104
  - AZ-500
  - AKS Specialist
  - AI-900

### Field 3: Track

- **Type**: Single select
- **Options**:
  - Track A (Master DevOps - 17 weeks)
  - Track B (Intro DevOps - 13 weeks)
  - Track C (AKS - 13 weeks)

### Field 4: Priority

- **Type**: Single select
- **Options**:
  - 🔴 High
  - 🟡 Medium
  - 🟢 Low

### Field 5: Sprint

- **Type**: Single select
- **Options**:
  - Sprint 1
  - Sprint 2
  - Sprint 3
  - Sprint 4
  - Sprint 5
  - Sprint 6
  - Sprint 7
  - Sprint 8

### Field 6: Estimate

- **Type**: Number
- **Format**: Hours

### Field 7: Task Type

- **Type**: Single select
- **Options**:
  - 📚 Study (Certification)
  - 📖 Course (Weekly Module)
  - 💻 Development (Code)
  - 🐛 Bug
  - 📝 Documentation
  - 🔧 Infrastructure

---

## Step 4: Create Initial Issues from Timesheet

### Category 1: Certification Study Tasks

Create one issue per certification:

**Example Issue 1**:

```
Title: [CERT] GitHub Foundations Study & Exam

Body:
## Certification Details
- **Hours Required**: 20h
- **Timeline**: Week 1
- **Projects**: All (Monorepo setup)

## Study Plan
- [ ] Complete Microsoft Learn modules
- [ ] Practice with monorepo setup
- [ ] Take practice exam
- [ ] Schedule certification exam
- [ ] Pass certification

## Resources
- [Microsoft Learn - GitHub Foundations](https://learn.microsoft.com/certifications/)
- See TIMESHEET.md - Certification Progress section

Labels: certification, week-1
Module: -
Cert Alignment: GitHub Foundations
Track: All
Priority: High
Estimate: 20
Task Type: 📚 Study
```

Repeat for all 10 certifications.

### Category 2: Course Week Tasks

Create one issue per week per track:

**Example Issue 2**:

```
Title: [Track A] Week 1 - Git & GitHub Fundamentals

Body:
## Week 1 Details
- **Topic**: Git & GitHub Fundamentals
- **Course Module**: Module 1: Lessons 2-10
- **Project Focus**: Setup Monorepo

## Deliverables
- [ ] Complete Module 1, Lessons 2-10
- [ ] Setup monorepo structure
- [ ] Create branch protection rules
- [ ] Team Workflow Guide document

## Resources
- [Course Link](https://github.com/MohamedRadwan-DevOps/devops-step-by-step)
- See SYLLABUS.md - Track A, Week 1
- See TIMESHEET.md - Internal Courses Progress

Labels: course, track-a, week-1
Module: -
Track: Track A (Master DevOps - 17 weeks)
Priority: High
Estimate: 10
Task Type: 📖 Course
```

Create for all weeks across all 3 tracks.

### Category 3: MonoPod Module Development

Create one epic issue per module:

**Example Issue 3**:

```
Title: [IMS] Complete IMS Module Development

Body:
## Module Overview
- **Domain**: Inventory Management System
- **Tech Stack**: .NET 8, PostgreSQL, RabbitMQ
- **Certification Alignment**: GitHub Actions, AZ-204, AZ-400, AZ-305

## Epics
- [ ] Epic 1: Core API Development (7 tasks)
- [ ] Epic 2: Event-Driven Architecture (5 tasks)
- [ ] Epic 3: Authentication & Authorization (4 tasks)
- [ ] Epic 4: Testing (4 tasks)
- [ ] Epic 5: CI/CD & Deployment (5 tasks)
- [ ] Epic 6: Documentation (4 tasks)

## Detailed Tasks
See TIMESHEET.md - Detailed Project: IMS section

Labels: module, ims, epic
Module: IMS
Priority: High
Estimate: 120
Task Type: 💻 Development
```

Then create sub-issues for each epic and task.

### Category 4: Individual Tasks (from IMS Example)

**Example Issue 4**:

```
Title: [IMS][Epic 1] Setup .NET 8 Web API Project

Body:
## Task Details
- **Epic**: Epic 1 - Core API Development
- **Task**: Task 1.1

## Acceptance Criteria
- [ ] Create .NET 8 Web API project
- [ ] Configure project structure (API, Domain, Infrastructure, Application layers)
- [ ] Add necessary NuGet packages
- [ ] Basic health check endpoint working
- [ ] README with setup instructions

## Resources
- See TIMESHEET.md - IMS Epic 1, Task 1.1
- MonoPod structure: /monopod/modules/ims/

Labels: module, ims, development
Module: IMS
Cert Alignment: AZ-204
Priority: High
Estimate: 4
Task Type: 💻 Development
```

---

## Step 5: Setup Project Automations

1. Click project **"..."** menu
2. Select **"Workflows"**
3. Enable these automations:

### Automation 1: Auto-add to project

- **When**: Issue is created with label `project-2026`
- **Then**: Add to project

### Automation 2: Auto-move to In Progress

- **When**: Issue is assigned
- **Then**: Set status to "🔄 In Progress"

### Automation 3: Auto-move to Review

- **When**: Pull request is created
- **Then**: Set status to "👀 In Review"

### Automation 4: Auto-move to Done

- **When**: Issue is closed
- **Then**: Set status to "✅ Done"

---

## Step 6: Create Issue Templates

Create templates in `.github/ISSUE_TEMPLATE/`:

### Template 1: Certification Study Task

File: `.github/ISSUE_TEMPLATE/certification_study.md`

```yaml
---
name: Certification Study Task
about: Track progress on a certification exam
title: '[CERT] '
labels: certification
assignees: ''
---

## Certification Details
- **Name**: 
- **Hours Required**: 
- **Timeline**: 
- **Projects Aligned**: 

## Study Plan
- [ ] Complete learning modules
- [ ] Hands-on practice
- [ ] Practice exam
- [ ] Schedule exam
- [ ] Pass certification

## Resources
- See [TIMESHEET.md](../management/TIMESHEET.md) - Certification Progress
- See [PROJECT_CERT_ALIGNMENT.md](../docs/certifications/PROJECT_CERT_ALIGNMENT.md)
```

### Template 2: Course Week Completion

File: `.github/ISSUE_TEMPLATE/course_week.md`

```yaml
---
name: Course Week Completion
about: Track weekly course module completion
title: '[Track X] Week N - Topic'
labels: course
assignees: ''
---

## Week Details
- **Track**: 
- **Week**: 
- **Topic**: 
- **Course Module**: 
- **Project Focus**: 

## Deliverables
- [ ] Complete course module
- [ ] Complete labs/demos
- [ ] Project work
- [ ] Deliverable document

## Resources
- See [SYLLABUS.md](../docs/internal-courses/SYLLABUS.md)
- See [TIMESHEET.md](../management/TIMESHEET.md)
```

### Template 3: Module Development

File: `.github/ISSUE_TEMPLATE/module_development.md`

```yaml
---
name: Module Development Task
about: Track MonoPod module development tasks
title: '[MODULE][Epic N] Task Description'
labels: module, development
assignees: ''
---

## Task Details
- **Module**: 
- **Epic**: 
- **Task**: 

## Acceptance Criteria
- [ ] 
- [ ] 
- [ ] 

## Technical Notes


## Resources
- See [TIMESHEET.md](../management/TIMESHEET.md)
- MonoPod: [/monopod/modules/](../monopod/modules/)
```

---

## Step 7: Bulk Create Issues (Optional - Using GH CLI)

If you have GitHub CLI installed, you can bulk create issues:

```bash
# Install GitHub CLI first
# https://cli.github.com/

# Login
gh auth login

# Create certification issues
gh issue create \
  --repo AhmedAzzu25/OpsVerseStudyGroup \
  --title "[CERT] GitHub Foundations Study & Exam" \
  --body-file .github/issue_templates/cert_github_foundations.md \
  --label "certification,week-1" \
  --project "OpsVerse Study Group - 2026 Q1-Q2"

# Repeat for other issues...
```

---

## Step 8: Link Project to TIMESHEET.md

Already done! The timesheet has this link at the top:

```markdown
> **GitHub Project**: [OpsVerse Study Group Projects](https://github.com/AhmedAzzu25/OpsVerseStudyGroup/projects)
```

---

## Step 9: Weekly Sync Workflow

Every Friday:

1. **Open GitHub Project** board view
2. **Review each column**:
   - Move cards that progressed
   - Update estimates
   - Add comments/notes
3. **Open TIMESHEET.md** in editor
4. **Update progress**:
   - Weekly hours
   - Certification checkboxes
   - Course completion checkboxes
   - Module status percentages
5. **Commit changes** to timesheet
6. **Team discussion** on blockers
7. **Plan next sprint** (every 2 weeks)

---

## Quick Start Checklist

- [ ] Create GitHub Project
- [ ] Add 3 views (Board, Table, Roadmap)
- [ ] Add 7 custom fields
- [ ] Create 10 certification study issues
- [ ] Create course week issues (17 for Track A, 13 for Track B, 13 for Track C)
- [ ] Create 8 module epic issues
- [ ] Create detailed task issues for IMS
- [ ] Setup 4 automation workflows
- [ ] Create 3 issue templates
- [ ] Link project to timesheet
- [ ] Schedule weekly Friday syncs

---

## Estimated Setup Time

- **Manual creation**: 2-3 hours
- **With GH CLI script**: 30-60 minutes

---

## Tips

1. **Start small**: Create project + 5-10 initial issues, then grow
2. **Use labels**: Makes filtering much easier
3. **Milestones**: Create milestones for each certification exam
4. **Team involvement**: Have each member create their own study/course issues
5. **Regular updates**: Keep project and timesheet in sync weekly

---

## Need Help?

- GitHub Projects Docs: <https://docs.github.com/en/issues/planning-and-tracking-with-projects>
- GitHub CLI: <https://cli.github.com/manual/>
- Timesheet: `management/TIMESHEET.md`
