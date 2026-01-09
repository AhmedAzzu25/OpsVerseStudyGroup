# 📝 GitHub Foundations Practice Tasks

Complete these tasks sequentially to build practical GitHub skills.

---

## ✅ Task 1: Repository Basics

**Objective**: Master repository creation and basic Git operations.

### Steps

1. **Create new repository**
   - Go to GitHub.com → New Repository
   - Name: `hello-github`
   - ✅ Add README.md
   - ✅ Add .gitignore (choose: Node, Python, or your preference)
   - ✅ Choose license: MIT
   - Click "Create repository"

2. **Clone locally**

   ```bash
   git clone https://github.com/YOUR_USERNAME/hello-github.git
   cd hello-github
   ```

3. **Create a new file**

   ```bash
   echo "# Hello GitHub!" > HELLO.md
   git add HELLO.md
   git commit -m "docs: add hello file"
   git push origin main
   ```

4. **Create a release tag**

   ```bash
   git tag -a v1.0.0 -m "First release"
   git push origin v1.0.0
   ```

   - Verify on GitHub: Releases → Tags

### ✅ Success Criteria

- [ ] Repository created with README, LICENSE, .gitignore
- [ ] File added and committed
- [ ] Tag v1.0.0 visible on GitHub

---

## ✅ Task 2: Branching & Merging

**Objective**: Practice Git branching workflow.

### Steps

1. **Create a branch**

   ```bash
   git checkout -b feature/add-docs
   ```

2. **Add CONTRIBUTING.md**

   ```bash
   cat > CONTRIBUTING.md << 'EOF'
   # Contributing Guidelines

   ## How to Contribute
   1. Fork the repository
   2. Create a feature branch
   3. Make your changes
   4. Submit a pull request

   ## Code Style
   - Use meaningful commit messages
   - Follow conventional commits (feat:, fix:, docs:)
   EOF
   ```

3. **Commit and push**

   ```bash
   git add CONTRIBUTING.md
   git commit -m "docs: add contributing guidelines"
   git push origin feature/add-docs
   ```

4. **Merge via GitHub**
   - Go to repository on GitHub
   - You'll see "Compare & pull request" banner (click it)
   - Click "Merge pull request" → "Confirm merge"
   - **OR** manually: Branches → feature/add-docs → Merge

5. **Pull changes locally**

   ```bash
   git checkout main
   git pull origin main
   ```

### ✅ Success Criteria

- [ ] Branch `feature/add-docs` created
- [ ] CONTRIBUTING.md exists on main branch
- [ ] Local main branch is up to date

---

## ✅ Task 3: README Mastery

**Objective**: Create a professional README with badges, sections, and formatting.

### Steps

1. **Edit README.md**

   ```bash
   # Replace existing content
   cat > README.md << 'EOF'
   # Hello GitHub 👋

   ![GitHub](https://img.shields.io/badge/GitHub-Foundations-blue)
   ![License](https://img.shields.io/badge/license-MIT-green)

   A demo repository for learning GitHub fundamentals.

   ## 📦 Installation

   ```bash
   git clone https://github.com/YOUR_USERNAME/hello-github.git
   cd hello-github
   ```

   ## 🚀 Usage

   This is a practice repository for GitHub certification prep.

   ## 🤝 Contributing

   See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

   ## 📄 License

   This project is licensed under the MIT License - see the [LICENSE](LICENSE) file.

   ## 📚 Resources

   - [GitHub Docs](https://docs.github.com/)
   - [Git Cheat Sheet](https://training.github.com/downloads/github-git-cheat-sheet/)
   EOF

   ```

2. **Update YOUR_USERNAME** in the README

3. **Commit changes**

   ```bash
   git add README.md
   git commit -m "docs: enhance README with badges and structure"
   git push origin main
   ```

### ✅ Success Criteria

- [ ] README has badges
- [ ] Clear sections: Installation, Usage, Contributing, License
- [ ] Code blocks formatted properly
- [ ] Links work correctly

---

## ✅ Task 4: Issue Management

**Objective**: Practice creating and organizing issues.

### Steps

