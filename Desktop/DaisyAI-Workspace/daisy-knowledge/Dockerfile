# Use Python 3.12 as base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install uv for fast Python package management
RUN pip install uv

# Copy dependency files
COPY pyproject.toml uv.lock ./

# Install dependencies
RUN uv sync --frozen

# Copy application code
COPY app/ ./app/
COPY *.py ./

# Set environment variables
ENV PYTHONPATH=/app
ENV GOOGLE_GENAI_USE_VERTEXAI=True

# Expose the port (Cloud Run will set PORT automatically)
EXPOSE 8080

# Run the application
CMD ["uv", "run", "python", "-m", "app.agent_engine_app"] 