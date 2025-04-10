# app/schemas/producto_politica.py
from decimal import Decimal
from app.schemas.base import BaseSchema
from typing import Optional
from datetime import datetime

class ProductoPoliticaCreate(BaseSchema):
    FK_POLITICA: int
    FK_PRODUCTO: int
    FK_DESTINO_COSTO: int
    FK_ESPECIFICACION_PRODUCTO: int = 0
    RENDIMIENTO_MEDIA_RES: Optional[Decimal]
    PRECIO_VENTA_FREE_ON_BOARD_USD_TON: Decimal
    PRECIO_VENTA_FREE_ON_TRACK_ARS_KG: Decimal
    PRECIO_VENTA_COST_INSURANCE_FREIGHT_USD_TON: Decimal
    PRECIO_RECUPERO_SUBPRODUCTO_ARS_KG: Decimal
    FL_APLICA_COSTO_CONGELADO: bool
    COSTO_MADURADO_CONGELADO_ARS_KG: Decimal

class ProductoPoliticaOut(ProductoPoliticaCreate):
    LAST_UPDATE: Optional[datetime]