1. **Create Bug Issue**
   - Go to Issues → New Issue
   - Title: "Fix typo in README"
   - Body:

     ```
     ## Description
     The word "repository" is misspelled in line 5.

     ## Expected
     repository

     ## Actual
     repositry
     ```

   - Labels: `bug`
   - Assignee: yourself
   - Submit

2. **Create Enhancement Issue**
   - Title: "Add CI workflow"
   - Body: "Add GitHub Actions workflow for automated testing"
   - Labels: `enhancement`
   - Submit

3. **Create Question Issue**
   - Title: "How to run locally?"
   - Body: "Are there any dependencies to install?"
   - Labels: `question`
   - Submit

4. **Close with commit**

   ```bash
   # Fix the typo (if it exists, or just make a change)
   # Edit README.md to fix any typo
   git add README.md
   git commit -m "fix: correct typo in README

   Closes #1"
   git push origin main
   ```

   - Verify issue #1 auto-closed

### ✅ Success Criteria

- [ ] 3 issues created with appropriate labels
- [ ] Issues assigned
- [ ] One issue closed via commit message

---

## ✅ Task 5: Pull Request Workflow

**Objective**: Master the PR process from creation to merge.

### Steps

1. **Create feature branch**

   ```bash
   git checkout -b feature/add-code-of-conduct
   ```

2. **Add CODE_OF_CONDUCT.md**

   ```bash
   cat > CODE_OF_CONDUCT.md << 'EOF'
   # Code of Conduct

   ## Our Pledge
   We pledge to make participation in our community a harassment-free experience for everyone.

   ## Standards
   - Be respectful
   - Accept constructive criticism
   - Focus on what is best for the community

   ## Enforcement
   Report violations to [your-email@example.com]
   EOF
   ```

3. **Commit and push**

   ```bash
   git add CODE_OF_CONDUCT.md
   git commit -m "docs: add code of conduct"
   git push origin feature/add-code-of-conduct
   ```

4. **Create Pull Request**
   - Go to repository → Pull Requests → New
   - Base: `main` ← Compare: `feature/add-code-of-conduct`
   - Title: "Add Code of Conduct"
   - Description:

     ```
     ## What does this PR do?
     Adds a Code of Conduct file.

     ## Type of Change
     - [x] Documentation update

     ## Checklist
     - [x] Follows project structure
     - [x] Ready for review
     ```

   - Create pull request

5. **Self-Review**
   - Click "Files changed"
   - Click line 3, add comment: "Consider adding more examples"
   - Submit review (Comment, not Approve yet)

6. **Address feedback** (optional: add more content)

7. **Merge PR**
   - Click "Merge pull request"
   - Confirm merge
   - Delete branch (optional)

### ✅ Success Criteria

- [ ] Feature branch created
- [ ] PR opened with description
- [ ] Code review comment added
- [ ] PR merged successfully

---

## ✅ Task 6: Branch Protection

**Objective**: Set up branch protection rules for main branch.

### Steps

1. **Navigate to Settings**
   - Repository → Settings → Branches

2. **Add Branch Protection Rule**
   - Branch name pattern: `main`
   - ✅ Require a pull request before merging
   - ✅ Require approvals (set to 1)
   - ✅ Dismiss stale pull request approvals when new commits are pushed
   - (If you have Actions): ✅ Require status checks to pass before merging
   - ✅ Require conversation resolution before merging
   - ✅ Do not allow bypassing the above settings
   - Click "Create"

3. **Test Protection**

   ```bash
   git checkout main
   git pull
   echo "test" >> README.md
   git add README.md
   git commit -m "test: verify branch protection"
   git push origin main
   ```

   - ❌ This should FAIL with "protected branch" error

4. **Correct workflow**

   ```bash
   git checkout -b test/branch-protection
   git push origin test/branch-protection
   ```

   - Create PR from `test/branch-protection` → `main`
   - Notice you can't merge without approval

### ✅ Success Criteria

- [ ] Branch protection enabled on `main`
- [ ] Direct push to main blocked
- [ ] PR requires approval before merge

---

## ✅ Task 7: Issue Templates

**Objective**: Create reusable issue templates.

### Steps

