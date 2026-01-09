# 🎯 HashiCorp Terraform Associate (TA-003) - Study Guide

**Exam Code**: TA-003 (Terraform Associate 003)  
**Duration**: 60 minutes  
**Questions**: 57 multiple choice  
**Passing Score**: Not disclosed (estimated 70%)  
**Cost**: $70.50 USD  
**Estimated Study Time**: 40 hours

---

## 📊 Exam Objectives & Weights

| Objective | Weight | Study Hours | Status |
|-----------|--------|-------------|--------|
| 1. Understand IaC Concepts | 11% | 4h | ⏳ |
| 2. Understand Terraform Purpose | 13% | 5h | ⏳ |
| 3. Understand Terraform Basics | 20% | 8h | ⏳ |
| 4. Use Terraform CLI | 15% | 6h | ⏳ |
| 5. Interact with Terraform Modules | 12% | 5h | ⏳ |
| 6. Use the Core Terraform Workflow | 17% | 7h | ⏳ |
| 7. Implement and Maintain State | 12% | 5h | ⏳ |

---

## 📚 Objective 1: Understand Infrastructure as Code (11%)

### Key Concepts

- Benefits of IaC
- Difference between declarative vs procedural
- Terraform advantages

**Example: Declarative vs Procedural**

```hcl
# Declarative (Terraform)
resource "azurerm_resource_group" "example" {
  name     = "my-rg"
  location = "eastus"
}

# Procedural would require:
# 1. Check if RG exists
# 2. If not, create it
# 3. If yes, update it
```

---

## 📚 Objective 2: Understand Terraform's Purpose (13%)

### Multi-Cloud Deployment

```hcl
# Azure Provider
provider "azurerm" {
  features {}
}

# AWS Provider (same config!)
provider "aws" {
  region = "us-east-1"
}

# Use both in same config
resource "azurerm_storage_account" "azure" {
  name = "mystorageacct"
  # ...
}

resource "aws_s3_bucket" "aws" {
  bucket = "my-bucket"
}
```

---

## 📚 Objective 3: Understand Terraform Basics (20%)

### HCL Syntax

```hcl
# Variables
variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

# Locals
locals {
  common_tags = {
    Environment = "production"
    ManagedBy   = "Terraform"
  }
}

# Resource
resource "azurerm_resource_group" "main" {
  name     = "my-rg"
  location = var.location
  tags     = local.common_tags
}

# Data Source
data "azurerm_resource_group" "existing" {
  name = "existing-rg "
}

# Output
output "rg_id" {
  value = azurerm_resource_group.main.id
}
```

### Resource Dependencies

```hcl
resource "azurerm_resource_group" "rg" {
  name     = "my-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "my-vnet"
  resource_group_name = azurerm_resource_group.rg.name  # Implicit dependency
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  # Explicit dependency
  depends_on = [azurerm_virtual_network.vnet]
  
  name                 = "my-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
```

---

## 📚 Objective 4: Use the Terraform CLI (15%)

### Essential Commands

```bash
# Initialize working directory
terraform init

# Validate configuration
terraform validate

# Format code
terraform fmt

# Plan changes
terraform plan -out=tfplan

# Apply changes
terraform apply tfplan

# Destroy resources
terraform destroy

# Show state
terraform show

# List resources in state
terraform state list

# Import existing resource
terraform import azurerm_resource_group.example /subscriptions/.../resourceGroups/my-rg
```

### Workspace Management

```bash
# Create workspace
terraform workspace new dev

# List workspaces
terraform workspace list

# Switch workspace
terraform workspace select prod

# Show current workspace
terraform workspace show
```

---

## 📚 Objective 5: Interact with Terraform Modules (12%)

### Module Structure

```
modules/
└── azure-webapp/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── README.md
```

### Using a Module

```hcl
module "webapp" {
  source = "./modules/azure-webapp"
  
  name                = "my-webapp"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  app_service_plan_id = azurerm_app_service_plan.main.id
  
  tags = local.common_tags
}

# Access module outputs
output "webapp_url" {
  value = module.webapp.url
}
```

