import os
import json
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from openai import AzureOpenAI
import pika
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="MonoPod Ops Agent", version="1.0.0")

# Azure OpenAI Client
client = AzureOpenAI(
    azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT", ""),
    api_key=os.getenv("AZURE_OPENAI_KEY", ""),
    api_version="2024-02-15-preview"
)

class LogAnalysisRequest(BaseModel):
    log_entries: list[str]
    service_name: str

class RemediationResponse(BaseModel):
    issue_detected: bool
    severity: str
    recommended_actions: list[str]
    auto_remediation_available: bool

@app.get("/")
def root():
    return {
        "service": "MonoPod Ops Agent",
        "version": "1.0.0",
        "description": "AI-powered operations agent for log monitoring and auto-remediation"
    }

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.post("/analyze-logs", response_model=RemediationResponse)
async def analyze_logs(request: LogAnalysisRequest):
    """Analyze log entries and suggest remediation actions using Azure OpenAI."""
    try:
        # Build context for AI
        log_context = "\n".join(request.log_entries[-50:])  # Last 50 log entries
        
        prompt = f"""You are an expert DevOps engineer analyzing logs from {request.service_name}.

Analyze these log entries and determine:
1. Is there a critical issue?
2. What is the severity (LOW, MEDIUM, HIGH, CRITICAL)?
3. What actions should be taken?
4. Can it be auto-remediated (restart service, clear cache, scale up)?

Log Entries:
{log_context}

Respond in JSON format:
{{
    "issue_detected": true/false,
    "severity": "LOW|MEDIUM|HIGH|CRITICAL",
    "recommended_actions": ["action1", "action2"],
    "auto_remediation_available": true/false
}}
"""

        response = client.chat.completions.create(
            model=os.getenv("AZURE_OPENAI_DEPLOYMENT", "gpt-4"),
            messages=[
                {"role": "system", "content": "You are an expert DevOps AI assistant."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.3
        )

        result_text = response.choices[0].message.content
        result = json.loads(result_text)

        logger.info(f"Analysis complete for {request.service_name}: {result}")
        
        return RemediationResponse(**result)

    except Exception as e:
        logger.error(f"Error analyzing logs: {e}")
        raise HTTPException(status_code=500, detail=str(e))

@app.post("/trigger-remediation")
async def trigger_remediation(service: str, action: str):
    """Trigger auto-remediation action."""
    logger.info(f"Triggering remediation for {service}: {action}")
    
    # In production, this would integrate with Kubernetes/Docker APIs
    actions_map = {
        "restart_service": f"kubectl rollout restart deployment/{service}",
        "scale_up": f"kubectl scale deployment/{service} --replicas=5",
        "clear_cache": f"redis-cli -h redis FLUSHDB"
    }
   
    command = actions_map.get(action, "echo 'Unknown action'")
    logger.info(f"Would execute: {command}")
    
    return {
        "status": "queued",
        "service": service,
        "action": action,
        "command": command
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
