# 🚀 DaisyAI Agent Starter Pack CI/CD Integration Plan

## 📋 Current Status Analysis

### ✅ What We Have Working:
1. **Agent Starter Pack Infrastructure**: All 3 agents deployed (Knowledge, Voice, Specialized)
2. **Vertex AI Search**: 1.4MB of content uploaded and ready for ingestion
3. **GitHub Repository**: Connected to `https://github.com/tiborknowles/Daisy.git`
4. **Cloud Build**: `cloudbuild.yaml` configured for containerized deployments
5. **3-Tier GCP Projects**: Development, Staging, Production

### ⚠️ Integration Issues Identified:
1. **Embedded Git Repository**: `agent-starter-pack/` has its own .git (needs submodule setup)
2. **CI/CD Scope**: Current `cloudbuild.yaml` only builds website, not agents
3. **Auto-Sync**: No automatic GitHub sync for Agent Starter Pack changes

## 🎯 RECOMMENDED SOLUTION: Unified Agent Starter Pack CI/CD

### **Strategy 1: Convert to Git Submodule (RECOMMENDED)**

```bash
# Remove embedded repo and add as submodule
git rm --cached agent-starter-pack
git submodule add https://github.com/tiborknowles/daisy-agent-starter-pack.git agent-starter-pack
git commit -m "Convert agent-starter-pack to submodule"
```

### **Strategy 2: Enhanced Cloud Build for Multi-Agent Deployment**

Create comprehensive `cloudbuild-agents.yaml`:

```yaml
steps:
  # Step 1: Deploy Knowledge Agent
  - name: 'gcr.io/cloud-builders/gcloud'
    dir: 'agent-starter-pack/daisy-knowledge'
    args: ['run', 'deploy', 'daisy-knowledge', '--source', '.', '--region', 'us-central1']
    id: 'deploy-knowledge-agent'

  # Step 2: Deploy Voice Agent  
  - name: 'gcr.io/cloud-builders/gcloud'
    dir: 'agent-starter-pack/daisy-voice'
    args: ['run', 'deploy', 'daisy-voice', '--source', '.', '--region', 'us-central1']
    id: 'deploy-voice-agent'

  # Step 3: Deploy Specialized Agent
  - name: 'gcr.io/cloud-builders/gcloud'
    dir: 'agent-starter-pack/daisy-specialized'
    args: ['run', 'deploy', 'daisy-specialized', '--source', '.', '--region', 'us-central1']
    id: 'deploy-specialized-agent'

  # Step 4: Run Data Ingestion
  - name: 'python:3.12'
    script: |
      cd agent-starter-pack/daisy-knowledge
      pip install -r requirements.txt
      python ../../simple_vertex_search_ingestion.py
    id: 'data-ingestion'
    waitFor: ['deploy-knowledge-agent']
```

### **Strategy 3: GitHub Actions Integration**

Create `.github/workflows/deploy-agents.yml`:

```yaml
name: Deploy DaisyAI Agents
on:
  push:
    branches: [main]
    paths: ['agent-starter-pack/**']

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
      with:
        submodules: recursive
    
    - name: Setup Google Cloud
      uses: google-github-actions/setup-gcloud@v1
      with:
        project_id: ${{ secrets.GCP_PROJECT_ID }}
        service_account_key: ${{ secrets.GCP_SA_KEY }}
    
    - name: Deploy All Agents
      run: |
        cd agent-starter-pack
        for agent in daisy-knowledge daisy-voice daisy-specialized; do
          cd $agent && make backend && cd ..
        done
```

## 🔄 AUTO-SYNC IMPLEMENTATION

### **Option 1: Git Hooks (Local Auto-Sync)**
```bash
# Create post-commit hook
echo '#!/bin/bash
git push origin main
cd agent-starter-pack && git push origin main
' > .git/hooks/post-commit
chmod +x .git/hooks/post-commit
```

### **Option 2: Cron-Based Sync**
```bash
# Add to crontab for auto-sync every hour
*/30 * * * * cd /Users/tibor.knowles/Desktop/Daisy/OntologyV2 && git add . && git commit -m "Auto-sync $(date)" && git push origin main
```

### **Option 3: Agent Starter Pack Native CI/CD**
```bash
# Use Agent Starter Pack's built-in CI/CD
cd agent-starter-pack
uvx agent-starter-pack setup-cicd --github-repo=tiborknowles/Daisy
```

## 📊 RECOMMENDED IMMEDIATE ACTIONS

### **Phase 1: Fix Git Integration (IMMEDIATE)**
1. **Convert embedded repo to submodule**
2. **Update .gitignore for clean commits**
3. **Create dedicated agent deployment pipeline**

### **Phase 2: Enhanced CI/CD (THIS WEEK)**
1. **Create multi-agent Cloud Build configuration**
2. **Setup GitHub Actions for automatic deployment**
3. **Configure branch-based deployments (dev/staging/prod)**

### **Phase 3: Full Automation (NEXT WEEK)**
1. **Auto-sync data ingestion on content changes**
2. **Automated testing for all agent deployments**
3. **Monitoring and alerting integration**

## 🎯 EXPECTED BENEFITS

✅ **Automatic GitHub Sync**: Every change auto-commits and pushes
✅ **Multi-Agent Deployment**: All 3 agents deploy together
✅ **Data Pipeline Integration**: Vertex AI Search updates automatically
✅ **100% Google Native**: No custom infrastructure to maintain
✅ **Branch-Based Environments**: Separate dev/staging/prod deployments

## 🚀 NEXT STEPS

**Would you like me to implement:**
1. **Git submodule conversion** (5 minutes)
2. **Enhanced Cloud Build setup** (10 minutes)  
3. **GitHub Actions automation** (15 minutes)
4. **Full auto-sync configuration** (20 minutes)

All options maintain 100% Google Agent Starter Pack compliance while adding robust CI/CD automation! 