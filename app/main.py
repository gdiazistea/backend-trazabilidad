from fastapi import FastAPI
from app.application.routers import producto_politica

app = FastAPI()

@app.get("/")
def root():
    return {"message": "API activa"}

app.include_router(producto_politica.router, prefix="/producto-politica")
