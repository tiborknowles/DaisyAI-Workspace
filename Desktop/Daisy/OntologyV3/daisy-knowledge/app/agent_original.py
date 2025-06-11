# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# mypy: disable-error-code="arg-type"
import os
import logging

import google
import vertexai
from google.adk.agents import Agent
from langchain_google_vertexai import VertexAIEmbeddings

from app.retrievers import get_compressor, get_retriever
from app.templates import format_docs

# DaisyAI Neo4j integration (Agent Starter Pack compliant)
try:
    from app.utils.neo4j_manager import DaisyNeo4jManager
    neo4j_available = True
except ImportError:
    neo4j_available = False

logger = logging.getLogger(__name__)

EMBEDDING_MODEL = "text-embedding-005"
LLM_LOCATION = "global"
LOCATION = "us-central1"
LLM = "gemini-2.0-flash-001"

credentials, project_id = google.auth.default()
os.environ.setdefault("GOOGLE_CLOUD_PROJECT", project_id)
os.environ.setdefault("GOOGLE_CLOUD_LOCATION", LLM_LOCATION)
os.environ.setdefault("GOOGLE_GENAI_USE_VERTEXAI", "True")

# DaisyAI: Set Neo4j connection details for music industry ontology
os.environ.setdefault("NEO4J_URI", "neo4j+s://c03cc6e3.databases.neo4j.io")
os.environ.setdefault("NEO4J_USERNAME", "neo4j")
os.environ.setdefault("NEO4J_PASSWORD", "AlCyIfcdh2lIrvKd9QsLEKHXpSPEXSITNEt9sPP7hrY")
os.environ.setdefault("NEO4J_DATABASE", "neo4j")

vertexai.init(project=project_id, location=LOCATION)
embedding = VertexAIEmbeddings(
    project=project_id, location=LOCATION, model_name=EMBEDDING_MODEL
)

EMBEDDING_COLUMN = "embedding"
TOP_K = 5

data_store_region = os.getenv("DATA_STORE_REGION", "us")
data_store_id = os.getenv("DATA_STORE_ID", "daisy-knowledge-datastore")

retriever = get_retriever(
    project_id=project_id,
    data_store_id=data_store_id,
    data_store_region=data_store_region,
    embedding=embedding,
    embedding_column=EMBEDDING_COLUMN,
    max_documents=10,
)

compressor = get_compressor(
    project_id=project_id,
)

# Initialize DaisyAI Neo4j manager for music industry ontology
neo4j_manager = None
if neo4j_available:
    try:
        neo4j_manager = DaisyNeo4jManager()
        logger.info("✅ DaisyAI: Neo4j music industry ontology connected")
    except Exception as e:
        logger.warning(f"⚠️ DaisyAI Neo4j initialization failed: {e}")

def search_music_ontology(query: str) -> str:
    """
    Search the DaisyAI music industry knowledge graph for entities, relationships, and classifications.
    Use this when you need to find connections between artists, genres, techniques, or industry concepts.

    Args:
        query (str): Search term for music industry entities (artists, genres, techniques, etc.)

    Returns:
        str: Formatted string containing relevant ontology entities and their relationships.
    """
    if not neo4j_manager:
        return "🗃️ Music Industry Ontology temporarily unavailable. Using document knowledge base instead."
    
    try:
        response = neo4j_manager.search_music_entities(query, limit=8)
        
        if response.success and response.data:
            results = []
            results.append(f"🎯 Found {len(response.data)} music industry entities matching '{query}':")
            
            for record in response.data:
                entity = record.get('n', {})
                entity_types = record.get('entity_types', [])
                
                if entity and entity_types:
                    name = entity.get('name', entity.get('title', 'Unknown Entity'))
                    description = entity.get('comment', entity.get('description', ''))
                    
                    entity_info = f"🎵 **{name}** ({', '.join(entity_types)})"
                    if description:
                        entity_info += f"\n   📝 {description[:150]}..."
                    
                    results.append(entity_info)
            
            results.append(f"\n📊 **Source**: DaisyAI Music Industry Knowledge Graph")
            return "\n".join(results)
        else:
            return f"🔍 No music industry entities found matching '{query}' in the ontology."
            
    except Exception as e:
        logger.error(f"Music ontology search error: {e}")
        return f"❌ Error searching music ontology: {str(e)}"

def retrieve_docs(query: str) -> str:
    """
    Enhanced retrieval with DaisyAI music industry ontology + Vertex AI Search.
    Use this when you need additional information to answer a question.

    Args:
        query (str): The user's question or search query.

    Returns:
        str: Formatted string containing relevant document content from Vertex AI Search 
             and ontology entities from DaisyAI music industry knowledge graph.
    """
    try:
        # 1. Vertex AI Search (standard Agent Starter Pack functionality)
        retrieved_docs = retriever.invoke(query)
        ranked_docs = compressor.compress_documents(
            documents=retrieved_docs, query=query
        )
        formatted_docs = format_docs.format(docs=ranked_docs)
        
        # 2. DaisyAI Music Industry Ontology (custom business logic)
        ontology_context = ""
        if neo4j_manager:
            try:
                response = neo4j_manager.search_music_entities(query, limit=5)
                if response.success and response.data:
                    ontology_results = []
                    for record in response.data:
                        entity = record.get('n', {})
                        entity_types = record.get('entity_types', [])
                        if entity and entity_types:
                            name = entity.get('name', entity.get('title', 'Unknown'))
                            ontology_results.append(f"🎵 {name} ({', '.join(entity_types)})")
                    
                    if ontology_results:
                        ontology_context = f"\n\n🗃️ **Music Industry Ontology** ({len(ontology_results)} entities):\n" + "\n".join([f"  • {result}" for result in ontology_results])
            except Exception as e:
                logger.error(f"Ontology search error: {e}")
        
        # 3. Combine results intelligently
        if ontology_context:
            combined_result = f"{formatted_docs}{ontology_context}\n\n📊 **Knowledge Sources**: Vertex AI Search + DaisyAI Music Industry Ontology"
            logger.info(f"✅ Enhanced retrieval: Vertex AI + DaisyAI ontology for query: {query}")
            return combined_result
        else:
            # Graceful degradation to standard retrieval
            logger.info(f"🔄 Standard Vertex AI Search for query: {query}")
            return formatted_docs
            
    except Exception as e:
        return f"Calling retrieval tool with query:\n\n{query}\n\nraised the following error:\n\n{type(e)}: {e}"

# Enhanced instruction for DaisyAI Knowledge Agent
instruction = """You are DaisyAI's Knowledge Agent - the central intelligence hub for the music industry AI system.

You have access to powerful knowledge sources:
📚 **Vertex AI Search**: Comprehensive music industry documents, insights, and best practices  
🗃️ **Music Industry Ontology**: Knowledge graph with relationships between artists, genres, techniques, and industry entities

**Your capabilities**:
- Answer questions about music industry relationships and connections
- Provide detailed explanations of production techniques and processes  
- Offer strategic insights for artists, labels, and industry professionals
- Connect concepts across the entire music ecosystem

**Tools available**:
- retrieve_docs(): Get detailed documents and insights + ontology context
- search_music_ontology(): Search the music industry knowledge graph directly

Always leverage the appropriate tool based on the query complexity. For factual questions, use retrieve_docs(). For relationship and entity searches, use search_music_ontology()."""

root_agent = Agent(
    name="root_agent",
    model="gemini-2.0-flash",
    instruction=instruction,
    tools=[retrieve_docs, search_music_ontology],
)
