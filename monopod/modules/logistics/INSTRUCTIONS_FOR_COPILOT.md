# Logistics: IoT Fleet Monitoring

## Context
Build a real-time fleet monitoring system for trucks using Azure IoT Hub, Digital Twins, and Edge computing for telemetry processing.

## Tech Stack
- **Azure IoT Hub** for device connectivity
- **Azure Digital Twins** with DTDL models
- **Azure IoT Edge** for edge processing
- **Python** for edge modules
- **Time Series Insights** for analytics

## Architecture Requirements

### Digital Twin Model
1. **Truck Twin**
   - Properties: VIN, Model, Year, Location
   - Telemetry: Temperature, Speed, FuelLevel, EngineStatus
   - Relationships: AssignedDriver, CurrentRoute

2. **Route Twin**
   - Properties: RouteId, StartLocation, EndLocation
   - Relationships: AssignedTrucks

### Edge Processing
1. **Temperature Filter Module**
   - Read telemetry from IoT Hub
   - Filter: Only send if temp > 80°C (anomaly)
   - Reduces cloud bandwidth by 90%

2. **Local Alerting**
   - Edge module detects critical conditions
   - Sends alert to local dashboard (offline capability)

## Key Implementation Tasks

### 1. DTDL Model (Truck)
```json
{
  "@context": "dtmi:dtdl:context;2",
  "@id": "dtmi:com:example:Truck;1",
  "@type": "Interface",
  "displayName": "Truck",
  "contents": [
    {
      "@type": "Property",
      "name": "VIN",
      "schema": "string"
    },
    {
      "@type": "Telemetry",
      "name": "temperature",
      "schema": "double"
    },
    {
      "@type": "Telemetry",
      "name": "speed",
      "schema": "double"
    },
    {
      "@type": "Relationship",
      "name": "assignedDriver",
      "target": "dtmi:com:example:Driver;1"
    }
  ]
}
```

### 2. IoT Hub Device Registration
```python
from azure.iot.hub import IoTHubRegistryManager

registry_manager = IoTHubRegistryManager(CONNECTION_STRING)

# Register truck device
device = registry_manager.create_device_with_sas(
    device_id="truck-001",
    primary_key="...",
    secondary_key="..."
)
```

### 3. Edge Module (Temperature Filter)
```python
# main.py
import asyncio
from azure.iot.device import IoTHubModuleClient, Message

async def main():
    module_client = IoTHubModuleClient.create_from_edge_environment()
    await module_client.connect()
    
    async def message_handler(message):
        data = json.loads(message.data)
        temp = data.get("temperature")
        
        # Filter: Only forward if anomaly
        if temp > 80:
            output_msg = Message(json.dumps(data))
            await module_client.send_message_to_output(output_msg, "temperatureAlert")
            print(f"ALERT: High temperature detected: {temp}°C")
    
    module_client.on_message_received = message_handler
    
    # Keep module running
    await asyncio.Event().wait()

if __name__ == "__main__":
    asyncio.run(main())
```

### 4. Deployment Manifest (IoT Edge)
```json
{
  "modulesContent": {
    "$edgeAgent": {
      "properties.desired": {
        "modules": {
          "temperatureFilter": {
            "version": "1.0",
            "type": "docker",
            "status": "running",
            "restartPolicy": "always",
            "settings": {
              "image": "myregistry.azurecr.io/temp-filter:latest",
              "createOptions": "{}"
            }
          }
        }
      }
    },
    "$edgeHub": {
      "properties.desired": {
        "routes": {
          "sensorToFilter": "FROM /messages/modules/tempSensor/* INTO BrokeredEndpoint(\"/modules/temperatureFilter/inputs/input1\")",
          "filterToIoTHub": "FROM /messages/modules/temperatureFilter/outputs/temperatureAlert INTO $upstream"
        }
      }
    }
  }
}
```

### 5. Digital Twin Update
```python
from azure.digitaltwins.core import DigitalTwinsClient

dt_client = DigitalTwinsClient(ENDPOINT, credential)

# Update truck twin with telemetry
patch = [
    {
        "op": "replace",
        "path": "/temperature",
        "value": 85.5
    }
]

dt_client.update_digital_twin("truck-001", patch)
```

### 6. Device Simulator
```python
from azure.iot.device import IoTHubDeviceClient
import random
import time

device_client = IoTHubDeviceClient.create_from_connection_string(DEVICE_CONN_STR)

while True:
    telemetry = {
        "temperature": random.uniform(60, 100),  # Some will trigger alert
        "speed": random.uniform(0, 90),
        "fuelLevel": random.uniform(0, 100)
    }
    
    message = Message(json.dumps(telemetry))
    device_client.send_message(message)
    print(f"Sent: {telemetry}")
    
    time.sleep(5)
```

## Acceptance Criteria
- [ ] DTDL model deployed to Azure Digital Twins
- [ ] IoT Hub receives telemetry from simulated trucks
- [ ] Edge module filters temperature data
- [ ] Only anomalies sent to cloud (verify reduced bandwidth)
- [ ] Digital Twin updated with latest telemetry
- [ ] Time Series Insights dashboard visualizes data
- [ ] Predictive maintenance alert (optional ML model)

## Testing Strategy
1. Run device simulator (send normal + anomaly data)
2. Verify edge module filters correctly
3. Check Digital Twin reflects latest state
4. Query Time Series Insights for historical data
5. Test offline scenario (disconnect IoT Hub, verify edge alerting)

## Getting Started
Execute this plan step-by-step:
1. Create DTDL model and upload to Digital Twins
2. Set up IoT Hub and register devices
3. Build edge module (Python)
4. Create deployment manifest
5. Deploy to IoT Edge device (or simulated edge)
6. Test with device simulator

**Remember:** Edge modules run in containers—test locally with `iotedgehubdev`!
