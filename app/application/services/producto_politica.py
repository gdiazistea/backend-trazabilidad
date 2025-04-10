from app.infrastructure.repositories.producto_politica import get_all_producto_politica
from sqlmodel import Session

def obtener_todas_las_politicas(session: Session):
    return get_all_producto_politica(session)
