# 🎯 GitHub Administration - Study Guide

**Exam Code**: GitHub Admin  
**Duration**: 120 minutes  
**Questions**: ~50 multiple choice  
**Passing Score**: 70%  
**Cost**: $99 USD  
**Estimated Study Time**: 20 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Support GitHub Enterprise for Users and Key Stakeholders | 25% | 5h | ⏳ |
| 2. Manage User Identities and GitHub Authentication | 20% | 4h | ⏳ |
| 3. Describe How GitHub is Deployed, Distributed, and Licensed | 15% | 3h | ⏳ |
| 4. Manage Access and Permissions Based on Membership | 20% | 4h | ⏳ |
| 5. Enable Secure Software Development and Ensure Compliance | 20% | 4h | ⏳ |

---

## 📚 Domain 1: Support GitHub Enterprise (25%)

### GitHub Enterprise Server vs Cloud

```
GitHub Enterprise Cloud (GHEC):
  ✅ SaaS, hosted by GitHub
  ✅ 99.9% uptime SLA
  ✅ SAML SSO, IP allow lists
  ✅ GitHub Connect for hybrid

GitHub Enterprise Server (GHES):
  ✅ Self-hosted on your infrastructure
  ✅ Full control over data
  ✅ Air-gapped deployments possible
  ✅ Requires maintenance and upgrades
```

### Organization Settings

```bash
# Create organization
gh api /admin/organizations \
  -f login="myorg" \
  -f admin="admin-user" \
  -f profile_name="My Organization"

# Set base permissions
gh api /orgs/myorg \
  --method PATCH \
  -f default_repository_permission="read"
```

### Repository Settings Best Practices

```yaml
Branch Protection Rules:
  ✅ Require pull request reviews (min 1-2)
  ✅ Require status checks to pass
  ✅ Require conversation resolution
  ✅ Require signed commits (optional)
  ✅ Include administrators (enforce for all)

Repository Security:
  ✅ Enable Dependabot alerts
  ✅ Enable Dependabot security updates
  ✅ Enable secret scanning
  ✅ Enable code scanning (CodeQL)
```

---

## 📚 Domain 2: Manage User Identities & Authentication (20%)

### SAML SSO Configuration

```xml
<!-- Identity Provider Metadata -->
<EntityDescriptor>
  <IDPSSODescriptor>
    <SingleSignOnService 
      Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST"
      Location="https://idp.example.com/sso"/>
  </IDPSSODescriptor>
</EntityDescriptor>
```

**Setup Steps:**

1. Configure SAML in organization settings
2. Upload IdP metadata or enter manually
3. Test SAML connection
4. Enforce SAML for organization
5. Users authenticate via SSO

### SCIM Provisioning

```
Automated User Management:
  ✅ Provision users from IdP (Azure AD, Okta)
  ✅ Deprovision on user removal
  ✅ Update user attributes automatically
  ✅ Sync team memberships
```

### Personal Access Tokens (PAT) Management

```bash
# Organization policy
gh api /orgs/myorg \
  --method PATCH \
  -f members_can_create_public_repositories=false
  
# Require PAT with SSO
# Users must authorize PAT for SSO-enabled orgs
```

---

## 📚 Domain 3: Deployment, Distribution, Licensing (15%)

### GitHub Enterprise Server Deployment

```bash
# High Availability Setup
Primary Instance (active)
    ↓
Replica Instance (standby, read-only)

# Load Balancer distributes read traffic
# Automatic failover on primary failure
```

### Backup and Recovery

```bash
# Configure backup utilities
ghe-backup-utils setup

# Schedule backups (cron)
0 2 * * * /backup/ghe-host-check && /backup/ghe-backup

# Restore from backup
ghe-restore -c -s backup-host
```

### License Management

```
License Types:
  - GitHub Enterprise Cloud: Per-user/month
  - GitHub Enterprise Server: Perpetual license, annual renewal
  
Seat Management:
  - Monitor consumed seats
  - Remove inactive users
  - Purchase additional seats as needed
```

---

## 📚 Domain 4: Access and Permissions (20%)

### Organization Roles

```
Owner:
  ✅ Full administrative access
  ✅ Manage billing
  ✅ Add/remove members
  ✅ Manage security settings

Member:
  ✅ Create repositories (if allowed)
  ✅ Create teams
  ❌ Cannot manage org settings

Outside Collaborator:
  ✅ Access specific repositories only
  ❌ Cannot see other org resources
```

### Team Permissions

