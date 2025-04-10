from sqlmodel import Field
from app.domain.models.base import BaseModel
from typing import Optional
from datetime import datetime

class ProductoPolitica(BaseModel, table=True):
    __tablename__ = "producto_politica"

    fk_politica: int = Field(primary_key=True)
    fk_producto: int = Field(primary_key=True)
    fk_destino_costo: Optional[int] = Field(default=None)
    fk_especificacion_producto: Optional[int] = Field(default=None)
    rendimiento_media_res: Optional[float] = Field(default=None)
    precio_venta_free_on_board_usd_ton: Optional[float] = Field(default=None)
    precio_venta_free_on_track_ars_kg: Optional[float] = Field(default=None)
    precio_venta_cost_insurance_freight_usd_ton: Optional[float] = Field(default=None)
    precio_recupero_subproducto_ars_kg: Optional[float] = Field(default=None)
    fl_aplica_costo_congelado: Optional[bool] = Field(default=None)
    costo_madurado_congelado_ars_kg: Optional[float] = Field(default=None)
    last_update: Optional[datetime] = Field(default=None)

