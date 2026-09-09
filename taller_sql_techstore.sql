-- ============================================================
-- TALLER PRACTICO DE SQL - TechStore
-- Solución de los 10 ejercicios (MySQL 8.0+)
-- ============================================================

-- ============================================================
-- EJ. 01 - Construir la base
-- Primero el contenedor, luego las tablas relacionadas.
-- ============================================================
CREATE DATABASE TechStore;
USE TechStore;

CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre      VARCHAR(50) NOT NULL,
    categoria   VARCHAR(50) NOT NULL,
    precio      DECIMAL(10,2) NOT NULL,
    stock       INT NOT NULL DEFAULT 0
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre     VARCHAR(100) NOT NULL,
    email      VARCHAR(100) UNIQUE,
    ciudad     VARCHAR(50) NOT NULL
);

-- ventas referencia a clientes y productos mediante FOREIGN KEY
CREATE TABLE ventas (
    id_venta    INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente  INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad    INT NOT NULL,
    fecha_venta DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ============================================================
-- EJ. 02 - Modificar una estructura
-- telefono se agrega después; nombre de producto se amplía.
-- ============================================================
ALTER TABLE clientes ADD COLUMN telefono VARCHAR(20);
ALTER TABLE productos MODIFY COLUMN nombre VARCHAR(100);

-- ============================================================
-- EJ. 03 - Cargar productos y clientes
-- Categorías, ciudades y rangos de precio repetidos a propósito.
-- El producto 11 se inserta "por error" para usarlo en el EJ.05.
-- ============================================================
INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Teclado mecánico RGB',   'Perifericos',    189000, 40),
('Mouse inalámbrico',      'Perifericos',     75000, 60),
('Monitor 24" Full HD',    'Monitores',      650000, 15),
('Monitor 27" 144Hz',      'Monitores',     1200000,  8),
('Portátil i5 8GB',        'Computadores',  2800000, 10),
('Disco SSD 1TB',          'Almacenamiento', 320000, 25),
('Memoria RAM 16GB',       'Componentes',    210000, 30),
('Audífonos Bluetooth',    'Audio',          150000, 20),
('Base para portátil',     'Accesorios',      60000, 50),
('Webcam Full HD',         'Perifericos',    130000, 18),
('Producto de prueba ERROR','Accesorios',        1000,  1);

INSERT INTO clientes (nombre, email, ciudad, telefono) VALUES
('Laura Gómez',    'laura.gomez@mail.com',    'Bogota',       '3001112222'),
('Carlos Ramírez', 'carlos.ramirez@mail.com', 'Medellin',     '3002223333'),
('Ana Torres',     'ana.torres@mail.com',     'Cali',         '3003334444'),
('Julián Pérez',   'julian.perez@mail.com',   'Bucaramanga',  '3004445555'),
('María Rojas',    'maria.rojas@mail.com',    'Bucaramanga',  '3005556666'),
('Diego Salazar',  'diego.salazar@mail.com',  'Cucuta',       '3006667777');

-- ============================================================
-- EJ. 04 - Registrar ventas con sentido
-- IDs verificados contra lo insertado arriba; clientes y
-- productos se repiten, con cantidades y fechas distintas.
-- ============================================================
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
(1, 1, 2, '2025-01-10'),
(2, 3, 1, '2025-01-12'),
(3, 5, 1, '2025-01-15'),
(1, 2, 3, '2025-01-20'),
(4, 6, 2, '2025-02-01'),
(5, 4, 1, '2025-02-03'),
(2, 1, 1, '2025-02-05'),
(6, 7, 4, '2025-02-10'),
(3, 8, 2, '2025-02-14'),
(1, 5, 1, '2025-03-01'),
(4, 9, 3, '2025-03-05'),
(5, 3, 1, '2025-03-08'),
(2, 10,2, '2025-03-15');

-- ============================================================
-- EJ. 05 - Corregir y eliminar con seguridad
-- Cada cambio se verifica antes de ejecutarse.
-- ============================================================

-- Corregir precio del producto 2 (Mouse inalámbrico)
SELECT * FROM productos WHERE id_producto = 2;
UPDATE productos SET precio = 69000 WHERE id_producto = 2;

-- Ajustar stock del producto 1 tras la venta registrada (2 unidades)
SELECT * FROM productos WHERE id_producto = 1;
UPDATE productos SET stock = stock - 2 WHERE id_producto = 1;

-- Eliminar el registro creado por error (id 11, no está referenciado en ventas)
SELECT * FROM productos WHERE id_producto = 11;
DELETE FROM productos WHERE id_producto = 11;

-- ============================================================
-- EJ. 06 - Primera exploración
-- ============================================================
SELECT * FROM productos;

SELECT nombre, precio FROM productos;

SELECT nombre, precio AS precio_venta FROM productos;

-- ============================================================
-- EJ. 07 - Filtrar por una condición
-- ============================================================
SELECT * FROM productos WHERE precio > 500000;

SELECT * FROM clientes WHERE ciudad = 'Bucaramanga';

SELECT * FROM productos WHERE categoria = 'Perifericos';

-- ============================================================
-- EJ. 08 - Combinar condiciones
-- ============================================================
SELECT * FROM productos WHERE categoria = 'Perifericos' AND precio < 100000;

SELECT * FROM clientes WHERE ciudad = 'Bogota' OR ciudad = 'Medellin';

-- ============================================================
-- EJ. 09 - Buscar por rangos y texto
-- ============================================================
SELECT * FROM productos WHERE precio BETWEEN 100000 AND 500000;

SELECT * FROM productos WHERE categoria IN ('Monitores', 'Computadores');

SELECT * FROM productos WHERE nombre LIKE '%Bluetooth%';

-- ============================================================
-- EJ. 10 - Ordenar resultados
-- ============================================================
SELECT * FROM productos ORDER BY precio ASC;

SELECT * FROM productos ORDER BY stock DESC;

-- filtro + ordenamiento combinados
SELECT * FROM productos
WHERE categoria = 'Perifericos'
ORDER BY precio ASC;
