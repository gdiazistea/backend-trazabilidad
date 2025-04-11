# app/application/routers/producto_politica.py
from app.application.routers.base import create_base_router
from app.application.services.producto_politica import (
    obtener_todas_las_politicas,
    obtener_politica_por_id,
    guardar_o_actualizar_politica
)
from app.domain.schemas.producto_politica import ProductoPoliticaRead, ProductoPoliticaUpsert


router = create_base_router(
    prefix="/producto_politica",
    tag="producto_politica",
    response_model=ProductoPoliticaRead,
    schema_in=ProductoPoliticaUpsert,
    service_get_all=obtener_todas_las_politicas,
    # service_get_by_id=obtener_politica_por_id,
    service_upsert=guardar_o_actualizar_politica
)
