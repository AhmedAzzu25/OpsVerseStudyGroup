# 🎯 GitHub Foundations Certification Study Guide

**Exam Code**: GHF (GitHub Foundations)  
**Duration**: 90 minutes  
**Questions**: 75 multiple choice  
**Passing Score**: 70%  
**Cost**: FREE (for limited time) or $99 USD  
**Estimated Study Time**: 20 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Introduction to Git and GitHub | 12% | 2.5h | ⏳ |
| 2. Working with GitHub Repositories | 20% | 4h | ⏳ |
| 3. Collaboration Features | 30% | 6h | ⏳ |
| 4. Modern Development | 22% | 4.5h | ⏳ |
| 5. Project Management | 10% | 2h | ⏳ |
| 6. Privacy, Security, and Administration | 6% | 1h | ⏳ |

---

## 📚 Domain 1: Introduction to Git and GitHub (12%)

### Topics Covered

- Git vs GitHub vs GitHub Desktop
- Distributed Version Control System (DVCS) concepts
- GitHub accounts (personal, organization, enterprise)
- GitHub billing and plans

### Key Concepts to Master

#### Git vs GitHub

```
Git (Local):
- Version control system
- Works offline
- Commands: git init, git add, git commit, git push

GitHub (Remote):
- Cloud hosting for Git repositories
- Collaboration platform
- Features: Issues, PRs, Actions, Projects
```

#### GitHub Account Types

| Type | Use Case | Cost | Features |
|------|----------|------|----------|
| **Personal** | Individual developers | Free | Unlimited public/private repos |
| **Organization** | Teams | Free or $4/user/month | Team management, SAML SSO |
| **Enterprise** | Large companies | $21/user/month | Advanced security, compliance |

### Practice Questions

1. What is the main difference between Git and GitHub?
2. Which GitHub plan is required for SAML SSO?
3. Can you work with Git without an internet connection?

### Study Resources

