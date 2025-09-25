USE nero_bakery;

-- Sucursales
INSERT INTO sucursal (nombre, direccion) VALUES
('Centro',  'Cra 7 #12-34'),
('Sucursal Norte', 'Av. 5 #45-10');

-- Empleados
INSERT INTO empleado (nombre, rol, id_sucursal) VALUES
('Ana Gómez','admin',1),
('Luis Pérez','cajero',1),
('María Rojas','panadero',1),
('Carlos Díaz','pastelero',1),
('Sofía Lima','cajero',2),
('Julián Mora','repartidor',2);

-- Clientes
INSERT INTO cliente (nombre, email, telefono) VALUES
('Cliente Mostrador', NULL, NULL),
('Valentina Ruiz','valen@example.com','3001112233'),
('Andrés León','andres@example.com','3001112244'),
('Camila Sol','camila@example.com','3001112255'),
('Nicolás Rey','nicolas@example.com','3001112266'),
('Sara Duque','sara@example.com','3001112277'),
('Laura Gil','laura@example.com','3001112288'),
('Mateo Ospina','mateo@example.com','3001112299'),
('Pedro López','pedro@example.com','3001112200'),
('Diana Paz','diana@example.com','3001112211');

-- Categorías
INSERT INTO categoria (nombre) VALUES
('Pan'), ('Pastel'), ('Salado'), ('Bebida'), ('Postre');

-- Productos 
INSERT INTO producto (nombre, id_categoria, precio, activo) VALUES
('Baguette',1, 4.50,1),
('Croissant',1, 2.80,1),
('Pan de masa madre',1, 5.20,1),
('Roll de canela',5, 3.50,1),
('Pastel de chocolate 8 porciones',2, 28.00,1),
('Cheesecake fresa porción',5, 4.80,1),
('Quiche lorraine',3, 6.90,1),
('Empanada de pollo',3, 2.20,1),
('Café americano 12oz',4, 1.80,1),
('Capuccino 12oz',4, 2.50,1),
('Jugo de naranja 12oz',4, 2.20,1),
('Tarta de manzana porción',5, 4.20,1),
('Galleta chispas de chocolate',5, 1.50,1),
('Brownie nuez',5, 2.40,1),
('Pan brioche',1, 4.00,1),
('Focaccia',1, 3.80,1),
('Pastel de vainilla 8 porciones',2, 26.00,1),
('Muffin arándanos',5, 2.60,1),
('Sándwich jamón y queso',3, 4.90,1),
('Té chai 12oz',4, 2.30,1);

-- Ingredientes (20)
INSERT INTO ingrediente (nombre, unidad) VALUES
('Harina de trigo','kg'),
('Azúcar','kg'),
('Mantequilla','kg'),
('Levadura','g'),
('Huevos','unidad'),
('Leche','L'),
('Cacao en polvo','kg'),
('Queso crema','kg'),
('Crema de leche','L'),
('Fresas','kg'),
('Jamón','kg'),
('Queso mozzarella','kg'),
('Pollo desmechado','kg'),
('Naranja','kg'),
('Café molido','kg'),
('Manzana','kg'),
('Nuez','kg'),
('Aceite de oliva','L'),
('Sal','g'),
('Arándanos','kg');

-- Proveedores 
INSERT INTO proveedor (nombre, contacto, telefono) VALUES
('Molinos Andinos','molinos@example.com','601-555-1001'),
('Lácteos del Valle','ventas@lacteos.com','601-555-1002'),
('Frutas Selectas','comercial@frutsel.com','601-555-1003'),
('Cárnicos El Buen Corte','contacto@carnicos.com','601-555-1004'),
('Café Premium','ventas@cafepremium.com','601-555-1005'),
('Abarrotes Centro','ventas@abarrotes.com','601-555-1006');

-- Inventario inicial
INSERT INTO inventario (id_ingrediente, stock_actual, stock_min) VALUES
(1, 50, 10),  
(2, 20, 5),
(3, 15, 4),
(4, 500, 100),
(5, 300, 60),
(6, 50, 10),
(7, 8, 2),
(8, 10, 2),
(9, 20, 5),
(10, 12, 3),
(11, 10, 2),
(12, 12, 3),
(13, 10, 2),
(14, 15, 5),
(15, 10, 3),
(16, 8, 2),
(17, 6, 2),
(18, 10, 2),
(19, 800, 200),
(20, 6, 2);

-- Recetas
-- Baguette
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Baguette'), 1, 0.250),
((SELECT id_producto FROM producto WHERE nombre='Baguette'), 4, 2.0),
((SELECT id_producto FROM producto WHERE nombre='Baguette'), 19, 10.0);

-- Croissant
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Croissant'), 1, 0.120),
((SELECT id_producto FROM producto WHERE nombre='Croissant'), 3, 0.050),
((SELECT id_producto FROM producto WHERE nombre='Croissant'), 4, 1.5);

