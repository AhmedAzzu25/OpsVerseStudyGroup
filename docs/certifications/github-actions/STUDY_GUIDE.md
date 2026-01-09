# 🎯 GitHub Actions Certification Study Guide

**Exam Code**: GitHub Actions  
**Duration**: 120 minutes  
**Questions**: ~50 multiple choice  
**Passing Score**: 70%  
**Cost**: $99 USD  
**Estimated Study Time**: 25 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Author and Maintain Workflows | 40% | 10h | ⏳ |
| 2. Consume Workflows | 20% | 5h | ⏳ |
| 3. Author and Maintain Actions | 25% | 6h | ⏳ |
| 4. Manage GitHub Actions | 15% | 4h | ⏳ |

---

## 📚 Domain 1: Author and Maintain Workflows (40%)

### Topics Covered

- Workflow syntax and structure
- Triggers and events
- Jobs, steps, and runners
- Expressions and contexts
- Environment variables and secrets
- Artifacts and caching
- Matrix builds
- Reusable workflows

### Key Concepts

#### Workflow Structure

```yaml
name: CI Pipeline
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run tests
        run: npm test
```

#### Common Triggers

```yaml
on:
  push:
    branches: [main, develop]
    paths:
      - 'src/**'
  pull_request:
    types: [opened, synchronize]
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight
  workflow_dispatch:  # Manual trigger
  workflow_call:  # Reusable workflow
```

#### Context Variables

```yaml
steps:
  - name: Print context
    run: |
      echo "Event: ${{ github.event_name }}"
      echo "Actor: ${{ github.actor }}"
      echo "Ref: ${{ github.ref }}"
      echo "SHA: ${{ github.sha }}"
```

#### Secrets and Variables

```yaml
env:
  NODE_ENV: production

steps:
  - name: Use secret
    env:
      API_KEY: ${{ secrets.API_KEY }}
    run: ./deploy.sh
```

#### Matrix Strategy

```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest, macos-latest]
    node: [14, 16, 18]
    
runs-on: ${{ matrix.os }}
steps:
  - uses: actions/setup-node@v3
    with:
      node-version: ${{ matrix.node }}
```

#### Caching Dependencies

```yaml
- uses: actions/cache@v3
  with:
    path: ~/.npm
    key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
    restore-keys: |
      ${{ runner.os }}-node-
```

### Practice Questions

1. What's the difference between `workflow_dispatch` and `workflow_call`?
2. How do you run a job only on pull requests to main branch?
3. What context variable gives you the commit SHA?
4. How do you pass outputs between jobs?

---

## 📚 Domain 2: Consume Workflows (20%)

### Topics Covered

- Using actions from marketplace
- Understanding action versions
- Passing inputs to actions
- Managing action outputs
- Troubleshooting workflows

### Key Concepts

#### Using Marketplace Actions

```yaml
- uses: actions/checkout@v3  # Pin to major version
  with:
    fetch-depth: 0

- uses: actions/setup-python@v4
  with:
    python-version: '3.11'
    cache: 'pip'
```

#### Action Inputs and Outputs

```yaml
- uses: some-action@v1
  id: my-action
  with:
    input-param: value

- name: Use output
  run: echo "${{ steps.my-action.outputs.result }}"
```

### Practice Questions

1. What's the benefit of pinning to major version vs exact SHA?
2. How do you reference an action from a private repository?

---

## 📚 Domain 3: Author and Maintain Actions (25%)

### Topics Covered

- Action types (JavaScript, Docker, Composite)
- action.yml metadata file
- Inputs and outputs definition
- Publishing actions to marketplace

### Key Concepts

#### Composite Action Example

```yaml
# action.yml
name: 'Setup Node and Install'
description: 'Set up Node.js and run npm install'

inputs:
  node-version:
    description: 'Node version to use'
    required: true
    default: '18'

runs:
  using: 'composite'
  steps:
    - uses: actions/setup-node@v3
      with:
        node-version: ${{ inputs.node-version }}
    
    - run: npm install
      shell: bash
```

#### JavaScript Action Structure

