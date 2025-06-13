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
  daisy-knowledge = {
    template = "agentic_rag"
    port     = 8502
    enabled  = true
    description = "Knowledge Management & RAG Agent for music industry expertise"
  }
  
  # Phase 1 - Additional agents (to be enabled next)
  # daisy_maestro = {
  #   template = "langgraph_base_react"
  #   port     = 8501
  #   enabled  = false
  #   description = "Central orchestrator and task routing agent"
  # }
  
  # Phase 2: Core Business Logic Agents (to be created)
  # daisy_insights = {
  #   template = "custom_analytics"
  #   port     = 8503
  #   enabled  = false
  #   description = "Analytics and insights generation agent"
  # }
  # daisy_content = {
  #   template = "content_generation"
  #   port     = 8504
  #   enabled  = false
  #   description = "Content creation and management agent"
  # }
  # daisy_social = {
  #   template = "social_media"
  #   port     = 8505
  #   enabled  = false
  #   description = "Social media management and engagement agent"
  # }
  # daisy_trends = {
  #   template = "trend_analysis"
  #   port     = 8506
  #   enabled  = false
  #   description = "Market and trend analysis agent"
  # }
  # daisy_collab = {
  #   template = "collaboration"
  #   port     = 8507
  #   enabled  = false
  #   description = "Collaboration and workflow management agent"
  # }
  
  # Phase 3: Specialized Agents (to be created)
  # daisy_playlist = {
  #   template = "music_curation"
  #   port     = 8508
  #   enabled  = false
  #   description = "Playlist creation and music curation agent"
  # }
  # daisy_discovery = {
  #   template = "music_discovery"
  #   port     = 8509
  #   enabled  = false
  #   description = "Music and artist discovery agent"
  # }
  # daisy_events = {
  #   template = "event_management"
  #   port     = 8510
  #   enabled  = false
  #   description = "Event planning and management agent"
  # }
  # daisy_rights = {
  #   template = "rights_management"
  #   port     = 8511
  #   enabled  = false
  #   description = "Rights and licensing management agent"
  # }
} 