# 🚀 READY TO RUN - GitHub Project Automation

## ✅ Prerequisites Checked

- ✅ GitHub CLI installed (v2.83.0)
- ❓ Authentication status: Check before running

---

## 🎯 Quick Start (3 Steps)

### Step 1: Authenticate (if needed)

```powershell
gh auth status
```

If not authenticated:

```powershell
gh auth login
```

- Choose: GitHub.com
- Protocol: HTTPS
- Authenticate: Browser
- Follow prompts

### Step 2: Test with 3 Issues

```powershell
cd e:\STG\scripts
.\test-create-issues.ps1
```

This creates 3 sample issues to verify everything works:

- [CERT] GitHub Foundations Study & Exam
- [Track A] Week 1 - Git & GitHub Fundamentals  
- [IMS][Epic 1] Setup .NET 8 Web API Project

### Step 3: Create All Issues

```powershell
.\create-github-project.ps1 -CreateIssues -Category All
```

This creates **~47 issues**:

- 10 certifications
- 17 course weeks (Track A)
- 8 module  epics
- 12 IMS tasks

---

## 📊 What You'll Get

### Issue Breakdown

| Category | Count | Labels | Example |
|----------|-------|--------|---------|
| **Certifications** | 10 | `certification`, `week-*` | [CERT] AZ-400 DevOps Expert |
| **Track A Weeks** | 17 | `course`, `track-a` | [Track A] Week 5 - Azure Fundamentals |
| **Module Epics** | 8 | `module`, `epic` | [Healthcare] Complete Medical Records Module |
| **IMS Tasks** | 12 | `module`, `ims` | [IMS][Epic 2] Implement Outbox Pattern |
| **Total** | **47** | | |

### All Issues Link Back to TIMESHEET.md

Every issue includes:

```markdown
---
**Timesheet Reference**: TIMESHEET.md - [Section]
```

---

## 🎬 Run Options

### Option 1: Everything at Once

```powershell
.\create-github-project.ps1 -CreateIssues -Category All
```

### Option 2: Step by Step

**Just Certifications** (10 issues):

```powershell
.\create-github-project.ps1 -CreateIssues -Category Certifications
```

**Just Course Weeks** (17 issues):

```powershell
.\create-github-project.ps1 -CreateIssues -Category CourseWeeks -Track A
```

**Just Modules** (8 issues):

```powershell
.\create-github-project.ps1 -CreateIssues -Category Modules
```

**Just IMS Tasks** (12 issues):

```powershell
.\create-github-project.ps1 -CreateIssues -Category IMS
```

### Option 3: Custom Mix

Run multiple categories in sequence:

```powershell
# First, create certification issues
.\create-github-project.ps1 -CreateIssues -Category Certifications

# Then, create week 1-4 only (manually edit script to limit weeks)
.\create-github-project.ps1 -CreateIssues -Category CourseWeeks -Track A

# Finally, create IMS tasks
.\create-github-project.ps1 -CreateIssues -Category IMS
```

---

## 🎯 After Running

### 1. View Created Issues

**In Browser**:
<https://github.com/AhmedAzzu25/OpsVerseStudyGroup/issues>

**In Terminal**:

```powershell
gh issue list --repo AhmedAzzu25/OpsVerseStudyGroup --limit 50
```

### 2. Create GitHub Project

Now that issues exist, create the project:

1. Go to: <https://github.com/AhmedAzzu25/OpsVerseStudyGroup/projects>
2. Click **"New project"**
3. Choose **"Board"** template
4. Name: `OpsVerse Study Group - 2026 Q1-Q2`

### 3. Add Custom Fields

In your new project, add these fields:

| Field | Type | Values |
|-------|------|--------|
| Module | Single select | IMS, Healthcare, Infra-Guardian, Gov-Services, Fintech, Ops-Agent, Charity, Logistics |
| Cert Alignment | Single select | GitHub Foundations, GitHub Actions, Terraform, AZ-204, AZ-400, AZ-305 |
| Track | Single select | Track A, Track B, Track C |
| Priority | Single select | High, Medium, Low |
| Estimate | Number | (hours) |

### 4. Add Issues to Project

**Manual** (for learning):

- Open each issue
- Click "Projects" sidebar
- Select your project

**Automated** (recommended):

1. In project, go to Settings → Workflows
2. Create workflow:
   - **When**: Issue is labeled `opsverse-2026`
   - **Then**: Add to this project

3. Bulk add label:

```powershell
# List all issues
$issues = gh issue list --repo AhmedAzzu25/OpsVerseStudyGroup --limit 100 --json number --jq '.[].number'

# Add label to all
foreach ($num in $issues) {
    gh issue edit $num --repo AhmedAzzu25/OpsVerseStudyGroup --add-label "opsverse-2026"
}
```

---

## 📝 Customization

### Add More Tracks

Edit `create-github-project.ps1`:

1. Add `$TrackBWeeks` array (copy from SYLLABUS.md)
2. Add `$TrackCWeeks` array  
3. Update `New-CourseWeekIssues` function to handle B and C

Then run:

```powershell
.\create-github-project.ps1 -CreateIssues -Category CourseWeeks -Track B
.\create-github-project.ps1 -CreateIssues -Category CourseWeeks -Track C
```

### Add More Module Tasks

Edit `$IMSTasks` array for more IMS tasks, or create similar arrays for other modules.

---

## 🐛 Troubleshooting

### "Not authenticated"

```powershell
gh auth login
```

### "Rate limited"

Script includes 500ms delays. If you still hit limits, wait 5 minutes and retry.

### "Duplicate issue"

GitHub prevents exact duplicate titles. Issues are safe to re-run.

### "Permission denied"

Make sure you have write access to the repository.

---

## 📚 Documentation

- **Full Guide**: [GITHUB_PROJECT_SETUP_GUIDE.md](GITHUB_PROJECT_SETUP_GUIDE.md)
- **Automation README**: [README_AUTOMATION.md](README_AUTOMATION.md)
- **Timesheet**: [../management/TIMESHEET.md](../management/TIMESHEET.md)

---

## 🎉 Success Checklist

- [ ] GitHub CLI installed and authenticated
- [ ] Test script run successfully (3 issues)
- [ ] Full script run (47 issues created)
- [ ] GitHub Project created via web UI
- [ ] Custom fields added to project
- [ ] Issues added to project (manual or automated)
- [ ] Team members assigned to issues
- [ ] TIMESHEET.md linked and ready to track

---

## ⚡ READY TO GO

Run this now:

```powershell
cd e:\STG\scripts

# Test first (recommended)
.\test-create-issues.ps1

# Then create all issues
.\create-github-project.ps1 -CreateIssues -Category All
```

**Time**: ~5 minutes for 47 issues

**Result**: Complete GitHub Project setup ready for team tracking! 🚀
