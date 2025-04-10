from fastapi import APIRouter, Depends
from sqlmodel import Session
from app.domain.schemas.producto_politica import ProductoPoliticaRead
from app.application.services.producto_politica import obtener_todas_las_politicas
from app.core.database import get_session

router = APIRouter(prefix="/producto_politica", tags=["producto_politica"])

@router.get("/", response_model=list[ProductoPoliticaRead])
def listar_producto_politica(session: Session = Depends(get_session)):
    return obtener_todas_las_politicas(session)


