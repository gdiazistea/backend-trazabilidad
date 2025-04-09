from sqlalchemy import Column, Integer, BigInteger, DECIMAL, Boolean, TIMESTAMP, ForeignKey, Table, MetaData

metadata = MetaData()

producto_politica = Table(
    "PRODUCTO_POLITICA", metadata,
    Column("FK_POLITICA", Integer, primary_key=True),
    Column("FK_PRODUCTO", Integer, primary_key=True),
    Column("FK_DESTINO_COSTO", Integer, nullable=False),
    Column("FK_ESPECIFICACION_PRODUCTO", BigInteger, nullable=False, default=0),
    Column("RENDIMIENTO_MEDIA_RES", DECIMAL(6, 4)),
    Column("PRECIO_VENTA_FREE_ON_BOARD_USD_TON", DECIMAL(40, 20), nullable=False, default=0),
    Column("PRECIO_VENTA_FREE_ON_TRACK_ARS_KG", DECIMAL(40, 20), nullable=False, default=0),
    Column("PRECIO_VENTA_COST_INSURANCE_FREIGHT_USD_TON", DECIMAL(40, 20), nullable=False, default=0),
    Column("PRECIO_RECUPERO_SUBPRODUCTO_ARS_KG", DECIMAL(40, 20), nullable=False, default=0),
    Column("FL_APLICA_COSTO_CONGELADO", Boolean, nullable=False, default=False),
    Column("COSTO_MADURADO_CONGELADO_ARS_KG", DECIMAL(40, 20), nullable=False, default=0),
    Column("LAST_UPDATE", TIMESTAMP)
)
