# **DaisyAI Agent Ecosystem \- Master Architecture & Execution Plan**

## **🚨 CRITICAL: LLM DEVELOPMENT INSTRUCTIONS \- MANDATORY COMPLIANCE**

### **⚠️ NON-NEGOTIABLE REQUIREMENTS FOR ALL CODE GENERATION AND SYSTEM ARCHITECTURE**

**🔒 ABSOLUTE COMPLIANCE MANDATE:**

* **ALL code creation, file structure, and system architecture MUST strictly follow Google Agent Starter Pack (ASP) 0.5.2 and the scalable mono-repo IaC principles defined herein.**  
* **This is NOT a recommendation \- this is a MANDATORY requirement.**

**📋 MANDATORY COMPLIANCE REPOSITORIES:**

* **Agent Starter Pack (ASP) 0.5.2**: [https://github.com/GoogleCloudPlatform/agent-starter-pack](https://github.com/GoogleCloudPlatform/agent-starter-pack)  
* **A2A Protocol**: [https://github.com/google-a2a/A2A](https://github.com/google-a2a/A2A)

### **🚨 CRITICAL: MONO-REPO ARCHITECTURE & IaC STRATEGY**

**⚡ MANDATORY DIRECTORY & IaC STRUCTURE:**

1. **Mono-Repo Structure**: All 11 agents MUST reside as root-level projects within the DaisyAI-Workspace/ mono-repo.  
2. **Centralized Terraform**: A **single, root-level /terraform directory** will manage the CI/CD infrastructure for ALL 11 agents using a for\_each meta-argument for scalability.  
3. **Agent Naming Convention**:  
   * Agent directories MUST use **underscores (\_)** (e.g., daisy\_knowledge) for Python import compatibility.  
   * The A2A name field in agent.json SHOULD use **hyphens (-)** (e.g., "name": "daisy-knowledge").

🔬 RECOMMENDED AGENT INTERNAL STRUCTURE:  
To ensure code clarity and maintainability, each agent's app/ directory SHOULD be organized by function, following this best-practice pattern:  
daisy\_knowledge/  
└── 📱 app/  
    ├── 📄 agent.py        \# Main agent entrypoint and orchestration  
    ├── 📁 tools/           \# Houses individual tool implementations (e.g., search\_tool.py)  
    └── 📁 services/        \# Handles connections to external APIs or data sources

### **🎯 "GOLDEN PATH" WORKFLOW (MANDATORY)**

**Phase A: One-Time Workspace Setup** (Performed Once)

1. Create the DaisyAI-Workspace/ mono-repo on GitHub.  
2. Create the daisy-ai-staging and daisy-ai-production GCP projects.  
3. Manually create a single **Cloud Build Connection** to the DaisyAI-Workspace repository.  
4. Create and deploy the root /terraform configuration to establish the foundation.

**Phase B: Per-Agent Onboarding Workflow** (Repeated for each agent)

1. **Create Agent**: From the workspace root, run agent-starter-pack create \[agent\_name\] ....  
2. **Local Validation**: Run cd \[agent\_name\], make install, and make playground.  
3. **Register Agent in IaC**: Add an entry for the new agent in the central terraform/vars/agents.tfvars file.  
4. Commit, PR, and Deploy: Commit the new agent and the configuration change. Merging the PR triggers the CI/CD pipeline. The pipeline will:  
   a. Intelligently detect which agent has changed.  
   b. Generate a clean requirements.txt from the agent's uv.lock file to ensure a deterministic container build.  
   c. Build the agent's container image using its Dockerfile.  
   d. Run terraform apply to provision the necessary triggers.  
   e. Deploy the new image to Vertex AI Agent Engine.

## **Executive Summary**

This document outlines the architecture for the DaisyAI multi-agent system, featuring 11 agents within a **scalable mono-repo**, deployed via a **centralized, state-of-the-art Infrastructure as Code (IaC) process** and a **mono-repo aware CI/CD pipeline** on Cloud Build.

## **Architecture Decisions**

* **Agent Deployment**: All agents are deployed exclusively to **Vertex AI Agent Engine**.  
* **CI/CD & IaC**: A centralized Terraform configuration manages all agent pipelines. The Cloud Build pipeline intelligently builds and deploys only the agents changed in a given pull request.  
* **Data & Communication**: A centralized Vertex AI Search data layer and A2A/LangGraph for communication.

## **Complete Agent Ecosystem (11 Agents)**

| Agent Directory | A2A Name | ASP Template | Management Console | Core Capabilities |
| :---- | :---- | :---- | :---- | :---- |
| daisy\_maestro | daisy-maestro | langgraph\_base\_react | Vertex AI Console | Strategic orchestration, goal setting |
| daisy\_knowledge | daisy-knowledge | agentic\_rag | Vertex AI Console | Document RAG, ontology queries |
| daisy\_talent | daisy-talent | adk\_base | Vertex AI Console | A\&R discovery, artist analysis |
| daisy\_production | daisy-production | adk\_base | Vertex AI Console | Music generation, remixing |
| daisy\_marketing | daisy-marketing | adk\_base | Vertex AI Console | Campaign management, optimization |
| daisy\_live | daisy-live | live\_api | Vertex AI Console | Real-time performance streaming |
| daisy\_venue | daisy-venue | adk\_base | Vertex AI Console | Tour logistics, venue booking |
| daisy\_rights | daisy-rights | adk\_base | Vertex AI Console | Rights management, royalties |
| daisy\_legal | daisy-legal | adk\_base | Vertex AI Console | Legal compliance, contracts |
| daisy\_financial | daisy-financial | adk\_base | Vertex AI Console | Financial planning, forecasting |
| daisy\_audience | daisy-audience | adk\_base | Vertex AI Console | Audience analysis, fan behavior |

## **4-Phase Master Execution Plan**

(Detailed execution steps and checklists are contained within the PHASE\_EXECUTION \_TRACKER.md document.)

* **Phase 1**: Foundation Infrastructure & Core Agents (daisy\_knowledge, daisy\_maestro)  
* **Phase 2**: Music Business Core (daisy\_talent, daisy\_production, daisy\_marketing, daisy\_live)  
* **Phase 3**: Business Operations (daisy\_venue, daisy\_rights, daisy\_legal, daisy\_financial, daisy\_audience)  
* **Phase 4**: Production Hardening (A2A Integration, Monitoring, Testing, Security)

## **Production Readiness: Testing, Observability & Integration Strategy**

### **🧪 Comprehensive Testing Strategy**

Each agent MUST adhere to a multi-layered testing protocol managed via its Makefile, providing a standard interface for the CI/CD pipeline:

1. **make test-unit**: Runs all unit tests using pytest. Mocks are required for external dependencies.  
2. **make test-integration**: Runs integration tests against live staging services.  
3. **make lint**: Runs code linters (e.g., Ruff, Mypy) to check for style issues.  
4. **make clean**: Removes temporary files and caches.  
5. **make evaluate**: Runs Vertex AI Model Evaluation jobs to measure response quality.  
6. **make test-load**: Triggers load tests against the staging environment.

### **📊 Observability & Monitoring Pipeline**

A comprehensive monitoring strategy will be implemented in **Phase 4**, leveraging the native capabilities of the Vertex AI ecosystem.

* **Native Agent Engine Monitoring**: We will leverage the built-in Vertex AI Agent Engine observability for comprehensive monitoring, logging, and performance metrics, providing a unified dashboard for all 11 agents.  
* **Cross-Agent Tracing**: Agent Engine's native tracing capabilities will be used to track requests across multiple agents.

### **🔌 MCP & External Feeds Integration**

A single, centralized **External Feeds MCP Server** will be developed in **Phase 3** to federate data from all external APIs (Spotify, YouTube, etc.). This provides a single point of access for all agents, simplifying their logic and centralizing cost-management features like rate limiting and caching.