### Public Registry Modules

```hcl
module "network" {
  source  = "Azure/network/azurerm"
  version = "5.0.0"
  
  resource_group_name = "my-rg"
  address_spaces      = ["10.0.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["subnet1"]
}
```

---

## 📚 Objective 6: Use the Core Terraform Workflow (17%)

### Write → Plan → Apply

```bash
# 1. Write Configuration
cat > main.tf << 'EOF'
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "eastus"
}
EOF

# 2. Initialize
terraform init

# 3. Plan (review changes)
terraform plan

# 4. Apply (execute changes)
terraform apply

# 5. Verify
terraform show
```

---

## 📚 Objective 7: Implement and Maintain State (12%)

### Remote State (Azure Storage)

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstate12345"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
```

### State Locking

```bash
# State is automatically locked during apply
terraform apply

# Unlock if needed (use carefully!)
terraform force-unlock <lock-id>
```

### State Commands

```bash
# List resources
terraform state list

# Show resource details
terraform state show azurerm_resource_group.example

# Move resource
terraform state mv azurerm_resource_group.old azurerm_resource_group.new

# Remove resource from state (resource remains in Azure)
terraform state rm azurerm_resource_group.example

# Pull current state
terraform state pull > terraform.tfstate.backup
```

---

## 🎯 Hands-On Practice Labs

### Lab 1: Basic Azure Infrastructure

```hcl
# Create RG, VNet, Subnet, NSG
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "lab1-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "main" {
  name                = "lab1-vnet"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]
}
```

### Lab 2: Variables and Outputs

Create `variables.tf`, `terraform.tfvars`, and `outputs.tf`

### Lab 3: Remote State

Configure Azure Storage backend for state

### Lab 4: Create Custom Module

Build a reusable module for Azure resources

### Lab 5: Multi-Environment with Workspaces

Deploy to dev, staging, prod using workspaces

---

## 📖 Study Schedule (40 Hours)

### Week 1 (15 hours)

- Objectives 1-3: IaC concepts, Terraform basics, HCL syntax
- Complete Labs 1-2

### Week 2 (15 hours)

- Objectives 4-5: CLI usage, modules
- Complete Labs 3-4

### Week 3 (10 hours)

- Objectives 6-7: Workflow, state management
- Complete Lab 5
- Practice exam review

---

## 📝 Practice Exam Questions

1. **What command downloads provider plugins?**
   - a) terraform install
   - b) terraform init ✅
   - c) terraform get
   - d) terraform download

2. **Which block defines input parameters?**
   - a) input
   - b) parameter
   - c) variable ✅
   - d) var

3. **What's the default state file name?**
   - a) state.tf
   - b) terraform.state
   - c) terraform.tfstate ✅
   - d) tfstate

4. **How do you reference a variable named 'region'?**
   - a) ${region}
   - b) var.region ✅
   - c) variable.region
   - d) region

5. **What does 'terraform plan' do?**
   - a) Applies changes
   - b) Shows planned changes ✅
   - c) Creates resources
   - d) Destroys resources

---

## 🔗 Official Resources

- [HashiCorp Learn](https://learn.hashicorp.com/terraform)
- [Terraform Registry](https://registry.terraform.io/)
- [Exam Review Guide](https://developer.hashicorp.com/terraform/tutorials/certification-003/associate-review-003)
- [Study Guide](https://developer.hashicorp.com/terraform/tutorials/certification-003/associate-study-003)

---

## ✅ Exam Preparation Checklist

- [ ] Understand IaC benefits and concepts
- [ ] Written 10+ Terraform configurations
- [ ] Created custom modules
- [ ] Worked with remote state (Azure backend)
- [ ] Used workspaces for environments
- [ ] Familiar with all CLI commands
- [ ] Completed 5 hands-on labs
- [ ] Practice exam score: 75%+
- [ ] Reviewed exam objectives

**Target Exam Date**: March 27, 2026  
**Study Period**: March 2-27 (18 days)  
**Next Cert**: GitHub Administration
