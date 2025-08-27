from fastapi import FastAPI
from pydantic import BaseModel
import os
import random

MODEL_NAME = os.getenv("MODEL_NAME", "llama-3.1-tiny")
TEMPERATURE = float(os.getenv("RESPONSE_TEMPERATURE", "0.7"))

app = FastAPI(title="LLM Demo Service")

class InferRequest(BaseModel):
    prompt: str

@app.get("/health")
def health():
    return {"status": "ok", "model": MODEL_NAME, "temperature": TEMPERATURE}

@app.post("/infer")
def infer(req: InferRequest):
    words = req.prompt.split()
    output = " ".join(reversed(words))
    if random.random() < TEMPERATURE:
        output += " 🤖"
    return {
        "model": MODEL_NAME,
        "input_tokens": len(words),
        "output": output
    }
