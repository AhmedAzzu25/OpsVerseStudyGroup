# Gov-Services: Government Service Automation

## Context
Build a scalable workflow orchestration system for government services (e.g., building permits) that handles burst traffic and multi-step approvals.

## Tech Stack
- **Azure Durable Functions** (Node.js or C#)
- **Queue-Based Load Leveling** with Azure Storage Queues
- **Azure Cosmos DB** for workflow state
- **Application Insights** for monitoring

## Architecture Requirements

### Workflow Orchestration
1. **Building Permit Workflow**
   - Step 1: Zoning approval (5 min timeout)
   - Step 2: Safety inspection (10 min timeout)
   - Step 3: Final approval (5 min timeout)
   - Auto-reject if any step fails or times out

2. **Human-in-the-Loop**
   - Send approval requests to external API
   - Wait for webhook callback
   - Handle timeout with escalation

### Scaling Pattern
1. **Queue Ingestion**
   - Public API writes requests to queue
   - Durable Function consumes from queue
   - Prevents function overload during bursts

2. **State Persistence**
   - Durable entities store application state
   - Query status via REST API

## Key Implementation Tasks

### 1. Initialize Durable Functions
```bash
func init gov-services --worker-runtime node
cd gov-services
func new --name BuildingPermitOrchestrator --template "Durable Functions orchestrator"
```

### 2. Orchestrator Function
```javascript
const df = require("durable-functions");

module.exports = df.orchestrator(function* (context) {
    const application = context.df.getInput();
    
    // Step 1: Zoning approval
    const zoningResult = yield context.df.callActivityWithTimeout(
        "ZoningApproval",
        300000, // 5 min
        application
    );
    
    if (!zoningResult.approved) {
        return { status: "Rejected", reason: "Zoning" };
    }
    
    // Step 2: Safety inspection
    const safetyResult = yield context.df.callActivityWithTimeout(
        "SafetyInspection",
        600000, // 10 min
        application
    );
    
    if (!safetyResult.approved) {
        return { status: "Rejected", reason: "Safety" };
    }
    
    // Step 3: Final approval
    const finalResult = yield context.df.callActivity(
        "FinalApproval",
        application
    );
    
    return { status: "Approved", permitNumber: finalResult.permitId };
});
```

### 3. Activity Functions
```javascript
// ZoningApproval activity
module.exports = async function (context) {
    const application = context.bindings.application;
    
    // Call external zoning API
    const response = await fetch('https://zoning-api/approve', {
        method: 'POST',
        body: JSON.stringify(application)
    });
    
    return await response.json();
};
```

### 4. HTTP Starter (Queue Trigger)
```javascript
module.exports = async function (context, queueItem) {
    const client = df.getClient(context);
    const instanceId = await client.startNew(
        "BuildingPermitOrchestrator",
        undefined,
        queueItem
    );
    
    return client.createCheckStatusResponse(context, instanceId);
};
```

### 5. Public API (Queue Writer)
```javascript
module.exports = async function (context, req) {
    const application = req.body;
    
    // Write to queue
    context.bindings.outputQueue = application;
    
    context.res = {
        status: 202,
        body: { message: "Application submitted" }
    };
};
```

## Acceptance Criteria
- [ ] Orchestrator handles all 3 approval steps
- [ ] Timeouts trigger automatic rejection
- [ ] Queue-based ingestion prevents overload
- [ ] Status query API works
- [ ] Application Insights tracks execution
- [ ] Load test with 1000 concurrent requests

## Testing Strategy
1. Submit normal application (should approve in ~20 min)
2. Submit application that fails zoning (should reject fast)
3. Test timeout by delaying webhook response
4. Load test with queue bursts

## Getting Started
Execute this plan step-by-step:
1. Initialize Durable Functions project
2. Implement orchestrator logic
3. Create activity functions (mock external APIs initially)
4. Add queue-based ingestion
5. Deploy to Azure and test

**Remember:** Durable Functions are stateful—use Durable Entities for complex state!
