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

1. **Mono-Repo Structure**: All 11 agents MUST reside as root-level projects within the DaisyAI-Workspace/ mono-repo. This enables shared configurations and coordinated changes.  
2. **Centralized Terraform**: A **single, root-level /terraform directory** will manage the CI/CD infrastructure for ALL 11 agents. This approach uses Terraform's for\_each meta-argument to ensure consistent, scalable management from a single state file.  
3. **Agent Naming Convention**:  
   * Agent directories MUST use **underscores (\_)** (e.g., daisy\_knowledge) for Python import compatibility.  
   * The A2A name field in agent.json SHOULD use **hyphens (-)** (e.g., "name": "daisy-knowledge").

**✅ REQUIRED: CORRECT SCALABLE MONO-REPO IMPLEMENTATION:**

DaisyAI-Workspace/  
├── 📄 .git/  
├── 🎵 daisy\_knowledge/      \# Agent-specific code only  
│   ├── 📄 pyproject.toml  
│   └── 📱 app/  
├── 🎯 daisy\_maestro/        \# Agent-specific code only  
│   └── ...  
│  
├── 🔥 terraform/             \# \<\<\< ROOT-LEVEL CENTRALIZED IaC  
│   ├── 📄 main.tf          \# Main logic with for\_each loops  
│   ├── 📄 variables.tf     \# Central variable definitions  
│   ├── 📄 triggers.tf       \# Defines all agent triggers  
│   └── 📁 vars/  
│       ├── 📄 agents.tfvars  \# The central map of all 11 agents  
│       ├── 📄 staging.tfvars \# Staging environment configs  
│       └── 📄 production.tfvars \# Production environment configs  
│  
└── 🚀 deployment/          \# Root-level Cloud Build YAML files  
    └── 📄 cloudbuild.yaml

### **🎯 "GOLDEN PATH" WORKFLOW (MANDATORY)**

**Phase A: One-Time Workspace Setup** (Performed Once)

1. Create the DaisyAI-Workspace/ mono-repo on GitHub.  
2. Create the daisy-ai-staging and daisy-ai-production GCP projects.  
3. Manually create a single **Cloud Build Connection** to the DaisyAI-Workspace repository.  
4. Create the root /terraform and /deployment directories and populate them with the initial, centralized configuration files. Run terraform apply once to set up the foundational infrastructure.

**Phase B: Per-Agent Onboarding Workflow** (Repeated for each agent)

1. **Create Agent**: From the workspace root, run agent-starter-pack create \[agent\_name\] ... to scaffold the new agent's directory.  
2. **Local Validation**: Run cd \[agent\_name\], make install, and make playground to verify local functionality.  
3. **Register Agent in IaC**: Open the central terraform/vars/agents.tfvars file and add a new entry for the agent (e.g., daisy\_knowledge \= { template \= "agentic\_rag", port \= 8502 }).  
4. **Commit, PR, and Deploy**: Commit the new agent directory and the change to agents.tfvars. Create a Pull Request. Upon merging the PR, the "mono-repo aware" Cloud Build pipeline will automatically detect the changes and run terraform apply to provision the new CI/CD triggers for that agent only.

## **Executive Summary**

This document outlines the complete architecture for the DaisyAI multi-agent system. The system features 11 specialized agents within a **scalable mono-repo**, deployed via a **centralized, state-of-the-art Infrastructure as Code (IaC) process** using Terraform and a **mono-repo aware CI/CD pipeline** on Cloud Build.

## **Architecture Decisions**

* **CI/CD & IaC**: A centralized Terraform configuration will manage all agent pipelines, providing consistency and ease of management. The Cloud Build pipeline will be designed to intelligently build and deploy only the agents that have been changed in a given pull request.  
* **Data Layer**: Centralized access through Vertex AI Search, federated with a read-only Neo4j knowledge graph.  
* **Communication**: A2A protocol for inter-agent messaging, with LangGraph for complex workflow orchestration.

## **System Architecture Overview**

(See docs/images/architecture\_diagram.png for a visual representation)

## **Complete Agent Ecosystem (11 Agents)**

| Agent Directory | A2A Name | ASP Template | Port | Core Capabilities |
| :---- | :---- | :---- | :---- | :---- |
| daisy\_maestro | daisy-maestro | langgraph\_base\_react | 8501 | Strategic orchestration, goal setting |
| daisy\_knowledge | daisy-knowledge | agentic\_rag | 8502 | Document RAG, ontology queries |
| daisy\_talent | daisy-talent | adk\_base | 8503 | A\&R discovery, artist analysis |
| daisy\_production | daisy-production | adk\_base | 8504 | Music generation, remixing |
| daisy\_marketing | daisy-marketing | adk\_base | 8505 | Campaign management, optimization |
| daisy\_live | daisy-live | live\_api | 8506 | Real-time performance streaming |
| daisy\_venue | daisy-venue | adk\_base | 8507 | Tour logistics, venue booking |
| daisy\_rights | daisy-rights | adk\_base | 8508 | Rights management, royalties |
| daisy\_legal | daisy-legal | adk\_base | 8509 | Legal compliance, contracts |
| daisy\_financial | daisy-financial | adk\_base | 8510 | Financial planning, forecasting |
| daisy\_audience | daisy-audience | adk\_base | 8511 | Audience analysis, fan behavior |

## **4-Phase Master Execution Plan**

(Detailed execution steps and checklists are contained within the PHASE\_TRACKER.md document.)

* **Phase 1**: Foundation Infrastructure & Core Agents (daisy\_knowledge, daisy\_maestro)  
* **Phase 2**: Music Business Core (daisy\_talent, daisy\_production, daisy\_marketing, daisy\_live)  
* **Phase 3**: Business Operations (daisy\_venue, daisy\_rights, daisy\_legal, daisy\_financial, daisy\_audience)  
* **Phase 4**: Production Hardening (A2A Integration, Monitoring, Testing, Security)

## **Production Readiness: Testing, Observability & Integration Strategy**

### **🧪 Comprehensive Testing Strategy**

* **Unit & Integration Testing**: Each agent's pipeline will run its own unit and integration tests (make test).  
* **Coordinated Ecosystem Testing**: A dedicated Cloud Build job will be triggered on a merge to main, which deploys all changed agents to the staging environment and then runs an end-to-end test suite against the entire ecosystem to validate cross-agent workflows.

### **📊 Observability & Monitoring Pipeline**

* **Centralized Stack**: A single, robust observability stack (Cloud Trace, Cloud Monitoring, BigQuery, Looker Studio) will monitor all 11 agents, providing a unified view of system health and performance.  
* **Cross-Agent Tracing**: OpenTelemetry will be used to generate distributed traces that correlate requests across multiple agents, allowing for easy debugging of complex LangGraph workflows.

### **🔌 MCP & External Feeds Integration**

* A single, centralized **External Feeds MCP Server** will be developed to federate data from all external APIs (Spotify, YouTube, etc.). This provides a single point of access for all agents, simplifying their logic and centralizing cost-management features like rate limiting and caching.

Vertex AI API Key: AIzaSyDzroxz90HKbPG4I264MPmUNth1wfZSieE
OAuth CLient ID:1069701282906-1p4iinf7qtdadc3met594vt97fveipss.apps.googleusercontent.com
Client secret: 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
You now have:
A working service account: daisy-ai-vertex@daisy-ai-staging.iam.gserviceaccount.com
A JSON key file: daisy-ai-vertex-key.json
Proper permissions: Vertex AI User role assigned
Working authentication: The API accepts your credentials (404 means auth works, just need model access)