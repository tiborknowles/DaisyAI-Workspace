# DaisyAI Central Agents Configuration
# This file contains the definitive map of all 11 DaisyAI agents
# Each agent entry will be added as we onboard them following the Golden Path workflow

# GOLDEN PATH EXECUTION: Adding agents one by one with ASP 0.5.2 compliance
# Agents will be added one by one following the exact ASP 0.5.2 workflow:
# 1. agent-starter-pack create [agent_name] --template=[template]
# 2. cd [agent_name] && make install && make playground
# 3. Add agent entry to this file
# 4. Git commit and push to trigger CI/CD

agents = {
  # Phase 1A: daisy_knowledge - GOLDEN PATH COMPLIANT ✅
  # Created: agent-starter-pack create daisy_knowledge -a 2 (agentic_rag)
  # Validated: make install && make playground ✅
  daisy_knowledge = {
    template = "agentic_rag"
    port     = 8502
    enabled  = true
    description = "Knowledge Management & RAG Agent - ASP 0.5.2 compliant with Vertex AI Search datastore"
  }
  
  # Phase 1B: daisy_maestro - GOLDEN PATH COMPLIANT ✅
  # Created: agent-starter-pack create daisy_maestro -a 3 (langgraph_base_react)
  # Validated: make install && make playground ✅
  daisy_maestro = {
    template = "langgraph_base_react"
    port     = 8503
    enabled  = true
    description = "Central Orchestrator Agent - ASP 0.5.2 compliant with LangGraph base react framework"
  }
  
  # Phase 1C: daisy_talent - GOLDEN PATH COMPLIANT ✅
  # Created: agent-starter-pack create daisy_talent -a 1 (adk_base)
  # Validated: make install && make playground ✅
  daisy_talent = {
    template = "adk_base"
    port     = 8504
    enabled  = true
    description = "A&R Discovery Agent - ASP 0.5.2 compliant with ADK base framework"
  }
} 