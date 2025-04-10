from typing import List
from sqlmodel import Session
from app.domain.schemas import ProductoPoliticaRead
from app.infrastructure.repositories import get_all_producto_politica

def obtener_todo_producto_politica(session: Session) -> List[ProductoPoliticaRead]:
    items = get_all_producto_politica(session)
    return [ProductoPoliticaRead.model_validate(item) for item in items]

