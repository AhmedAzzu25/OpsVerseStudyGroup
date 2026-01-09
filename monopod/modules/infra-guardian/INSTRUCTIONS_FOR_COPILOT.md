# Infra-Guardian: Self-Healing Compliance Platform

## Context
Build an automated compliance and remediation system that enforces Azure policies and auto-heals non-compliant resources.

## Tech Stack
- **Terraform** for IaC
- **Azure Policy** for compliance rules
- **Azure Event Grid** for event routing
- **Python Azure Functions** for remediation logic
- **Azure Monitor** for alerting

## Architecture Requirements

### Policy Layer
1. **Custom Policies**
   - Deny public IP assignments
   - Enforce tag requirements
   - Require encryption at rest
   - Block non-approved regions

2. **Policy Assignments**
   - Management group scope
   - Resource group exclusions
   - Custom parameters per environment

### Event-Driven Remediation
1. **Event Grid Subscription**
   - Filter for policy violation events
   - Route to remediation function

2. **Python Function**
   - Receive policy violation event
   - Execute remediation action
   - Log to Application Insights

## Key Implementation Tasks

### 1. Terraform Structure
```
infra-guardian/
├── policies/
│   ├── deny-public-ip.tf
│   ├── require-tags.tf
│   └── enforce-encryption.tf
├── functions/
│   ├── auto-remediate/
│   │   ├── __init__.py
│   │   └── function.json
│   └── host.json
└── main.tf
```

### 2. Deny Public IP Policy
```hcl
resource "azurerm_policy_definition" "deny_public_ip" {
  name         = "deny-public-ip-assignment"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deny Public IP Assignment"

  policy_rule = jsonencode({
    if = {
      field  = "type"
      equals = "Microsoft.Network/publicIPAddresses"
    }
    then = {
      effect = "deny"
    }
  })
}
```

### 3. Event Grid Trigger Function
```python
import logging
import azure.functions as func
from azure.mgmt.network import NetworkManagementClient

def main(event: func.EventGridEvent):
    logging.info(f'Policy Violation: {event.subject}')
    
    # Parse resource ID
    resource_id = event.subject
    
    # Remediation logic
    if 'port 22' in event.data['details']:
        close_ssh_port(resource_id)
        logging.info('SSH port auto-closed')
```

### 4. Auto-Close SSH Port
```python
def close_ssh_port(nsg_id):
    # Get NSG
    nsg = network_client.network_security_groups.get(...)
    
    # Find SSH rule
    ssh_rule = [r for r in nsg.security_rules if r.destination_port_range == '22']
    
    # Delete rule
    network_client.security_rules.delete(...)
```

## Acceptance Criteria
- [ ] Terraform deploys policy definitions
- [ ] Policy violations trigger Event Grid events
- [ ] Python function remediates violations automatically
- [ ] Logs sent to Application Insights
- [ ] Alert rules for critical violations
- [ ] Compliance dashboard (Azure Policy Compliance)

## Testing Strategy
1. Deploy a public IP (should be denied)
2. Create NSG with port 22 open (should auto-close)
3. Verify Event Grid delivery
4. Check Application Insights logs

## Getting Started
Execute this plan sequentially:
1. Write Terraform for policy definitions
2. Deploy policies to test subscription
3. Create Event Grid subscription
4. Implement Python remediation function
5. Test end-to-end flow

**Remember:** Test in non-production environment first!
