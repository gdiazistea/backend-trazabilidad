from sqlmodel import Session
from app.domain.models.producto_politica import ProductoPolitica
from app.infrastructure.repositories.base import BaseRepository

producto_politica_repository = BaseRepository(ProductoPolitica)

# Podés usar:
# producto_politica_repository.get_all(session)
# producto_politica_repository.get_by_id(session, 1)