1. **Create template directory**

   ```bash
   mkdir -p .github/ISSUE_TEMPLATE
   ```

2. **Create Bug Report template**

   ```bash
   cat > .github/ISSUE_TEMPLATE/bug_report.md << 'EOF'
   ---
   name: Bug Report
   about: Report a bug
   title: '[BUG] '
   labels: bug
   assignees: ''
   ---

   ## 🐛 Description
   A clear description of the bug.

   ## 📋 Steps to Reproduce
   1. Go to '...'
   2. Click on '...'
   3. See error

   ## ✅ Expected Behavior
   What should happen.

   ## ❌ Actual Behavior
   What actually happens.

   ## 📸 Screenshots
   If applicable, add screenshots.

   ## 🖥️ Environment
   - OS: [e.g. Windows 11]
   - Browser: [e.g. Chrome 120]
   - Version: [e.g. 1.0.0]
   EOF
   ```

3. **Create Feature Request template**

   ```bash
   cat > .github/ISSUE_TEMPLATE/feature_request.md << 'EOF'
   ---
   name: Feature Request
   about: Suggest a new feature
   title: '[FEATURE] '
   labels: enhancement
   assignees: ''
   ---

   ## 💡 Feature Description
   A clear description of the feature.

   ## 🎯 Problem Statement
   What problem does this solve?

   ## 💭 Proposed Solution
   How should this work?

   ## 🔄 Alternatives Considered
   Any alternative solutions?

   ## 📋 Additional Context
   Any other context or screenshots.
   EOF
   ```

4. **Commit templates**

   ```bash
   git checkout -b feat/issue-templates
   git add .github/
   git commit -m "feat: add issue templates"
   git push origin feat/issue-templates
   ```

5. **Create PR and merge**

6. **Test templates**
   - Go to Issues → New Issue
   - Verify template options appear

### ✅ Success Criteria

- [ ] `.github/ISSUE_TEMPLATE/` directory created
- [ ] Bug report template works
- [ ] Feature request template works
- [ ] Templates auto-apply labels

---

## ✅ Task 8: GitHub Pages

**Objective**: Deploy a simple site using GitHub Pages.

### Steps

1. **Create docs folder**

   ```bash
   mkdir docs
   ```

2. **Create index.html**

   ```bash
   cat > docs/index.html << 'EOF'
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Hello GitHub</title>
       <style>
           body {
               font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
               max-width: 800px;
               margin: 50px auto;
               padding: 20px;
               background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
               color: white;
           }
           h1 { font-size: 3em; margin-bottom: 0; }
           p { font-size: 1.2em; }
           a { color: #FFD700; }
       </style>
   </head>
   <body>
       <h1>🚀 Hello GitHub!</h1>
       <p>This is a demo GitHub Pages site for certification practice.</p>
       <p><a href="https://github.com/YOUR_USERNAME/hello-github">View Repository</a></p>
   </body>
   </html>
   EOF
   ```

3. **Commit and push**

   ```bash
   git checkout -b gh-pages-setup
   git add docs/
   git commit -m "feat: add GitHub Pages site"
   git push origin gh-pages-setup
   ```

4. **Create PR and merge to main**

5. **Enable GitHub Pages**
   - Go to Settings → Pages
   - Source: Deploy from branch
   - Branch: `main`, Folder: `/docs`
   - Click "Save"
   - Wait ~1 minute

6. **Visit your site**
   - URL: `https://YOUR_USERNAME.github.io/hello-github/`
   - Verify site loads

### ✅ Success Criteria

- [ ] `docs/index.html` created
- [ ] GitHub Pages enabled
- [ ] Site accessible at `https://YOUR_USERNAME.github.io/hello-github/`

---

## ✅ Task 9: GitHub Actions (Basic)

**Objective**: Create a simple GitHub Actions workflow.

### Steps

1. **Create workflow directory**

   ```bash
   mkdir -p .github/workflows
   ```

