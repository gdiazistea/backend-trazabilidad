# Acá se maneja la lógica de acceso a datos (query con SQLModel o SQLAlchemy).
from sqlmodel import Session, select
from app.domain.models.producto_politica import ProductoPolitica

def get_all_producto_politica(session: Session):
    statement = select(ProductoPolitica)
    return session.exec(statement).all()