```
Team Sync with IdP:
  - Map Azure AD groups → GitHub teams
  - Auto-update team membership
  - Example: "Engineering" AD group → "engineering" GitHub team

Team Hierarchy:
  Parent Team: Engineering
    ├── Child Team: Frontend
    └── Child Team: Backend
    
  Inheritance: Child teams inherit parent permissions
```

### Repository Permissions

```
Admin: Full control (⚠️ assign carefully)
Maintain: Manage repo without sensitive actions
Write: Push code, merge PRs
Triage: Manage issues/PRs (no code push)
Read: View code, open issues
```

---

## 📚 Domain 5: Secure Software Development & Compliance (20%)

### Dependabot Configuration

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 5
    reviewers:
      - "security-team"
    
  - package-ecosystem: "docker"
    directory: "/"
    schedule:
      interval: "weekly"
```

### Code Scanning with CodeQL

```yaml
# .github/workflows/codeql-analysis.yml
name: "CodeQL"

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]
  schedule:
    - cron: '0 0 * * 1'  # Weekly on Monday

jobs:
  analyze:
    runs-on: ubuntu-latest
    permissions:
      security-events: write
    
    strategy:
      matrix:
        language: ['javascript', 'python']
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Initialize CodeQL
      uses: github/codeql-action/init@v2
      with:
        languages: ${{ matrix.language }}
    
    - name: Autobuild
      uses: github/codeql-action/autobuild@v2
    
    - name: Perform CodeQL Analysis
      uses: github/codeql-action/analyze@v2
```

### Secret Scanning

```
Automatic Detection:
  ✅ API keys (AWS, Azure, GitHub, Stripe, etc.)
  ✅ Database connection strings
  ✅ Private keys
  ✅ OAuth tokens

Actions:
  1. Alert sent to repository admins
  2. Service provider notified (if partner)
  3. Token revoked automatically (GitHub, Azure)
  4. Fix: Remove secret, rotate credentials
```

### Compliance Exports

```bash
# Audit log API
gh api /orgs/myorg/audit-log \
  --jq '.[] | select(.action == "repo.create")'

# Export for compliance
gh api /orgs/myorg/audit-log \
  --paginate > audit-log.json
```

---

## 🎯 Hands-On Practice Tasks

### Task 1: Organization Setup

- Create test organization
- Configure SAML SSO (use test IdP)
- Set default repository permissions
- Create teams with hierarchy

### Task 2: Repository Administration

- Set branch protection on main
- Enable Dependabot alerts
- Configure code scanning
- Test secret push protection

### Task 3: User Management

- Add members via SCIM
- Create custom roles
- Manage outside collaborators
- Audit access permissions

### Task 4: Security Compliance

- Enable all security features
- Create security policy
- Set up required workflows
- Export audit logs

### Task 5: GitHub Enterprise Server (Optional)

- Deploy GHES in VM/container
- Configure high availability
- Test backup and restore
- Upgrade to new version

---

## 📖 Study Schedule (20 Hours)

### Day 1-2 (6 hours)

- Domain 1: Enterprise support
- Domain 3: Deployment & licensing

### Day 3-4 (8 hours)

- Domain 2: Authentication (SAML, SCIM)
- Domain 4: Access & permissions

### Day 5-6 (6 hours)

- Domain 5: Security & compliance
- Practice tasks
- Review & practice exam

---

## 📝 Practice Exam Questions

1. **Which authentication method allows automatic user provisioning?**
   - a) SAML SSO
   - b) SCIM ✅
   - c) OAuth
   - d) Personal Access Tokens

2. **What's the minimum role needed to manage organization billing?**
   - a) Member
   - b) Billing Manager ✅
   - c) Owner
   - d) Admin

3. **Which tool automatically creates PRs for dependency updates?**
   - a) CodeQL
   - b) Secret Scanning
   - c) Dependabot ✅
   - d) GitHub Actions

---

## 🔗 Official Resources

- [GitHub Admin Documentation](https://docs.github.com/en/enterprise-cloud@latest/admin)
- [GitHub Enterprise Server](https://docs.github.com/en/enterprise-server)
- [Exam Registration](https://examregistration.github.com/certification/GHA)

---

## ✅ Exam Preparation Checklist

- [ ] Configured SAML SSO for organization
- [ ] Set up SCIM provisioning
- [ ] Created branch protection rules
- [ ] Enabled all security features (Dependabot, CodeQL, Secret Scanning)
- [ ] Managed teams and permissions
- [ ] Exported audit logs
- [ ] Familiar with GHES deployment (concepts)
- [ ] Practice exam score: 75%+

**Target Exam Date**: April 15, 2026  
**Study Period**: April 5-15 (10 days)  
**Next Cert**: AZ-400 DevOps Engineer Expert
