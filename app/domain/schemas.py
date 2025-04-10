from pydantic import BaseModel, ConfigDict
from typing import Optional
from datetime import datetime

class ProductoPoliticaRead(BaseModel):
    fk_politica: int
    fk_producto: int
    fk_destino_costo: int
    fk_especificacion_producto: Optional[int]
    rendimiento_media_res: Optional[float]
    precio_venta_free_on_board_usd_ton: float
    precio_venta_free_on_track_ars_kg: float
    precio_venta_cost_insurance_freight_usd_ton: float
    precio_recupero_subproducto_ars_kg: float
    fl_aplica_costo_congelado: bool
    costo_madurado_congelado_ars_kg: float
    last_update: Optional[datetime]

    model_config = ConfigDict(from_attributes=True)
