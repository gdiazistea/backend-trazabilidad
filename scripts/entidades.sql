CREATE DATABASE "modelo_optimizacion";
DROP SCHEMA IF EXISTS modelo_optimizacion;
CREATE SCHEMA modelo_optimizacion;

----------------- TRIGGERS ------------------------------
-- Crear la función que actualizará LAST_UPDATE
DROP FUNCTION IF EXISTS modelo_optimizacion.odp.update_last_update_column;
CREATE OR REPLACE FUNCTION modelo_optimizacion.odp.update_last_update_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_update = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

---------------------------- ENTIDADES ------------------
--------------------------- ENTIDAD CUARTO ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.CUARTO;
CREATE TABLE modelo_optimizacion.odp.CUARTO (
    PK_CUARTO INT PRIMARY KEY,
    NOMBRE_CUARTO VARCHAR(100) NOT NULL,
    DESCRIPCION VARCHAR(255) DEFAULT 'SIN ASIGNAR',
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
COMMENT ON TABLE modelo_optimizacion.odp.CUARTO IS 'Tabla que almacena la información de los cuartos en los que se puede faenar un animal';
COMMENT ON COLUMN modelo_optimizacion.odp.CUARTO.PK_CUARTO IS 'Identificador único del cuarto';
COMMENT ON COLUMN modelo_optimizacion.odp.CUARTO.NOMBRE_CUARTO IS 'Nombre o identificador textual del cuarto';
COMMENT ON COLUMN modelo_optimizacion.odp.CUARTO.DESCRIPCION IS 'Descripción detallada del cuarto';
COMMENT ON COLUMN modelo_optimizacion.odp.CUARTO.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

CREATE TRIGGER trigger_update_cuarto_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.CUARTO
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_cuarto_last_update ON modelo_optimizacion.odp.CUARTO 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial records   
INSERT INTO modelo_optimizacion.odp.CUARTO  (PK_CUARTO, NOMBRE_CUARTO, DESCRIPCION, LAST_UPDATE)
VALUES (0, 'SIN ASIGNAR', 'SIN ASIGNAR', '2024-10-24'),
(1, 'ASADO', 'ASADO', '2024-10-24'),
(2, 'PECHO', 'PECHO', '2024-10-24'),
(3, 'RAL,RUMP & LOINS', 'RAL,RUMP & LOINS', '2024-10-24'),
(4, 'RUEDA', 'RUEDA', '2024-10-24'),
(5, 'MEDIA RES', 'MEDIA RES ENTERA', '2024-10-24');

ALTER TABLE modelo_optimizacion.odp.CUARTO ALTER COLUMN pk_cuarto DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.CUARTO ALTER COLUMN pk_cuarto ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.CUARTO', 'pk_cuarto'), 
    (SELECT MAX(pk_cuarto) FROM modelo_optimizacion.odp.CUARTO), 
    true
);
--------------------------- ENTIDAD GRADO_CALIDAD_HACIENDA ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA;
CREATE TABLE modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA (
    PK_GRADO_CALIDAD_HACIENDA INT PRIMARY KEY,
    NOMBRE_GRADO_CALIDAD VARCHAR(100) NOT NULL,
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA IS 'Tabla que almacena la información de los grados de calidad de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA.PK_GRADO_CALIDAD_HACIENDA IS 'Identificador único del grado de calidad de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA.NOMBRE_GRADO_CALIDAD IS 'Nombre del grado de calidad de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_grado_calidad_hacienda_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_grado_calidad_hacienda_last_update ON modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial records
INSERT INTO odp.grado_calidad_hacienda (pk_grado_calidad_hacienda, nombre_grado_calidad, last_update) VALUES(0, 'SIN ASIGNAR', '2025-04-07 18:42:38.125');
INSERT INTO odp.grado_calidad_hacienda (pk_grado_calidad_hacienda, nombre_grado_calidad, last_update) VALUES(1, 'STANDARD', '2025-04-07 18:42:38.125');
INSERT INTO odp.grado_calidad_hacienda (pk_grado_calidad_hacienda, nombre_grado_calidad, last_update) VALUES(2, 'BLACK', '2025-04-07 18:42:38.125');
INSERT INTO odp.grado_calidad_hacienda (pk_grado_calidad_hacienda, nombre_grado_calidad, last_update) VALUES(3, 'BLUE', '2025-04-07 18:42:38.125');
INSERT INTO odp.grado_calidad_hacienda (pk_grado_calidad_hacienda, nombre_grado_calidad, last_update) VALUES(4, 'AMARILLA', '2025-04-07 18:42:38.125');
INSERT INTO odp.grado_calidad_hacienda (pk_grado_calidad_hacienda, nombre_grado_calidad, last_update) VALUES(5, 'BLANCA', '2025-04-07 18:42:38.125');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA ALTER COLUMN pk_grado_calidad_hacienda DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA ALTER COLUMN pk_grado_calidad_hacienda ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA', 'pk_grado_calidad_hacienda'), 
    (SELECT MAX(pk_grado_calidad_hacienda) FROM modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA), 
    true
);

