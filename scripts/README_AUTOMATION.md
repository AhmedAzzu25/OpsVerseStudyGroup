# GitHub Project Automation Scripts

Automated tools to convert `management/TIMESHEET.md` into GitHub Issues and Project.

---

## 📋 What This Does

This script automates creating **70+ GitHub issues** based on your TIMESHEET.md:

- ✅ **10 Certification study tasks**
- ✅ **17 Track A course week tasks** (+ Track B & C can be added)
- ✅ **8 MonoPod module epics**
- ✅ **12+ IMS detailed tasks**

---

## 🚀 Quick Start

### Prerequisites

1. **Install GitHub CLI**:

   ```powershell
   winget install GitHub.cli
   ```

   Or download from: <https://cli.github.com/>

2. **Authenticate**:

   ```powershell
   gh auth login
   ```

   - Choose: GitHub.com
   - Protocol: HTTPS
   - Authenticate with: Browser
   - Follow prompts

3. **Verify**:

   ```powershell
   gh auth status
   ```

### Usage

#### Create ALL Issues (Recommended First Time)

```powershell
cd e:\STG\scripts
.\create-github-project.ps1 -CreateIssues -Category All
```

This creates:

- 10 certification issues
- 17 course week issues (Track A)
- 8 module epic issues
- 12 IMS task issues

**Total**: ~47 issues

#### Create Specific Categories

**Only Certifications** (10 issues):

```powershell
.\create-github-project.ps1 -CreateIssues -Category Certifications
```

**Only Course Weeks** (17 issues for Track A):

```powershell
.\create-github-project.ps1 -CreateIssues -Category CourseWeeks -Track A
```

**Only Module Epics** (8 issues):

```powershell
.\create-github-project.ps1 -CreateIssues -Category Modules
```

**Only IMS Tasks** (12 issues):

```powershell
.\create-github-project.ps1 -CreateIssues -Category IMS
```

---

## 📊 What Gets Created

### 1. Certification Study Tasks (10 issues)

Example:

```
Title: [CERT] GitHub Foundations Study & Exam
Labels: certification, week-1, github
Body: Includes study plan, resources, success criteria
```

### 2. Course Week Tasks (17 issues for Track A)

Example:

```
Title: [Track A] Week 1 - Git & GitHub Fundamentals
Labels: course, track-a, week-1
Body: Includes module details, deliverables, resources
```

### 3. Module Epic Issues (8 issues)

Example:

```
Title: [IMS] Complete Inventory Management System Module
Labels: module, ims, epic
Body: Includes 8 epics, tech stack, cert alignment
```

### 4. IMS Detailed Tasks (12 issues)

Example:

```
Title: [IMS][Epic 1] Setup .NET 8 Web API Project
Labels: module, ims, development, epic-1
Body: Includes task details, acceptance criteria, estimate
```

---

## 🎯 After Running the Script

### Step 1: Review Issues

```powershell
# Open issues in browser
gh issue list --repo AhmedAzzu25/OpsVerseStudyGroup --limit 50
```

Or visit: <https://github.com/AhmedAzzu25/OpsVerseStudyGroup/issues>

### Step 2: Create GitHub Project (Manual)

1. Go to: <https://github.com/AhmedAzzu25/OpsVerseStudyGroup/projects>
2. Click **"New project"**
3. Choose **"Board"** template
4. Name: `OpsVerse Study Group - 2026 Q1-Q2`

### Step 3: Add Custom Fields to Project

Click "+ New field" and add:

| Field | Type | Values |
|-------|------|--------|
| Module | Single select | IMS, Healthcare, Infra-Guardian, Gov-Services, Fintech, Ops-Agent, Charity, Logistics |
| Cert Alignment | Single select | GitHub Foundations, GitHub Actions, Terraform, AZ-204, AZ-400, AZ-305 |
| Track | Single select | Track A, Track B, Track C |
| Priority | Single select | High, Medium, Low |
| Sprint | Single select | Sprint 1, Sprint 2, Sprint 3... |
| Estimate | Number | (hours) |

