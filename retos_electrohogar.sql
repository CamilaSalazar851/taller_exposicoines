-- ============================================================
-- SQL PARA PRINCIPIANTES - Caso ElectroHogar
-- Solución de los 7 "retos" de la presentación
-- ============================================================

-- ------------------------------------------------------------
-- RETO 1 (Tipos de datos) - Tabla clientes para fidelización
-- ------------------------------------------------------------
CREATE TABLE clientes (
    id_cliente          INT,
    nombre              VARCHAR(100),
    email               VARCHAR(150),   -- margen amplio, los correos pueden ser largos
    ciudad              VARCHAR(60),
    fecha_registro      DATE,
    acepta_promociones  BOOLEAN         -- más claro que un INT 0/1
);

-- ------------------------------------------------------------
-- RETO 2 (Modificadores) - Tabla empleados con integridad
-- ------------------------------------------------------------
CREATE TABLE empleados (
    id_empleado         INT PRIMARY KEY AUTO_INCREMENT,
    nombre              VARCHAR(100) NOT NULL,
    email               VARCHAR(150) UNIQUE,
    salario             DECIMAL(10,2) CHECK (salario >= 0),
    id_departamento     INT,
    fecha_contratacion  DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (id_departamento)
        REFERENCES departamentos(id_departamento)
);

-- ------------------------------------------------------------
-- RETO 3 (DDL) - Eliminar tabla de prueba y agregar teléfono
-- ------------------------------------------------------------
DROP TABLE productos_prueba;

ALTER TABLE clientes
    ADD COLUMN telefono VARCHAR(20);

-- ------------------------------------------------------------
-- RETO 4 (DML) - Corregir precio y dar de baja un producto
-- ------------------------------------------------------------
-- Siempre se verifica con SELECT antes de UPDATE/DELETE:
SELECT * FROM productos WHERE id_producto = 310;
UPDATE productos
SET precio = 549.00
WHERE id_producto = 310;

SELECT * FROM productos WHERE id_producto = 118;
DELETE FROM productos
WHERE id_producto = 118;

-- ------------------------------------------------------------
-- RETO 5 (DQL) - 5 clientes más recientes de Bogotá
-- ------------------------------------------------------------
SELECT nombre, fecha_registro
FROM clientes
WHERE ciudad = 'Bogotá'
ORDER BY fecha_registro DESC
LIMIT 5;

-- ------------------------------------------------------------
-- RETO 6 (Operadores) - Productos "Smart" en dos categorías
-- ------------------------------------------------------------
SELECT nombre, precio, categoria
FROM productos
WHERE categoria IN ('Electrodomésticos', 'Tecnología')
  AND nombre LIKE '%Smart%';

-- ------------------------------------------------------------
-- RETO 7 (Agrupación) - Categorías con precio promedio > 300000
-- ------------------------------------------------------------
SELECT
    id_categoria,
    AVG(precio) AS precio_promedio
FROM productos
GROUP BY id_categoria
HAVING AVG(precio) > 300000;