-- Pan de masa madre
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Pan de masa madre'), 1, 0.300),
((SELECT id_producto FROM producto WHERE nombre='Pan de masa madre'), 19, 10.0);

-- Roll de canela
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Roll de canela'), 1, 0.150),
((SELECT id_producto FROM producto WHERE nombre='Roll de canela'), 2, 0.020),
((SELECT id_producto FROM producto WHERE nombre='Roll de canela'), 3, 0.030);

-- Pastel de chocolate
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Pastel de chocolate 8 porciones'), 1, 0.800),
((SELECT id_producto FROM producto WHERE nombre='Pastel de chocolate 8 porciones'), 7, 0.080),
((SELECT id_producto FROM producto WHERE nombre='Pastel de chocolate 8 porciones'), 5, 6.0),
((SELECT id_producto FROM producto WHERE nombre='Pastel de chocolate 8 porciones'), 6, 0.5);

-- Cheesecake fresa porción
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Cheesecake fresa porción'), 8, 0.080),
((SELECT id_producto FROM producto WHERE nombre='Cheesecake fresa porción'), 9, 0.030),
((SELECT id_producto FROM producto WHERE nombre='Cheesecake fresa porción'),10, 0.040);

-- Quiche
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Quiche lorraine'), 1, 0.120),
((SELECT id_producto FROM producto WHERE nombre='Quiche lorraine'), 5, 1.0),
((SELECT id_producto FROM producto WHERE nombre='Quiche lorraine'),12, 0.060);

-- Empanada pollo
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Empanada de pollo'), 1, 0.080),
((SELECT id_producto FROM producto WHERE nombre='Empanada de pollo'),13, 0.070);

-- Café y bebidas
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Café americano 12oz'), 15, 0.015);
INSERT INTO receta VALUES
((SELECT id_producto FROM producto WHERE nombre='Jugo de naranja 12oz'), 14, 0.250);

-- Compras
INSERT INTO compra (fecha, id_proveedor, total) VALUES
('2025-08-01',1,0), 
('2025-08-01',2,0), 
('2025-08-02',3,0),
('2025-08-03',5,0), 
('2025-08-05',6,0), 
('2025-08-07',1,0),
('2025-08-10',2,0), 
('2025-08-12',3,0), 
('2025-08-15',4,0), 
('2025-08-18',5,0);

-- Detalles de compras
INSERT INTO compra_detalle VALUES
(1,1,25,1.20),(1,4,300,0.010),(1,19,500,0.002);
INSERT INTO compra_detalle VALUES
(2,6,30,0.90),(2,9,15,1.20);
INSERT INTO compra_detalle VALUES
(3,10,10,3.50),(3,14,20,1.10),(3,16,6,2.80);
INSERT INTO compra_detalle VALUES
(4,15,8,7.00);
INSERT INTO compra_detalle VALUES
(5,2,10,1.10),(5,3,8,4.50);
INSERT INTO compra_detalle VALUES
(6,1,20,1.18);
INSERT INTO compra_detalle VALUES
(7,6,20,0.92),(7,9,10,1.25);
INSERT INTO compra_detalle VALUES
(8,10,8,3.40),(8,14,15,1.15);
INSERT INTO compra_detalle VALUES
(9,11,5,6.80),(9,12,6,7.20),(9,13,6,5.40);
INSERT INTO compra_detalle VALUES
(10,15,6,7.20);

-- Recalcular totales de compra
UPDATE compra c
JOIN (
  SELECT id_compra, SUM(cantidad*costo_unit) AS t
  FROM compra_detalle GROUP BY id_compra
) x ON x.id_compra = c.id_compra
SET c.total = x.t;

-- Ventas
INSERT INTO venta (fecha, id_sucursal, id_cliente, metodo_pago, total) VALUES
('2025-08-20 08:10:00',1,2,'efectivo',0),
('2025-08-20 08:25:00',1,1,'tarjeta',0),
('2025-08-20 09:05:00',1,3,'efectivo',0),
('2025-08-20 10:30:00',2,4,'transferencia',0),
('2025-08-20 11:15:00',1,5,'tarjeta',0),
('2025-08-20 12:05:00',2,6,'efectivo',0),
('2025-08-20 14:20:00',1,7,'efectivo',0),
('2025-08-20 15:10:00',1,8,'tarjeta',0),
('2025-08-20 16:45:00',2,9,'efectivo',0),
('2025-08-21 08:15:00',1,10,'efectivo',0),
('2025-08-21 09:00:00',1,2,'tarjeta',0),
('2025-08-21 10:40:00',2,3,'efectivo',0),
('2025-08-21 12:30:00',2,4,'efectivo',0),
('2025-08-21 16:00:00',1,5,'tarjeta',0),
('2025-08-21 18:10:00',2,6,'efectivo',0);

