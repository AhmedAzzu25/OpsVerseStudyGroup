Master Architect Prompt: Global Smart Logistics & IoT Fleet Monitoring
Role: You are a Principal IoT Architect and Big Data Engineer. Context: We are designing the "FleetCommand" module for the OpsVerse Monorepo. This is a global logistics platform managing thousands of trucks/ships. It handles massive streams of telemetry data (GPS, Engine Temp, Speed) to optimize routes and predict breakdowns. Constraints:

Architecture: IoT Hot/Warm/Cold Path Architecture.

Throughput: High Ingestion Rate (e.g., 50,000 events/sec).

Tech Stack: Azure IoT Hub, Azure Data Explorer (ADX) or Stream Analytics, Cosmos DB (Geospatial).

Intelligence: Predictive Maintenance (ML on Edge).

1. 📐 Architecture & Design Requirements
Please generate the following Mermaid diagrams and design documents:

IoT Reference Architecture Diagram: Visualize the data pipeline:

Device: Truck OBU (On-Board Unit) running IoT Edge.

Ingestion: Azure IoT Hub (MQTT).

Hot Path (Real-time): Stream Analytics -> Cosmos DB (Dashboard).

Cold Path (History): IoT Hub -> Data Lake Gen2 -> Synapse Analytics (Training).

Digital Twin Topology: Illustrate the relationship graph:

Region -> Hub -> Fleet -> Truck -> Engine -> Sensor.

Show how Azure Digital Twins models this hierarchy.

Edge Compute Flow: Show how a "Temperature Anomaly" model runs locally on the truck to alert the driver immediately, even without internet.

1. 📂 Monorepo Project Structure
Map out the file structure for monopod/modules/logistics:

/src/edge-modules: Python/C modules deployed to IoT Edge devices (Docker containers).

/src/cloud-processor: Functions processing the "Hot Path" alerts.

/src/twin-graph: JSON-LD models definition for Azure Digital Twins (DTDL).

/src/telemetry-api: API for the Frontend Dashboard (SignalR for live map updates).

/tests/simulators: Device simulators sending synthetic MQTT traffic for load testing.

1. 📝 Documentation Strategy (*.md)
Generate the templates for the following required documentation in /modules/logistics/docs:

README.md: How to provision a simulated IoT Device and view telemetry.

ADR-006-Time-Series-DB.md: Decision record comparing Azure Data Explorer (Kusto) vs TimescaleDB for storing sensor history.

EDGE-MANIFEST.md: Definition of the deployment manifest for edge devices (which containers run on the truck).

1. 🤖 GitHub Copilot "Meta-Prompts"
Provide a list of 5-7 specific prompts to generate the IoT logic:

Example: "Write an Azure Stream Analytics query that detects 'Geofence Breach' by comparing live GPS coordinates against a reference Polygon..."

Example: "Generate a Python script for Azure IoT Edge that reads from a simulated Serial Port, aggregates data over 1 minute, and sends it to IoT Hub..."

Example: "Create a DTDL (Digital Twins Definition Language) interface for a 'RefrigeratedTruck' that extends 'Vehicle' and adds 'Temperature' telemetry..."

1. 🚀 "Day 1" Implementation Plan
Provide a step-by-step execution list starting from git checkout -b feature/fleet-init. Focus on setting up the IoT Hub and running a Simulated Device locally.

Output Requirement: Produce a single, cohesive Technical Design Document (TDD) in Markdown format. The output must demonstrate expertise in Signal Processing, Distributed Systems, and Operational Technology (OT) integration.

💡 Why this prompt works for a Senior Architect:
It respects the "Paths": In IoT, separating Hot (Real-time alerts) from Cold (Long-term storage) is the #1 architectural rule. This prompt enforces that.

It uses "Edge": Real-world logistics can't rely on 100% connectivity. Requesting IoT Edge and local ML models shows you understand the "Disconnected" reality of the field.

It models the World: Asking for Digital Twins and DTDL (Digital Twin Definition Language) moves this beyond a simple "tracker" to a modern "Smart Industry 4.0" solution.

🏁 Mission Accomplished
You now have the Complete Architect Toolkit for all 8 projects.

Summary of your Arsenal:

Smart Supply Chain (IMS): Event-Driven, Concurrency (The Core).

Healthcare (Offline): PWA, Sync, Compliance.

Infra Platform (SecOps): Policy-as-Code, Self-Healing.

GovTech (Burst Scale): Durable Functions, Queues.

FinTech (High Perf): Stream Processing, Zero Trust.

DevOps AI (GenAI): RAG, Vector Search, CLI Tools.

Charity (Trust): Ledger, Blockchain, Chatbots.

Logistics (IoT): Hot/Cold Paths, Edge Computing, Digital Twins.
