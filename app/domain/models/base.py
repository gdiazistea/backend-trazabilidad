from sqlmodel import SQLModel
from app.core.config import settings

class BaseModel(SQLModel):
    __abstract__ = True  # evita que SQLModel lo cree como tabla
    __table_args__ = {"schema": settings.DB_SCHEMA}
