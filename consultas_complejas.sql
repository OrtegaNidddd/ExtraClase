
USE nero_bakery;

-- 1) Top 5 productos más vendidos (por unidades) y su facturación
SELECT p.nombre,
       SUM(vd.cantidad) AS unidades,
       SUM(vd.cantidad*vd.precio_unit) AS ingresos
FROM venta_detalle vd
JOIN producto p ON p.id_producto = vd.id_producto
GROUP BY p.id_producto
ORDER BY unidades DESC
LIMIT 5;

-- 2) Ventas por día y sucursal
SELECT DATE(v.fecha) AS dia, s.nombre AS sucursal, SUM(v.total) AS total_dia
FROM venta v
JOIN sucursal s ON s.id_sucursal = v.id_sucursal
GROUP BY dia, s.id_sucursal
ORDER BY dia, sucursal;

-- 3) Ticket promedio por cliente (solo clientes registrados)
SELECT c.nombre, COUNT(v.id_venta) AS compras, SUM(v.total) AS gasto, AVG(v.total) AS ticket_prom
FROM venta v
JOIN cliente c ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NOT NULL
GROUP BY c.id_cliente
ORDER BY ticket_prom DESC;

-- 4) Ingredientes por debajo del stock mínimo (alerta reposición)
SELECT i.nombre, inv.stock_actual, inv.stock_min
FROM inventario inv
JOIN ingrediente i ON i.id_ingrediente = inv.id_ingrediente
WHERE inv.stock_actual < inv.stock_min
ORDER BY (inv.stock_min - inv.stock_actual) DESC;

-- 5) Costo promedio de compra por ingrediente y proveedor principal
SELECT i.nombre AS ingrediente,
       pr.nombre AS proveedor,
       ROUND(SUM(cd.cantidad*cd.costo_unit)/NULLIF(SUM(cd.cantidad),0),3) AS costo_promedio
FROM compra_detalle cd
JOIN ingrediente i ON i.id_ingrediente = cd.id_ingrediente
JOIN compra c ON c.id_compra = cd.id_compra
JOIN proveedor pr ON pr.id_proveedor = c.id_proveedor
GROUP BY i.id_ingrediente, pr.id_proveedor
ORDER BY i.nombre, costo_promedio;

-- 6) Ingresos por categoría de producto
SELECT cat.nombre AS categoria,
       SUM(vd.cantidad*vd.precio_unit) AS ingresos
FROM venta_detalle vd
JOIN producto p ON p.id_producto = vd.id_producto
JOIN categoria cat ON cat.id_categoria = p.id_categoria
GROUP BY cat.id_categoria
ORDER BY ingresos DESC;

-- 7) Receta: costo estimado por producto (a partir de últimos costos de compra)
-- Tomamos el costo_unit promedio histórico como aproximación
WITH costo_ingred AS (
  SELECT cd.id_ingrediente,
         AVG(cd.costo_unit) AS costo_prom
  FROM compra_detalle cd
  GROUP BY cd.id_ingrediente
)
SELECT p.nombre AS producto,
       ROUND(SUM(r.cantidad * ci.costo_prom), 3) AS costo_estimado
FROM receta r
JOIN producto p ON p.id_producto = r.id_producto
LEFT JOIN costo_ingred ci ON ci.id_ingrediente = r.id_ingrediente
GROUP BY p.id_producto
ORDER BY costo_estimado DESC;

-- 8) Margen estimado por producto = precio - costo_estimado (para productos con receta)
WITH costo_prod AS (
  SELECT r.id_producto, SUM(r.cantidad * ci.costo_prom) AS costo_est
  FROM receta r
  LEFT JOIN (
    SELECT cd.id_ingrediente, AVG(cd.costo_unit) AS costo_prom
    FROM compra_detalle cd GROUP BY cd.id_ingrediente
  ) ci ON ci.id_ingrediente = r.id_ingrediente
  GROUP BY r.id_producto
)
SELECT p.nombre, p.precio, ROUND(cp.costo_est,3) AS costo_est,
       ROUND(p.precio - cp.costo_est,3) AS margen_est
FROM producto p
JOIN costo_prod cp ON cp.id_producto = p.id_producto
ORDER BY margen_est DESC;

-- 9) Productos y número de ingredientes de su receta (complejidad)
SELECT p.nombre, COUNT(r.id_ingrediente) AS ingredientes
FROM producto p
LEFT JOIN receta r ON r.id_producto = p.id_producto
GROUP BY p.id_producto
ORDER BY ingredientes DESC, p.nombre;

-- 10) Clientes con mayor recurrencia y gasto total
SELECT c.nombre, COUNT(v.id_venta) AS visitas, SUM(v.total) AS gasto_total
FROM cliente c
JOIN venta v ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente
ORDER BY visitas DESC, gasto_total DESC;