```
my-action/
├── action.yml
├── index.js
├── package.json
└── README.md
```

### Practice Questions

1. What are the three types of actions?
2. When would you use a Docker action vs JavaScript action?

---

## 📚 Domain 4: Manage GitHub Actions (15%)

### Topics Covered

- Self-hosted runners
- Required workflows
- Runner groups
- Usage limits and billing
- Security best practices

### Key Concepts

#### Self-Hosted Runner

```yaml
runs-on: self-hosted

# Or with labels
runs-on: [self-hosted, linux, x64]
```

#### Required Workflows (Organization-level)

```yaml
# .github/workflows/required-ci.yml in .github repository
on:
  workflow_call:

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: npm audit
```

#### Security Best Practices

```yaml
permissions:
  contents: read
  pull-requests: write

steps:
  - uses: actions/checkout@v3
    with:
      persist-credentials: false
```

### Practice Questions

1. What are runner groups used for?
2. How do you enforce required workflows across an organization?

---

## 🎯 Hands-On Practice Tasks

### Task 1: Basic CI Workflow

Create a workflow that:

- Runs on push to main
- Checks out code
- Installs dependencies
- Runs tests
- Uploads test results

### Task 2: Matrix Build

Create a workflow that tests across:

- 3 OS versions (Ubuntu, Windows, macOS)
- 3 Node versions (14, 16, 18)

### Task 3: Reusable Workflow

Create a reusable workflow for Docker builds that accepts:

- Image name
- Dockerfile path
- Build args

### Task 4: Custom Composite Action

Create a composite action that:

- Sets up Node.js
- Installs dependencies with cache
- Runs linting

### Task 5: Conditional Jobs

Create a workflow where:

- Build always runs
- Deploy only runs on main branch
- Notify only runs if previous jobs failed

---

## 📖 Study Schedule (25 Hours)

### Day 1-2 (8 hours)

- Domain 1: Workflow authoring (40%)
- Create 3 sample workflows

### Day 3 (5 hours)

- Domain 2: Consuming workflows
- Practice using 10 different marketplace actions

### Day 4-5 (7 hours)

- Domain 3: Author custom actions
- Create 1 composite, 1 JavaScript action

### Day 6 (3 hours)

- Domain 4: Management and security
- Review best practices

### Day 7 (2 hours)

- Practice exam
- Review weak areas

---

## 📝 Practice Exam Questions

1. **Which trigger runs only when manually initiated?**
   - a) push
   - b) workflow_dispatch ✅
   - c) schedule
   - d) pull_request

2. **How do you reference a secret in a workflow?**
   - a) `${{ env.SECRET_NAME }}`
   - b) `${{ secrets.SECRET_NAME }}` ✅
   - c) `${{ vars.SECRET_NAME }}`
   - d) `${SECRET_NAME}`

3. **What's the default timeout for a job?**
   - a) 30 minutes
   - b) 60 minutes
   - c) 360 minutes ✅
   - d) Unlimited

4. **Which context provides information about the workflow run?**
   - a) env
   - b) github ✅
   - c) runner
   - d) steps

5. **How do you make a job depend on another job?**
   - a) `depends-on: [job-id]`
   - b) `needs: [job-id]` ✅
   - c) `requires: [job-id]`
   - d) `after: [job-id]`

---

## 🔗 Official Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax Reference](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)
- [GitHub Learning Lab](https://lab.github.com/)
- [GitHub Skills: Actions](https://skills.github.com/)

---

## ✅ Exam Preparation Checklist

- [ ] Completed all 4 domains study
- [ ] Created 5+ custom workflows
- [ ] Used 10+ marketplace actions
- [ ] Created at least 1 custom action
- [ ] Practiced matrix builds
- [ ] Implemented caching and artifacts
- [ ] Reviewed security best practices
- [ ] Taken practice exam (70%+ score)
- [ ] Scheduled real exam

---

**Target Exam Date**: February 7, 2026  
**Study Period**: January 26 - February 7 (12 days)  
**Next Cert**: AZ-204 Azure Developer
