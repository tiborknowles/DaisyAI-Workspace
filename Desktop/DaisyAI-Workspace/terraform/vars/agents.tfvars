# DaisyAI Central Agents Configuration
# This file contains the definitive map of all 11 DaisyAI agents
# Each agent entry will be added as we onboard them following the Golden Path workflow

# Initially empty - will be populated during Phase 1, 2, and 3
# Format for each agent:
# agent_name = {
#   template = "asp_template_name"
#   port     = unique_port_number
#   enabled  = true
# }

# Complete agent map based on MASTER_ARCHITECTURE.md:
agents = {
  # Phase 1: Foundation Infrastructure & Core Agents - ACTIVE
  daisy_knowledge = {
    template = "agentic_rag"
    port     = 8502
    enabled  = true
    description = "Knowledge Management & RAG Agent for music industry expertise"
  }
  
  # Central Orchestrator Agent
  daisy_maestro = {
    template = "langgraph_base_react"
    port     = 8501
    enabled  = true
    description = "Central orchestrator and strategic task routing agent"
  }
  
  # A&R and Talent Discovery Agent
  daisy_talent = {
    template = "adk_base"
    port     = 8503
    enabled  = true
    description = "A&R discovery, artist analysis, and talent scouting agent"
  }
  
  # Phase 2: Music Business Core Agents (to be created next)
  # daisy_production = {
  #   template = "adk_base"
  #   port     = 8504
  #   enabled  = false
  #   description = "Music generation, production, and remixing agent"
  # }
  # 
  # daisy_marketing = {
  #   template = "adk_base"
  #   port     = 8505
  #   enabled  = false
  #   description = "Campaign management and marketing optimization agent"
  # }
  # 
  # daisy_live = {
  #   template = "live_api"
  #   port     = 8506
  #   enabled  = false
  #   description = "Real-time performance streaming and live event agent"
  # }
  
  # Phase 3: Business Operations Agents (to be created later)
  # daisy_venue = {
  #   template = "adk_base"
  #   port     = 8507
  #   enabled  = false
  #   description = "Tour logistics and venue booking agent"
  # }
  # 
  # daisy_rights = {
  #   template = "adk_base"
  #   port     = 8508
  #   enabled  = false
  #   description = "Rights management and royalty tracking agent"
  # }
  # 
  # daisy_legal = {
  #   template = "adk_base"
  #   port     = 8509
  #   enabled  = false
  #   description = "Legal compliance and contract management agent"
  # }
  # 
  # daisy_financial = {
  #   template = "adk_base"
  #   port     = 8510
  #   enabled  = false
  #   description = "Financial planning and forecasting agent"
  # }
  # 
  # daisy_audience = {
  #   template = "adk_base"
  #   port     = 8511
  #   enabled  = false
  #   description = "Audience analysis and fan behavior tracking agent"
  # }
} 