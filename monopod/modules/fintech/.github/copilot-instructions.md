# GitHub Copilot Instructions - Fintech Platform

## Project Overview
**Module**: Fintech Platform  
**Tech Stack**: .NET 8, Azure Stream Analytics, Event Hubs, Cosmos DB, ML.NET  
**Domain**: Financial Technology

---

## Purpose
Real-time fraud detection with Stream Analytics and Event Hubs

---

## Technology Stack
.NET 8, Azure Stream Analytics, Event Hubs, Cosmos DB, ML.NET

---

## Key Architectural Patterns
- See [ARCHITECTURE.md](../docs/ARCHITECTURE.md) for detailed design
- Follow coding standards in [CODING_STANDARDS.md](../docs/CODING_STANDARDS.md)
- Reference technology details in [TECHNOLOGY_STACK.md](../docs/TECHNOLOGY_STACK.md)
- Ensure security compliance per [SECURITY_CHECKLIST.md](../docs/SECURITY_CHECKLIST.md)

---

## Copilot Guidelines

When generating code for fintech:

1. **Follow the architectural patterns** defined in ARCHITECTURE.md
2. **Adhere to coding standards** in CODING_STANDARDS.md
3. **Use approved technologies** from TECHNOLOGY_STACK.md
4. **Include comprehensive tests** (unit + integration)
5. **Add structured logging** with appropriate log levels
6. **Implement security best practices** from SECURITY_CHECKLIST.md
7. **Document all public APIs** with clear comments
8. **Handle errors gracefully** with proper error types
9. **Optimize for performance** - async/await, caching, indexing
10. **Add OpenTelemetry** for observability

---

## Security Requirements
- All endpoints require authentication
- Input validation on all user inputs
- Secrets stored in Azure Key Vault
- TLS 1.3 for all communications
- Audit logging for sensitive operations

---

## Code Quality Standards
- Unit test coverage: 80%+
- No critical security vulnerabilities
- Code review required (min 2 approvers)
- All tests passing before merge
- Documentation updated with code changes

---

**For detailed instructions, see the docs/ folder.**
