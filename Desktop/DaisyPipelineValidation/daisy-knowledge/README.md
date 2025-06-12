# DaisyAI Knowledge Agent

Central intelligence hub for the music industry AI system built with Google Agent Development Kit (ADK) and ASP 0.5.2 compliance.

## 🎯 **Overview**

The DaisyAI Knowledge Agent provides comprehensive access to music industry insights through:

- **📚 Vertex AI Search**: Industry documents, best practices, and insights
- **🗃️ Music Industry Ontology**: Knowledge graph with artist, genre, and technique relationships  
- **🎵 Strategic Intelligence**: Expert guidance for artists, labels, and industry professionals

## 🚀 **Quick Start**

### Prerequisites
- Python 3.11+
- Google Cloud Project with Vertex AI enabled
- Agent Development Kit (ADK) installed

### Environment Setup
```bash
export PROJECT_ID=your-gcp-project
export DATA_STORE_ID=your-datastore-id
export DATA_STORE_REGION=us
```

### Development
```bash
# Install dependencies
uv sync

# Start playground
make playground
```

## 🏗️ **Architecture**

This agent follows ASP 0.5.2 compliance standards:

```
daisy-knowledge/
├── app/
│   ├── __init__.py
│   ├── agent.py          # Root agent (daisy-knowledge.agent.root_agent)
│   └── utils/
├── deployment/           # CI/CD and infrastructure
├── pyproject.toml       # Package configuration
└── README.md
```

## 🔧 **Configuration**

The agent uses environment-driven configuration:

- `PROJECT_ID`: Google Cloud Project ID
- `DATA_STORE_ID`: Vertex AI Search datastore
- `DATA_STORE_REGION`: Data store region
- `NEO4J_*`: Music industry ontology connection (optional)

## 📊 **Capabilities**

- Music industry document retrieval
- Knowledge graph exploration
- Strategic insights and analysis
- Industry relationship mapping

## 🛠️ **Development**

Built with:
- Google Agent Development Kit (ADK) 0.5.2+
- Vertex AI Search
- Custom music industry ontology
- ASP compliance standards

## 📝 **License**

Apache 2.0 - See LICENSE file for details. 