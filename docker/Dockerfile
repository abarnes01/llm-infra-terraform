FROM python:3.11-slim

WORKDIR /app

# Install runtime deps
RUN pip install --no-cache-dir fastapi "uvicorn[standard]" pydantic

# Copy app code
COPY app /app

# Set defaults
ENV MODEL_NAME="llama-3.1-tiny" \
    RESPONSE_TEMPERATURE="0.7" \
    PORT=8000

EXPOSE 8000

# Run server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
