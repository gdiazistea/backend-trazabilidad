# app/models/producto_politica.py
from sqlalchemy import Column, Integer, BigInteger, DECIMAL, Boolean, TIMESTAMP, ForeignKey, CheckConstraint, func
from app.models.base import Base

class ProductoPolitica(Base):
    __tablename__ = 'PRODUCTO_POLITICA'
    __table_args__ = {'schema': 'modelo_optimizacion.odp'}

    FK_POLITICA = Column(Integer, ForeignKey("modelo_optimizacion.odp.POLITICA.PK_POLITICA"), primary_key=True)
    FK_PRODUCTO = Column(Integer, ForeignKey("modelo_optimizacion.odp.PRODUCTO.PK_PRODUCTO"), primary_key=True)
    FK_DESTINO_COSTO = Column(Integer, ForeignKey("modelo_optimizacion.odp.DESTINO.PK_DESTINO"), nullable=False)
    FK_ESPECIFICACION_PRODUCTO = Column(BigInteger, default=0)
    RENDIMIENTO_MEDIA_RES = Column(DECIMAL(6, 4), CheckConstraint("RENDIMIENTO_MEDIA_RES BETWEEN 0 AND 1"))
    PRECIO_VENTA_FREE_ON_BOARD_USD_TON = Column(DECIMAL(40, 20), nullable=False, default=0)
    PRECIO_VENTA_FREE_ON_TRACK_ARS_KG = Column(DECIMAL(40, 20), nullable=False, default=0)
    PRECIO_VENTA_COST_INSURANCE_FREIGHT_USD_TON = Column(DECIMAL(40, 20), nullable=False, default=0)
    PRECIO_RECUPERO_SUBPRODUCTO_ARS_KG = Column(DECIMAL(40, 20), nullable=False, default=0)
    FL_APLICA_COSTO_CONGELADO = Column(Boolean, nullable=False, default=False)
    COSTO_MADURADO_CONGELADO_ARS_KG = Column(DECIMAL(40, 20), nullable=False, default=0)
    LAST_UPDATE = Column(TIMESTAMP, server_default=func.current_timestamp(), onupdate=func.current_timestamp())
