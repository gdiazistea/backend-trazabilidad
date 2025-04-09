from fastapi import FastAPI
from app.api.endpoints import maestro

app = FastAPI()

app.include_router(maestro.router, prefix="/api", tags=["Maestro"])
