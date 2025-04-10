from fastapi import APIRouter, Depends
from sqlmodel import Session
from app.core.database import get_session
from app.application.services import obtener_todo_producto_politica
from app.domain.schemas import ProductoPoliticaRead
from typing import List

router = APIRouter()

@router.get("/producto_politica", response_model=List[ProductoPoliticaRead])
def get_producto_politica(session: Session = Depends(get_session)):
    return obtener_todo_producto_politica(session)
