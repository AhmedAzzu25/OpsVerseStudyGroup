# 🎯 AZ-305: Azure Solutions Architect Expert - Study Guide

**Exam Code**: AZ-305  
**Duration**: 120 minutes  
**Questions**: 40-60 questions  
**Passing Score**: 700/1000  
**Cost**: $165 USD  
**Prerequisites**: AZ-104 or equivalent experience  
**Estimated Study Time**: 100 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Design Identity, Governance, Monitoring | 25-30% | 27h | ⏳ |
| 2. Design Data Storage Solutions | 25-30% | 27h | ⏳ |
| 3. Design Business Continuity Solutions | 10-15% | 12h | ⏳ |
| 4. Design Infrastructure Solutions | 25-30% | 34h | ⏳ |

---

## 📚 Domain 1: Identity, Governance, Monitoring (25-30%)

### Azure AD Architecture

```
Tenant (Organization)
├── Subscriptions
│   ├── Management Groups
│   ├── Resource Groups
│   └── Resources
├── Users & Groups
├── Enterprise Apps (Service Principals)
├── App Registrations
└── Conditional Access Policies
```

### RBAC Best Practices

```json
// Custom Role Definition
{
  "Name": "Virtual Machine Operator",
  "IsCustom": true,
  "Description": "Can monitor and restart VMs",
  "Actions": [
    "Microsoft.Compute/*/read",
    "Microsoft.Compute/virtualMachines/start/action",
    "Microsoft.Compute/virtualMachines/restart/action"
  ],
  "NotActions": [],
  "AssignableScopes": [
    "/subscriptions/{subscription-id}"
  ]
}
```

### Azure Policy for Governance

```json
{
  "if": {
    "allOf": [
      {
        "field": "type",
        "equals": "Microsoft.Compute/virtualMachines"
      },
      {
        "field": "location",
        "notIn": ["eastus", "westus"]
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}
```

---

## 📚 Domain 2: Data Storage Solutions (25-30%)

### Cosmos DB Consistency Levels

```
Strong
└─ Bounded Staleness
   └─ Session
      ├─ Consistent Prefix
      └─ Eventual
      
Trade-off: Consistency ↔ Availability ↔ Latency ↔ Throughput
```

### Storage Account Decision Tree

```
Hot Data + Frequent Access → Blob Storage (Hot tier)
Cool Data + Infrequent Access → Blob Storage (Cool tier)
Archive Data + Rare Access → Blob Storage (Archive tier)
Big Data Analytics → Azure Data Lake Storage Gen2
Files Share → Azure Files
Queue Messages → Queue Storage
NoSQL Documents → Cosmos DB
Relational Data → Azure SQL Database
Data Warehouse → Azure Synapse Analytics
```

### Partitioning Strategy

```csharp
// Good partition key (high cardinality)
[JsonProperty(PropertyName = "userId")]
public string UserId { get; set; }  // Millions of unique values

// Bad partition key (low cardinality)
[JsonProperty(PropertyName = "country")]
public string Country { get; set; }  // Only ~200 unique values
```

---

## 📚 Domain 3: Business Continuity (10-15%)

### HA/DR Architecture Patterns

**Active-Active Pattern**

```
Traffic Manager (Global)
     ├── Region 1 (Primary): App Service + SQL Database (Active)
     └── Region 2 (Secondary): App Service + SQL Database (Active)
     
Benefits: Load distribution, zero RTO
Cost: High (double resources)
```

**Active-Passive Pattern**

```
Traffic Manager
     ├── Region 1 (Primary): Full stack
     └── Region 2 (Secondary): Scaled-down standby
     
Benefits: Lower cost
RTO: Minutes to hours (during failover)
```

### Backup Strategy

```
Azure Backup
├── Azure VMs: Snapshot-based, 7-9999 days retention
├── SQL Database: Point-in-time restore (7-35 days)
├── Cosmos DB: Continuous backup (30 days)
└── Blob Storage: Soft delete + versioning
```

---

## 📚 Domain 4: Infrastructure Solutions (25-30%)

### Network Architecture

```
Hub-Spoke Topology

         [Hub VNet]
         (Firewall, VPN Gateway)
              |
      ┌───────┼───────┐
      |       |       |
  [Spoke 1][Spoke 2][Spoke 3]
  (Prod)   (Dev)    (Test)
  
Peering: Hub ↔ Spokes (no spoke-to-spoke without hub routing)
```