--------------------------- ENTIDAD MADUREZ_ANIMAL ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.MADUREZ_ANIMAL;
CREATE TABLE modelo_optimizacion.odp.MADUREZ_ANIMAL (
    PK_MADUREZ_ANIMAL INT PRIMARY KEY,
    NOMBRE_MADUREZ VARCHAR(100) NOT NULL,
    DESCRIPCION VARCHAR(255) DEFAULT 'SIN ASIGNAR',
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.MADUREZ_ANIMAL IS 'Tabla que almacena la información de los niveles de madurez del animal';
COMMENT ON COLUMN modelo_optimizacion.odp.MADUREZ_ANIMAL.PK_MADUREZ_ANIMAL IS 'Identificador único del nivel de madurez';
COMMENT ON COLUMN modelo_optimizacion.odp.MADUREZ_ANIMAL.NOMBRE_MADUREZ IS 'Nombre del nivel de madurez del animal';
COMMENT ON COLUMN modelo_optimizacion.odp.MADUREZ_ANIMAL.DESCRIPCION IS 'Descripción detallada del nivel de madurez';
COMMENT ON COLUMN modelo_optimizacion.odp.MADUREZ_ANIMAL.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_madurez_animal_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.MADUREZ_ANIMAL
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_madurez_animal_last_update ON modelo_optimizacion.odp.MADUREZ_ANIMAL 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial records
INSERT INTO odp.madurez_animal (pk_madurez_animal, nombre_madurez, descripcion, last_update) VALUES(0, 'SIN ASIGNAR', 'SIN ASIGNAR', '2025-04-07 18:42:38.016');
INSERT INTO odp.madurez_animal (pk_madurez_animal, nombre_madurez, descripcion, last_update) VALUES(1, 'TERNERO', 'Tiene menos de un año de edad, generalmente entre 6 y 12 meses. A veces se considera que un animal es ternero hasta los 15 meses de edad.', '2025-04-07 18:42:38.016');
INSERT INTO odp.madurez_animal (pk_madurez_animal, nombre_madurez, descripcion, last_update) VALUES(2, 'NOVILLO', 'Según el Senasa, antes de los dos años de edad, se lo considera novillito, mientras que al pasar esa edad se lo conoce como novillo.', '2025-04-07 18:42:38.016');
INSERT INTO odp.madurez_animal (pk_madurez_animal, nombre_madurez, descripcion, last_update) VALUES(3, 'VACA', 'El SENASA define a una vaca como una hembra bovina que ha parido al menos una vez.', '2025-04-07 18:42:38.016');
INSERT INTO odp.madurez_animal (pk_madurez_animal, nombre_madurez, descripcion, last_update) VALUES(4, 'VAQUILLONA', 'El SENASA define a las vaquillonas como hembras bovinas jóvenes que aún no han parido, pero que están en condiciones de ser madres.', '2025-04-07 18:42:38.016');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.MADUREZ_ANIMAL ALTER COLUMN pk_madurez_animal DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.MADUREZ_ANIMAL ALTER COLUMN pk_madurez_animal ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.MADUREZ_ANIMAL', 'pk_madurez_animal'), 
    (SELECT MAX(pk_madurez_animal) FROM modelo_optimizacion.odp.MADUREZ_ANIMAL), 
    true
);
--------------------------- ENTIDAD TIPO_ANIMAL ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.TIPO_ANIMAL;
CREATE TABLE modelo_optimizacion.odp.TIPO_ANIMAL (
    PK_TIPO_ANIMAL INT PRIMARY KEY,
    NOMBRE_TIPO_ANIMAL VARCHAR(100) NOT NULL,
    ABREVIACION VARCHAR(50) NOT NULL,
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.TIPO_ANIMAL IS 'Tabla que almacena la información de los tipos de animales que se pueden comprar o contar en haciendas propias';
COMMENT ON COLUMN modelo_optimizacion.odp.TIPO_ANIMAL.PK_TIPO_ANIMAL IS 'Identificador único del tipo de animal';
COMMENT ON COLUMN modelo_optimizacion.odp.TIPO_ANIMAL.NOMBRE_TIPO_ANIMAL IS 'Nombre del tipo de animal';
COMMENT ON COLUMN modelo_optimizacion.odp.TIPO_ANIMAL.ABREVIACION IS 'Abreviación del tipo de animal. Coincide con el nombre de web hacienda.';
COMMENT ON COLUMN modelo_optimizacion.odp.TIPO_ANIMAL.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_tipo_animal_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.TIPO_ANIMAL
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_tipo_animal_last_update ON modelo_optimizacion.odp.TIPO_ANIMAL 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial records
INSERT INTO modelo_optimizacion.odp.TIPO_ANIMAL 
(PK_TIPO_ANIMAL, NOMBRE_TIPO_ANIMAL, ABREVIACION)
VALUES 
    (0, 'SIN ASIGNAR', 'SIN ASIGNAR'),
    (1, 'NOVILLO ESPECIAL', 'NO E.'),
    (2, 'VAQUILLONA ESPECIAL', 'VQ E.'),
    (3, 'VACA', 'VACA'),
    (4, 'NOVILLO STANDARD', 'NO STD');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.TIPO_ANIMAL ALTER COLUMN pk_tipo_animal DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.TIPO_ANIMAL ALTER COLUMN pk_tipo_animal ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.TIPO_ANIMAL', 'pk_tipo_animal'), 
    (SELECT MAX(pk_tipo_animal) FROM modelo_optimizacion.odp.TIPO_ANIMAL), 
    true
);
--------------------------- ENTIDAD CATEGORIA_HACIENDA ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.CATEGORIA_HACIENDA;
CREATE TABLE modelo_optimizacion.odp.CATEGORIA_HACIENDA (
    PK_CATEGORIA_HACIENDA INT PRIMARY KEY,
    NOMBRE_CATEGORIA VARCHAR(100) NOT NULL,
    DESCRIPCION VARCHAR(255) DEFAULT 'SIN ASIGNAR',
    PESO_MEDIA_RES_KG DECIMAL(10,2) NOT NULL,
    CANTIDAD_ANIMALES_MINIMA INT DEFAULT 0,
    CANTIDAD_ANIMALES_MAXIMA INT DEFAULT 0,
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.CATEGORIA_HACIENDA IS 'Tabla que almacena la información de las categorías de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CATEGORIA_HACIENDA.PK_CATEGORIA_HACIENDA IS 'Identificador único de la categoría de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CATEGORIA_HACIENDA.NOMBRE_CATEGORIA IS 'Nombre de la categoría de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CATEGORIA_HACIENDA.DESCRIPCION IS 'Descripción detallada de la categoría';
COMMENT ON COLUMN modelo_optimizacion.odp.CATEGORIA_HACIENDA.PESO_MEDIA_RES_KG IS 'Peso promedio de la media res en kilogramos';
COMMENT ON COLUMN modelo_optimizacion.odp.CATEGORIA_HACIENDA.CANTIDAD_ANIMALES_MINIMA IS 'Cantidad mínima de animales que se puede obtener de la categoría por default en la planificación';
COMMENT ON COLUMN modelo_optimizacion.odp.CATEGORIA_HACIENDA.CANTIDAD_ANIMALES_MAXIMA IS 'Cantidad máxima de animales que se puede obtener de la categoría por default en la planificación';
COMMENT ON COLUMN modelo_optimizacion.odp.CATEGORIA_HACIENDA.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_categoria_hacienda_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.CATEGORIA_HACIENDA
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_categoria_hacienda_last_update ON modelo_optimizacion.odp.CATEGORIA_HACIENDA 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial record
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(0, 'SIN ASIGNAR', 'SIN ASIGNAR', 0.00, 0, 0, '2025-04-07 18:42:38.041');
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(1, 'INDIFERENTE', 'PUEDE SER CUALQUIER CATEGORIA', 0.00, 0, 0, '2025-04-07 18:42:38.041');
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(2, 'HILTON', 'UE HILTON', 140.00, 2000, 8000, '2025-04-07 18:42:38.041');
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(3, 'NO HILTON', 'UE NO HILTON', 150.00, 0, 10800, '2025-04-07 18:42:38.041');
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(4, '481', 'UE 481', 150.00, 12000, 16000, '2025-04-07 18:42:38.041');
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(5, 'TERCEROS PAISES', '3ROS PAISES', 150.00, 0, 4000, '2025-04-07 18:42:38.041');
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(6, 'CONSUMO', 'CONSUMO INTERNO ARGENTINA', 120.00, 0, 0, '2025-04-07 18:42:38.041');
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(7, 'VACA UE', 'VACA UNION EUROPEA', 140.00, 0, 500, '2025-04-07 18:42:38.041');
INSERT INTO odp.categoria_hacienda (pk_categoria_hacienda, nombre_categoria, descripcion, peso_media_res_kg, cantidad_animales_minima, cantidad_animales_maxima, last_update) VALUES(8, 'VACA TERCEROS PAISES', 'VACA TERCEROS PAISES', 140.00, 0, 500, '2025-04-07 18:42:38.041');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.CATEGORIA_HACIENDA ALTER COLUMN pk_categoria_hacienda DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.CATEGORIA_HACIENDA ALTER COLUMN pk_categoria_hacienda ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('odp.categoria_hacienda', 'pk_categoria_hacienda'), 
    (SELECT MAX(pk_categoria_hacienda) FROM modelo_optimizacion.odp.CATEGORIA_HACIENDA), 
    true
);
--------------------------- ENTIDAD CALIDAD_HACIENDA ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.CALIDAD_HACIENDA;
CREATE TABLE modelo_optimizacion.odp.CALIDAD_HACIENDA (
    PK_CALIDAD_HACIENDA                 INT PRIMARY KEY,
    FK_GRADO_CALIDAD_HACIENDA           INT NOT NULL REFERENCES modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA(PK_GRADO_CALIDAD_HACIENDA),
    FK_CATEGORIA_HACIENDA               INT NOT NULL REFERENCES modelo_optimizacion.odp.CATEGORIA_HACIENDA(PK_CATEGORIA_HACIENDA),
    FK_MADUREZ_ANIMAL                   INT NOT NULL REFERENCES modelo_optimizacion.odp.MADUREZ_ANIMAL(PK_MADUREZ_ANIMAL),
    FK_TIPO_ANIMAL                      INT NOT NULL REFERENCES modelo_optimizacion.odp.TIPO_ANIMAL(PK_TIPO_ANIMAL),
    PROGRAMA                            VARCHAR(100) NOT NULL,
    NOMBRE_CALIDAD                      VARCHAR(100) NOT NULL,
    PORCENTAJE_DERIVACION_CATEGORIA 	DECIMAL(5,4) CHECK (PORCENTAJE_DERIVACION_CATEGORIA BETWEEN 0 AND 1) NOT NULL,
    PRECIO_REPOSICION_MEDIA_RES_ARS_KG  DECIMAL(10,2) NOT NULL,
    DESCRIPCION                         VARCHAR(255) DEFAULT 'SIN ASIGNAR',
    LAST_UPDATE                         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_grado_calidad_hacienda FOREIGN KEY (FK_GRADO_CALIDAD_HACIENDA) 
        REFERENCES modelo_optimizacion.odp.GRADO_CALIDAD_HACIENDA(PK_GRADO_CALIDAD_HACIENDA) ON DELETE RESTRICT,
    CONSTRAINT fk_categoria_hacienda FOREIGN KEY (FK_CATEGORIA_HACIENDA)
        REFERENCES modelo_optimizacion.odp.CATEGORIA_HACIENDA(PK_CATEGORIA_HACIENDA) ON DELETE RESTRICT,
    CONSTRAINT fk_madurez_animal FOREIGN KEY (FK_MADUREZ_ANIMAL)
        REFERENCES modelo_optimizacion.odp.MADUREZ_ANIMAL(PK_MADUREZ_ANIMAL) ON DELETE RESTRICT,
    CONSTRAINT fk_tipo_animal FOREIGN KEY (FK_TIPO_ANIMAL)
        REFERENCES modelo_optimizacion.odp.TIPO_ANIMAL(PK_TIPO_ANIMAL) ON DELETE RESTRICT
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.CALIDAD_HACIENDA IS 'Tabla que almacena la información de las calidades de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.PK_CALIDAD_HACIENDA IS 'Identificador único de la calidad de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.FK_GRADO_CALIDAD_HACIENDA IS 'Clave foránea al grado de calidad de hacienda. Entidad GRADO_CALIDAD_HACIENDA';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.FK_CATEGORIA_HACIENDA IS 'Clave foránea a la categoría de hacienda. Entidad CATEGORIA_HACIENDA';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.FK_MADUREZ_ANIMAL IS 'Clave foránea a la madurez de la res. Entidad MADUREZ_ANIMAL';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.FK_TIPO_ANIMAL IS 'Clave foránea al tipo de animal. Entidad TIPO_ANIMAL';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.PROGRAMA IS 'Programa asociado a la calidad de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.NOMBRE_CALIDAD IS 'Nombre de la calidad de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.PORCENTAJE_DERIVACION_CATEGORIA IS 'Porcentaje de derivación de la categoría de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.PRECIO_REPOSICION_MEDIA_RES_ARS_KG IS 'Precio de reposición media res en ARS por KG';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.DESCRIPCION IS 'Descripción detallada de la calidad de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.CALIDAD_HACIENDA.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_calidad_hacienda_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.CALIDAD_HACIENDA
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_calidad_hacienda_last_update ON modelo_optimizacion.odp.CALIDAD_HACIENDA 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(0, 0, 0, 2, 0, 'SIN ASIGNAR', 'SIN ASIGNAR', 0.0000, 0.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(1, 0, 1, 2, 0, 'SIN ASIGNAR', 'INDIFERENTE', 0.0000, 0.00, 'PUEDE SER CUALQUIER CALIDAD Y CATEGORIA', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(2, 1, 4, 2, 1, 'STANDARD', '481 STANDARD', 0.1129, 4700.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(3, 2, 4, 2, 1, 'GRAIN FED', '481 BLACK', 0.7871, 4700.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(4, 3, 4, 2, 1, 'PREMIUM', '481 BLUE', 0.1000, 4700.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(5, 1, 2, 2, 4, 'STANDARD', 'HILTON STANDARD', 0.2308, 4800.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(6, 2, 2, 2, 1, 'NATURAL', 'HILTON BLACK', 0.7692, 4800.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(7, 3, 2, 2, 1, 'PREMIUM', 'HILTON BLUE', 0.0000, 4800.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(8, 1, 3, 2, 4, 'STANDARD', 'NO HILTON STANDARD', 0.0000, 4700.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(9, 2, 3, 2, 1, 'NATURAL', 'NO HILTON BLACK', 0.9250, 4700.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(10, 3, 3, 2, 1, 'PREMIUM', 'NO HILTON BLUE', 0.0750, 4700.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(11, 1, 5, 2, 4, 'STANDARD', 'TERCEROS PAISES STANDARD', 0.1700, 4700.00, 'CONOCIDO COMO ESTADOS UNIDOS STANDARD', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(12, 2, 5, 2, 1, 'GRAIN FED / NATURAL', 'TERCEROS PAISES BLACK', 0.6700, 4700.00, 'INTEGRA LO QUE TAMBIEN SE CONOCE COMO CHINA BLACK Y USA BLACK', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(13, 3, 5, 2, 1, 'PREMIUM', 'TERCEROS PAISES BLUE', 0.1600, 4700.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(14, 1, 6, 2, 1, 'STANDARD', 'CONSUMO STANDARD', 0.1500, 4600.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(15, 2, 6, 2, 1, 'GRAIN FED / NATURAL', 'CONSUMO BLACK', 0.8500, 4600.00, 'CATEGORIA QUE ABARCA LAS MEDIAS RESES ENTERAS VENDIDAS A CONSUMO INTERNO', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(16, 3, 6, 2, 1, 'PREMIUM', 'CONSUMO BLUE', 0.0000, 4600.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(17, 4, 7, 3, 3, 'STANDARD', 'VACA UE AMARILLA', 0.5000, 3900.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(18, 5, 7, 3, 3, 'STANDARD', 'VACA UE BLANCA', 0.5000, 3900.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(19, 4, 8, 3, 3, 'STANDARD', 'VACA TERCEROS PAISES AMARILLA', 0.5000, 3800.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
INSERT INTO odp.calidad_hacienda (pk_calidad_hacienda, fk_grado_calidad_hacienda, fk_categoria_hacienda, fk_madurez_animal, fk_tipo_animal, programa, nombre_calidad, porcentaje_derivacion_categoria, precio_reposicion_media_res_ars_kg, descripcion, last_update) VALUES(20, 5, 8, 3, 3, 'STANDARD', 'VACA TERCEROS PAISES BLANCA', 0.5000, 3800.00, 'SIN ASIGNAR', '2025-04-07 18:42:38.171');
-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.CALIDAD_HACIENDA ALTER COLUMN pk_calidad_hacienda DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.CALIDAD_HACIENDA ALTER COLUMN pk_calidad_hacienda ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.CALIDAD_HACIENDA', 'pk_calidad_hacienda'), 
    (SELECT MAX(pk_calidad_hacienda) FROM modelo_optimizacion.odp.CALIDAD_HACIENDA), 
    true
);
--------------------------- ENTIDAD PRODUCTO ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.PRODUCTO;
CREATE TABLE modelo_optimizacion.odp.PRODUCTO (
    PK_PRODUCTO                         INT PRIMARY KEY,
    FK_CUARTO                           INT NOT NULL REFERENCES modelo_optimizacion.odp.CUARTO(PK_CUARTO),
    NOMBRE_PRODUCTO                     VARCHAR(100) NOT NULL,
    KG_PRODUCTO_POR_CAJA_FIJO           DECIMAL(10,2) DEFAULT 0.00,
    FL_KG_PRODUCTO_POR_CAJA_FIJO        BOOLEAN DEFAULT FALSE,
    FL_REQUIERE_DESPOSTADA              BOOLEAN NOT NULL,
    FL_CON_HUESO                        BOOLEAN NOT NULL,
    FL_SIN_HUESO                        BOOLEAN NOT NULL,
    FL_HUESO                            BOOLEAN NOT NULL,
    FL_OTROS                            BOOLEAN NOT NULL,
    FL_CUARTO                           BOOLEAN NOT NULL,
    FL_MEDIA_RES_ENTERA                 BOOLEAN NOT NULL,
    LAST_UPDATE                         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cuarto FOREIGN KEY (FK_CUARTO) 
        REFERENCES modelo_optimizacion.odp.CUARTO(PK_CUARTO) ON DELETE RESTRICT
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.PRODUCTO IS 'Tabla que almacena la información de los productos del frigorífico';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.PK_PRODUCTO IS 'Identificador único del producto';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FK_CUARTO IS 'Clave foránea al cuarto al que pertenece el producto. Entidad CUARTO';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.NOMBRE_PRODUCTO IS 'Nombre del producto';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.KG_PRODUCTO_POR_CAJA_FIJO IS 'Peso fijo de la caja en KG(cantidad de kg de producto por caja fijos). Algunos productos tienen un peso fijo por caja, por ejemplo, RECORTE 80/20, RAL EN SET y DELANTERO. Esto es porque no pueden ser calculados mediante los valores de las especificaciones de producto para obtener los precios de costos por kg.';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FL_KG_PRODUCTO_POR_CAJA_FIJO IS 'Flag que indica si la cantidad de kg de producto por caja es fija.';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FL_REQUIERE_DESPOSTADA IS 'Flag que indica si el producto requiere despostada';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FL_CON_HUESO IS 'Flag que indica si el producto es con hueso';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FL_SIN_HUESO IS 'Flag que indica si el producto es sin hueso';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FL_HUESO IS 'Flag que indica si el producto es hueso';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FL_OTROS IS 'Flag que indica si el producto pertenece a otros';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FL_CUARTO IS 'Flag que indica si el producto es un cuarto completo';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.FL_MEDIA_RES_ENTERA IS 'Flag que indica si el producto es una media res entera';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_producto_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.PRODUCTO
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_producto_last_update ON modelo_optimizacion.odp.PRODUCTO 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial records
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(0, 0, 'SIN ASIGNAR', 0.00, false, false, false, false, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(1, 1, 'ASADO 13C', 0.00, false, false, false, false, false, false, true, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(2, 1, 'ASADO 5 COSTILLAS', 0.00, false, true, true, false, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(3, 1, 'ASADO 8 COSTILLAS', 0.00, false, true, true, false, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(4, 1, 'ENTRAÑA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(5, 1, 'MATAMBRE', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(6, 1, 'VACIO', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(7, 2, 'AGUJA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(8, 2, 'BRAZUELO', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(9, 2, 'CARNAZA DE PALETA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(28, 3, 'LOMO CON CORDON', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(29, 3, 'LOMO SIN CORDON', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(30, 3, 'RAL EN SET', 18.00, true, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(31, 3, 'TAPA DE BIFE', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(32, 3, 'TAPA DE CUADRIL', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(33, 4, 'BOLA DE LOMO', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(34, 4, 'COLITA DE CUADRIL', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(35, 4, 'CUADRADA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(36, 4, 'GARRON CON TORTUGUITA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(37, 4, 'HUESO CHIQUIZUELA', 0.00, false, true, false, false, true, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(38, 4, 'NALGA SIN TAPA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(39, 4, 'PECETO', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(40, 4, 'RUEDA CON HUESO', 0.00, false, false, false, false, false, false, true, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(41, 4, 'TAPA DE NALGA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(42, 0, 'RECORTE 80/20', 24.00, true, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(43, 0, 'GRASA', 0.00, false, true, false, false, false, true, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(44, 0, 'HUESO', 0.00, false, true, false, false, false, true, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(45, 0, 'MERMA', 0.00, false, true, false, false, false, true, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(46, 2, 'PECHO CON HUESO', 0.00, false, false, false, false, false, false, true, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(47, 5, 'MEDIA RES CON HUESO', 0.00, false, false, false, false, false, false, false, true, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(48, 4, 'TRASERO', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(10, 2, 'CHINGOLO', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(11, 2, 'DELANTERO', 26.00, true, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(12, 2, 'ENTRAÑA FINA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(13, 2, 'HUESO DE AGUJA', 0.00, false, true, false, false, true, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(14, 2, 'HUESO DEL BRISKET NE', 0.00, false, true, false, false, true, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(15, 2, 'HUESO DEL BRISKET PE', 0.00, false, true, false, false, true, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(16, 2, 'HUESO DEL COGOTE', 0.00, false, true, false, false, true, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(17, 2, 'MARUCHA', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(18, 2, 'TAPA DE ASADO NE', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(19, 2, 'TAPA DE ASADO PE', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(20, 3, 'BIFE ANCHO', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(21, 3, 'BIFE ANCHO SIN TAPA EN TROZOS', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(22, 3, 'BIFE ANGOSTO CON CORDON', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(23, 3, 'BIFE ANGOSTO SIN CORDON', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(24, 3, 'CORAZON DE CUADRIL', 0.00, false, true, false, true, false, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(25, 3, 'HUESO CONTRACARA BIFE ANCHO', 0.00, false, true, false, false, true, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(26, 3, 'HUESO DEL BIFE ANCHO', 0.00, false, true, false, false, true, false, false, false, '2025-04-07 18:42:39.068');
INSERT INTO odp.producto (pk_producto, fk_cuarto, nombre_producto, kg_producto_por_caja_fijo, fl_kg_producto_por_caja_fijo, fl_requiere_despostada, fl_con_hueso, fl_sin_hueso, fl_hueso, fl_otros, fl_cuarto, fl_media_res_entera, last_update) VALUES(27, 3, 'HUESO DEL ESPINAZO', 0.00, false, true, false, false, true, false, false, false, '2025-04-07 18:42:39.068');
-- Actualizaciones para los productos que tienen un peso fijo por caja
UPDATE odp.producto
SET kg_producto_por_caja_fijo=26.00, fl_kg_producto_por_caja_fijo=true
WHERE pk_producto=11;
UPDATE odp.producto
SET kg_producto_por_caja_fijo=18.00, fl_kg_producto_por_caja_fijo=true
WHERE pk_producto=30;
UPDATE odp.producto
SET kg_producto_por_caja_fijo=24.00, fl_kg_producto_por_caja_fijo=true
WHERE pk_producto=42;

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.PRODUCTO ALTER COLUMN pk_producto DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.PRODUCTO ALTER COLUMN pk_producto ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.PRODUCTO', 'pk_producto'), 
    (SELECT MAX(pk_producto) FROM modelo_optimizacion.odp.PRODUCTO), 
    true
);
--------------------------- ENTIDAD MERCADO ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.MERCADO;
CREATE TABLE modelo_optimizacion.odp.MERCADO (
    PK_MERCADO INT PRIMARY KEY,
    NOMBRE_MERCADO VARCHAR(100) NOT NULL,
    ABREVIATURA VARCHAR(2) NOT NULL,
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.MERCADO IS 'Tabla que almacena la información de los mercados';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO.PK_MERCADO IS 'Identificador único del mercado';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO.NOMBRE_MERCADO IS 'Nombre del mercado';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO.ABREVIATURA IS 'Código de dos letras que identifica al mercado';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_mercado_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.MERCADO
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_mercado_last_update ON modelo_optimizacion.odp.MERCADO 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial records
INSERT INTO modelo_optimizacion.odp.MERCADO 
(PK_MERCADO, NOMBRE_MERCADO, ABREVIATURA, LAST_UPDATE)
VALUES 
    (0, 'SIN ASIGNAR', 'SA', '2024-10-24'),
    (1, 'ASIA', 'AS', '2024-10-24'),
    (2, 'CONSUMO INTERNO ARGENTINA', 'AR', '2024-10-24'),
    (3, 'ESTADOS UNIDOS', 'US', '2024-10-24'),
    (4, 'ORIENTE MEDIO', 'OM', '2024-10-24'),
    (5, 'TERCEROS PAISES', 'TP', '2024-10-24'),
    (6, 'UNION EUROPEA', 'UE', '2024-10-24'),
    (7, 'UNITED KINGDOM', 'UK', '2024-10-24'),
    (8, 'AFRICA', 'AF', '2024-10-24'),
    (9, 'EUROPA', 'EU', '2024-10-24');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.MERCADO ALTER COLUMN pk_mercado DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.MERCADO ALTER COLUMN pk_mercado ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.MERCADO', 'pk_mercado'), 
    (SELECT MAX(pk_mercado) FROM modelo_optimizacion.odp.MERCADO), 
    true
);

--------------------------- ENTIDAD DESTINO ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.DESTINO;
CREATE TABLE modelo_optimizacion.odp.DESTINO (
    PK_DESTINO INT PRIMARY KEY,
    FK_MERCADO INT NOT NULL REFERENCES modelo_optimizacion.odp.MERCADO(PK_MERCADO),
    FK_MERCADO_ALTERNATIVO INT REFERENCES modelo_optimizacion.odp.MERCADO(PK_MERCADO),
    NOMBRE_DESTINO VARCHAR(100) NOT NULL,
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_mercado FOREIGN KEY (FK_MERCADO) 
        REFERENCES modelo_optimizacion.odp.MERCADO(PK_MERCADO) ON DELETE RESTRICT,
    CONSTRAINT fk_mercado_alternativo FOREIGN KEY (FK_MERCADO_ALTERNATIVO)
        REFERENCES modelo_optimizacion.odp.MERCADO(PK_MERCADO) ON DELETE RESTRICT
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.DESTINO IS 'Tabla que almacena la información de los destinos de comercialización';
COMMENT ON COLUMN modelo_optimizacion.odp.DESTINO.PK_DESTINO IS 'Identificador único del destino';
COMMENT ON COLUMN modelo_optimizacion.odp.DESTINO.FK_MERCADO IS 'Clave foránea al mercado principal. Entidad: MERCADO';
COMMENT ON COLUMN modelo_optimizacion.odp.DESTINO.FK_MERCADO_ALTERNATIVO IS 'Clave foránea al mercado alternativo. Entidad: MERCADO. Si es NULL, se usa el mercado principal';
COMMENT ON COLUMN modelo_optimizacion.odp.DESTINO.NOMBRE_DESTINO IS 'Nombre del país o región de destino';
COMMENT ON COLUMN modelo_optimizacion.odp.DESTINO.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger function for setting FK_MERCADO_ALTERNATIVO
CREATE OR REPLACE FUNCTION odp.set_mercado_alternativo()
RETURNS TRIGGER AS $$
BEGIN
    -- If the FK_MERCADO_ALTERNATIVO is not provided, it will use the FK_MERCADO value set by the trigger trigger_set_mercado_alternativo
    NEW.FK_MERCADO_ALTERNATIVO = COALESCE(NEW.FK_MERCADO_ALTERNATIVO, NEW.FK_MERCADO);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger for FK_MERCADO_ALTERNATIVO. If not provided, it will use the FK_MERCADO value
CREATE TRIGGER trigger_set_mercado_alternativo
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.DESTINO
    FOR EACH ROW
    EXECUTE FUNCTION odp.set_mercado_alternativo();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_set_mercado_alternativo ON modelo_optimizacion.odp.DESTINO 
    IS 'Trigger para actualizar automáticamente el campo FK_MERCADO_ALTERNATIVO con el valor de FK_MERCADO si no se proporciona';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_destino_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.DESTINO
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_destino_last_update ON modelo_optimizacion.odp.DESTINO 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';


-- Insert initial records
INSERT INTO modelo_optimizacion.odp.DESTINO 
(PK_DESTINO, FK_MERCADO, FK_MERCADO_ALTERNATIVO, NOMBRE_DESTINO, LAST_UPDATE)
VALUES 
    (0, 0, 0, 'SIN ASIGNAR', '2024-10-24'),
    (1, 6, 9, 'ALBANIA', '2024-10-24'),
    (2, 6, 9, 'ALEMANIA', '2024-10-24'),
    (3, 8, 8, 'ANGOLA', '2024-10-24'),
    (4, 5, 5, 'ANTILLAS', '2024-10-24'),
    (5, 4, 4, 'ARABIA', '2024-10-24'),
    (6, 8, 8, 'ARGELIA', '2024-10-24'),
    (7, 2, 2, 'ARGENTINA', '2024-10-24'),
    (8, 6, 9, 'BELGICA', '2024-10-24'),
    (9, 5, 5, 'BOLIVIA', '2024-10-24'),
    (10, 9, 9, 'BOSNIA', '2024-10-24'),
    (11, 5, 5, 'BRASIL', '2024-10-24'),
    (12, 6, 9, 'BULGARIA', '2024-10-24'),
    (13, 5, 5, 'CANADA', '2024-10-24'),
    (14, 5, 5, 'CHILE', '2024-10-24'),
    (15, 1, 1, 'CHINA', '2024-10-24'),
    (16, 5, 5, 'COLOMBIA', '2024-10-24'),
    (17, 8, 8, 'CONGO', '2024-10-24'),
    (18, 6, 9, 'CROACIA', '2024-10-24'),
    (19, 6, 9, 'DINAMARCA', '2024-10-24'),
    (20, 4, 4, 'DUBAI', '2024-10-24'),
    (21, 5, 5, 'ECUADOR', '2024-10-24'),
    (22, 8, 1, 'EGIPTO', '2024-10-24'),
    (23, 6, 9, 'ESPAÑA', '2024-10-24'),
    (24, 3, 3, 'ESTADOS UNIDOS', '2024-10-24'),
    (25, 1, 1, 'FILIPINAS', '2024-10-24'),
    (26, 6, 9, 'FINLANDIA', '2024-10-24'),
    (27, 6, 9, 'FRANCIA', '2024-10-24'),
    (28, 6, 9, 'HOLANDA', '2024-10-24'),
    (29, 1, 1, 'HONG KONG', '2024-10-24'),
    (30, 7, 9, 'INGLATERRA', '2024-10-24'),
    (31, 6, 9, 'ISLAS CANARIAS', '2024-10-24'),
    (32, 1, 1, 'ISRAEL', '2024-10-24'),
    (33, 6, 9, 'ITALIA', '2024-10-24'),
    (34, 4, 4, 'JAPON', '2024-10-24'),
    (35, 1, 1, 'KUWAIT', '2024-10-24'),
    (36, 4, 4, 'LIBANO', '2024-10-24'),
    (37, 4, 4, 'LIBIA', '2024-10-24'),
    (38, 8, 8, 'MALASIA', '2024-10-24'),
    (39, 6, 9, 'MALTA', '2024-10-24'),
    (40, 5, 5, 'MEXICO', '2024-10-24'),
    (41, 1, 1, 'PALESTINA', '2024-10-24'),
    (42, 5, 5, 'PERU', '2024-10-24'),
    (43, 6, 9, 'PORTUGAL', '2024-10-24'),
    (44, 4, 4, 'QATAR', '2024-10-24'),
    (45, 1, 1, 'RUSIA', '2024-10-24'),
    (46, 1, 1, 'SINGAPUR', '2024-10-24'),
    (47, 1, 1, 'SUDAFRICA', '2024-10-24'),
    (48, 8, 8, 'SUECIA', '2024-10-24'),
    (49, 6, 9, 'SUIZA', '2024-10-24'),
    (50, 1, 1, 'TAILANDIA', '2024-10-24'),
    (51, 9, 9, 'UCRANIA', '2024-10-24'),
    (52, 5, 5, 'URUGUAY', '2024-10-24'),
    (53, 5, 9, 'VENEZUELA', '2024-10-24'),
    (54, 1, 1, 'VIETNAM', '2024-10-24');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.DESTINO ALTER COLUMN pk_destino DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.DESTINO ALTER COLUMN pk_destino ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.DESTINO', 'pk_destino'), 
    (SELECT MAX(pk_destino) FROM modelo_optimizacion.odp.DESTINO), 
    true
);
--------------------------- ENTIDAD ENTRADA_RES ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.ENTRADA_RES;
CREATE TABLE modelo_optimizacion.odp.ENTRADA_RES (
    PK_ENTRADA_RES INT PRIMARY KEY,
    FK_CUARTO INT NOT NULL REFERENCES modelo_optimizacion.odp.CUARTO(PK_CUARTO),
    NOMBRE_ENTRADA VARCHAR(100) NOT NULL,
    CANTIDAD_COSTILLAS_ENTRADA SMALLINT NOT NULL CHECK (CANTIDAD_COSTILLAS_ENTRADA BETWEEN 0 AND 13),
    RENDIMIENTO_ENTRADA_MEDIA_RES   DECIMAL(6,4) NOT NULL CHECK (RENDIMIENTO_ENTRADA_MEDIA_RES BETWEEN 0 AND 1),
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cuarto FOREIGN KEY (FK_CUARTO)
        REFERENCES modelo_optimizacion.odp.CUARTO(PK_CUARTO) ON DELETE RESTRICT
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.ENTRADA_RES IS 'Tabla que almacena la información de las entradas de res para las políticas';
COMMENT ON COLUMN modelo_optimizacion.odp.ENTRADA_RES.PK_ENTRADA_RES IS 'Identificador único de la entrada de res';
COMMENT ON COLUMN modelo_optimizacion.odp.ENTRADA_RES.FK_CUARTO IS 'Clave foránea al cuarto. Entidad: CUARTO';
COMMENT ON COLUMN modelo_optimizacion.odp.ENTRADA_RES.NOMBRE_ENTRADA IS 'Nombre de la entrada de res';
COMMENT ON COLUMN modelo_optimizacion.odp.ENTRADA_RES.CANTIDAD_COSTILLAS_ENTRADA IS 'Cantidad de costillas en la entrada (entre 0 y 13)';
COMMENT ON COLUMN modelo_optimizacion.odp.ENTRADA_RES.RENDIMIENTO_ENTRADA_MEDIA_RES IS 'Rendimiento de la entrada de media res (entre 0 y 1). Porcentaje de la media res que representa la entrada. Este valor multiplicado por dos es el porcentaje con respecto al animal entero.';
COMMENT ON COLUMN modelo_optimizacion.odp.ENTRADA_RES.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_entrada_res_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.ENTRADA_RES
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_entrada_res_last_update ON modelo_optimizacion.odp.ENTRADA_RES 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';


-- Insert initial records
INSERT INTO modelo_optimizacion.odp.ENTRADA_RES 
(PK_ENTRADA_RES, FK_CUARTO, NOMBRE_ENTRADA, CANTIDAD_COSTILLAS_ENTRADA, RENDIMIENTO_ENTRADA_MEDIA_RES)
VALUES 
    (0, 0, 'SIN ASIGNAR', 0, 0.0000),
    (1, 3, 'RUMP & LOIN 10C', 10, 0.2179),
    (2, 3, 'RUMP & LOIN 9C', 9, 0.2086),
    (3, 1, 'ASADO 13C', 13, 0.1451),
    (4, 2, 'PECHO C/FALDA 3C', 3, 0.3591),
    (5, 4, 'RUEDA CON COLITA', 0, 0.2515),
    (6, 2, 'PECHO C/FALDA 4C', 4, 0.3684),
    (7, 5, 'MEDIA RES CON HUESO', 13, 0.9746);

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.ENTRADA_RES ALTER COLUMN pk_entrada_res DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.ENTRADA_RES ALTER COLUMN pk_entrada_res ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.ENTRADA_RES', 'pk_entrada_res'), 
    (SELECT MAX(pk_entrada_res) FROM modelo_optimizacion.odp.ENTRADA_RES), 
    true
);
--------------------------- ENTIDAD POLITICA ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.POLITICA;
CREATE TABLE modelo_optimizacion.odp.POLITICA (
    PK_POLITICA                     INT PRIMARY KEY,
    FK_CUARTO                       INT NOT NULL REFERENCES modelo_optimizacion.odp.CUARTO(PK_CUARTO),
    FK_CALIDAD_HACIENDA_ENTRADA     INT NOT NULL REFERENCES modelo_optimizacion.odp.CALIDAD_HACIENDA(PK_CALIDAD_HACIENDA),
    FK_ENTRADA_RES                  INT NOT NULL REFERENCES modelo_optimizacion.odp.ENTRADA_RES(PK_ENTRADA_RES),
    NOMBRE_POLITICA                 VARCHAR(100) NOT NULL,
    CANTIDAD_CUARTOS_MINIMA_MENSUAL INTEGER DEFAULT 0,
    CANTIDAD_CUARTOS_MAXIMA_MENSUAL INTEGER DEFAULT 0,
    FL_POLITICA_ACTIVA              BOOLEAN NOT NULL DEFAULT TRUE,
    LAST_UPDATE                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cuarto FOREIGN KEY (FK_CUARTO)
        REFERENCES modelo_optimizacion.odp.CUARTO(PK_CUARTO) ON DELETE RESTRICT,
    CONSTRAINT fk_calidad_hacienda FOREIGN KEY (FK_CALIDAD_HACIENDA_ENTRADA)
        REFERENCES modelo_optimizacion.odp.CALIDAD_HACIENDA(PK_CALIDAD_HACIENDA) ON DELETE RESTRICT,
    CONSTRAINT fk_entrada_res FOREIGN KEY (FK_ENTRADA_RES)
        REFERENCES modelo_optimizacion.odp.ENTRADA_RES(PK_ENTRADA_RES) ON DELETE RESTRICT
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.POLITICA IS 'Tabla que almacena la información de las políticas de producción';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.PK_POLITICA IS 'Identificador único de la política';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.FK_CUARTO IS 'Clave foránea al cuarto. Entidad: CUARTO';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.FK_CALIDAD_HACIENDA_ENTRADA IS 'Clave foránea a la calidad de hacienda. Entidad: CALIDAD_HACIENDA';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.FK_ENTRADA_RES IS 'Clave foránea a la entrada de res. Entidad: ENTRADA_RES';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.NOMBRE_POLITICA IS 'Nombre de la política';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.FL_POLITICA_ACTIVA IS 'Flag que indica si la política está activa (default TRUE)';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.CANTIDAD_CUARTOS_MINIMA_MENSUAL IS 'Restriccion de cantidad minima de cuartos a producir de la politica al mes por default';
COMMENT ON COLUMN modelo_optimizacion.odp.POLITICA.CANTIDAD_CUARTOS_MAXIMA_MENSUAL IS 'Restriccion de cantidad maxima de cuartos a producir de la politica al mes por default';


-- Create trigger for last_update
CREATE TRIGGER trigger_update_politica_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.POLITICA
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_politica_last_update ON modelo_optimizacion.odp.POLITICA 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';


-- Insert initial records
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(0, 0, 0, 0, 'SIN ASIGNAR', 0, 0, false, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(1, 3, 3, 1, '481 AVION', 0, 6000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(2, 3, 3, 1, '481 BARCO', 0, 4000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(3, 3, 5, 1, 'ALEMANIA H', 0, 20000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(4, 3, 8, 1, 'ALEMANIA NH', 0, 20000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(5, 3, 12, 2, 'CHINA NEGRA', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(6, 3, 11, 2, 'CHINA STD', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(7, 3, 6, 1, 'CONTINENTAL H', 0, 0, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(8, 3, 9, 1, 'CONTINENTAL NH', 0, 2000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(9, 3, 13, 2, 'EEUU BLUE', 0, 1000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(10, 3, 12, 2, 'EEUU CHOICE', 0, 10000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(11, 3, 11, 2, 'EEUU SELECT', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(12, 3, 6, 1, 'ITALIA H', 0, 6000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(13, 3, 9, 1, 'ITALIA NH', 0, 6000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(14, 3, 12, 2, 'RUSIA', 0, 1000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(15, 3, 9, 1, 'SUIZA', 0, 1000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(16, 3, 12, 2, 'BRASIL', 0, 500, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(17, 1, 1, 3, 'ASADO CHINA NOVILLO', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(18, 1, 1, 3, 'ASADO CON HUESO', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(19, 2, 1, 4, 'PECHO CHINA GRAIN FED - A', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(20, 4, 1, 5, 'RUEDA CHINA NOVILLO', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(21, 4, 1, 5, 'RUEDA CON HUESO', 0, 10000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(22, 2, 1, 6, 'PECHO CHINA GRAIN FED - B', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(23, 2, 1, 4, 'PECHO CON HUESO - A', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(24, 2, 1, 6, 'PECHO CON HUESO - B', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(25, 3, 17, 1, 'ALEMANIA NH VACA UE INDIFERENTE', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(26, 3, 19, 2, 'EEUU SELECT VACA UE/TP', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(27, 1, 19, 3, 'ASADO CON HUESO VACA UE/TP', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(28, 4, 19, 5, 'RUEDA CON HUESO VACA UE/TP', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(29, 4, 19, 5, 'RUEDA CHINA VACA UE/TP', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(30, 2, 19, 4, 'PECHO CHINA GRASS FED - A VACA UE/TP', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(31, 2, 19, 6, 'PECHO CHINA GRASS FED - B VACA UE/TP', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(32, 2, 20, 4, 'PECHO CHINA GRAIN FED - A VACA UE/TP', 0, 60000, true, '2025-04-07 18:42:39.017');
INSERT INTO odp.politica (pk_politica, fk_cuarto, fk_calidad_hacienda_entrada, fk_entrada_res, nombre_politica, cantidad_cuartos_minima_mensual, cantidad_cuartos_maxima_mensual, fl_politica_activa, last_update) VALUES(33, 2, 20, 6, 'PECHO CHINA GRAIN FED - B VACA UE/TP', 0, 60000, true, '2025-04-07 18:42:39.017');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.POLITICA ALTER COLUMN pk_politica DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.POLITICA ALTER COLUMN pk_politica ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.POLITICA', 'pk_politica'), 
    (SELECT MAX(pk_politica) FROM modelo_optimizacion.odp.POLITICA), 
    true
);
--------------------------- ENTIDAD TRIBUTO ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.TRIBUTO;
CREATE TABLE modelo_optimizacion.odp.TRIBUTO (
    PK_TRIBUTO INT PRIMARY KEY,
    NOMBRE_TRIBUTO VARCHAR(100) NOT NULL,
    FL_APLICA_SOBRE_FOB BOOLEAN NOT NULL DEFAULT FALSE,
    FL_APLICA_SOBRE_FOT BOOLEAN NOT NULL DEFAULT FALSE,
    FL_APLICA_SOBRE_CFR BOOLEAN NOT NULL DEFAULT FALSE,
    FL_APLICA_SOBRE_CIF BOOLEAN NOT NULL DEFAULT FALSE,
    FL_POSITIVO BOOLEAN NOT NULL DEFAULT FALSE,
    PORCENTAJE DECIMAL(6,5) NOT NULL CHECK (PORCENTAJE BETWEEN 0 AND 1),
    DESCRIPCION TEXT,
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.TRIBUTO IS 'Tabla que almacena la información de los tributos aplicables. Impuestos, reintegros, retenciones, etc.';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.PK_TRIBUTO IS 'Identificador único del tributo';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.NOMBRE_TRIBUTO IS 'Nombre del tributo';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.FL_APLICA_SOBRE_FOB IS 'Flag que indica si el tributo aplica sobre el precio FOB';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.FL_APLICA_SOBRE_FOT IS 'Flag que indica si el tributo aplica sobre el precio FOT';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.FL_APLICA_SOBRE_CFR IS 'Flag que indica si el tributo aplica sobre el precio CFR';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.FL_APLICA_SOBRE_CIF IS 'Flag que indica si el tributo aplica sobre el precio CIF';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.FL_POSITIVO IS 'Flag que indica si el tributo suma o resta. Por ejemplo, un reintegro es positivo.';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.PORCENTAJE IS 'Porcentaje del tributo (entre 0 y 1)';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.DESCRIPCION IS 'Descripción detallada del tributo';
COMMENT ON COLUMN modelo_optimizacion.odp.TRIBUTO.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_tributo_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.TRIBUTO
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_tributo_last_update ON modelo_optimizacion.odp.TRIBUTO 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';


-- Insert initial records
INSERT INTO modelo_optimizacion.odp.TRIBUTO 
(PK_TRIBUTO, NOMBRE_TRIBUTO, FL_APLICA_SOBRE_FOB, FL_APLICA_SOBRE_FOT, FL_APLICA_SOBRE_CFR, 
 FL_APLICA_SOBRE_CIF, FL_POSITIVO, PORCENTAJE, DESCRIPCION, LAST_UPDATE)
VALUES 
    (0, 'SIN ASIGNAR', FALSE, FALSE, FALSE, FALSE, FALSE, 0.0, 'SIN ASIGNAR', '2024-10-30'),
    (1, 'IMPUESTO INGRESOS BRUTOS ARS/KG', FALSE, TRUE, FALSE, FALSE, FALSE, 0.01, 'Es un impuesto local. Es el 1,0% del FOT', '2024-10-30'),
    (2, 'IMPUESTO MOVIMIENTO BANCARIO ARS/KG', TRUE, TRUE, FALSE, FALSE, FALSE, 0.006, 'También conocido como impuesto al cheque o impuesto a las transferencias bancarias. Es el 0,6% del precio FOB/FOT', '2024-10-30'),
    (3, 'REINTEGRO CONGELADO ARS/KG', TRUE, FALSE, FALSE, FALSE, TRUE, 0.0125, 'Es un reintegro que recibe el exportador. En productos congelados es el 1,25% del precio FOB.', '2024-10-30'),
    (4, 'REINTEGRO ENFRIADO ARS/KG', TRUE, FALSE, FALSE, FALSE, TRUE, 0.01, 'Es un reintegro que recibe el exportador. En productos enfriados es el 1,0% del FOB.', '2024-10-30'),
    (5, 'TASA DERECHO DE EXPORTACION ARS/KG', TRUE, FALSE, FALSE, FALSE, FALSE, 0.0632, 'Es una tasa que se le paga al Estado por exportar. Es el 6,32% del precio FOB.', '2024-10-30'),
    (6, 'TASA SEGURIDAD HIGIENE ARS/KG', FALSE, TRUE, FALSE, FALSE, FALSE, 0.0061, 'Es una tasa municipal. Es el 0,61% del FOT', '2024-10-30'),
    (7, 'DESPACHANTE DE ADUANA', TRUE, FALSE, FALSE, FALSE, FALSE, 0.0045, 'Es el porcentaje que se le paga al despachante de aduana para exportar', '2024-10-30');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.TRIBUTO ALTER COLUMN pk_tributo DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.TRIBUTO ALTER COLUMN pk_tributo ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.TRIBUTO', 'pk_tributo'), 
    (SELECT MAX(pk_tributo) FROM modelo_optimizacion.odp.TRIBUTO), 
    true
);
--------------------------- ENTIDAD PRODUCTO_POLITICA ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.PRODUCTO_POLITICA;
CREATE TABLE modelo_optimizacion.odp.PRODUCTO_POLITICA (
    FK_POLITICA                                     INTEGER NOT NULL,
    FK_PRODUCTO                                     INTEGER NOT NULL,
    FK_DESTINO_COSTO                                INTEGER NOT NULL,
    FK_ESPECIFICACION_PRODUCTO                      BIGINT NOT NULL DEFAULT 0,
    RENDIMIENTO_MEDIA_RES                           DECIMAL(6,4) CHECK (RENDIMIENTO_MEDIA_RES BETWEEN 0 AND 1),
    PRECIO_VENTA_FREE_ON_BOARD_USD_TON              DECIMAL(40,20) NOT NULL DEFAULT 0,
    PRECIO_VENTA_FREE_ON_TRACK_ARS_KG               DECIMAL(40,20) NOT NULL DEFAULT 0,
    PRECIO_VENTA_COST_INSURANCE_FREIGHT_USD_TON     DECIMAL(40,20) NOT NULL DEFAULT 0,
    PRECIO_RECUPERO_SUBPRODUCTO_ARS_KG              DECIMAL(40,20) NOT NULL DEFAULT 0,
    FL_APLICA_COSTO_CONGELADO                       BOOLEAN NOT NULL DEFAULT FALSE,
    COSTO_MADURADO_CONGELADO_ARS_KG                 DECIMAL(40,20) NOT NULL DEFAULT 0,
    LAST_UPDATE                                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (FK_POLITICA, FK_PRODUCTO),
    CONSTRAINT fk_politica_ref FOREIGN KEY (FK_POLITICA) REFERENCES modelo_optimizacion.odp.POLITICA(PK_POLITICA),
    CONSTRAINT fk_producto_ref FOREIGN KEY (FK_PRODUCTO) REFERENCES modelo_optimizacion.odp.PRODUCTO(PK_PRODUCTO),
    CONSTRAINT fk_destino_costo_ref FOREIGN KEY (FK_DESTINO_COSTO) REFERENCES modelo_optimizacion.odp.DESTINO(PK_DESTINO)
);
-- Add table comments
COMMENT ON TABLE modelo_optimizacion.odp.PRODUCTO_POLITICA IS 'Tabla que relaciona los productos con las políticas y sus costos asociados';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.FK_POLITICA IS 'Clave foránea que referencia a la tabla POLITICA';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.FK_PRODUCTO IS 'Clave foránea que referencia a la tabla PRODUCTO';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.FK_DESTINO_COSTO IS 'Clave foránea que referencia a la tabla DESTINO. Representa el destino del costo de envío del producto.';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.FK_ESPECIFICACION_PRODUCTO IS 'Clave foránea que referencia a la vista odp.specs_view del sistema de especificaciones en la columna "codigo". Representa la especificación del producto con su dressing e insumos. Si es 0, significa que no se tiene una especificación asociada.';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.RENDIMIENTO_MEDIA_RES IS 'Rendimiento del corte respecto a la media res (valor entre 0 y 1)';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.PRECIO_VENTA_FREE_ON_BOARD_USD_TON IS 'Precio de venta FOB en USD por tonelada';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.PRECIO_VENTA_FREE_ON_TRACK_ARS_KG IS 'Precio de venta FOT en ARS por kilogramo';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.PRECIO_VENTA_COST_INSURANCE_FREIGHT_USD_TON IS 'Precio de venta CIF en USD por tonelada';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.PRECIO_RECUPERO_SUBPRODUCTO_ARS_KG IS 'Precio de recupero del subproducto en ARS por kilogramo';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.FL_APLICA_COSTO_CONGELADO IS 'Indica si aplica el costo de congelado. Si es TRUE, significa que el producto se congela y, por lo tanto, tiene un costo de congelado.';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.COSTO_MADURADO_CONGELADO_ARS_KG IS 'Costo de madurado y congelado en ARS por kilogramo';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_POLITICA.LAST_UPDATE IS 'Fecha de última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_producto_politica_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.PRODUCTO_POLITICA
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_producto_politica_last_update ON modelo_optimizacion.odp.PRODUCTO_POLITICA 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 20, 2, 2742150410, 0.0187, 15800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 32, 11, 3042250202, 0.0099, 15800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 31, 15, 3632220201, 0.0131, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 42, 15, 3632130201, 0.0175, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 43, 7, 0, 0.0216, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(2, 45, 7, 0, 0.0018, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 30, 49, 2782000201, 0.0598, 17000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 20, 49, 2742150410, 0.0199, 17000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 32, 11, 3042250202, 0.0103, 13000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 31, 15, 3632220201, 0.0110, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 42, 15, 3632130201, 0.0201, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 43, 7, 0, 0.0226, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(15, 45, 7, 0, 0.0018, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 22, 15, 2062100101, 0.0245, 0.00000000000000000000, 0.00000000000000000000, 12100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 24, 24, 2212270404, 0.0170, 0.00000000000000000000, 0.00000000000000000000, 8308.43000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 29, 24, 2702110103, 0.0120, 0.00000000000000000000, 0.00000000000000000000, 24250.82000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 20, 15, 2062150101, 0.0348, 0.00000000000000000000, 0.00000000000000000000, 16500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 32, 11, 3042250202, 0.0096, 13000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 31, 15, 3632220201, 0.0075, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 42, 15, 3632130201, 0.0095, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 43, 7, 0, 0.0215, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(5, 45, 7, 0, 0.0017, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 22, 15, 2062100101, 0.0245, 0.00000000000000000000, 0.00000000000000000000, 7000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 24, 24, 2212270404, 0.0170, 0.00000000000000000000, 0.00000000000000000000, 8308.43000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 29, 15, 2702110103, 0.0120, 0.00000000000000000000, 0.00000000000000000000, 20275.57000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 20, 15, 2062150101, 0.0348, 0.00000000000000000000, 0.00000000000000000000, 7500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 32, 11, 3042250202, 0.0096, 9000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 31, 15, 3632220201, 0.0075, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 42, 15, 3632130201, 0.0095, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 43, 7, 0, 0.0215, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(6, 45, 7, 0, 0.0017, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 22, 11, 2062100101, 0.0245, 11900.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 24, 11, 2212270404, 0.0170, 7500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 29, 24, 2702110103, 0.0120, 0.00000000000000000000, 0.00000000000000000000, 24250.82000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 20, 11, 2062150101, 0.0348, 15200.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 32, 11, 3042250202, 0.0096, 13000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 31, 15, 3632220201, 0.0075, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 42, 15, 3632130201, 0.0095, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 43, 7, 0, 0.0215, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(16, 45, 7, 0, 0.0017, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 22, 45, 2062100101, 0.0245, 11600.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 24, 24, 2212270404, 0.0170, 0.00000000000000000000, 0.00000000000000000000, 8308.43000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 29, 45, 2702110103, 0.0120, 20500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 20, 45, 2062150101, 0.0348, 15700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 32, 11, 3042250202, 0.0096, 13000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 31, 15, 3632220201, 0.0075, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 42, 15, 3632130201, 0.0095, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 43, 7, 0, 0.0215, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(14, 45, 7, 0, 0.0017, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 22, 24, 2062100101, 0.0245, 0.00000000000000000000, 0.00000000000000000000, 11734.65000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 24, 24, 2212270404, 0.0170, 0.00000000000000000000, 0.00000000000000000000, 8308.43000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 29, 24, 2702110103, 0.0120, 0.00000000000000000000, 0.00000000000000000000, 24250.82000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 20, 24, 2062150101, 0.0348, 0.00000000000000000000, 0.00000000000000000000, 17284.22000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 32, 11, 3042250202, 0.0096, 13000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 31, 15, 3632220201, 0.0075, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 42, 15, 3632130201, 0.0095, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 43, 7, 0, 0.0215, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(10, 45, 7, 0, 0.0017, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 22, 24, 2062100101, 0.0245, 0.00000000000000000000, 0.00000000000000000000, 9620.29000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 24, 24, 2212270404, 0.0170, 0.00000000000000000000, 0.00000000000000000000, 8308.43000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 29, 24, 2702110103, 0.0120, 0.00000000000000000000, 0.00000000000000000000, 22487.12000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 20, 24, 2062150101, 0.0348, 0.00000000000000000000, 0.00000000000000000000, 11544.34000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 32, 11, 3042250202, 0.0096, 12300.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 31, 15, 3632220201, 0.0075, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 42, 15, 3632130201, 0.0095, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 43, 7, 0, 0.0215, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(11, 45, 7, 0, 0.0017, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 22, 24, 2062100101, 0.0245, 0.00000000000000000000, 0.00000000000000000000, 14223.71000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 24, 24, 2212270404, 0.0170, 0.00000000000000000000, 0.00000000000000000000, 8300.84000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 29, 24, 2702110103, 0.0120, 0.00000000000000000000, 0.00000000000000000000, 27778.21000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 20, 24, 2062150101, 0.0348, 0.00000000000000000000, 0.00000000000000000000, 18768.32000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 32, 11, 3042250202, 0.0096, 13000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 31, 15, 3632220201, 0.0075, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 42, 15, 3632130201, 0.0095, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 43, 7, 0, 0.0215, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(9, 45, 7, 0, 0.0017, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 23, 2, 2742100405, 0.0366, 15800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 24, 2, 2212270404, 0.0175, 15800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 29, 2, 2702110103, 0.0123, 15800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 20, 2, 2742150410, 0.0187, 15800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 32, 11, 3042250202, 0.0099, 15800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 31, 15, 3632220201, 0.0131, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 42, 15, 3632130201, 0.0175, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 43, 7, 0, 0.0216, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(1, 45, 7, 0, 0.0018, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(17, 2, 15, 3632760101, 0.0282, 0.00000000000000000000, 0.00000000000000000000, 3800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(17, 3, 15, 3632760102, 0.0500, 0.00000000000000000000, 0.00000000000000000000, 3800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(17, 6, 7, 1052500201, 0.0330, 0.00000000000000000000, 9700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(17, 5, 7, 1052510201, 0.0120, 0.00000000000000000000, 8750.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(17, 4, 24, 2062390102, 0.0032, 0.00000000000000000000, 0.00000000000000000000, 12000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(17, 42, 15, 3632130201, 0.0009, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(17, 43, 7, 0, 0.0078, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(17, 45, 7, 0, 0.0001, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(18, 1, 7, 0, 0.1351, 0.00000000000000000000, 7000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 7, 15, 3632520101, 0.0434, 0.00000000000000000000, 0.00000000000000000000, 6500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 8, 15, 1052700201, 0.0252, 0.00000000000000000000, 0.00000000000000000000, 5100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 9, 15, 3632980101, 0.0280, 0.00000000000000000000, 0.00000000000000000000, 5600.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 10, 15, 3632320102, 0.0080, 0.00000000000000000000, 0.00000000000000000000, 5800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 17, 15, 3632110101, 0.0123, 0.00000000000000000000, 0.00000000000000000000, 8800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 18, 15, 3632350102, 0.0271, 0.00000000000000000000, 0.00000000000000000000, 5900.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 19, 15, 3632350101, 0.0364, 0.00000000000000000000, 0.00000000000000000000, 5400.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 11, 15, 3632440201, 0.0510, 0.00000000000000000000, 0.00000000000000000000, 5000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 12, 24, 3062390101, 0.0028, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 13, 15, 3632650102, 0.0110, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 16, 15, 3632650101, 0.0078, 0.00000000000000000000, 0.00000000000000000000, 1600.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 15, 15, 3632650104, 0.0147, 0.00000000000000000000, 0.00000000000000000000, 1650.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 14, 15, 3632650105, 0.0083, 0.00000000000000000000, 0.00000000000000000000, 1650.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 44, 7, 0, 0.0590, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 43, 7, 0, 0.0330, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(19, 45, 7, 0, 0.0030, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 38, 7, 2052010102, 0.0370, 0.00000000000000000000, 8100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 41, 7, 1052230201, 0.0150, 0.00000000000000000000, 5600.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 33, 15, 3632060101, 0.0320, 0.00000000000000000000, 0.00000000000000000000, 6000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 35, 15, 3632300101, 0.0315, 0.00000000000000000000, 0.00000000000000000000, 6000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 39, 7, 1052050201, 0.0142, 0.00000000000000000000, 8200.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 34, 7, 1052240201, 0.0056, 0.00000000000000000000, 9500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 36, 15, 3632710101, 0.0440, 0.00000000000000000000, 0.00000000000000000000, 3100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 42, 15, 3632130201, 0.0091, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 37, 15, 3632650203, 0.0038, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 44, 7, 0, 0.0264, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 43, 7, 0, 0.0267, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(20, 45, 7, 0, 0.0018, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 29, 33, 2702110103, 0.0123, 16000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 20, 33, 2742150410, 0.0187, 16000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 32, 11, 3042250202, 0.0099, 15000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 31, 15, 3632220201, 0.0131, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 42, 15, 3632130201, 0.0175, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 27, 15, 3633400201, 0.0237, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 25, 15, 3632650106, 0.0057, 0.00000000000000000000, 0.00000000000000000000, 1500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 26, 15, 3633400202, 0.0251, 0.00000000000000000000, 0.00000000000000000000, 2700.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 44, 7, 0, 0.0144, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 43, 7, 0, 0.0216, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(12, 45, 7, 0, 0.0018, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(13, 23, 33, 2742100405, 0.0366, 14174.58000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(13, 24, 33, 2212270404, 0.0175, 14174.58000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(13, 29, 33, 2702110103, 0.0123, 14174.58000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(13, 20, 33, 2742150410, 0.0187, 14174.58000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(13, 32, 11, 3042250202, 0.0099, 13000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(13, 31, 15, 3632220201, 0.0131, 0.00000000000000000000, 0.00000000000000000000, 6800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(13, 42, 15, 3632130201, 0.0175, 0.00000000000000000000, 0.00000000000000000000, 4000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(21, 40, 7, 0, 0.2471, 0.00000000000000000000, 4800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 7, 15, 3632520101, 0.0484, 0.00000000000000000000, 0.00000000000000000000, 6500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 8, 15, 1052700201, 0.0252, 0.00000000000000000000, 0.00000000000000000000, 5100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 9, 15, 3632980101, 0.0280, 0.00000000000000000000, 0.00000000000000000000, 5600.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 10, 15, 3632320102, 0.0080, 0.00000000000000000000, 0.00000000000000000000, 5800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 17, 15, 3632110101, 0.0123, 0.00000000000000000000, 0.00000000000000000000, 8800.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 18, 15, 3632350102, 0.0271, 0.00000000000000000000, 0.00000000000000000000, 5900.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 19, 15, 3632350101, 0.0364, 0.00000000000000000000, 0.00000000000000000000, 5400.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 11, 15, 3632440201, 0.0525, 0.00000000000000000000, 0.00000000000000000000, 5000.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 12, 24, 3062390101, 0.0028, 10500.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 13, 15, 3632650102, 0.0145, 0.00000000000000000000, 0.00000000000000000000, 2100.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 16, 15, 3632650101, 0.0078, 0.00000000000000000000, 0.00000000000000000000, 1600.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 15, 15, 3632650104, 0.0147, 0.00000000000000000000, 0.00000000000000000000, 1650.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 14, 15, 3632650105, 0.0083, 0.00000000000000000000, 0.00000000000000000000, 1650.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', true);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 44, 7, 0, 0.0590, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 90.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 43, 7, 0, 0.0330, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 390.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(22, 45, 7, 0, 0.0030, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(23, 46, 7, 0, 0.3710, 0.00000000000000000000, 3600.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(24, 46, 7, 0, 0.3810, 0.00000000000000000000, 3600.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);
INSERT INTO odp.producto_politica (fk_politica, fk_producto, fk_destino_costo, fk_especificacion_producto, rendimiento_media_res, precio_venta_free_on_board_usd_ton, precio_venta_free_on_track_ars_kg, precio_venta_cost_insurance_freight_usd_ton, precio_recupero_subproducto_ars_kg, costo_madurado_congelado_ars_kg, last_update, fl_aplica_costo_congelado) VALUES(25, 23, 2, 2702090102, 0.0351, 13962.16965708937800000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, 0.00000000000000000000, '2025-04-07 18:42:39.159', false);

--------------------------- ENTIDAD DEGRADACION_CALIDAD_HACIENDA ----------------------
DROP TABLE IF EXISTS modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA;
CREATE TABLE modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA (
    FK_CATEGORIA_HACIENDA_BASE                  INTEGER NOT NULL,
    FK_CALIDAD_HACIENDA_BASE                    INTEGER NOT NULL,
    RELACION                                    CHAR(1) NOT NULL,
    FK_CATEGORIA_HACIENDA_COMPARATIVA           INTEGER NOT NULL,
    FK_CALIDAD_HACIENDA_COMPARATIVA             INTEGER NOT NULL,
    FL_DOWNGRADE                                BOOLEAN NOT NULL DEFAULT FALSE,
    FL_UPGRADE                                  BOOLEAN NOT NULL DEFAULT FALSE,
    FL_EQUAL                                    BOOLEAN NOT NULL DEFAULT FALSE,
    LAST_UPDATE                                 TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (FK_CATEGORIA_HACIENDA_BASE, FK_CALIDAD_HACIENDA_BASE, FK_CATEGORIA_HACIENDA_COMPARATIVA, FK_CALIDAD_HACIENDA_COMPARATIVA),
    CONSTRAINT fk_categoria_hacienda_base_ref FOREIGN KEY (FK_CATEGORIA_HACIENDA_BASE) REFERENCES modelo_optimizacion.odp.CATEGORIA_HACIENDA(PK_CATEGORIA_HACIENDA),
    CONSTRAINT fk_calidad_hacienda_base_ref FOREIGN KEY (FK_CALIDAD_HACIENDA_BASE) REFERENCES modelo_optimizacion.odp.CALIDAD_HACIENDA(PK_CALIDAD_HACIENDA),
    CONSTRAINT fk_categoria_hacienda_comparativa_ref FOREIGN KEY (FK_CATEGORIA_HACIENDA_COMPARATIVA) REFERENCES modelo_optimizacion.odp.CATEGORIA_HACIENDA(PK_CATEGORIA_HACIENDA),
    CONSTRAINT fk_calidad_hacienda_comparativa_ref FOREIGN KEY (FK_CALIDAD_HACIENDA_COMPARATIVA) REFERENCES modelo_optimizacion.odp.CALIDAD_HACIENDA(PK_CALIDAD_HACIENDA)
);
-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA IS 'Tabla que almacena las relaciones de degradación de calidad de hacienda';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.FK_CATEGORIA_HACIENDA_BASE IS 'Clave foránea a la categoría de hacienda base';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.FK_CALIDAD_HACIENDA_BASE IS 'Clave foránea a la calidad de hacienda base';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.RELACION IS 'Relación entre la calidad de hacienda base y la calidad de hacienda comparativa. La relación puede ser: "=", "<" o ">" o "!" en caso de que la degradación de calidad no se pueda realizar. Que tenga la relación ">" significa que la calidad de hacienda base es mayor a la calidad de hacienda comparativa, por ende, se puede degradar de la hacienda base a la hacienda comparativa.';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.FK_CATEGORIA_HACIENDA_COMPARATIVA IS 'Clave foránea a la categoría de hacienda comparativa';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.FK_CALIDAD_HACIENDA_COMPARATIVA IS 'Clave foránea a la calidad de hacienda comparativa';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.FL_DOWNGRADE IS 'Flag que indica si hay degradación de calidad. Hacienda base puede degradarse a hacienda comparativa. Siempre y cuando la relación sea ">"';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.FL_UPGRADE IS 'Flag que indica si hay upgrade de calidad. Hacienda comparativa puede upgradearse a hacienda base. Siempre y cuando la relación sea "<"';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.FL_EQUAL IS 'Flag que indica si hay igualdad de calidad. No hay degradación ni upgrade. Siempre y cuando la relación sea "="';
COMMENT ON COLUMN modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_degradacion_calidad_hacienda_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_degradacion_calidad_hacienda_last_update ON modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial records
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '!', 2, 6, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '!', 2, 7, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '>', 4, 2, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '=', 4, 3, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '<', 4, 4, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '!', 6, 14, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '!', 6, 15, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '!', 6, 16, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '>', 7, 17, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '>', 7, 18, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '>', 8, 19, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 3, '>', 8, 20, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 3, 8, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 3, 9, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 3, 10, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 5, 11, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 5, 12, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 5, 13, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '!', 2, 6, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '!', 2, 7, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 4, 2, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 4, 3, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '=', 4, 4, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '!', 6, 14, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '!', 6, 15, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '!', 6, 16, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 7, 17, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 7, 18, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 8, 19, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(4, 4, '>', 8, 20, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '=', 3, 8, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '<', 3, 9, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '<', 3, 10, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '>', 5, 11, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '!', 5, 12, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '!', 5, 13, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '<', 2, 5, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '<', 2, 6, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '<', 2, 7, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '<', 4, 2, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '<', 4, 3, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '<', 4, 4, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '!', 6, 14, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '!', 6, 15, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '!', 6, 16, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '>', 7, 17, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '>', 7, 18, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '>', 8, 19, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 8, '>', 8, 20, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '>', 3, 8, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '=', 3, 9, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '<', 3, 10, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '>', 5, 11, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '>', 5, 12, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '!', 5, 13, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '<', 2, 6, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '<', 2, 7, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '!', 4, 2, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '<', 4, 3, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '<', 4, 4, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '!', 6, 14, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '!', 6, 15, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '!', 6, 16, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '>', 7, 17, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '>', 7, 18, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '>', 8, 19, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 9, '>', 8, 20, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 3, 8, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 3, 9, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '=', 3, 10, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 5, 11, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 5, 12, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 5, 13, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '!', 2, 6, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '<', 2, 7, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '!', 4, 2, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '!', 4, 3, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '<', 4, 4, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '!', 6, 14, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '!', 6, 15, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '!', 6, 16, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 7, 17, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 7, 18, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 8, 19, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(3, 10, '>', 8, 20, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 3, 8, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 3, 9, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 3, 10, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '=', 5, 11, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 5, 12, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 5, 13, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 2, 5, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 2, 6, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 2, 7, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 4, 2, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 4, 3, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '<', 4, 4, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '!', 6, 14, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '!', 6, 15, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '!', 6, 16, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '>', 7, 17, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '>', 7, 18, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '>', 8, 19, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 11, '>', 8, 20, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '!', 3, 8, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '<', 3, 9, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '<', 3, 10, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '>', 5, 11, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '=', 5, 12, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '<', 5, 13, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '<', 2, 6, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '<', 2, 7, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '!', 4, 2, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '<', 4, 3, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '<', 4, 4, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '!', 6, 14, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '!', 6, 15, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '!', 6, 16, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '>', 7, 17, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '>', 7, 18, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '>', 8, 19, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 12, '>', 8, 20, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 3, 8, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 3, 9, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '<', 3, 10, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '>', 5, 11, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '>', 5, 12, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '=', 5, 13, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 2, 6, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '<', 2, 7, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(2, 5, '>', 3, 8, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 4, 2, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 4, 3, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '<', 4, 4, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 6, 14, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 6, 15, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '!', 6, 16, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '>', 7, 17, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '>', 7, 18, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '>', 8, 19, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(5, 13, '>', 8, 20, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 3, 8, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 3, 9, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 3, 10, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 5, 11, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 5, 12, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 5, 13, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 2, 6, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 2, 7, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 4, 2, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 4, 3, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 4, 4, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '=', 6, 14, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '<', 6, 15, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '<', 6, 16, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 7, 17, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 7, 18, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 8, 19, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 14, '!', 8, 20, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 3, 8, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 3, 9, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 3, 10, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 5, 11, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 5, 12, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 5, 13, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 2, 6, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 2, 7, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 4, 2, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 4, 3, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 4, 4, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '>', 6, 14, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '=', 6, 15, false, false, true, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '<', 6, 16, false, true, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 7, 17, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 7, 18, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 8, 19, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 15, '!', 8, 20, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 3, 8, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 3, 9, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 3, 10, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 5, 11, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 5, 12, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 5, 13, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 2, 5, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 2, 6, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 2, 7, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 4, 2, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 4, 3, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '!', 4, 4, false, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '>', 6, 14, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '>', 6, 15, true, false, false, '2025-04-07 18:42:38.281');
INSERT INTO odp.degradacion_calidad_hacienda (fk_categoria_hacienda_base, fk_calidad_hacienda_base, relacion, fk_categoria_hacienda_comparativa, fk_calidad_hacienda_comparativa, fl_downgrade, fl_upgrade, fl_equal, last_update) VALUES(6, 16, '=', 6, 16, false, false, true, '2025-04-07 18:42:38.281');

-- DIMENSION DEGRADACION CALIDAD HACIENDA
DROP VIEW IF EXISTS modelo_optimizacion.odp.dim_degradacion_calidad_hacienda;
CREATE VIEW modelo_optimizacion.odp.dim_degradacion_calidad_hacienda AS
SELECT
    d.FK_CATEGORIA_HACIENDA_BASE 			AS  FK_CATEGORIA_HACIENDA_BASE,
    d.FK_CALIDAD_HACIENDA_BASE				AS 	FK_CALIDAD_HACIENDA_BASE,
    d.FK_CATEGORIA_HACIENDA_COMPARATIVA		AS 	FK_CATEGORIA_HACIENDA_COMPARATIVA,
    d.FK_CALIDAD_HACIENDA_COMPARATIVA 		AS 	FK_CALIDAD_HACIENDA_COMPARATIVA,
    cb.NOMBRE_CATEGORIA 					AS 	NOMBRE_CATEGORIA_HACIENDA_BASE,
    ch.NOMBRE_CALIDAD 						AS 	NOMBRE_CALIDAD_HACIENDA_BASE,
    d.RELACION 								AS 	RELACION,
    cc.NOMBRE_CATEGORIA 					AS 	NOMBRE_CATEGORIA_HACIENDA_COMPARATIVA,
    chc.NOMBRE_CALIDAD 						AS 	NOMBRE_CALIDAD_HACIENDA_COMPARATIVA,
    d.FL_DOWNGRADE 							AS 	FL_DOWNGRADE,
    d.FL_UPGRADE 							AS 	FL_UPGRADE,
    d.FL_EQUAL 								AS 	FL_EQUAL,
    d.LAST_UPDATE 							AS 	LAST_UPDATE
FROM
    modelo_optimizacion.odp.DEGRADACION_CALIDAD_HACIENDA 	d
    LEFT JOIN modelo_optimizacion.odp.CATEGORIA_HACIENDA 	cb 	ON d.FK_CATEGORIA_HACIENDA_BASE = cb.PK_CATEGORIA_HACIENDA
    LEFT JOIN modelo_optimizacion.odp.CALIDAD_HACIENDA 		ch 	ON d.FK_CALIDAD_HACIENDA_BASE = ch.PK_CALIDAD_HACIENDA
    LEFT JOIN modelo_optimizacion.odp.CATEGORIA_HACIENDA 	cc 	ON d.FK_CATEGORIA_HACIENDA_COMPARATIVA = cc.PK_CATEGORIA_HACIENDA
    LEFT JOIN modelo_optimizacion.odp.CALIDAD_HACIENDA 		chc ON d.FK_CALIDAD_HACIENDA_COMPARATIVA = chc.PK_CALIDAD_HACIENDA;
-- Documentación
COMMENT ON VIEW modelo_optimizacion.odp.dim_degradacion_calidad_hacienda IS 'Vista que almacena las relaciones de degradación de calidad de hacienda. Entidades: DEGRADACION_CALIDAD_HACIENDA, CATEGORIA_HACIENDA, CALIDAD_HACIENDA';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.FK_CATEGORIA_HACIENDA_BASE IS 'Clave foránea a la categoría de hacienda base';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.FK_CALIDAD_HACIENDA_BASE IS 'Clave foránea a la calidad de hacienda base';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.NOMBRE_CATEGORIA_HACIENDA_BASE IS 'Nombre de la categoría de hacienda base';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.NOMBRE_CALIDAD_HACIENDA_BASE IS 'Nombre de la calidad de hacienda base';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.RELACION IS 'Relación entre la calidad de hacienda base y la calidad de hacienda comparativa. La relación puede ser: "=", "<" o ">" o "!" en caso de que la degradación de calidad no se pueda realizar. Que tenga la relación ">" significa que la calidad de hacienda base es mayor a la calidad de hacienda comparativa, por ende, se puede degradar de la hacienda base a la hacienda comparativa.';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.FK_CATEGORIA_HACIENDA_COMPARATIVA IS 'Clave foránea a la categoría de hacienda comparativa';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.NOMBRE_CATEGORIA_HACIENDA_COMPARATIVA IS 'Nombre de la categoría de hacienda comparativa';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.NOMBRE_CALIDAD_HACIENDA_COMPARATIVA IS 'Nombre de la calidad de hacienda comparativa';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.FL_DOWNGRADE IS 'Flag que indica si hay degradación de calidad. Hacienda base puede degradarse a hacienda comparativa. Siempre y cuando la relación sea ">"';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.FL_UPGRADE IS 'Flag que indica si hay upgrade de calidad. Hacienda comparativa puede upgradearse a hacienda base. Siempre y cuando la relación sea "<"';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.FL_EQUAL IS 'Flag que indica si hay igualdad de calidad. No hay degradación ni upgrade. Siempre y cuando la relación sea "="';
COMMENT ON COLUMN modelo_optimizacion.odp.dim_degradacion_calidad_hacienda.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Entidad MERCADO_CUOTA
DROP TABLE IF EXISTS modelo_optimizacion.odp.MERCADO_CUOTA;
CREATE TABLE modelo_optimizacion.odp.MERCADO_CUOTA (
    PK_CUOTA                    INTEGER NOT NULL,
    FK_MERCADO                  INTEGER NOT NULL,
    FK_CATEGORIA_HACIENDA       INTEGER NOT NULL,
    NOMBRE_CUOTA                VARCHAR(100) NOT NULL,
    PREFERENCIA_ARANCELARIA     DECIMAL(6,5)NOT NULL,
    MES_INICIO_CUOTA            INT NOT NULL,
    DIA_INICIO_CUOTA            INT NOT NULL,
    TONELAJE_MAX_ANUAL          DECIMAL(10,2) NOT NULL,
    TONELAJE_MIN_MENSUAL        DECIMAL(10,2) NOT NULL,
    TONELAJE_MAX_MENSUAL        DECIMAL(10,2) NOT NULL,
    TONELAJE_MAX_TRIMESTRAL     DECIMAL(10,2) NOT NULL,
    DESCRIPCION                 VARCHAR(1000) DEFAULT 'SIN ASIGNAR',
    LAST_UPDATE                 TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (PK_CUOTA),
    CONSTRAINT fk_mercad_ref FOREIGN KEY (FK_MERCADO)   REFERENCES modelo_optimizacion.odp.MERCADO(PK_MERCADO),
    CONSTRAINT fk_categoria_hacienda_ref FOREIGN KEY (FK_CATEGORIA_HACIENDA) REFERENCES modelo_optimizacion.odp.CATEGORIA_HACIENDA(PK_CATEGORIA_HACIENDA)
);

-- Add comments for documentation
COMMENT ON TABLE modelo_optimizacion.odp.MERCADO_CUOTA IS 'Tabla que almacena la información de las cuotas de mercado y sus preferencias arancelarias.';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.PK_CUOTA IS 'Clave primaria de la entidad MERCADO_CUOTA. Identificación única de cada cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.FK_MERCADO IS 'Clave foránea a la entidad MERCADO';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.FK_CATEGORIA_HACIENDA IS 'Clave foránea a la entidad CATEGORIA_HACIENDA';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.NOMBRE_CUOTA IS 'Nombre de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.TONELAJE_MAX_ANUAL IS 'Tonelaje máximo anual de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.TONELAJE_MIN_MENSUAL IS 'Tonelaje mínimo mensual de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.TONELAJE_MAX_MENSUAL IS 'Tonelaje máximo mensual de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.TONELAJE_MAX_TRIMESTRAL IS 'Tonelaje máximo trimestral de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.PREFERENCIA_ARANCELARIA IS 'Preferencia arancelaria de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.MES_INICIO_CUOTA IS 'Mes de inicio de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.DIA_INICIO_CUOTA IS 'Día de inicio de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.DESCRIPCION IS 'Descripción de la cuota';
COMMENT ON COLUMN modelo_optimizacion.odp.MERCADO_CUOTA.LAST_UPDATE IS 'Fecha y hora de la última actualización del registro';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_mercado_cuota_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.MERCADO_CUOTA
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_mercado_cuota_last_update ON modelo_optimizacion.odp.MERCADO_CUOTA 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';


-- Insert initial records
INSERT INTO modelo_optimizacion.odp.MERCADO_CUOTA 
(PK_CUOTA, FK_MERCADO, FK_CATEGORIA_HACIENDA, NOMBRE_CUOTA, TONELAJE_MAX_ANUAL, TONELAJE_MIN_MENSUAL, TONELAJE_MAX_MENSUAL, TONELAJE_MAX_TRIMESTRAL, PREFERENCIA_ARANCELARIA, MES_INICIO_CUOTA, DIA_INICIO_CUOTA, DESCRIPCION)
VALUES 
    (0, 0, 0, 'SIN ASIGNAR', -1, 0, 0, -1, 0.0, 0, 0, 'SIN ASIGNAR'),
    (1, 6, 2, 'CUOTA HILTON EUROPA PARA ARGENTINA', 1822, 137, 168, -1, 0.2, 0, 0, 'Es la cantidad de kg que se puede exportar a EU con una tarifa arancelaria preferencial. No hay restricciones respecto al corte, pero siempre se apunta a vender los cortes de mayor valor (al ser una reducción porcentual, cortes de mayor valor dan lugar a mayor ahorro/ganancia). En principio, la Cuota Hilton es competencia entre empresas argentinas, pero para evitar competencia per se, se define previamente qué porcentaje de la cuota exporta cada productor argentino. Esto cambia según la performance histórica de cada productor. También se puede devolver tantas toneladas de cuota a un pozo y que lo tomen otros productores. Esto evita que te penalicen si no cumples con la cuota. La cuota es un input del modelo, que se podría modificar en base a si pediste más volumen o lo devolviste al pozo.'),
    (2, 7, 2, 'CUOTA HILTON UNITED KINGDOM', 111, 9, 11, -1, 0.2, 6, 30, 'Es la cantidad de kg que se puede exportar a INGLATERRA con una tarifa arancelaria preferencial. No hay restricciones respecto al corte, pero siempre se apunta a vender los cortes de mayor valor (al ser una reducción porcentual, cortes de mayor valor dan lugar a mayor ahorro/ganancia). En principio, la Cuota Hilton es competencia entre empresas argentinas, pero para evitar competencia per se, se define previamente qué porcentaje de la cuota exporta cada productor argentino. Esto cambia según la performance histórica de cada productor. También se puede devolver tantas toneladas de cuota a un pozo y que lo tomen otros productores. Esto evita que te penalicen si no cumples con la cuota. La cuota es un input del modelo, que se podría modificar en base a si pediste más volumen o lo devolviste al pozo.'),
    (3, 6, 4, 'CUOTA 481', 44000, 3300, 4034, 11500, 1.0, 0, 0, 'Tiene la peculiaridad de que es una asignación para todos los países que no son ESTADOS UNIDOS, por lo que Argentina compite con el resto de los otros países. Tienen que ser de origen feedlot.  INTERNACIONAL EXCEPTO ESTADOS UNIDOS.'),
    (4, 3, 5, 'USA', 2000, 150, 184, -1, 0.264, 0, 0, 'Es similar a la Hilton pero no tiene la restriccion de que los animales tienen que ser grassfed. Al igual que la Cuota Hilton, la Cuota ESTADOS UNIDOS es competencia entre empresas argentinas, pero para evitar competencia per se, se define previamente qué porcentaje de la cuota exporta cada productor argentino. Esto cambia según la performance histórica de cada productor. También se puede devolver tantas toneladas de cuota a un pozo y que lo tomen otros productores. Esto evita que te penalicen si no cumples con la cuota.');

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.MERCADO_CUOTA ALTER COLUMN PK_CUOTA DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.MERCADO_CUOTA ALTER COLUMN PK_CUOTA ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.MERCADO_CUOTA', 'pk_cuota'), 
    (SELECT MAX(pk_cuota) FROM modelo_optimizacion.odp.MERCADO_CUOTA), 
    true
);

-- Entidad PRODUCTO_MERCADO_CUOTA
DROP TABLE IF EXISTS modelo_optimizacion.odp.PRODUCTO_MERCADO_CUOTA;
CREATE TABLE modelo_optimizacion.odp.PRODUCTO_MERCADO_CUOTA (
    FK_PRODUCTO INTEGER NOT NULL,
    FK_CUOTA    INTEGER NOT NULL,
    LAST_UPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (FK_PRODUCTO, FK_CUOTA),
    CONSTRAINT fk_producto_ref FOREIGN KEY (FK_PRODUCTO) REFERENCES modelo_optimizacion.odp.PRODUCTO(PK_PRODUCTO),
    CONSTRAINT fk_cuota_ref FOREIGN KEY (FK_CUOTA) REFERENCES modelo_optimizacion.odp.MERCADO_CUOTA(PK_CUOTA)
);

-- Documentación
COMMENT ON TABLE modelo_optimizacion.odp.PRODUCTO_MERCADO_CUOTA IS 'Tabla que almacena la relación entre productos y cuotas de mercado. Define que producto puede exportar a que cuota.';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_MERCADO_CUOTA.FK_PRODUCTO IS 'Clave foránea a la entidad PRODUCTO';
COMMENT ON COLUMN modelo_optimizacion.odp.PRODUCTO_MERCADO_CUOTA.FK_CUOTA IS 'Clave foránea a la entidad MERCADO_CUOTA';

-- Create trigger for last_update
CREATE TRIGGER trigger_update_producto_mercado_cuota_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.PRODUCTO_MERCADO_CUOTA
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Add comment to trigger
COMMENT ON TRIGGER trigger_update_producto_mercado_cuota_last_update ON modelo_optimizacion.odp.PRODUCTO_MERCADO_CUOTA 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert initial records
INSERT INTO modelo_optimizacion.odp.PRODUCTO_MERCADO_CUOTA 
(FK_PRODUCTO, FK_CUOTA)
VALUES 
    (0,0),
    (22,4),
    (24,4),
    (29,4),
    (20,4),
    (12,4),
    (23,1),
    (24,1),
    (29,1),
    (20,1),
    (30,1),
    (20,2),
    (24,2),
    (29,2),
    (23,3),
    (24,3),
    (29,3),
    (20,3);


-------------- RESULTS --------------
CREATE TABLE modelo_optimizacion.odp.ejecucion_modelo_optimizacion (
    pk_ejecucion_modelo_optimizacion SERIAL PRIMARY KEY,
    nombre_ejecucion VARCHAR(255) NOT NULL,
    fecha_ejecucion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    json_data JSONB NOT null,
    fl_version_valida boolean NOT NULL DEFAULT true,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Agregar comentarios a la tabla y sus columnas
COMMENT ON TABLE modelo_optimizacion.odp.ejecucion_modelo_optimizacion IS 'Tabla que almacena las ejecuciones del modelo de optimización con sus parámetros y resultados';

COMMENT ON COLUMN modelo_optimizacion.odp.ejecucion_modelo_optimizacion.pk_ejecucion_modelo_optimizacion IS 'Identificador único auto-incremental de la ejecución del modelo';

COMMENT ON COLUMN modelo_optimizacion.odp.ejecucion_modelo_optimizacion.nombre_ejecucion IS 'Nombre descriptivo de la ejecución del modelo para facilitar su identificación';

COMMENT ON COLUMN modelo_optimizacion.odp.ejecucion_modelo_optimizacion.fecha_ejecucion IS 'Fecha y hora en que se realizó/guardó la ejecución del modelo';

COMMENT ON COLUMN modelo_optimizacion.odp.ejecucion_modelo_optimizacion.json_data IS 'Datos de la ejecución en formato JSON, incluyendo parámetros de entrada y resultados del modelo';

COMMENT ON COLUMN odp.ejecucion_modelo_optimizacion.fl_version_valida IS 'Indica si la version tiene una estructura de datos valida en comparcion con el modelo de datos que tiene la pagina web. En caso de que no sea valida, la version no podra ser utilizada en la web del modelo.';

COMMENT ON COLUMN modelo_optimizacion.odp.ejecucion_modelo_optimizacion.last_update IS 'Fecha y hora de la última actualización del registro.';

-- Index on fecha_ejecucion for time-based queries
CREATE INDEX idx_ejecucion_fecha 
ON modelo_optimizacion.odp.ejecucion_modelo_optimizacion(fecha_ejecucion);

-- Index on nombre_ejecucion for name-based searches
CREATE INDEX idx_ejecucion_nombre 
ON modelo_optimizacion.odp.ejecucion_modelo_optimizacion(nombre_ejecucion);

-- GIN(Generalized Inverted Index) index on json_data for JSON content searches
CREATE INDEX idx_json_data 
ON modelo_optimizacion.odp.ejecucion_modelo_optimizacion USING GIN (json_data);

-- Crear el trigger para actualizar LAST_UPDATE
CREATE TRIGGER trigger_update_ejecucion_modelo_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.ejecucion_modelo_optimizacion
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Agregar comentario al trigger
COMMENT ON TRIGGER trigger_update_ejecucion_modelo_last_update ON modelo_optimizacion.odp.ejecucion_modelo_optimizacion 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

 -- Crear función
CREATE OR REPLACE FUNCTION set_fecha_ejecucion_default() 
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.fecha_ejecucion IS NULL THEN
        NEW.fecha_ejecucion = NEW.last_update;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Comentario para la función
COMMENT ON FUNCTION set_fecha_ejecucion_default() 
IS 'Asigna automáticamente last_update a fecha_ejecucion cuando este último es NULL. Se ejecuta antes de operaciones INSERT/UPDATE.';

-- Crear trigger
CREATE TRIGGER trg_set_fecha_ejecucion
BEFORE INSERT OR UPDATE ON modelo_optimizacion.odp.ejecucion_modelo_optimizacion
FOR EACH ROW EXECUTE FUNCTION set_fecha_ejecucion_default();

-- Comentario para el trigger
COMMENT ON TRIGGER trg_set_fecha_ejecucion ON modelo_optimizacion.odp.ejecucion_modelo_optimizacion 
IS 'Trigger que garantiza que fecha_ejecucion herede el valor de last_update cuando no se especifica. Actúa a nivel de fila antes de insertar/actualizar.';


-- Creación de la tabla de relación de producto, especificacion y costo de mano de obra
CREATE TABLE modelo_optimizacion.odp.producto_especificacion_mano_de_obra (
    FK_ESPECIFICACION_PRODUCTO BIGINT NOT NULL,
    FK_PRODUCTO INT NOT NULL,
    FACTOR_COSTO_MANO_OBRA_DESPOSTADA DECIMAL(3,2) DEFAULT 1.00,
    LAST_UPDATE TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (FK_ESPECIFICACION_PRODUCTO),
    CONSTRAINT fk_producto_ref FOREIGN KEY (FK_PRODUCTO) REFERENCES modelo_optimizacion.odp.PRODUCTO(PK_PRODUCTO)
);

-- Comentarios de la tabla
COMMENT ON TABLE modelo_optimizacion.odp.producto_especificacion_mano_de_obra 
    IS 'Tabla que establece la relacion entre producto, especificacion y su costo de mano de obra a partir de un factor de mano de obra. El valor del factor se establece arbitrariamente.';

-- Comentarios de columnas
COMMENT ON COLUMN modelo_optimizacion.odp.producto_especificacion_mano_de_obra.FK_PRODUCTO 
    IS 'Clave foránea que referencia al producto (ODP.PRODUCTO)';
COMMENT ON COLUMN modelo_optimizacion.odp.producto_especificacion_mano_de_obra.FK_ESPECIFICACION_PRODUCTO 
    IS 'Clave foránea que referencia a la especificación del producto';
COMMENT ON COLUMN modelo_optimizacion.odp.producto_especificacion_mano_de_obra.FACTOR_COSTO_MANO_OBRA_DESPOSTADA 
    IS 'Factor multiplicativo para el cálculo del costo de mano de obra despostada (hasta 2 decimales). Se utiliza para calcular el costo de mano de obra despostada a partir del costo de mano de obra despostada base.';
COMMENT ON COLUMN modelo_optimizacion.odp.producto_especificacion_mano_de_obra.LAST_UPDATE 
    IS 'Fecha y hora de última actualización (se actualiza automáticamente mediante trigger)';

-- Crear trigger para last_update (similar al existente en PRODUCTO)
CREATE TRIGGER trigger_update_mano_obra_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.producto_especificacion_mano_de_obra
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Comentario del trigger
COMMENT ON TRIGGER trigger_update_mano_obra_last_update ON modelo_optimizacion.odp.producto_especificacion_mano_de_obra 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';

-- Insert data into producto_especificacion_mano_de_obra
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632650104, 15, 0.80, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632650105, 14, 0.80, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2052010102, 38, 0.90, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(1052230201, 41, 0.90, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632060101, 33, 0.90, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632300101, 35, 0.90, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(1052050201, 39, 0.90, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(1052240201, 34, 0.90, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632710101, 36, 0.90, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632650203, 37, 0.80, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2702110103, 29, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(1052700201, 8, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(0, 0, 0.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632220201, 31, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632130201, 42, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3633400201, 27, 0.80, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632650106, 25, 0.80, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3633400202, 26, 0.80, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2742100405, 23, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2212270404, 24, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2742110407, 29, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2742150410, 20, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3042250202, 32, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2702090102, 23, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2752090406, 23, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2782000201, 30, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2062150101, 20, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2062100101, 22, 1.20, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632760101, 2, 1.50, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632760102, 3, 1.50, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(1052500201, 6, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(1052510201, 5, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(2062390102, 4, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632520101, 7, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632700102, 8, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632980101, 9, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632320102, 10, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632110101, 17, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632350102, 18, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632350101, 19, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632440201, 11, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3062390101, 12, 1.00, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632650102, 13, 0.80, '2025-04-07 18:42:40.320');
INSERT INTO odp.producto_especificacion_mano_de_obra (fk_especificacion_producto, fk_producto, factor_costo_mano_obra_despostada, last_update) VALUES(3632650101, 16, 0.80, '2025-04-07 18:42:40.320');


-- Tabla de costos de transporte por mercado. Se utiliza para automatizar los costos por kg de los productos de una politica.
CREATE TABLE modelo_optimizacion.odp.costo_destino_transporte (
    pk_costo_destino_transporte     INT NOT NULL,
    fk_destino                      INT NOT NULL DEFAULT 0,
    nombre_costo_destino_transporte VARCHAR(255) NOT NULL,
    monto                           DECIMAL(14,2) NOT NULL CHECK (monto >= 0.00),
    fl_monto_por_contenedor         BOOLEAN NOT NULL DEFAULT FALSE,
    fl_monto_por_viaje              BOOLEAN NOT NULL DEFAULT FALSE,
    fl_monto_por_kg                 BOOLEAN NOT NULL DEFAULT FALSE,
    fl_monto_usd                    BOOLEAN NOT NULL DEFAULT FALSE,
    fl_monto_ars                    BOOLEAN NOT NULL DEFAULT FALSE,
    fl_documentacion_embarque       BOOLEAN NOT NULL DEFAULT FALSE,
    fl_retiro_contenedor            BOOLEAN NOT NULL DEFAULT FALSE,
    fl_flete_terrestre              BOOLEAN NOT NULL DEFAULT FALSE,
    fl_flete_maritimo               BOOLEAN NOT NULL DEFAULT FALSE,
    fl_flete_aereo                  BOOLEAN NOT NULL DEFAULT FALSE,
    fl_congelado                    BOOLEAN NOT NULL DEFAULT FALSE,
    last_update                     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (pk_costo_destino_transporte),
    CONSTRAINT fk_destino_ref FOREIGN KEY (fk_destino) REFERENCES modelo_optimizacion.odp.destino(pk_destino)
);

-- Comentarios de la tabla
COMMENT ON TABLE modelo_optimizacion.odp.costo_destino_transporte 
    IS 'Tabla que almacena los costos de transporte por destino. Si no tiene un destino asignado en particular(fk_destino=0), entonces aplica a todos los los productos de una politica sin importar su destino excepto que haya costos asociados a destinos específicos. Se utiliza para automatizar los costos por kg de los productos de una politica.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.pk_costo_destino_transporte 
    IS 'Identificador único del costo de transporte por mercado.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fk_destino 
    IS 'Identificador del destino al que aplica el costo de transporte. Si es 0, aplica a todos los destinos excepto a los destinos que tengan el mismo costo pero asignado a un destino en particular.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.nombre_costo_destino_transporte 
    IS 'Nombre del costo de transporte por destino aplicado a los productos de una politica.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.monto 
    IS 'Monto del costo de transporte. Si fl_monto_por_contenedor es TRUE, entonces este monto se aplica por contenedor. Si fl_monto_por_viaje es TRUE, entonces este monto se aplica por viaje. Si fl_monto_usd es TRUE, entonces este monto se aplica en USD. Si fl_monto_ars es TRUE, entonces este monto se aplica en ARS.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_monto_por_contenedor 
    IS 'Indica si el monto se aplica por contenedor. Si es TRUE, el monto se aplica por contenedor.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_monto_por_viaje 
    IS 'Indica si el monto se aplica por viaje. Si es TRUE, el monto se aplica por viaje.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_monto_por_kg 
    IS 'Indica si el monto se aplica por kg. Si es TRUE, el monto se aplica por kg.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_monto_usd 
    IS 'Indica si el monto se aplica en USD. Si es TRUE, el monto se encuentra representado en USD.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_monto_ars 
    IS 'Indica si el monto se aplica en ARS. Si es TRUE, el monto se encuentra representado en ARS.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_documentacion_embarque 
    IS 'Indica si el monto esta asociado al costo de documentacion de embarque. Si es TRUE, el monto se aplica al costo de documentacion de embarque.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_retiro_contenedor 
    IS 'Indica si el monto esta asociado al retiro de contenedor. Si es TRUE, el monto se aplica al retiro de contenedor.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_flete_terrestre 
    IS 'Indica si el monto esta asociado al flete terrestre. Si es TRUE, el monto se aplica al flete terrestre.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_flete_maritimo 
    IS 'Indica si el monto esta asociado al flete marítimo. Si es TRUE, el monto se aplica al flete marítimo.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_flete_aereo 
    IS 'Indica si el monto esta asociado al flete aéreo. Si es TRUE, el monto se aplica al flete aéreo.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.fl_congelado 
    IS 'Indica si el monto esta asociado al congelamiento del producto. Si es TRUE, el monto se aplica al producto que viaja congelado.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_destino_transporte.last_update 
    IS 'Fecha y hora de la última actualización del registro.';

-- Crear trigger para last_update (similar al existente en PRODUCTO)
CREATE TRIGGER trigger_update_costo_destino_transporte_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.costo_destino_transporte
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Comentario del trigger
COMMENT ON TRIGGER trigger_update_costo_destino_transporte_last_update ON modelo_optimizacion.odp.costo_destino_transporte 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';


-- Insert default data into costo_destino_transporte
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(0, 0, 'SIN ASIGNAR', 0.00, false, false, false, false, false, false, false, false, false, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(1, 0, 'DOCUMENTACION DE EMBARQUE', 600.00, true, false, false, true, false, true, false, false, false, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(2, 0, 'RETIRO DE CONTENEDOR', 250000.00, true, false, false, false, true, false, true, false, false, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(3, 0, 'FLETE TERRESTRE', 300000.00, false, true, false, false, true, false, false, true, false, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(4, 15, 'FLETE MARITIMO CHINA', 3100.00, true, false, false, true, false, false, false, false, true, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(5, 24, 'FLETE MARITIMO ESTADOS UNIDOS', 4800.00, true, false, false, true, false, false, false, false, true, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(6, 30, 'FLETE MARITIMO UNITED KINGDOM', 2700.00, true, false, false, true, false, false, false, false, true, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(7, 11, 'FLETE TERRESTRE BRAZIL', 0.00, false, true, false, false, true, false, false, true, false, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(8, 7, 'FLETE TERRESTRE ARGENTINA', 0.00, false, true, false, false, true, false, false, true, false, false, false, '2025-04-07 18:42:40.409');
INSERT INTO odp.costo_destino_transporte (pk_costo_destino_transporte, fk_destino, nombre_costo_destino_transporte, monto, fl_monto_por_contenedor, fl_monto_por_viaje, fl_monto_por_kg, fl_monto_usd, fl_monto_ars, fl_documentacion_embarque, fl_retiro_contenedor, fl_flete_terrestre, fl_flete_maritimo, fl_flete_aereo, fl_congelado, last_update) VALUES(9, 0, 'COSTO CONGELADO', 100.00, false, false, true, false, true, false, false, false, false, false, true, '2025-04-07 18:42:40.409');
    
-- Add contraint of unique nombre_costo_destino_transporte
ALTER TABLE modelo_optimizacion.odp.costo_destino_transporte
ADD CONSTRAINT unique_nombre_costo_destino_transporte
UNIQUE (nombre_costo_destino_transporte);

-- -- Convert pk_costo_destino_transporte to an IDENTITY column and restart the sequence to avoid conflicts with existing data
ALTER TABLE modelo_optimizacion.odp.costo_destino_transporte ALTER COLUMN pk_costo_destino_transporte ADD GENERATED ALWAYS AS IDENTITY;
SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.costo_destino_transporte', 'pk_costo_destino_transporte'),
    (SELECT MAX(pk_costo_destino_transporte) + 1 FROM modelo_optimizacion.odp.costo_destino_transporte),
    true
);
    
-- Tabla relacion entre producto, mercado y contenedor
CREATE TABLE modelo_optimizacion.odp.producto_destino_contenedor (
    fk_producto             INT NOT NULL DEFAULT 0,
    fk_destino              INT NOT NULL DEFAULT 0,
    kg_por_caja             DECIMAL(4,2) NOT NULL CHECK (kg_por_caja > 0.00),
    cajas_por_contenedor    INT NOT NULL CHECK (cajas_por_contenedor > 0),
    last_update             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (fk_producto, fk_destino),
    CONSTRAINT fk_producto_ref  FOREIGN KEY (fk_producto) REFERENCES modelo_optimizacion.odp.producto(pk_producto),
    CONSTRAINT fk_destino_ref   FOREIGN KEY (fk_destino) REFERENCES modelo_optimizacion.odp.destino(pk_destino)
);

-- Comentarios de la tabla
COMMENT ON TABLE modelo_optimizacion.odp.producto_destino_contenedor 
    IS 'Tabla que almacena la relación entre productos, mercados y contenedores. Se utiliza para automatizar el calculo del costo de documentacion de embarque por kg de los productos de una politica.';

COMMENT ON COLUMN modelo_optimizacion.odp.producto_destino_contenedor.fk_producto 
    IS 'Identificador del producto de la entidad PRODUCTO. Si es 0, aplica a todos los productos excepto a los productos que tengan el mismo identificador de producto pero asignado a un mercado en particular.';

COMMENT ON COLUMN modelo_optimizacion.odp.producto_destino_contenedor.fk_destino 
    IS 'Identificador del destino de la entidad DESTINO. Si es 0, aplica a todos los destinos excepto a los destinos que tengan el mismo identificador de destino pero asignado a un producto en particular.';

COMMENT ON COLUMN modelo_optimizacion.odp.producto_destino_contenedor.kg_por_caja 
    IS 'Cantidad de kg por caja.';

COMMENT ON COLUMN modelo_optimizacion.odp.producto_destino_contenedor.cajas_por_contenedor 
    IS 'Cantidad de cajas por contenedor.';

COMMENT ON COLUMN modelo_optimizacion.odp.producto_destino_contenedor.last_update 
    IS 'Fecha y hora de la última actualización del registro.';


-- Crear trigger para last_update
CREATE TRIGGER trigger_update_producto_destino_contenedor_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.producto_destino_contenedor
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Comentario del trigger
COMMENT ON TRIGGER trigger_update_producto_destino_contenedor_last_update ON modelo_optimizacion.odp.producto_destino_contenedor 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones';


-- Insert default data into producto_destino_contenedor
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(0, 15, 22.33, 1200, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(13, 15, 18.67, 1400, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(16, 15, 19.81, 1300, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(15, 15, 13.30, 1400, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(14, 15, 18.19, 1400, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(37, 15, 20.82, 1250, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(27, 15, 12.00, 1400, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(25, 15, 16.18, 1400, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(26, 15, 16.68, 1400, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(0, 24, 22.33, 1100, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(0, 30, 20.00, 550, '2025-04-07 18:42:40.386');
INSERT INTO odp.producto_destino_contenedor (fk_producto, fk_destino, kg_por_caja, cajas_por_contenedor, last_update) VALUES(0, 0, 18.21, 1255, '2025-04-07 18:30:08.060');


-- COTIZACION_DOLAR
CREATE TABLE modelo_optimizacion.odp.cotizacion_dolar (
    pk_cotizacion_dolar                         BIGINT NOT NULL,
    cotizacion_dolar_oficial                    DECIMAL(10,2) NOT NULL CHECK (cotizacion_dolar_oficial > 0.00),
    cotizacion_dolar_contado_con_liquidacion    DECIMAL(10,2) NOT NULL CHECK (cotizacion_dolar_contado_con_liquidacion > 0.00),
    porcentaje_dolar_oficial                    DECIMAL(10,2) NOT NULL CHECK (porcentaje_dolar_oficial >= 0.00 AND porcentaje_dolar_oficial <= 100.00),
    porcentaje_dolar_contado_con_liquidacion    DECIMAL(10,2) NOT NULL CHECK (porcentaje_dolar_contado_con_liquidacion >= 0.00 AND porcentaje_dolar_contado_con_liquidacion <= 100.00),
    last_update                                 TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (pk_cotizacion_dolar)
);

-- Comentarios de la tabla
COMMENT ON TABLE modelo_optimizacion.odp.cotizacion_dolar 
    IS 'Tabla que almacena las cotizaciones del dólar con respecto al peso argentino para calcular el dolar blend.';

COMMENT ON COLUMN modelo_optimizacion.odp.cotizacion_dolar.pk_cotizacion_dolar 
    IS 'Identificador único de la cotización del dólar.';

COMMENT ON COLUMN modelo_optimizacion.odp.cotizacion_dolar.cotizacion_dolar_oficial 
    IS 'Cotización del dólar oficial.';

COMMENT ON COLUMN modelo_optimizacion.odp.cotizacion_dolar.cotizacion_dolar_contado_con_liquidacion 
    IS 'Cotización del dólar contado con liquidación.';

COMMENT ON COLUMN modelo_optimizacion.odp.cotizacion_dolar.porcentaje_dolar_oficial 
    IS 'Porcentaje de la cotización del dólar oficial. Se utiliza para calcular el dolar blend.';

COMMENT ON COLUMN modelo_optimizacion.odp.cotizacion_dolar.porcentaje_dolar_contado_con_liquidacion 
    IS 'Porcentaje de la cotización del dólar contado con liquidación. Se utiliza para calcular el dolar blend.';

COMMENT ON COLUMN modelo_optimizacion.odp.cotizacion_dolar.last_update 
    IS 'Fecha y hora de la última actualización del registro. Fecha en la que se actualiza la cotizacion del dolar.';

-- Agregar constraint de que porcentaje_dolar_oficial + porcentaje_dolar_contado_con_liquidacion = 100
ALTER TABLE modelo_optimizacion.odp.cotizacion_dolar
ADD CONSTRAINT check_porcentaje_dolar
CHECK (porcentaje_dolar_oficial + porcentaje_dolar_contado_con_liquidacion = 100.00);


-- Crear trigger para last_update
CREATE TRIGGER trigger_update_cotizacion_dolar_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.cotizacion_dolar
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Comentario del trigger
COMMENT ON TRIGGER trigger_update_cotizacion_dolar_last_update ON modelo_optimizacion.odp.cotizacion_dolar 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones. Fecha en la que se actualiza la cotizacion del dolar.';

-- Crear índice en last_update para consultas frecuentes. Este índice sería útil si, por ejemplo, necesitas obtener la cotización más reciente o realizar análisis temporales de las cotizaciones.
CREATE INDEX idx_cotizacion_dolar_last_update 
ON modelo_optimizacion.odp.cotizacion_dolar(last_update);

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.cotizacion_dolar ALTER COLUMN pk_cotizacion_dolar DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.cotizacion_dolar ALTER COLUMN pk_cotizacion_dolar ADD GENERATED ALWAYS AS IDENTITY;

-- Insert default data into cotizacion_dolar
INSERT INTO odp.cotizacion_dolar
(cotizacion_dolar_oficial, cotizacion_dolar_contado_con_liquidacion, porcentaje_dolar_oficial, porcentaje_dolar_contado_con_liquidacion)
VALUES
    (1000.00, 1070.00, 80.00, 20.00);


-- COSTOS MANO DE OBRA
CREATE TABLE modelo_optimizacion.odp.costo_mano_de_obra (
    pk_costo_mano_de_obra   BIGINT NOT NULL,
    monto_ars_kg            DECIMAL(10,2) NOT NULL CHECK (monto_ars_kg > 0.00),
    fl_monto_cuarteo        BOOLEAN NOT NULL DEFAULT FALSE,
    fl_monto_despostada     BOOLEAN NOT NULL DEFAULT FALSE,
    last_update             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (pk_costo_mano_de_obra)
);

-- Comentarios de la tabla
COMMENT ON TABLE modelo_optimizacion.odp.costo_mano_de_obra 
    IS 'Tabla que almacena los costos de mano de obra.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_mano_de_obra.pk_costo_mano_de_obra 
    IS 'Identificador único del costo de mano de obra.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_mano_de_obra.monto_ars_kg 
    IS 'Monto en ARS por kg de producto.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_mano_de_obra.fl_monto_cuarteo 
    IS 'Indica si el monto en ARS por kg de producto refiere al costo de mano de obra de cuarteo.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_mano_de_obra.fl_monto_despostada 
    IS 'Indica si el monto en ARS por kg de producto refiere al costo de mano de obra de despostada.';

COMMENT ON COLUMN modelo_optimizacion.odp.costo_mano_de_obra.last_update 
    IS 'Fecha y hora de la última actualización del registro. Fecha en la que se actualiza el costo de mano de obra.';

-- Crear trigger para last_update
CREATE TRIGGER trigger_update_costo_mano_de_obra_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.costo_mano_de_obra
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Comentario del trigger
COMMENT ON TRIGGER trigger_update_costo_mano_de_obra_last_update ON modelo_optimizacion.odp.costo_mano_de_obra 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones. Fecha en la que se actualiza el costo de mano de obra.';

-- Crear índice en last_update para consultas frecuentes. Este índice sería útil si, por ejemplo, necesitas obtener el costo de mano de obra más reciente o realizar análisis temporales de los costos de mano de obra.
CREATE INDEX idx_costo_mano_de_obra_last_update 
ON modelo_optimizacion.odp.costo_mano_de_obra(last_update);

-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.costo_mano_de_obra ALTER COLUMN pk_costo_mano_de_obra DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.costo_mano_de_obra ALTER COLUMN pk_costo_mano_de_obra ADD GENERATED ALWAYS AS IDENTITY;

-- Insert default data into costo_mano_de_obra
INSERT INTO odp.costo_mano_de_obra
(monto_ars_kg, fl_monto_cuarteo, fl_monto_despostada)
VALUES
    (26.00, TRUE, FALSE),
    (535.00, FALSE, TRUE);


-- TABLA COSTOS DE CERTIFICADO
CREATE TABLE modelo_optimizacion.odp.certificado (
    pk_certificado                      INT             NOT NULL,
    fk_categoria_hacienda               INT             NOT NULL,
    nombre_certificado                  VARCHAR(255)    NOT NULL,
    costo_certificado_ars_contenedor    DECIMAL(10,2)   NOT NULL CHECK (costo_certificado_ars_contenedor >= 0.00),
    toneladas_por_contenedor             DECIMAL(10,2)  NOT NULL CHECK (toneladas_por_contenedor >= 0.00),
    last_update                         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (pk_certificado),
    CONSTRAINT fk_categoria_hacienda_ref FOREIGN KEY (fk_categoria_hacienda) REFERENCES modelo_optimizacion.odp.categoria_hacienda(pk_categoria_hacienda)
);

-- Comentarios de la tabla
COMMENT ON TABLE modelo_optimizacion.odp.certificado 
    IS 'Tabla que almacena certificados que aplican a los productos de una politica por categoria de hacienda y sus costos asociados.';

COMMENT ON COLUMN modelo_optimizacion.odp.certificado.pk_certificado 
    IS 'Identificador único del certificado.';

COMMENT ON COLUMN modelo_optimizacion.odp.certificado.fk_categoria_hacienda 
    IS 'Identificador de la categoria de hacienda a la que aplica el certificado.';

COMMENT ON COLUMN modelo_optimizacion.odp.certificado.nombre_certificado 
    IS 'Nombre del certificado.';

COMMENT ON COLUMN modelo_optimizacion.odp.certificado.costo_certificado_ars_contenedor 
    IS 'Costo del certificado en ARS por contenedor.';

COMMENT ON COLUMN modelo_optimizacion.odp.certificado.toneladas_por_contenedor 
    IS 'Cantidad de toneladas por contenedor. Se utiliza para calcular el costo del certificado por kg de producto.';

COMMENT ON COLUMN modelo_optimizacion.odp.certificado.last_update 
    IS 'Fecha y hora de la última actualización del registro. Fecha en la que se actualiza el certificado.';


-- Crear trigger para last_update
CREATE TRIGGER trigger_update_certificado_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.certificado
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Comentario del trigger
COMMENT ON TRIGGER trigger_update_certificado_last_update ON modelo_optimizacion.odp.certificado 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones. Fecha en la que se actualiza el certificado.';

-- Insert default data into certificado
INSERT INTO odp.certificado
(pk_certificado, fk_categoria_hacienda, nombre_certificado, costo_certificado_ars_contenedor, toneladas_por_contenedor)
VALUES
    (0, 0, 'SIN ASIGNAR', 0.00, 0.00),
    (1, 2, 'CERTIFICADO HILTON', 4500.00, 5.00),
    (2, 4, 'CERTIFICADO 481', 5000.00, 5.00);


-- Add identity column configuration
ALTER TABLE modelo_optimizacion.odp.certificado ALTER COLUMN pk_certificado DROP DEFAULT;
ALTER TABLE modelo_optimizacion.odp.certificado ALTER COLUMN pk_certificado ADD GENERATED ALWAYS AS IDENTITY;

SELECT setval(
    pg_get_serial_sequence('modelo_optimizacion.odp.certificado', 'pk_certificado'), 
    (SELECT MAX(pk_certificado) FROM modelo_optimizacion.odp.certificado), 
    true
);


-- Add constraint of unique nombre_certificado
ALTER TABLE modelo_optimizacion.odp.certificado
ADD CONSTRAINT unique_nombre_certificado
UNIQUE (nombre_certificado);


-- TABLA PRODUCTO_CERTIFICADO
CREATE TABLE modelo_optimizacion.odp.producto_certificado (
    fk_producto             INT NOT NULL,
    fk_certificado          INT NOT NULL,
    last_update             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (fk_producto, fk_certificado),
    CONSTRAINT fk_producto_ref FOREIGN KEY (fk_producto) REFERENCES modelo_optimizacion.odp.producto(pk_producto),
    CONSTRAINT fk_certificado_ref FOREIGN KEY (fk_certificado) REFERENCES modelo_optimizacion.odp.certificado(pk_certificado)
);

-- Comentarios de la tabla
COMMENT ON TABLE modelo_optimizacion.odp.producto_certificado 
    IS 'Tabla que almacena la relación entre productos y certificados. Aquellos productos que apliquen a un certificado en particular, se almacenan en esta tabla. Se utiliza para automatizar el calculo del costo del certificado por kg de los productos de una politica que cumplan con la categoria de hacienda y el certificado en particular.';

COMMENT ON COLUMN modelo_optimizacion.odp.producto_certificado.fk_producto 
    IS 'Identificador del producto de la entidad PRODUCTO.';

COMMENT ON COLUMN modelo_optimizacion.odp.producto_certificado.fk_certificado 
    IS 'Identificador del certificado de la entidad CERTIFICADO.';

COMMENT ON COLUMN modelo_optimizacion.odp.producto_certificado.last_update 
    IS 'Fecha y hora de la última actualización del registro. Fecha en la que se actualiza la relación entre producto y certificado.';


-- Crear trigger para last_update
CREATE TRIGGER trigger_update_producto_certificado_last_update
    BEFORE INSERT OR UPDATE
    ON modelo_optimizacion.odp.producto_certificado
    FOR EACH ROW
    EXECUTE FUNCTION odp.update_last_update_column();

-- Comentario del trigger
COMMENT ON TRIGGER trigger_update_producto_certificado_last_update ON modelo_optimizacion.odp.producto_certificado 
    IS 'Trigger para actualizar automáticamente el campo LAST_UPDATE con timestamp en inserciones y actualizaciones. Fecha en la que se actualiza la relación entre producto y certificado.';


-- Insert default data into producto_certificado
INSERT INTO odp.producto_certificado (fk_producto, fk_certificado, last_update) VALUES(23, 1, '2025-04-07 18:42:40.444');
INSERT INTO odp.producto_certificado (fk_producto, fk_certificado, last_update) VALUES(24, 1, '2025-04-07 18:42:40.444');
INSERT INTO odp.producto_certificado (fk_producto, fk_certificado, last_update) VALUES(29, 1, '2025-04-07 18:42:40.444');
INSERT INTO odp.producto_certificado (fk_producto, fk_certificado, last_update) VALUES(20, 1, '2025-04-07 18:42:40.444');
INSERT INTO odp.producto_certificado (fk_producto, fk_certificado, last_update) VALUES(23, 2, '2025-04-07 18:42:40.444');
INSERT INTO odp.producto_certificado (fk_producto, fk_certificado, last_update) VALUES(24, 2, '2025-04-07 18:42:40.444');
INSERT INTO odp.producto_certificado (fk_producto, fk_certificado, last_update) VALUES(29, 2, '2025-04-07 18:42:40.444');
INSERT INTO odp.producto_certificado (fk_producto, fk_certificado, last_update) VALUES(20, 2, '2025-04-07 18:42:40.444');





















