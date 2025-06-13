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
│   ├── 📄 main.tf  
│   ├── 📄 variables.tf  
│   ├── 📄 triggers.tf  
│   └── 📁 vars/  
│       ├── 📄 agents.tfvars  
│       ├── 📄 staging.tfvars  
│       └── 📄 production.tfvars  
│  
└── 🚀 deployment/          \# Root-level Cloud Build YAML files  
    └── 📄 cloudbuild.yaml

### **🎯 "GOLDEN PATH" WORKFLOW (MANDATORY)**

**Phase A: One-Time Workspace Setup** (Performed Once)

1. Create the DaisyAI-Workspace/ mono-repo on GitHub.  
2. Create the daisy-ai-staging and daisy-ai-production GCP projects.  
3. Manually create a single **Cloud Build Connection** to the DaisyAI-Workspace repository.  
4. Create and deploy the root /terraform configuration to establish the foundation.

**Phase B: Per-Agent Onboarding Workflow** (Repeated for each agent)

1. **Create Agent**: From the workspace root, run agent-starter-pack create \[agent\_name\] ....  
2. **Local Validation**: Run cd \[agent\_name\], make install, and make playground.  
3. **Register Agent in IaC**: Open the central terraform/vars/agents.tfvars file and add an entry for the new agent.  
4. **Commit, PR, and Deploy**: Commit the new agent and the configuration change. Merging the PR triggers the CI/CD pipeline, which automatically runs terraform apply and deploys the agent.

## **Executive Summary**

This document outlines the architecture for the DaisyAI multi-agent system, featuring 11 agents within a **scalable mono-repo**, deployed via a **centralized, state-of-the-art Infrastructure as Code (IaC) process** using Terraform and a **mono-repo aware CI/CD pipeline** on Cloud Build.

## **Architecture Decisions**

* **Agent Deployment**: All agents are deployed exclusively to **Vertex AI Agent Engine** for centralized management and monitoring.  
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