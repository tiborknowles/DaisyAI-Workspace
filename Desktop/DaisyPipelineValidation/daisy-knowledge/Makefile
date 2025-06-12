# DaisyAI Knowledge Agent Makefile
# ASP 0.5.2 Compliant

.PHONY: help playground test lint format install clean

help: ## Show this help message
	@echo "DaisyAI Knowledge Agent - Available commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

playground: ## Start the agent playground
	@echo "==============================================================================="
	@echo "| 🚀 Starting your agent playground...                                        |"
	@echo "|                                                                             |"
	@echo "| 💡 Try asking: How to save a pandas dataframe to CSV?                       |"
	@echo "|                                                                             |"
	@echo "| 🔍 IMPORTANT: Select the 'app' folder to interact with your agent.          |"
	@echo "==============================================================================="
	uv run adk web --port 8501

install: ## Install dependencies
	uv sync

test: ## Run tests
	uv run pytest tests/ -v

lint: ## Run linting
	uv run flake8 app/
	uv run mypy app/

format: ## Format code
	uv run black app/

clean: ## Clean temporary files
	find . -type d -name "__pycache__" -delete
	find . -type f -name "*.pyc" -delete
	find . -type d -name ".pytest_cache" -delete

dev-setup: install ## Set up development environment
	@echo "🔧 Development environment ready!"
	@echo "💡 Run 'make playground' to start testing your agent"

deploy-staging: ## Deploy to staging environment
	@echo "🚀 Deploying to staging..."
	# Add your staging deployment commands here

deploy-prod: ## Deploy to production environment  
	@echo "🚀 Deploying to production..."
	# Add your production deployment commands here 