- [Git Handbook](https://guides.github.com/introduction/git-handbook/)
- [GitHub Docs: Account Types](https://docs.github.com/en/get-started/learning-about-github/types-of-github-accounts)

---

## 📚 Domain 2: Working with GitHub Repositories (20%)

### Topics Covered

- Creating and cloning repositories
- Understanding repository visibility (public, private, internal)
- Repository components (README, LICENSE, .gitignore)
- Commits, branches, and tags
- GitHub gists and wikis

### Key Concepts to Master

#### Repository Visibility

```
Public:
  ✅ Anyone can view and fork
  ✅ Good for open source
  ❌ Code is visible to all

Private:
  ✅ Only invited collaborators
  ✅ Good for proprietary code
  ❌ Limited collaborators on free plan

Internal (Enterprise only):
  ✅ All org members can access
  ✅ Not visible outside organization
```

#### Essential Repository Files

**README.md**

```markdown
# Project Title
Description of what the project does.

## Installation
`npm install`

## Usage
`npm start`

## Contributing
See CONTRIBUTING.md
```

**.gitignore**

```
node_modules/
*.log
.env
build/
```

**LICENSE**

- MIT, Apache 2.0, GPL (know differences!)
- Required for open source projects

#### Git Workflow

```bash
# Clone repository
git clone https://github.com/user/repo.git

# Create branch
git checkout -b feature/new-feature

# Make changes, then stage
git add .

# Commit with meaningful message
git commit -m "feat: add user authentication"

# Push to remote
git push origin feature/new-feature
```

#### Commits Best Practices

- Use conventional commits: `feat:`, `fix:`, `docs:`, `chore:`
- Keep commits atomic (one logical change)
- Write descriptive messages

#### Tags vs Branches

```
Tags:
  - Immutable reference to specific commit
  - Typically used for releases (v1.0.0)
  - Command: git tag v1.0.0

Branches:
  - Mutable pointer to commits
  - Used for parallel development
  - Command: git branch feature-x
```

### Hands-On Practice (See Practice Tasks #1-4)

- [ ] Create a new repository with README, LICENSE, .gitignore
- [ ] Clone, make changes, commit, push
- [ ] Create and merge branches
- [ ] Create a release tag

### Practice Questions

1. What file should you use to exclude build artifacts from version control?
2. What's the difference between a tag and a branch?
3. Which repository visibility allows forking by anyone?
4. What is the purpose of a README.md file?

---

## 📚 Domain 3: Collaboration Features (30%) ⭐ HIGHEST WEIGHT

### Topics Covered

- Issues and templates
- Pull Requests (PRs) and draft PRs
- Code review process
- Discussions
- Notifications and watching repositories
- GitHub Pages
- Wikis

### Key Concepts to Master

#### Issues

```yaml
Purpose:
  - Bug reports
  - Feature requests
  - Task tracking
  - Q&A

Features:
  - Labels (bug, enhancement, documentation)
  - Assignees
  - Milestones
  - Projects (Kanban boards)
  - Templates
```

**Issue Template Example** (.github/ISSUE_TEMPLATE/bug_report.md):

```markdown
---
name: Bug Report
about: Report a bug
labels: bug
---

## Description
Brief description of the bug.

## Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. See error

## Expected Behavior
What should happen.

## Actual Behavior
What actually happens.

## Screenshots
If applicable.
```

#### Pull Requests (PRs)

```
PR Workflow:
1. Fork repository (or create branch)
2. Make changes in feature branch
3. Open PR from feature → main
4. Request reviewers
5. Address feedback (commit to same branch)
6. Merge when approved

PR Types:
  - Draft PR: Work in progress, not ready for review
  - Ready for Review: Complete, needs approval
```

**PR Template** (.github/PULL_REQUEST_TEMPLATE.md):

```markdown
## What does this PR do?
Brief description.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Checklist
- [ ] Tests pass locally
- [ ] Added unit tests
- [ ] Updated documentation
- [ ] No merge conflicts

## Screenshots (if UI changes)

## Related Issues
Closes #123
```

#### Code Review Best Practices

```
Reviewer:
  ✅ Check code quality, readability, tests
  ✅ Suggest improvements politely
  ✅ Approve or request changes
  ❌ Don't block on minor style issues

Author:
  ✅ Respond to all comments
  ✅ Push new commits to address feedback
  ✅ Re-request review after changes
  ❌ Don't force-push after review started
```

#### Branch Protection Rules

```yaml
Settings → Branches → Add Rule:
  - Require pull request before merging
  - Require approvals (minimum 1-2)
  - Require status checks to pass (CI)
  - Require conversation resolution
  - Require signed commits
  - Include administrators (enforce for all)
```

#### GitHub Discussions

```
Purpose:
  - Community Q&A
  - Announcements
  - Ideas and brainstorming
  
Categories:
  - General
  - Q&A
  - Ideas
  - Announcements
  - Show and Tell
```

#### GitHub Pages

```bash
# Enable Pages for documentation
Settings → Pages → Source: main branch /docs folder

# Common uses:
- Project documentation (Sphinx, MkDocs)
- Personal website (Jekyll)
- Portfolio
- Demo sites

# URL format:
https://<username>.github.io/<repository>
```

### Hands-On Practice (See Practice Tasks #5-8)

- [ ] Create and assign an issue
- [ ] Open a pull request
- [ ] Review a PR with comments
- [ ] Set up branch protection
- [ ] Enable GitHub Pages

### Practice Questions

1. What's the difference between a draft PR and a regular PR?
2. How do you link a PR to an issue?
3. What are branch protection rules used for?
4. Where should issue templates be stored?
5. What is the purpose of GitHub Discussions vs Issues?

---

## 📚 Domain 4: Modern Development (22%)

### Topics Covered

- GitHub Actions basics
- GitHub Copilot overview
- GitHub Codespaces
- GitHub Mobile

### Key Concepts to Master

#### GitHub Actions

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm install
      
      - name: Run tests
        run: npm test
```

**Key Concepts**:

- **Workflow**: Automated process (YAML file in `.github/workflows/`)
- **Event**: Trigger (push, pull_request, schedule, workflow_dispatch)
- **Job**: Set of steps running on same runner
- **Step**: Individual task (action or shell command)
- **Runner**: Server that executes workflows (GitHub-hosted or self-hosted)
- **Action**: Reusable unit of code (from Marketplace)

**Common Triggers**:

```yaml
on:
  push:                    # Code pushed to repo
  pull_request:            # PR opened/updated
  schedule:                # Cron schedule
    - cron: '0 0 * * *'    # Daily at midnight
  workflow_dispatch:       # Manual trigger
  release:                 # Release published
```

#### GitHub Copilot

```
What it is:
  - AI pair programmer
  - Autocompletes code from comments
  - Suggests entire functions
  - Available in VS Code, JetBrains, Neovim

Plans:
  - Individual: $10/month
  - Business: $19/user/month
  - Free for students and verified open source maintainers

Key Features:
  - Code suggestions (Tab to accept)
  - Multiple suggestions (Ctrl+Enter)
  - Comment-to-code generation
```

#### GitHub Codespaces

```
What it is:
  - Cloud-based development environment
  - Runs VS Code in browser
  - Pre-configured with dependencies

Use Cases:
  - Onboard new contributors (no local setup)
  - Quick bug fixes (edit from browser)
  - Consistent dev environments

Pricing:
  - Free tier: 60 hours/month for individuals
  - Paid: $0.18/hour (2-core machine)
```

**Codespace Configuration** (.devcontainer/devcontainer.json):

```json
{
  "name": "OpsVerse Dev Container",
  "image": "mcr.microsoft.com/devcontainers/javascript-node:18",
  "features": {
    "ghcr.io/devcontainers/features/docker-in-docker:1": {}
  },
  "postCreateCommand": "npm install",
  "customizations": {
    "vscode": {
      "extensions": [
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode"
      ]
    }
  }
}
```

#### GitHub Mobile

```
Features:
  - Triage notifications
  - Review and merge PRs
  - Approve deployment workflows
  - Browse code
  - Available: iOS and Android

Common Use Cases:
  - Approve critical hotfix PR while away from desk
  - Respond to @mentions
  - Check CI status
```

### Hands-On Practice (See Practice Tasks #9-11)

- [ ] Create a basic GitHub Actions workflow
- [ ] Launch a Codespace
- [ ] Install GitHub Mobile (optional)

### Practice Questions

1. What file extension do GitHub Actions workflows use?
2. Where should workflow files be stored in a repository?
3. What is a GitHub Actions runner?
4. Can you run GitHub Actions workflows manually? How?
5. What is GitHub Copilot used for?

---

## 📚 Domain 5: Project Management (10%)

### Topics Covered

- GitHub Projects (Kanban boards)
- Milestones
- Labels
- Automated project workflows

### Key Concepts to Master

#### GitHub Projects

```
Types:
  - Classic Projects (simple Kanban)
  - Projects (Beta) - New table/board views with automation

Views:
  - Board (Kanban style)
  - Table (spreadsheet style)
  - Roadmap (timeline view)

Common Columns:
  - To Do
  - In Progress
  - Review
  - Done
```

**Project Automation**:

```
Built-in Workflows:
  - Auto-add new issues to project
  - Move to "In Progress" when issue assigned
  - Move to "Done" when issue closed
  - Move to "Review" when PR opened
```

#### Milestones

```
Purpose:
  - Group related issues/PRs
  - Track progress toward release
  - Set due dates

Example:
  Milestone: v1.0 Release
  Due: 2026-02-01
  Issues: 10 open, 25 closed (71% complete)
```

#### Labels

```
Common Label Schemes:

Type:
  - bug (red)
  - enhancement (blue)
  - documentation (green)

Priority:
  - P0: Critical
  - P1: High
  - P2: Medium
  - P3: Low

Status:
  - needs-triage
  - blocked
  - help-wanted
  - good-first-issue
```

### Hands-On Practice (See Practice Task #12)

- [ ] Create a project board
- [ ] Add issues to milestones
- [ ] Use labels to categorize issues

### Practice Questions

1. What's the difference between a milestone and a label?
2. Can you add PRs to a GitHub Project?
3. How do you automatically move issues between columns?

---

## 📚 Domain 6: Privacy, Security, and Administration (6%)

### Topics Covered

- Authentication (2FA, PAT, SSH keys)
- Repository permissions and roles
- Security features (Dependabot, Code Scanning, Secret Scanning)
- GitHub's privacy policies

### Key Concepts to Master

#### Authentication Methods

```
1. HTTPS with Personal Access Token (PAT):
   git clone https://github.com/user/repo.git
   Username: your-username
   Password: ghp_xxxxxxxxxxxx (PAT)

2. SSH Keys:
   git clone git@github.com:user/repo.git
   (Uses ~/.ssh/id_ed25519 key)

3. Two-Factor Authentication (2FA):
   - Recommended for all accounts
   - TOTP apps (Authy, Google Authenticator)
   - Security keys (YubiKey)
```

**Creating a PAT**:

```
Settings → Developer settings → Personal access tokens → Tokens (classic)

Scopes:
  - repo: Full control of private repos
  - workflow: Update GitHub Actions workflows
  - admin:org: Manage organizations

Expiration: 30 days, 90 days, custom (max 1 year recommended)
```

#### Repository Permissions

```
Roles (from least to most access):

Read:
  - View code
  - Open issues
  - Comment on PRs
  ❌ Cannot push code

Triage:
  - Read +
  - Manage issues/PRs (labels, assignees)
  ❌ Cannot merge

Write:
  - Triage +
  - Push to branches
  - Merge PRs
  ❌ Cannot modify settings

Maintain:
  - Write +
  - Manage releases
  - Manage branch protection
  ❌ Cannot delete repo

Admin:
  - Full access
  - Modify settings
  - Delete repository
```

#### Security Features

**Dependabot**:

```
Purpose: Automatic dependency updates

Features:
  - Security alerts for vulnerable dependencies
  - Automatic PRs to update dependencies
  - Version updates (e.g., npm packages)

Configuration (.github/dependabot.yml):
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
```

**Code Scanning (CodeQL)**:

```
Purpose: Find security vulnerabilities in code

Languages Supported:
  - JavaScript, TypeScript, Python, Java, C++, C#, Go, Ruby

Setup:
  - Enable in Security tab
  - Uses GitHub Actions workflow
  - Results appear in Security → Code scanning alerts
```

**Secret Scanning**:

```
Purpose: Detect committed secrets (API keys, tokens)

Automatically scans for:
  - AWS access keys
  - GitHub PATs
  - Stripe API keys
  - 100+ token types

Action: Alerts sent to repo admins
```

### Hands-On Practice (See Practice Task #13)

- [ ] Enable 2FA on your account
- [ ] Create a Personal Access Token
- [ ] Enable Dependabot alerts

### Practice Questions

1. What are the 5 repository permission levels?
2. What's the recommended authentication method for Git operations?
3. What does Dependabot do?
4. Should you commit API keys to a repository?
5. What is the purpose of 2FA?

---

## 🎯 Hands-On Practice Tasks

Located in: `e:\STG\github-cert-practice\`

### Task 1: Repository Basics

- [ ] Create new repo "hello-github" with README, MIT license, .gitignore
- [ ] Clone locally
- [ ] Add a file, commit, push
- [ ] Create a release tag v1.0.0

### Task 2: Branching & Merging

- [ ] Create branch "feature/add-docs"
- [ ] Add CONTRIBUTING.md
- [ ] Commit and push branch
- [ ] Merge via GitHub UI (no PR yet)

### Task 3: README Mastery

- [ ] Enhance README with badges
- [ ] Add sections: Installation, Usage, Contributing
- [ ] Include code blocks and links

### Task 4: Issue Management

- [ ] Create 3 issues (1 bug, 1 enhancement, 1 question)
- [ ] Add labels
- [ ] Assign to yourself
- [ ] Close one with a commit message (fix: closes #1)

### Task 5: Pull Request Workflow

- [ ] Create branch "feature/new-feature"
- [ ] Make changes
- [ ] Open PR
- [ ] Self-review (add comments)
- [ ] Merge PR

### Task 6: Branch Protection

- [ ] Set up branch protection on main
- [ ] Require PR reviews (minimum 1)
- [ ] Require status checks (if you have a workflow)

### Task 7: Issue Templates

- [ ] Create .github/ISSUE_TEMPLATE/bug_report.md
- [ ] Create .github/ISSUE_TEMPLATE/feature_request.md
- [ ] Test by creating new issue

### Task 8: GitHub Pages

- [ ] Create docs/ folder
- [ ] Add index.html
- [ ] Enable Pages (source: main, /docs)
- [ ] Visit <https://yourusername.github.io/hello-github/>

### Task 9: GitHub Actions

- [ ] Create .github/workflows/greetings.yml
- [ ] Use "first-interaction" action to greet new contributors
- [ ] Test by creating issue/PR from alt account or incognito

### Task 10: Advanced Workflow

- [ ] Create CI workflow that runs on PR
- [ ] Add a simple test (e.g., "echo test passed")
- [ ] Make it a required check
- [ ] Open PR and watch it run

### Task 11: Project Board

- [ ] Create project "Cert Study Tracker"
- [ ] Add columns: To Do, Studying, Done
- [ ] Add issues to board
- [ ] Move cards as you progress

### Task 12: Milestones

- [ ] Create milestone "Exam Ready"
- [ ] Add target date (1 week from today)
- [ ] Assign all practice tasks to this milestone

### Task 13: Security Setup

- [ ] Enable 2FA on your GitHub account
- [ ] Create a Personal Access Token (repo scope)
- [ ] Use PAT to push a commit
- [ ] Enable Dependabot alerts

---

## 📖 Study Schedule (20 Hours)

### Weekend 1: Foundations (10 hours)

**Saturday (5 hours)**

- [ ] 09:00-10:30 | Domain 1: Git & GitHub Intro (1.5h)
- [ ] 10:45-12:45 | Domain 2: Repositories - Study (2h)
- [ ] 13:30-15:00 | Practice Tasks 1-3 (1.5h)

**Sunday (5 hours)**

- [ ] 09:00-12:00 | Domain 3: Collaboration Features (3h)
- [ ] 13:00-15:00 | Practice Tasks 4-8 (2h)

### Weekday Evening Sessions (6 hours)

**Monday (2 hours)**

- [ ] 19:00-21:00 | Domain 4: Modern Development (2h)

**Tuesday (2 hours)**

- [ ] 19:00-20:00 | Practice Tasks 9-10 (1h)
- [ ] 20:00-21:00 | Domain 5: Project Management (1h)

**Wednesday (2 hours)**

- [ ] 19:00-20:00 | Practice Task 11-12 (1h)
- [ ] 20:00-21:00 | Domain 6: Security (1h)

### Weekend 2: Review & Exam (4 hours)

**Saturday (3 hours)**

- [ ] 09:00-11:00 | Practice Task 13 + Full repo review (2h)
- [ ] 11:00-12:00 | Practice questions review (1h)

**Sunday (1 hour)**

- [ ] 09:00-10:00 | Take practice exam
- [ ] **SCHEDULE REAL EXAM** 🎯

---

## 📝 Practice Exam Questions

### Domain 1: Introduction (9 questions)

1. What is the primary difference between Git and GitHub?
   - a) Git is proprietary, GitHub is open source
   - b) Git is version control software, GitHub is a hosting platform ✅
   - c) Git only works with GitHub
   - d) There is no difference

2. Which GitHub plan is required for SAML SSO?
   - a) Free
   - b) Pro
   - c) Team
   - d) Enterprise ✅

3. Is an internet connection required to work with Git?
   - a) Yes, always
   - b) No, Git works offline ✅
   - c) Only for commits
   - d) Only for pushes

### Domain 2: Repositories (15 questions)

1. What file specifies which files Git should ignore?
   - a) .gitignore ✅
   - b) .ignore
   - c) ignorefile
   - d) .notrack

2. What's the difference between a tag and a branch?
   - a) Tags are mutable, branches are immutable
   - b) Tags are immutable references, branches are mutable ✅
   - c) No difference
   - d) Tags are only for releases published to GitHub

3. Which repository visibility allows anyone to fork?
   - a) Private
   - b) Internal
   - c) Public ✅
   - d) Protected

### Domain 3: Collaboration (22 questions)

1. What does "Closes #42" in a commit message do?
   - a) Nothing
   - b) Closes pull request #42
   - c) Closes issue #42 when merged to default branch ✅
   - d) Deletes issue #42

2. What is a draft pull request?
   - a) A PR that can't be merged
   - b) A PR marked as work-in-progress ✅
   - c) A PR without code changes
   - d) A PR without a description

3. Where should issue templates be stored?
   - a) /templates/
   - b) .github/ISSUE_TEMPLATE/ ✅
   - c) Root directory
   - d) /docs/templates/

4. What branch protection rule requires PRs?
    - a) Require status checks
    - b) Require approvals
    - c) Require pull request before merging ✅
    - d) Require signed commits

### Domain 4: Modern Development (16 questions)

1. What format are GitHub Actions workflows written in?
    - a) JSON
    - b) XML
    - c) YAML ✅
    - d) TOML

2. Where are workflow files stored?
    - a) /workflows/
    - b) .github/workflows/ ✅
    - c) /.github/actions/
    - d) /actions/

3. What triggers a workflow on every push?
    - a) on: push ✅
    - b) trigger: push
    - c) when: push
    - d) event: push

4. What is GitHub Copilot?
    - a) A code review tool
    - b) An AI pair programmer ✅
    - c) A deployment service
    - d) A project management tool

### Domain 5: Project Management (7 questions)

1. Can pull requests be added to GitHub Projects?
    - a) No, only issues
    - b) Yes ✅
    - c) Only in Enterprise plan
    - d) Only draft PRs

2. What is a milestone used for?
    - a) Track commits
    - b) Group related issues/PRs toward a goal ✅
    - c) Mark repository stars
    - d) Track contributors

### Domain 6: Security (5 questions)

1. What are the repository permission levels? (Select all)
    - a) Read ✅
    - b) View
    - c) Write ✅
    - d) Admin ✅
    - e) Triage ✅
    - f) Maintain ✅

2. What does Dependabot do?
    - a) Deploys applications
    - b) Scans for vulnerable dependencies ✅
    - c) Reviews code
    - d) Manages branches

3. Should API keys be committed to repositories?
    - a) Yes, for convenience
    - b) No, never ✅
    - c) Only in private repos
    - d) Only if encrypted

4. What is 2FA?
    - a) Two-factor authentication ✅
    - b) Two-file access
    - c) Two-fork approval
    - d) Two-factor approval

---

## 🎓 Official Microsoft Learn Path

Complete this learning path (FREE):
**[GitHub Foundations](https://learn.microsoft.com/en-us/training/paths/github-foundations/)**

Modules:

1. ✅ Introduction to Git
2. ✅ Introduction to GitHub
3. ✅ Work with GitHub repositories
4. ✅ Collaborate with pull requests
5. ✅ Search and organize repository history
6. ✅ Manage your work with GitHub Projects
7. ✅ Communicate effectively on GitHub using Markdown
8. ✅ Build community on GitHub
9. ✅ Introduction to GitHub administration
10. ✅ Introduction to GitHub Copilot

**Total Learning Time**: 6-8 hours

---

## 🔗 Additional Resources

### Official Documentation

- [GitHub Docs](https://docs.github.com/)
- [GitHub Skills (Interactive Tutorials)](https://skills.github.com/)
- [Git Cheat Sheet](https://training.github.com/downloads/github-git-cheat-sheet/)

### Practice Platforms

- [GitHub Learning Lab](https://lab.github.com/) (Deprecated but still useful)
- [Git Handbook](https://guides.github.com/introduction/git-handbook/)

### YouTube Channels

- [GitHub Training & Guides](https://www.youtube.com/githubguides)
- [Fireship: Git in 100 Seconds](https://www.youtube.com/watch?v=hwP7WQkmECE)

### Community

- [GitHub Community Forum](https://github.community/)
- [r/github](https://reddit.com/r/github)

---

## ✅ Final Checklist

### Before Exam Day

- [ ] Completed all 6 domains study
- [ ] Finished 13 practice tasks
- [ ] Reviewed all practice questions (70%+ correct)
- [ ] Completed MS Learn path
- [ ] Created 1-2 real projects using GitHub
- [ ] Comfortable with: repos, branches, PRs, Issues, Actions basics

### Exam Day

- [ ] Get good sleep (7-8 hours)
- [ ] Have ID ready (government-issued)
- [ ] Stable internet connection
- [ ] Quiet environment (90 minutes uninterrupted)
- [ ] Water and snacks nearby
- [ ] Read each question twice before answering
- [ ] Flag uncertain questions for review

### After Passing 🎉

- [ ] Share badge on LinkedIn
- [ ] Update resume with certification
- [ ] Move to GitHub Actions cert study
- [ ] Start building IMS module with CI/CD

---

## 💡 Pro Tips

1. **Hands-On is Key**: Don't just read - actually do the practice tasks
2. **Focus on Collaboration**: Domain 3 is 30% - master PRs and Issues
3. **Know the Differences**: Git vs GitHub, Tag vs Branch, Issue vs Discussion
4. **Understand Workflows**: Basic YAML syntax, common triggers
5. **Security Matters**: Know authentication methods, Dependabot, permissions

---

**You've got this! 20 hours to certification. Let's go! 🚀**
