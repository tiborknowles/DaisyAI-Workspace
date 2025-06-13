# DaisyAI Central Agents Configuration
# This file contains the definitive map of all 11 DaisyAI agents
# Each agent entry will be added as we onboard them following the Golden Path workflow

# CLEAN SLATE: Ready for Golden Path onboarding
# Agents will be added one by one following the exact ASP 0.5.2 workflow:
# 1. agent-starter-pack create [agent_name] --template=[template]
# 2. cd [agent_name] && make install && make playground
# 3. Add agent entry to this file
# 4. Git commit and push to trigger CI/CD

agents = {
  # All agents will be added here following the Golden Path workflow
  # Format for each agent:
  # agent_name = {
  #   template = "asp_template_name"
  #   port     = unique_port_number
  #   enabled  = true
  #   description = "Agent description"
  # }
} 