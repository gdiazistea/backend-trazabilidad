from sqlmodel import SQLModel, create_engine, Session
from app.core.config import settings

# Armamos la URL con el esquema como opción de PostgreSQL
DATABASE_URL = (
    f"postgresql://{settings.DB_USER}:{settings.DB_PASSWORD}"
    f"@{settings.DB_HOST}:{settings.DB_PORT}/{settings.DB_NAME}"
    f"?options=-csearch_path%3D{settings.DB_SCHEMA}"
)

# Creamos el engine con SQLAlchemy
engine = create_engine(DATABASE_URL, echo=True)

# Función para obtener una sesión
def get_session() -> Session:
    with Session(engine) as session:
        yield session

# Función para inicializar la base de datos (crear tablas)
def init_db():
    SQLModel.metadata.create_all(engine)

# Si ejecutás este archivo directamente, se crean las tablas
if __name__ == "__main__":
    init_db()
    print("Base de datos inicializada correctamente.")
