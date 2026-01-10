import os
import json
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from openai import AzureOpenAI
from datetime import datetime, timedelta
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(title="MonoPod Business Agent", version="1.0.0")

client = AzureOpenAI(
    azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT", ""),
    api_key=os.getenv("AZURE_OPENAI_KEY", ""),
    api_version="2024-02-15-preview"
)

class SalesData(BaseModel):
    product_id: str
    product_name: str
    sales_history: list[dict]  # [{date, quantity, amount}]

class ForecastRequest(BaseModel):
    sales_data: list[SalesData]
    forecast_days: int = 30

class ForecastResponse(BaseModel):
    product_id: str
    product_name: str
    current_stock: int
    forecasted_demand: int
    reorder_recommended: bool
    suggested_quantity: int
    confidence: str

@app.get("/")
def root():
    return {
        "service": "MonoPod Business Agent",
        "version": "1.0.0",
        "description": "AI-powered business intelligence for demand forecasting"
    }

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.post("/forecast-demand", response_model=list[ForecastResponse])
async def forecast_demand(request: ForecastRequest):
    """Generate demand forecast using Azure OpenAI."""
    try:
        forecasts = []
        
        for product in request.sales_data:
            # Prepare sales history summary
            total_sales = sum(item.get("quantity", 0) for item in product.sales_history)
            avg_daily_sales = total_sales / len(product.sales_history) if product.sales_history else 0
            
            prompt = f"""Analyze sales data and forecast demand for {request.forecast_days} days.

Product: {product.product_name}
Historical Sales (last {len(product.sales_history)} days): {total_sales} units
Average Daily Sales: {avg_daily_sales:.2f} units

Recent Sales Pattern:
{json.dumps(product.sales_history[-14:], indent=2)}

Provide a demand forecast and reorder recommendation in JSON:
{{
    "forecasted_demand": <number>,
    "confidence": "HIGH|MEDIUM|LOW",
    "reorder_recommended": true/false,
    "suggested_quantity": <number>,
    "reasoning": "brief explanation"
}}
"""

            response = client.chat.completions.create(
                model=os.getenv("AZURE_OPENAI_DEPLOYMENT", "gpt-4"),
                messages=[
                    {"role": "system", "content": "You are an expert supply chain analyst."},
                    {"role": "user", "content": prompt}
                ],
                temperature=0.5
            )

            result_text = response.choices[0].message.content
            result = json.loads(result_text)

            forecast = ForecastResponse(
                product_id=product.product_id,
                product_name=product.product_name,
                current_stock=product.sales_history[-1].get("current_stock", 0) if product.sales_history else 0,
                forecasted_demand=result["forecasted_demand"],
                reorder_recommended=result["reorder_recommended"],
                suggested_quantity=result["suggested_quantity"],
                confidence=result["confidence"]
            )
            
            forecasts.append(forecast)
            logger.info(f"Forecast generated for {product.product_name}: {result['reasoning']}")

        return forecasts

    except Exception as e:
        logger.error(f"Error forecasting demand: {e}")
        raise HTTPException(status_code=500, detail=str(e))

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001)