-- Detalles
-- v1
INSERT INTO venta_detalle VALUES (1,(SELECT id_producto FROM producto WHERE nombre='Café americano 12oz'),1,1.80);
INSERT INTO venta_detalle VALUES (1,(SELECT id_producto FROM producto WHERE nombre='Croissant'),2,2.80);
-- v2
INSERT INTO venta_detalle VALUES (2,(SELECT id_producto FROM producto WHERE nombre='Baguette'),1,4.50);
INSERT INTO venta_detalle VALUES (2,(SELECT id_producto FROM producto WHERE nombre='Jugo de naranja 12oz'),1,2.20);
-- v3
INSERT INTO venta_detalle VALUES (3,(SELECT id_producto FROM producto WHERE nombre='Empanada de pollo'),2,2.20);
INSERT INTO venta_detalle VALUES (3,(SELECT id_producto FROM producto WHERE nombre='Capuccino 12oz'),1,2.50);
-- v4
INSERT INTO venta_detalle VALUES (4,(SELECT id_producto FROM producto WHERE nombre='Quiche lorraine'),1,6.90);
INSERT INTO venta_detalle VALUES (4,(SELECT id_producto FROM producto WHERE nombre='Té chai 12oz'),1,2.30);
-- v5
INSERT INTO venta_detalle VALUES (5,(SELECT id_producto FROM producto WHERE nombre='Pastel de chocolate 8 porciones'),1,28.00);
-- v6
INSERT INTO venta_detalle VALUES (6,(SELECT id_producto FROM producto WHERE nombre='Sándwich jamón y queso'),2,4.90);
INSERT INTO venta_detalle VALUES (6,(SELECT id_producto FROM producto WHERE nombre='Jugo de naranja 12oz'),2,2.20);
-- v7
INSERT INTO venta_detalle VALUES (7,(SELECT id_producto FROM producto WHERE nombre='Roll de canela'),1,3.50);
INSERT INTO venta_detalle VALUES (7,(SELECT id_producto FROM producto WHERE nombre='Café americano 12oz'),1,1.80);
INSERT INTO venta_detalle VALUES (7,(SELECT id_producto FROM producto WHERE nombre='Galleta chispas de chocolate'),2,1.50);
-- v8
INSERT INTO venta_detalle VALUES (8,(SELECT id_producto FROM producto WHERE nombre='Cheesecake fresa porción'),2,4.80);
INSERT INTO venta_detalle VALUES (8,(SELECT id_producto FROM producto WHERE nombre='Capuccino 12oz'),2,2.50);
-- v9
INSERT INTO venta_detalle VALUES (9,(SELECT id_producto FROM producto WHERE nombre='Pan brioche'),1,4.00);
INSERT INTO venta_detalle VALUES (9,(SELECT id_producto FROM producto WHERE nombre='Brownie nuez'),2,2.40);
-- v10
INSERT INTO venta_detalle VALUES (10,(SELECT id_producto FROM producto WHERE nombre='Tarta de manzana porción'),1,4.20);
INSERT INTO venta_detalle VALUES (10,(SELECT id_producto FROM producto WHERE nombre='Café americano 12oz'),1,1.80);
-- v11
INSERT INTO venta_detalle VALUES (11,(SELECT id_producto FROM producto WHERE nombre='Focaccia'),1,3.80);
INSERT INTO venta_detalle VALUES (11,(SELECT id_producto FROM producto WHERE nombre='Capuccino 12oz'),1,2.50);
-- v12
INSERT INTO venta_detalle VALUES (12,(SELECT id_producto FROM producto WHERE nombre='Empanada de pollo'),3,2.20);
-- v13
INSERT INTO venta_detalle VALUES (13,(SELECT id_producto FROM producto WHERE nombre='Quiche lorraine'),1,6.90);
INSERT INTO venta_detalle VALUES (13,(SELECT id_producto FROM producto WHERE nombre='Jugo de naranja 12oz'),1,2.20);
-- v14
INSERT INTO venta_detalle VALUES (14,(SELECT id_producto FROM producto WHERE nombre='Pastel de vainilla 8 porciones'),1,26.00);
-- v15
INSERT INTO venta_detalle VALUES (15,(SELECT id_producto FROM producto WHERE nombre='Muffin arándanos'),3,2.60);
INSERT INTO venta_detalle VALUES (15,(SELECT id_producto FROM producto WHERE nombre='Té chai 12oz'),2,2.30);

-- Recalcular totales de venta
UPDATE venta v
JOIN (
  SELECT id_venta, SUM(cantidad*precio_unit) AS t
  FROM venta_detalle GROUP BY id_venta
) x ON x.id_venta = v.id_venta
SET v.total = x.t;

-- Pedidos personalizados (3)
INSERT INTO pedido_personalizado (id_cliente, fecha_entrega, especificaciones, anticipo, estado) VALUES
(2,'2025-08-28','Pastel de chocolate 20 porciones con dedicatoria',10.00,'en_produccion'),
(4,'2025-08-30','Cheesecake frutos rojos 12 porciones',8.00,'pendiente'),
(5,'2025-09-02','Pastel vainilla temático infantil 16 porciones',12.00,'pendiente');
