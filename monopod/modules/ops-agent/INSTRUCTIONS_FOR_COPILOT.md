# Ops-Agent: DevOps AI Copilot (RAG)

## Context
Build an AI-powered chatbot that answers DevOps questions by searching through local documentation using Retrieval-Augmented Generation (RAG).

## Tech Stack
- **Python FastAPI** for REST API
- **Azure OpenAI** (GPT-4)
- **LangChain** for RAG pipeline
- **Azure AI Search** (Vector Search)
- **Local Markdown Files** as knowledge base

## Architecture Requirements

### RAG Pipeline
1. **Document Ingestion**
   - Load markdown files from `/docs` folder
   - Split into chunks (512 tokens)
   - Generate embeddings using `text-embedding-ada-002`
   - Store in Azure AI Search vector index

2. **Query Flow**
   - User asks question
   - Generate query embedding
   - Search vector index for top 5 relevant chunks
   - Pass chunks + question to GPT-4
   - Stream response back to user

### Knowledge Base
- OpsVerse project READMEs
- Azure documentation excerpts
- Terraform best practices
- Kubernetes cheat sheets

## Key Implementation Tasks

### 1. Initialize FastAPI Project
```bash
mkdir ops-agent && cd ops-agent
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install fastapi uvicorn langchain openai azure-search-documents
```

### 2. Document Loader
```python
from langchain.document_loaders import DirectoryLoader
from langchain.text_splitter import MarkdownTextSplitter

# Load all markdown files
loader = DirectoryLoader('../../docs', glob="**/*.md")
documents = loader.load()

# Split into chunks
splitter = MarkdownTextSplitter(chunk_size=512, chunk_overlap=50)
chunks = splitter.split_documents(documents)
```

### 3. Vector Store Setup
```python
from langchain.embeddings import AzureOpenAIEmbeddings
from langchain.vectorstores import AzureSearch

embeddings = AzureOpenAIEmbeddings(
    azure_deployment="text-embedding-ada-002",
    openai_api_version="2023-05-15"
)

vector_store = AzureSearch(
    azure_search_endpoint="https://<name>.search.windows.net",
    azure_search_key="<key>",
    index_name="opsverse-docs",
    embedding_function=embeddings.embed_query
)

# Index documents
vector_store.add_documents(chunks)
```

### 4. RAG Chain
```python
from langchain.chains import RetrievalQA
from langchain.chat_models import AzureChatOpenAI

llm = AzureChatOpenAI(
    azure_deployment="gpt-4",
    openai_api_version="2023-05-15",
    temperature=0
)

qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=vector_store.as_retriever(search_kwargs={"k": 5})
)
```

### 5. FastAPI Endpoints
```python
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class Question(BaseModel):
    query: str

@app.post("/ask")
async def ask_question(question: Question):
    result = qa_chain.run(question.query)
    return {"answer": result}

@app.get("/health")
async def health_check():
    return {"status": "healthy"}
```

### 6. Streaming Response (Optional)
```python
from fastapi.responses import StreamingResponse

@app.post("/ask/stream")
async def ask_streaming(question: Question):
    async def generate():
        for chunk in qa_chain.stream(question.query):
            yield f"data: {chunk}\n\n"
    
    return StreamingResponse(generate(), media_type="text/event-stream")
```

## Acceptance Criteria
- [ ] Ingest all markdown files from `/docs`
- [ ] Vector search returns relevant chunks
- [ ] RAG pipeline answers DevOps questions accurately
- [ ] FastAPI serves `/ask` endpoint
- [ ] Streaming response works
- [ ] Unit tests for chunking logic
- [ ] Integration tests with Azure OpenAI

## Testing Strategy
### Test Questions
1. "How do I implement the Outbox Pattern in IMS?"
2. "What is the tech stack for the Healthcare module?"
3. "Explain Azure Durable Functions workflow"
4. "How to detect fraud in the Fintech module?"

### Evaluation
- Accuracy: Does answer match source docs?
- Relevance: Are retrieved chunks related to question?
- Latency: Response time < 3 seconds

## Getting Started
Execute this plan step-by-step:
1. Set up FastAPI project
2. Implement document loader and chunking
3. Configure Azure OpenAI and AI Search
4. Build RAG chain
5. Create REST API
6. Test with sample questions

**Remember:** Quality of RAG depends on chunk size and retrieval k!
