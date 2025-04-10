from sqlmodel import SQLModel, Field
from typing import Optional
from datetime import datetime

class ProductoPolitica(SQLModel, table=True):
    fk_politica: int = Field(primary_key=True)
    fk_producto: int = Field(primary_key=True)
    fk_destino_costo: int
    fk_especificacion_producto: Optional[int] = 0
    rendimiento_media_res: Optional[float]
    precio_venta_free_on_board_usd_ton: float = 0
    precio_venta_free_on_track_ars_kg: float = 0
    precio_venta_cost_insurance_freight_usd_ton: float = 0
    precio_recupero_subproducto_ars_kg: float = 0
    fl_aplica_costo_congelado: bool = False
    costo_madurado_congelado_ars_kg: float = 0
    last_update: Optional[datetime] = None