### Application Gateway vs Load Balancer vs Front Door

| Feature | App Gateway | Load Balancer | Front Door |
|---------|-------------|---------------|------------|
| **Layer** | L7 (HTTP) | L4 (TCP/UDP) | L7 (HTTP/Global) |
| **Scope** | Regional | Regional | Global |
| **SSL Offload** | Yes | No | Yes |
| **WAF** | Yes | No | Yes |
| **URL Routing** | Yes | No | Yes |
| **Use Case** | Web apps | Any TCP/UDP | Global web apps |

### VM Sizing Decision

```
General Purpose: D-series (balanced CPU/memory)
Compute Optimized: F-series (high CPU/memory ratio)
Memory Optimized: E-series (high memory/CPU ratio)
Storage Optimized: L-series (high throughput/IOPS)
GPU: N-series (machine learning, rendering)
```

---

## 🎯 Architecture Case Studies

### Case Study 1: E-Commerce Platform (Multi-Region)

**Requirements:**

- Global reach (3 regions: US, EU, Asia)
- <100ms latency for all users
- 99.99% SLA
- PCI-DSS compliance

**Solution:**

```
Front Door (global load balancing, WAF)
    ├── Region 1 (US East): App Service, Cosmos DB, Key Vault
    ├── Region 2 (EU West): App Service, Cosmos DB, Key Vault
    └── Region 3 (Asia Southeast): App Service, Cosmos DB, Key Vault

Cosmos DB: Multi-region writes, Session consistency
App Service: Premium tier (zone redundant)
Azure CDN: Static content caching
Azure Policy: Enforce encryption, auditing
```

### Case Study 2: Real-Time IoT Analytics

**Requirements:**

- Ingest 1M events/sec
- Real-time dashboards
- 7-year data retention

**Solution:**

```
IoT Devices
    ↓
IoT Hub (message routing)
    ↓
Event Hubs (stream ingestion)
    ├→ Stream Analytics (real-time processing) → Power BI
    └→ Azure Functions (event processing) → Cosmos DB (hot data)
                                           → Azure Data Lake (cold storage)
                                           
Archive: Lifecycle management (Hot → Cool → Archive)
```

---

## 📖 Study Schedule (100 Hours)

### Week 1-2 (28 hours)

- Domain 1: Identity, Governance, Monitoring
- Practice: Design AD architecture, RBAC, policies

### Week 3-4 (28 hours)

- Domain 2: Data Storage Solutions
- Practice: Cosmos DB partition strategies, storage tiers

### Week 5 (14 hours)

- Domain 3: Business Continuity
- Practice: Design HA/DR solutions

### Week 6-7 (28 hours)

- Domain 4: Infrastructure Solutions
- Practice: Network topology, compute selection

### Week 8 (2 hours)

- Case studies review
- Practice exams

---

## 📝 Practice Exam Questions

1. **Which Cosmos DB consistency level provides lowest latency?**
   - a) Strong
   - b) Bounded Staleness
   - c) Session
   - d) Eventual ✅

2. **What's required for zone redundancy in App Service?**
   - a) Basic tier
   - b) Standard tier
   - c) Premium v2/v3 tier ✅
   - d) Isolated tier

3. **Which service provides global HTTP load balancing?**
   - a) Azure Load Balancer
   - b) Application Gateway
   - c) Traffic Manager
   - d) Azure Front Door ✅

---

## 🔗 Official Resources

- [MS Learn AZ-305](https://learn.microsoft.com/en-us/certifications/exams/az-305/)
- [Azure Architecture Center](https://learn.microsoft.com/en-us/azure/architecture/)
- [Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/)

---

## ✅ Exam Preparation Checklist

- [ ] Designed 10+ architecture diagrams
- [ ] Understand all Azure networking components
- [ ] Can explain Cosmos DB consistency models
- [ ] Familiar with HA/DR patterns
- [ ] Know RBAC vs Azure Policy differences
- [ ] Can size VMs and databases correctly
- [ ] Completed 5+ case studies
- [ ] Practice exam score: 75%+

**Target Exam Date**: July 27, 2026 🏆  
**Study Period**: June 22 - July 27 (35 days)  
**Next Cert**: AI-102 Azure AI Engineer
