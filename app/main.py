# app/main.py
from fastapi import FastAPI
from app.api.routes import router

app = FastAPI(title="API de Trazabilidad de Producto-Política")

app.include_router(router, prefix="/api")
