import psycopg2

# Parámetros de conexión
conn_params = {
    "dbname": "modelo_optimizacion",
    "user": "postgres",
    "password": "1234",
    "host": "10.255.255.0",
    "port": "5432"
}

try:
    # Establecer conexión
    conn = psycopg2.connect(**conn_params)
    cursor = conn.cursor()

    # Ejecutar una consulta de prueba
    cursor.execute("SELECT version();")
    version = cursor.fetchone()
    print("✅ Conexión exitosa. Versión de PostgreSQL:", version)

    # Cerrar conexión
    cursor.close()
    conn.close()

except psycopg2.Error as e:
    print("❌ Error al conectar con la base de datos:")
    print(e)