2. **Create greeting workflow**

   ```bash
   cat > .github/workflows/greetings.yml << 'EOF'
   name: Greetings

   on: [issue_comment, pull_request_target]

   jobs:
     greeting:
       runs-on: ubuntu-latest
       permissions:
         issues: write
         pull-requests: write
       steps:
         - uses: actions/first-interaction@v1
           with:
             repo-token: ${{ secrets.GITHUB_TOKEN }}
             issue-message: 'Thanks for your first issue! 🎉'
             pr-message: 'Thanks for your first pull request! 🚀'
   EOF
   ```

3. **Commit and push**

   ```bash
   git checkout -b feat/add-workflows
   git add .github/workflows/
   git commit -m "ci: add greetings workflow"
   git push origin feat/add-workflows
   ```

4. **Create PR and merge**

5. **Test workflow**
   - Create a new issue
   - Check if greeting comment appears (might need fresh account/incognito)

### ✅ Success Criteria

- [ ] Workflow file created in `.github/workflows/`
- [ ] Workflow appears in Actions tab
- [ ] Greeting sent on first interaction

---

## ✅ Task 10: GitHub Actions (Advanced)

**Objective**: Create a CI workflow with tests.

### Steps

1. **Create a test script**

   ```bash
   cat > test.sh << 'EOF'
   #!/bin/bash
   echo "Running tests..."
   
   # Simple test: Check if README exists
   if [ -f "README.md" ]; then
       echo "✅ README.md exists"
   else
       echo "❌ README.md not found"
       exit 1
   fi

   # Check if LICENSE exists
   if [ -f "LICENSE" ]; then
       echo "✅ LICENSE exists"
   else
       echo "❌ LICENSE not found"
       exit 1
   fi

   echo "All tests passed! 🎉"
   EOF

   chmod +x test.sh
   ```

2. **Create CI workflow**

   ```bash
   cat > .github/workflows/ci.yml << 'EOF'
   name: CI

   on:
     push:
       branches: [main]
     pull_request:
       branches: [main]

   jobs:
     test:
       runs-on: ubuntu-latest
       
       steps:
         - name: Checkout code
           uses: actions/checkout@v3
         
         - name: Run tests
           run: |
             chmod +x test.sh
             ./test.sh
         
         - name: Success message
           if: success()
           run: echo "✅ All checks passed!"
   EOF
   ```

3. **Commit and push**

   ```bash
   git add test.sh .github/workflows/ci.yml
   git commit -m "ci: add automated testing workflow"
   git push origin feat/add-workflows
   ```

4. **Create PR**
   - Open PR from branch
   - Watch Actions tab - workflow should run
   - Verify checks pass

5. **Make it a required check** (if branch protection active)
   - Settings → Branches → Edit rule
   - Under "Require status checks", search for "test"
   - ✅ Enable "test"
   - Save

### ✅ Success Criteria

- [ ] CI workflow runs on every PR
- [ ] Tests execute successfully
- [ ] Status check appears on PRs

---

## ✅ Task 11: Project Board

**Objective**: Create and use a GitHub Project board.

### Steps

1. **Create Project**
   - Go to Projects tab → New project
   - Template: "Board"
   - Name: "Cert Study Tracker"
   - Click "Create project"

2. **Add columns** (if not already there)
   - To Do
   - In Progress
   - Done

3. **Add issues to board**
   - Click "+ Add item" in "To Do"
   - Add existing issues
   - Create new cards:
     - "Study Domain 1: Git & GitHub"
     - "Study Domain 2: Repositories"
     - "Study Domain 3: Collaboration"
     - "Complete practice exam"

4. **Move cards**
   - Drag "Study Domain 1" to "In Progress"
   - When completed, drag to "Done"

5. **Convert card to issue**
   - Click a card → "Convert to issue"
   - Select repository: hello-github
   - Confirm

### ✅ Success Criteria

- [ ] Project board created
- [ ] At least 5 items added
- [ ] Cards moved between columns
- [ ] At least one card converted to issue

---

## ✅ Task 12: Milestones

**Objective**: Use milestones to track progress toward goals.

### Steps

1. **Create Milestone**
   - Go to Issues → Milestones → New milestone
   - Title: "Exam Ready"
   - Due date: (Set 1 week from today)
   - Description: "Complete all practice tasks and study domains"
   - Click "Create milestone"

