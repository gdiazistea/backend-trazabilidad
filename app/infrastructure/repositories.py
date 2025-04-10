from sqlmodel import Session, select
from app.domain.models import ProductoPolitica

def get_all_producto_politica(session: Session):
    query = select(ProductoPolitica)
    return session.exec(query).all()