### Step 4: Add Issues to Project

**Option A - Manual**:

- Open each issue
- Click "Projects" on the right sidebar
- Select your project

**Option B - Bulk** (using labels):

1. In project settings, create workflow:
   - When: Issue labeled with `opsverse-2026`
   - Then: Add to project

2. Bulk add label:

```powershell
# Get all issue numbers
$issues = gh issue list --repo AhmedAzzu25/OpsVerseStudyGroup --limit 100 --json number --jq '.[].number'

# Add label to all
foreach ($issue in $issues) {
    gh issue edit $issue --repo AhmedAzzu25/OpsVerseStudyGroup --add-label "opsverse-2026"
}
```

---

## 🔧 Advanced Usage

### Dry Run (Preview without creating)

Modify the script to add `-WhatIf`:

```powershell
# In the script, change:
gh issue create ... 
# To:
Write-Host "Would create: $title"
```

### Customize Issue Templates

Edit the script variables:

- `$Certifications` - Add/remove certifications
- `$TrackAWeeks` - Modify course weeks
- `$Modules` - Add/remove modules
- `$IMSTasks` - Add/remove tasks

### Create Track B and Track C Issues

Add data for Track B (13 weeks) and Track C (13 weeks) in the script, then run:

```powershell
.\create-github-project.ps1 -CreateIssues -Category CourseWeeks -Track B
.\create-github-project.ps1 -CreateIssues -Category CourseWeeks -Track C
```

---

## 📝 Issue Templates Created

All issues reference back to:

- `management/TIMESHEET.md` - Main tracking document
- `docs/internal-courses/SYLLABUS.md` - Course details
- `docs/certifications/PROJECT_CERT_ALIGNMENT.md` - Cert details

---

## 🐛 Troubleshooting

### Error: "gh: command not found"

```powershell
# Install GitHub CLI
winget install GitHub.cli

# Or download from:
https://cli.github.com/
```

### Error: "Not authenticated"

```powershell
gh auth login
# Follow prompts
```

### Error: "Rate limited"

The script includes 500ms delays between issues. If you hit rate limits:

- Wait 5 minutes
- Run script again (it will skip existing issues)

### Error: "Duplicate issues"

GitHub CLI won't create duplicates with exact same titles. To recreate:

```powershell
# Delete all issues (CAREFUL!)
gh issue list --repo AhmedAzzu25/OpsVerseStudyGroup --json number --jq '.[].number' | ForEach-Object {
    gh issue close $_ --repo AhmedAzzu25/OpsVerseStudyGroup
}
```

---

## 📊 Issue Count Breakdown

| Category | Count | Labels |
|----------|-------|--------|
| Certifications | 10 | `certification` |
| Track A Weeks | 17 | `course`, `track-a`, `week-*` |
| Track B Weeks | 13 | `course`, `track-b`, `week-*` |
| Track C Weeks | 13 | `course`, `track-c`, `week-*` |
| Module Epics | 8 | `module`, `epic` |
| IMS Tasks | 12 | `module`, `ims`, `development` |
| **Total** | **73** | |

---

## 🎯 Next Steps

After creating issues:

1. **Triage**: Review all issues, adjust labels/priorities
2. **Assign**: Distribute across team members
3. **Milestone**: Create milestones for certifications
4. **Sprint**: Group into 2-week sprints
5. **Track**: Update TIMESHEET.md weekly

---

## 📚 Resources

- **GitHub CLI Docs**: <https://cli.github.com/manual/>
- **GitHub Projects**: <https://docs.github.com/en/issues/planning-and-tracking-with-projects>
- **TIMESHEET.md**: `../management/TIMESHEET.md`
- **Setup Guide**: `../management/GITHUB_PROJECT_SETUP_GUIDE.md`

---

## 🎉 Success

Once complete, you'll have:

- ✅ 70+ GitHub issues created
- ✅ All labeled and categorized
- ✅ Ready to add to Project board
- ✅ Linked back to TIMESHEET.md

Start tracking your team's progress! 🚀