2. **Assign issues to milestone**
   - Go to Issues
   - Open an issue
   - Right sidebar → Milestone → Select "Exam Ready"
   - Repeat for all open issues

3. **Track progress**
   - Go to Milestones
   - View "Exam Ready" milestone
   - See progress bar (X% complete)

4. **Close issues**
   - As you complete tasks, close related issues
   - Watch milestone progress increase

### ✅ Success Criteria

- [ ] Milestone "Exam Ready" created with due date
- [ ] At least 3 issues assigned to milestone
- [ ] Progress tracked correctly as issues close

---

## ✅ Task 13: Security Setup

**Objective**: Enable security features and use secure authentication.

### Steps

#### Part A: Enable 2FA

1. **Go to Settings** (your profile, not repo)
   - Settings → Password and authentication
2. **Enable two-factor authentication**
   - Choose: Authenticator app (Authy, Google Authenticator)
   - Scan QR code
   - Enter verification code
   - **SAVE RECOVERY CODES** (important!)
3. **Verify 2FA is active**

#### Part B: Create Personal Access Token

1. **Navigate to Developer Settings**
   - Settings → Developer settings → Personal access tokens → Tokens (classic)
2. **Generate new token**
   - Name: "Git CLI Access"
   - Expiration: 30 days
   - Scopes:
     - ✅ repo (Full control of private repositories)
     - ✅ workflow (Update GitHub Action workflows)
   - Click "Generate token"
   - **COPY TOKEN** (you won't see it again!)

3. **Test PAT with git**

   ```bash
   # Make a change
   echo "\nUpdated with PAT" >> README.md
   git add README.md
   git commit -m "test: verify PAT authentication"
   git push origin main
   
   # When prompted:
   # Username: YOUR_USERNAME
   # Password: ghp_xxxxxxxxxxxx (your PAT)
   ```

4. **Cache credentials** (optional, avoids re-entering)

   ```bash
   # Windows:
   git config --global credential.helper manager

   # Mac:
   git config --global credential.helper osxkeychain

   # Linux:
   git config --global credential.helper cache
   ```

#### Part C: Enable Dependabot

1. **Go to Settings** (repository)
   - Security → Code security and analysis
2. **Enable Dependabot alerts**
   - ✅ Dependabot alerts
   - ✅ Dependabot security updates
3. **Create dependabot.yml** (optional)

   ```bash
   mkdir -p .github
   cat > .github/dependabot.yml << 'EOF'
   version: 2
   updates:
     - package-ecosystem: "github-actions"
       directory: "/"
       schedule:
         interval: "weekly"
   EOF
   
   git add .github/dependabot.yml
   git commit -m "ci: configure dependabot"
   git push
   ```

#### Part D: Enable Secret Scanning

1. **Go to Settings → Code security and analysis**
2. **Enable**:
   - ✅ Secret scanning
   - ✅ Push protection

3. **Test secret scanning**

   ```bash
   # Try to commit a fake secret (DON'T use real one!)
   echo "aws_secret=AKIAIOSFODNN7EXAMPLE" > fake-secret.txt
   git add fake-secret.txt
   git commit -m "test: trigger secret scanning"
   git push
   ```

   - Push protection should block this

### ✅ Success Criteria

- [ ] 2FA enabled on account
- [ ] Personal Access Token created and tested
- [ ] Dependabot alerts enabled
- [ ] Secret scanning enabled
- [ ] Understand how to use PAT for authentication

---

## 🎉 Completion

**Congratulations!** You've completed all 13 practice tasks.

### Final Steps

1. ✅ Review all tasks
2. ✅ Ensure repository is clean and well-organized
3. ✅ Update progress tracker in README
4. ✅ Take practice quiz in study guide
5. ✅ Schedule exam when ready!

### Repository Checklist

- [ ] README.md with badges
- [ ] LICENSE file
- [ ] CONTRIBUTING.md
- [ ] CODE_OF_CONDUCT.md
- [ ] .gitignore
- [ ] Issue templates
- [ ] PR template (optional, bonus)
- [ ] GitHub Actions workflows
- [ ] GitHub Pages deployed
- [ ] Branch protection rules
- [ ] Security features enabled

**You're exam-ready! 🚀**
