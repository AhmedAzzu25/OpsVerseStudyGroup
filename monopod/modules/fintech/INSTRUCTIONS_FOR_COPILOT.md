# Fintech: Real-Time Fraud Detection

## Context
Build a real-time fraud detection system that analyzes transaction streams and flags anomalies using Azure Stream Analytics.

## Tech Stack
- **Azure Event Hubs** for ingestion
- **Azure Stream Analytics** for real-time processing
- **Azure SQL Database** with Always Encrypted
- **Terraform** for infrastructure
- **Python** for fraud simulation

## Architecture Requirements

### Data Flow
1. **Transaction Ingestion**
   - Clients send transactions to Event Hub
   - Schema: `{ userId, amount, merchantId, timestamp, location }`

2. **Stream Analytics Job**
   - **Sliding Window**: Detect >5 transactions in 5 minutes
   - **Geofencing**: Flag transactions from blacklisted locations
   - **Anomaly Detection**: Built-in ML model for unusual patterns

3. **Output Sinks**
   - **SQL Database**: Store all transactions
   - **Alerts**: Send high-risk transactions to AlertHub
   - **Dashboard**: Power BI real-time dataset

### Security
1. **Always Encrypted**
   - Encrypt sensitive columns (cardNumber, CVV)
   - Azure Key Vault for key management

2. **Confidential Computing** (Optional)
   - Use DC-series VMs for SQL
   - Encrypt data in use

## Key Implementation Tasks

### 1. Terraform Infrastructure
```hcl
resource "azurerm_eventhub_namespace" "fintech" {
  name                = "fintech-events"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Standard"
}

resource "azurerm_stream_analytics_job" "fraud_detection" {
  name                = "fraud-detection"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  transformation_query = file("query.sql")
}
```

### 2. Stream Analytics Query
```sql
-- Detect rapid transactions (sliding window)
SELECT
    userId,
    COUNT(*) AS transactionCount,
    System.Timestamp() AS windowEnd
INTO
    AlertOutput
FROM
    TransactionInput TIMESTAMP BY timestamp
GROUP BY
    userId,
    SlidingWindow(minute, 5)
HAVING
    COUNT(*) > 5

-- Detect blacklisted locations
SELECT
    *
INTO
    BlockedOutput
FROM
    TransactionInput
WHERE
    location IN ('Country1', 'Country2')

-- Store all transactions
SELECT
    *
INTO
    SQLOutput
FROM
    TransactionInput
```

### 3. SQL Table with Always Encrypted
```sql
CREATE TABLE Transactions (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId NVARCHAR(50),
    Amount DECIMAL(18,2),
    MerchantId NVARCHAR(50),
    CardNumber NVARCHAR(16) ENCRYPTED WITH (
        COLUMN_ENCRYPTION_KEY = CEK1,
        ENCRYPTION_TYPE = Deterministic,
        ALGORITHM = 'AEAD_AES_256_CBC_HMAC_SHA_256'
    ),
    Timestamp DATETIME2
);
```

### 4. Python Transaction Simulator
```python
from azure.eventhub import EventHubProducerClient, EventData
import json
import random
import time

producer = EventHubProducerClient.from_connection_string(
    conn_str="<connection_string>",
    eventhub_name="transactions"
)

def simulate_fraud():
    # Rapid transactions (same user)
    user_id = "user123"
    for i in range(10):
        transaction = {
            "userId": user_id,
            "amount": random.randint(10, 500),
            "merchantId": f"merchant{i}",
            "timestamp": time.time(),
            "location": "US"
        }
        producer.send_batch([EventData(json.dumps(transaction))])
        time.sleep(0.5)  # 10 transactions in 5 seconds

simulate_fraud()
```

## Acceptance Criteria
- [ ] Event Hub receives transactions
- [ ] Stream Analytics detects fraud patterns
- [ ] Alerts sent to separate output
- [ ] SQL table uses Always Encrypted
- [ ] Terraform deploys all resources
- [ ] Python simulator generates test data
- [ ] Dashboard visualizes fraud rate

## Testing Strategy
1. Send normal transactions (should pass)
2. Trigger rapid transaction fraud (should alert)
3. Send transaction from blacklisted location (should block)
4. Verify encryption in SQL (query should fail without keys)

## Getting Started
Execute this plan sequentially:
1. Write Terraform for Event Hub and Stream Analytics
2. Deploy infrastructure
3. Create SQL table with Always Encrypted
4. Configure Stream Analytics query
5. Build Python simulator
6. Test end-to-end flow

**Remember:** Always Encrypted requires client-side drivers with key access!
