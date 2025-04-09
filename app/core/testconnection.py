from sqlalchemy import create_engine
from sqlalchemy.exc import OperationalError
from dotenv import load_dotenv
import os

# Cargar variables del .env
load_dotenv()

# Obtener la URL de conexión
DATABASE_URL = os.getenv("DATABASE_URL")

# Crear el engine
engine = create_engine(DATABASE_URL)

# Intentar conectarse
try:
    with engine.connect() as connection:
        result = connection.execute("SELECT 1")
        print("✅ Conexión exitosa a la base de datos.")
except OperationalError as e:
    print("❌ Error al conectar con la base de datos:")
    print(e)
