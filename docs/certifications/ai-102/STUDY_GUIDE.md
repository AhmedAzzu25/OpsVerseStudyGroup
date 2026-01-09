# 🎯 AI-102: Azure AI Engineer Associate - Study Guide

**Exam Code**: AI-102  
**Duration**: 100 minutes  
**Questions**: 40-60 questions  
**Passing Score**: 700/1000  
**Cost**: $165 USD  
**Estimated Study Time**: 70 hours

---

## 📊 Exam Domains & Weights

| Domain | Weight | Study Hours | Status |
|--------|--------|-------------|--------|
| 1. Plan and Manage Azure AI Solution | 15-20% | 12h | ⏳ |
| 2. Implement Computer Vision Solutions | 20-25% | 16h | ⏳ |
| 3. Implement Natural Language Processing | 20-25% | 16h | ⏳ |
| 4. Implement Knowledge Mining Solutions | 15-20% | 12h | ⏳ |
| 5. Implement Generative AI Solutions | 10-15% | 14h | ⏳ |

---

## 📚 Domain 1: Plan & Manage Azure AI (15-20%)

### Azure OpenAI Service Setup

```python
import openai
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

# Get API key from Key Vault
credential = DefaultAzureCredential()
secret_client = SecretClient(vault_url="https://myvault.vault.azure.net", credential=credential)
api_key = secret_client.get_secret("OpenAI-API-Key").value

# Configure Azure OpenAI
openai.api_type = "azure"
openai.api_key = api_key
openai.api_base = "https://myopenai.openai.azure.com/"
openai.api_version = "2023-05-15"

# Make request
response = openai.ChatCompletion.create(
    engine="gpt-35-turbo",
    messages=[{"role": "user", "content": "Hello!"}],
    temperature=0.7,
    max_tokens=800
)
```

---

## 📚 Domain 2: Computer Vision (20-25%)

### Custom Vision - Image Classification

```python
from azure.cognitiveservices.vision.customvision.training import CustomVisionTrainingClient
from azure.cognitiveservices.vision.customvision.prediction import CustomVisionPredictionClient
from msrest.authentication import ApiKeyCredentials

# Training
training_client = CustomVisionTrainingClient(training_key, endpoint)

project = training_client.create_project("Product Classification")

# Add tags
apple_tag = training_client.create_tag(project.id, "Apple")
banana_tag = training_client.create_tag(project.id, "Banana")

# Upload images
with open("apple1.jpg", "rb") as image:
    training_client.create_images_from_data(project.id, image.read(), [apple_tag.id])

# Train model
iteration = training_client.train_project(project.id)

# Publish
training_client.publish_iteration(project.id, iteration.id, "ProductModel", prediction_resource_id)

# Prediction
predictor = CustomVisionPredictionClient(prediction_key, endpoint)
with open("test.jpg", "rb") as image:
    results = predictor.classify_image(project.id, "ProductModel", image.read())
    
    for prediction in results.predictions:
        print(f"{prediction.tag_name}: {prediction.probability * 100:.2f}%")
```

### Face API - Detection & Recognition

```python
from azure.cognitiveservices.vision.face import FaceClient
from msrest.authentication import CognitiveServicesCredentials

face_client = FaceClient(endpoint, CognitiveServicesCredentials(key))

# Detect faces
detected_faces = face_client.face.detect_with_url(
    url=image_url,
    return_face_attributes=['age', 'gender', 'emotion'],
    return_face_id=True
)

for face in detected_faces:
    print(f"Age: {face.face_attributes.age}")
    print(f"Gender: {face.face_attributes.gender}")
    print(f"Emotion: {face.face_attributes.emotion.happiness}")
```

---

## 📚 Domain 3: Natural Language Processing (20-25%)

### Language Understanding (LUIS)

```python
from azure.cognitiveservices.language.luis.runtime import LUISRuntimeClient
from msrest.authentication import CognitiveServicesCredentials

runtime_client = LUISRuntimeClient(endpoint, CognitiveServicesCredentials(key))

# Predict intent
request = {"query": "Book a flight to Seattle"}
response = runtime_client.prediction.get_slot_prediction(
    app_id=app_id,
    slot_name="production",
    prediction_request=request
)

print(f"Top intent: {response.prediction.top_intent}")
print(f"Entities: {response.prediction.entities}")
```

### Text Analytics - Sentiment Analysis

```python
from azure.ai.textanalytics import TextAnalyticsClient
from azure.core.credentials import AzureKeyCredential

text_analytics_client = TextAnalyticsClient(endpoint, AzureKeyCredential(key))

documents = [
    "I love this product! It's amazing.",
    "This is terrible. Worst purchase ever.",
    "It's okay, nothing special."
]

response = text_analytics_client.analyze_sentiment(documents, show_opinion_mining=True)

for idx, doc in enumerate(response):
    print(f"Document {idx}: {doc.sentiment} (confidence: {doc.confidence_scores.positive:.2f})")
    
    for sentence in doc.sentences:
        print(f"  - {sentence.text}: {sentence.sentiment}")
```

### Language Service - Q&A

```python
from azure.ai.language.questionanswering import QuestionAnsweringClient

qna_client = QuestionAnsweringClient(endpoint, AzureKeyCredential(key))

response = qna_client.get_answers(
    question="What is the return policy?",
    project_name="FAQ",
    deployment_name="production"
)

for answer in response.answers:
    print(f"Answer: {answer.answer}")
    print(f"Confidence: {answer.confidence}")
```

