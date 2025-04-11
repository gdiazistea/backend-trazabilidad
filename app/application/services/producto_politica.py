# app/application/services/producto_politica.py

from app.infrastructure.repositories.producto_politica import (
    producto_politica_repository
)
from app.domain.models.producto_politica import ProductoPolitica
from app.application.services.base import (
    get_all_service, get_by_id_service, upsert_service
)

obtener_todas_las_politicas = get_all_service(producto_politica_repository.get_all)
obtener_politica_por_id = get_by_id_service(producto_politica_repository.get_by_id)
guardar_o_actualizar_politica = upsert_service(
    producto_politica_repository.get_by_id, ProductoPolitica
)
