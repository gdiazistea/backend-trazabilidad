
from pydantic import BaseModel
from datetime import datetime
from typing import Optional


class ProductoPoliticaBase(BaseModel):
    fk_politica: int
    fk_producto: int
    fk_destino_costo: int
    fk_especificacion_producto: int
    rendimiento_media_res: float
    precio_venta_free_on_board_usd_ton: float
    precio_venta_free_on_track_ars_kg: float
    precio_venta_cost_insurance_freight_usd_ton: float
    precio_recupero_subproducto_ars_kg: float
    fl_aplica_costo_congelado: bool
    costo_madurado_congelado_ars_kg: float

    class Config:
        from_attributes = True


class ProductoPoliticaRead(ProductoPoliticaBase):
    last_update: datetime


class ProductoPoliticaUpsert(ProductoPoliticaBase):
    last_update: Optional[datetime] = None  # Puede omitirse si se genera en la BD