---

## 📚 Domain 4: Knowledge Mining (15-20%)

### Azure Cognitive Search - Indexing

```python
from azure.search.documents.indexes import SearchIndexClient
from azure.search.documents.indexes.models import (
    SearchIndex,
    SimpleField,
    SearchableField,
    SearchFieldDataType
)

index_client = SearchIndexClient(endpoint, AzureKeyCredential(key))

# Define index
fields = [
    SimpleField(name="id", type=SearchFieldDataType.String, key=True),
    SearchableField(name="title", type=SearchFieldDataType.String),
    SearchableField(name="content", type=SearchFieldDataType.String),
    SimpleField(name="category", type=SearchFieldDataType.String, filterable=True)
]

index = SearchIndex(name="documents", fields=fields)
index_client.create_index(index)

# Upload documents
from azure.search.documents import SearchClient

search_client = SearchClient(endpoint, "documents", AzureKeyCredential(key))

documents = [
    {"id": "1", "title": "Azure AI", "content": "...", "category": "tech"},
    {"id": "2", "title": "Ops Guide", "content": "...", "category": "devops"}
]

search_client.upload_documents(documents)

# Search
results = search_client.search("Azure", select=["title", "content"])
for result in results:
    print(f"{result['title']}: {result['@search.score']}")
```

---

## 📚 Domain 5: Generative AI (10-15%)

### RAG Pattern with Azure OpenAI

```python
from azure.search.documents import SearchClient
import openai

def rag_query(user_question):
    # 1. Retrieve relevant documents
    search_client = SearchClient(search_endpoint, "knowledge-base", AzureKeyCredential(search_key))
    search_results = search_client.search(user_question, top=3)
    
    context = "\n".join([doc['content'] for doc in search_results])
    
    # 2. Augment with context
    messages = [
        {"role": "system", "content": "Answer based on the following context:"},
        {"role": "system", "content": context},
        {"role": "user", "content": user_question}
    ]
    
    # 3. Generate response
    response = openai.ChatCompletion.create(
        engine="gpt-35-turbo",
        messages=messages,
        temperature=0.3,
        max_tokens=500
    )
    
    return response.choices[0].message.content

# Use
answer = rag_query("How do I configure Azure Functions?")
print(answer)
```

### Prompt Engineering Best Practices

```python
# System message for role definition
system_message = """You are a helpful DevOps assistant specializing in Azure. 
Provide clear, concise answers with code examples when appropriate."""

# Few-shot learning
messages = [
    {"role": "system", "content": system_message},
    {"role": "user", "content": "How do I create a resource group?"},
    {"role": "assistant", "content": "az group create --name myrg --location eastus"},
    {"role": "user", "content": "How do I create a storage account?"}
]

response = openai.ChatCompletion.create(
    engine="gpt-4",
    messages=messages,
    temperature=0.2,  # Lower for factual responses
    max_tokens=200
)
```

---

## 🎯 Hands-On Practice Labs

### Lab 1: Custom Vision - Product Classifier

Train model to classify 5 product categories

### Lab 2: Face Recognition System

Implement face detection, identification, and verification

### Lab 3: Chatbot with LUIS

Create intent recognition for customer service bot

### Lab 4: Document Search with Cognitive Search

Index PDF documents with AI enrichment

### Lab 5: RAG Application

Build Q&A system using Azure OpenAI + Cognitive Search

### Lab 6: Sentiment Analysis Dashboard

Analyze customer reviews and visualize sentiments

---

## 📖 Study Schedule (70 Hours)

### Week 1-2 (24 hours)

- Domain 2: Computer Vision
- Complete Labs 1-2

### Week 3 (20 hours)

- Domain 3: NLP
- Complete Labs 3, 6

### Week 4 (16 hours)

- Domain 4: Knowledge Mining
- Domain 5: Generative AI
- Complete Labs 4-5

### Week 5 (10 hours)

- Domain 1: Planning & management
- Practice exams

---

## 📝 Practice Exam Questions

1. **Which service is best for document search with AI enrichment?**
   - a) Cosmos DB
   - b) Azure Cognitive Search ✅
   - c) Azure Table Storage
   - d) Azure SQL

2. **What's the recommended approach for grounding LLM responses?**
   - a) Fine-tuning
   - b) Prompt engineering
   - c) RAG (Retrieval-Augmented Generation) ✅
   - d) Increasing temperature

---

## 🔗 Official Resources

- [MS Learn AI-102](https://learn.microsoft.com/en-us/certifications/exams/ai-102/)
- [Azure AI Services Docs](https://learn.microsoft.com/en-us/azure/cognitive-services/)
- [Azure OpenAI](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/)

---

## ✅ Exam Preparation Checklist

- [ ] Trained Custom Vision model
- [ ] Implemented Face API recognition
- [ ] Created LUIS app with intents/entities
- [ ] Built Cognitive Search index
- [ ] Implemented RAG pattern
- [ ] Familiar with responsible AI principles
- [ ] Practice exam score: 75%+

**Target Exam Date**: August 25, 2026  
**Study Period**: July 28 - August 25 (28 days)  
**Next Cert**: PCA Prometheus
