
# 🧬 API de Trazabilidad de Productos

Este proyecto implementa una API REST utilizando **FastAPI**, **SQLModel** y **PostgreSQL** para exponer los datos de productos y sus políticas de precios y rendimiento. Está pensado para sistemas de trazabilidad y análisis en entornos productivos.

---

## 📁 Estructura del Proyecto

```bash
.
├── app/
│   ├── core/              # Configuración y conexión a la base de datos
│   │   ├── config.py
│   │   └── database.py
│   ├── domain/            # Modelos de datos (SQLModel)
│   │   └── producto_politica.py
│   ├── routers/           # Endpoints de la API
│   │   └── producto_politica.py
│   ├── main.py            # Punto de entrada de la API
├── requirements.txt
└── README.md
```

---

## ⚙️ Requisitos

- Python 3.10+
- PostgreSQL
- `virtualenv` o `pipenv`
- FastAPI, SQLModel, psycopg2

---

## 🚀 Instalación y Ejecución

```bash
# Crear entorno virtual
python -m venv .venv
source .venv/bin/activate  # En Windows: .venv\Scripts\activate

# Instalar dependencias
pip install -r requirements.txt

# Ejecutar la API
uvicorn app.main:app --reload
```

---

## 🔐 Variables de Entorno

Crear un archivo `.env` con:

```env
DB_USER=usuario
DB_PASSWORD=contraseña
DB_HOST=localhost
DB_PORT=5432
DB_NAME=nombre_basededatos
DB_SCHEMA=odp
```

La configuración se carga automáticamente desde `app/core/config.py`.

---

## 🧠 Arquitectura

Este proyecto sigue una **arquitectura inspirada en hexagonal**, separando claramente:

- **Infraestructura (core)**: conexión y configuración.
- **Dominio**: modelos que representan tus tablas.
- **Aplicación (routers)**: lógica y exposición de endpoints.

---

## 📡 Endpoints

Una vez ejecutada la API, accedé a la documentación en:

- Swagger UI: [http://localhost:8000/docs](http://localhost:8000/docs)
- ReDoc: [http://localhost:8000/redoc](http://localhost:8000/redoc)
