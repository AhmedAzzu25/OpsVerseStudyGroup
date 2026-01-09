# Charity: Immutable NGO Ledger

## Context
Build a transparent donation tracking system using Azure SQL Ledger for immutable audit trails, with WhatsApp Bot integration for donor engagement.

## Tech Stack
- **Azure SQL Database** (Ledger feature)
- **Azure Bot Service** (WhatsApp channel)
- **C# .NET 8** for bot logic
- **Power BI** for transparency dashboard

## Architecture Requirements

### Ledger Schema
1. **Donations Table** (Updateable Ledger)
   - Columns: DonationId, DonorName, Amount, CampaignId, Timestamp
   - Ledger tracks all updates (e.g., refunds)

2. **Disbursements Table** (Append-Only Ledger)
   - Columns: DisbursementId, RecipientOrg, Amount, Purpose, Timestamp
   - Cannot be modified once written

3. **Ledger Views**
   - Automatically generated history tables
   - Query: `SELECT * FROM Donations FOR SYSTEM_TIME ALL`

### WhatsApp Bot
1. **Donation Flow**
   - User: "Donate $50 to Campaign123"
   - Bot: Confirms details, generates payment link
   - User: Sends payment receipt photo
   - Bot: Stores in Blob Storage, creates ledger record

2. **Query Flow**
   - User: "Show my donations"
   - Bot: Queries ledger, sends formatted list

## Key Implementation Tasks

### 1. SQL Ledger Setup
```sql
-- Create updateable ledger table
CREATE TABLE Donations (
    DonationId INT IDENTITY(1,1) PRIMARY KEY,
    DonorName NVARCHAR(100),
    Amount DECIMAL(18,2),
    CampaignId NVARCHAR(50),
    Status NVARCHAR(20), -- Pending, Confirmed, Refunded
    CreatedAt DATETIME2 DEFAULT GETUTCDATE()
)
WITH (SYSTEM_VERSIONING = ON, LEDGER = ON);

-- Create append-only ledger table
CREATE TABLE Disbursements (
    DisbursementId INT IDENTITY(1,1) PRIMARY KEY,
    RecipientOrg NVARCHAR(200),
    Amount DECIMAL(18,2),
    Purpose NVARCHAR(500),
    DisbursedAt DATETIME2 DEFAULT GETUTCDATE()
)
WITH (LEDGER = ON (APPEND_ONLY = ON));
```

### 2. Verify Ledger Integrity
```sql
-- Generate ledger digest
EXEC sys.sp_generate_database_ledger_digest;

-- Verify ledger (returns true if no tampering)
EXEC sys.sp_verify_database_ledger;
```

### 3. Bot Dialog (C#)
```csharp
using Microsoft.Bot.Builder;
using Microsoft.Bot.Schema;

public class CharityBot : ActivityHandler
{
    protected override async Task OnMessageActivityAsync(
        ITurnContext<IMessageActivity> turnContext,
        CancellationToken cancellationToken)
    {
        var text = turnContext.Activity.Text.ToLower();
        
        if (text.StartsWith("donate"))
        {
            await HandleDonation(turnContext, text, cancellationToken);
        }
        else if (text == "my donations")
        {
            await ShowDonations(turnContext, cancellationToken);
        }
    }
    
    private async Task HandleDonation(ITurnContext turnContext, string text, CancellationToken ct)
    {
        // Parse: "donate $50 to campaign123"
        var amount = ExtractAmount(text);
        var campaign = ExtractCampaign(text);
        
        await turnContext.SendActivityAsync(
            $"Confirm donation of ${amount} to {campaign}? Reply YES to proceed.",
            cancellationToken: ct
        );
    }
}
```

### 4. WhatsApp Channel Configuration
```json
{
  "type": "whatsapp",
  "settings": {
    "phoneNumber": "+1234567890",
    "apiKey": "<whatsapp_business_api_key>"
  }
}
```

### 5. Receipt Photo Handler
```csharp
private async Task OnPhotoReceived(ITurnContext turnContext, Attachment photo)
{
    // Upload to Blob Storage
    var blobUrl = await UploadToBlob(photo.ContentUrl);
    
    // Create ledger record
    await _sqlService.ExecuteAsync(@"
        INSERT INTO Donations (DonorName, Amount, CampaignId, ReceiptUrl, Status)
        VALUES (@name, @amount, @campaign, @url, 'Pending')
    ", new { name = ..., amount = ..., campaign = ..., url = blobUrl });
    
    await turnContext.SendActivityAsync("Receipt uploaded! Donation pending verification.");
}
```

## Acceptance Criteria
- [ ] SQL Ledger tables created (updateable + append-only)
- [ ] Ledger integrity verification passes
- [ ] WhatsApp bot handles donation commands
- [ ] Receipt photos stored in Blob Storage
- [ ] Ledger history queryable via views
- [ ] Power BI dashboard shows donations/disbursements
- [ ] Unit tests for bot dialogs

## Testing Strategy
1. Send donation command via WhatsApp
2. Upload receipt photo
3. Verify ledger record created
4. Query donation history
5. Attempt to tamper with ledger (should detect)
6. Run integrity verification

## Getting Started
Execute this plan step-by-step:
1. Create Azure SQL Database with Ledger enabled
2. Design and create ledger tables
3. Initialize Bot Framework project (C#)
4. Implement bot dialogs
5. Configure WhatsApp channel
6. Test end-to-end flow

**Remember:** Ledger tables cannot be dropped—plan schema carefully!
