# Documentación de Llaves, FKs e Índices — Nero Bakery (MySQL)

---

## Convenciones globales

- **PK**: Clave primaria  
- **FK**: Clave foránea  
- **CK**: Restricción CHECK  
- **UNQ**: Índice único  
- **IDX**: Índice no único

**ENUM usados**:
- `empleado.rol` ∈ {cajero, panadero, pastelero, repartidor, admin}  
- `ingrediente.unidad` ∈ {kg, g, L, ml, unidad}  
- `venta.metodo_pago` ∈ {efectivo, tarjeta, transferencia}  
- `pedido_personalizado.estado` ∈ {pendiente, en_produccion, entregado, cancelado}

**CHECKs relevantes**:
- `producto.precio >= 0`  
- `receta.cantidad > 0`  
- `compra_detalle.cantidad > 0`, `compra_detalle.costo_unit >= 0`  
- `inventario.stock_actual >= 0`, `inventario.stock_min >= 0`  
- `venta_detalle.cantidad > 0`, `venta_detalle.precio_unit >= 0`

---

## 1) `sucursal`
- **PK**: `(id_sucursal)`
- **FKs**: —  
- **UNQ/IDX**: `UNQ nombre`  
- **Llaves candidatas (3)**:  
  1) `nombre` (UNQ)  
  2) `direccion`  
  3) `(nombre, direccion)`  
- **Notas**: nombre comercial único por diseño del script.

---

## 2) `empleado`
- **PK**: `(id_empleado)`
- **FKs**:  
  - `id_sucursal → sucursal(id_sucursal)` (ON UPDATE CASCADE, ON DELETE RESTRICT)
- **UNQ/IDX**: IDX implícito por FK `id_sucursal`
- **Llaves candidatas (3)**:  
  1) `(nombre, id_sucursal, rol)`  
  2) `(nombre, rol)`  
  3) *(Sugerido a futuro)* `email` o `documento` con UNQ  
- **Notas**: `rol` es ENUM.

---

## 3) `cliente`
- **PK**: `(id_cliente)`
- **FKs**: —  
- **UNQ/IDX**: `UNQ email`  
- **Llaves candidatas (3)**:  
  1) `email` (si no es NULL)  
  2) `(nombre, telefono)`  
  3) `(nombre, email)`  
- **Notas**: “Cliente Mostrador” se maneja con `NULL` en email/teléfono.

---

## 4) `categoria`
- **PK**: `(id_categoria)`
- **FKs**: —  
- **UNQ/IDX**: `UNQ nombre`  
- **Llaves candidatas (3)**:  
  1) `nombre` (UNQ)  
  2) `LOWER(nombre)` (convención)  
  3) `nombre` + política de catálogo  

---

## 5) `producto`
- **PK**: `(id_producto)`
- **FKs**:  
  - `id_categoria → categoria(id_categoria)` (ON UPDATE CASCADE, ON DELETE RESTRICT)
- **UNQ/IDX**: `UNQ nombre`, `IDX id_categoria`
- **CK**: `precio >= 0`
- **Llaves candidatas (3)**:  
  1) `nombre` (UNQ)  
  2) `(id_categoria, nombre)`  
  3) `LOWER(nombre)`  

---

## 6) `ingrediente`
- **PK**: `(id_ingrediente)`
- **FKs**: —  
- **UNQ/IDX**: `UNQ nombre`
- **Llaves candidatas (3)**:  
  1) `nombre` (UNQ)  
  2) `LOWER(nombre)`  
  3) *(si existieran sinónimos por unidad)* `(nombre, unidad)`  
- **Notas**: `unidad` es ENUM.

---

## 7) `proveedor`
- **PK**: `(id_proveedor)`
- **FKs**: —  
- **UNQ/IDX**: `UNQ nombre`
- **Llaves candidatas (3)**:  
  1) `nombre` (UNQ)  
  2) `contacto` (si es email único)  
  3) `(nombre, telefono)`  

---

## 8) `receta`
- **PK**: `(id_producto, id_ingrediente)`
- **FKs**:  
  - `id_producto → producto(id_producto)` (ON UPDATE CASCADE, ON DELETE CASCADE)  
  - `id_ingrediente → ingrediente(id_ingrediente)` (ON UPDATE CASCADE, ON DELETE RESTRICT)
- **UNQ/IDX**: `IDX id_producto`
- **CK**: `cantidad > 0`
- **Llaves candidatas (3)**:  
  1) `(id_producto, id_ingrediente)` (= PK)  
  2) `(id_producto, id_ingrediente, cantidad)` *(no añade unicidad útil)*  
  3) *(no aplica otra alternativa sin nuevos atributos)*  

---

## 9) `compra`
- **PK**: `(id_compra)`
- **FKs**:  
  - `id_proveedor → proveedor(id_proveedor)` (ON UPDATE CASCADE, ON DELETE RESTRICT)
- **UNQ/IDX**: `IDX fecha`
- **Llaves candidatas (3)**:  
  1) `(fecha, id_proveedor)` (si no hay duplicidad por día)  
  2) *(recomendado a futuro)* `numero_factura` (UNQ)  
  3) `(id_proveedor, id_compra)` *(contiene PK; documentada por requisito)*  

---

## 10) `compra_detalle`
- **PK**: `(id_compra, id_ingrediente)`
- **FKs**:  
  - `id_compra → compra(id_compra)` (ON UPDATE CASCADE, ON DELETE CASCADE)  
  - `id_ingrediente → ingrediente(id_ingrediente)` (ON UPDATE CASCADE, ON DELETE RESTRICT)
- **CK**: `cantidad > 0`, `costo_unit >= 0`
- **Llaves candidatas (3)**:  
  1) `(id_compra, id_ingrediente)` (= PK)  
  2) `(id_compra, id_ingrediente, costo_unit)` *(no mejora unicidad)*  
  3) `(id_compra, id_ingrediente, cantidad)` *(no mejora unicidad)*  

---

## 11) `inventario`
- **PK**: `(id_ingrediente)`
- **FKs**:  
  - `id_ingrediente → ingrediente(id_ingrediente)` (ON UPDATE CASCADE, ON DELETE RESTRICT)
- **CK**: `stock_actual >= 0`, `stock_min >= 0`
- **Llaves candidatas (3)**:  
  1) `id_ingrediente` (= PK)  
  2) `(id_ingrediente, stock_min)` *(operativa; no deseable como alternativa real)*  
  3) `(id_ingrediente, stock_actual)` *(operativa)*  

---

## 12) `venta`
- **PK**: `(id_venta)`
- **FKs**:  
  - `id_sucursal → sucursal(id_sucursal)` (ON UPDATE CASCADE, ON DELETE RESTRICT)  
  - `id_cliente → cliente(id_cliente)` (ON UPDATE CASCADE, ON DELETE SET NULL)
- **UNQ/IDX**: `IDX fecha`
- **Llaves candidatas (3)**:  
  1) `(fecha, id_sucursal, id_cliente)` (si no hay colisión por timestamp)  
  2) `(fecha, id_sucursal)` (si se garantiza 1 ticket por segundo/sucursal)  
  3) *(recomendado a futuro)* `consecutivo` UNIQUE por sucursal  
- **Notas**: `metodo_pago` es ENUM. `total` se recalcula tras insertar detalles.

---

## 13) `venta_detalle`
- **PK**: `(id_venta, id_producto)`
- **FKs**:  
  - `id_venta → venta(id_venta)` (ON UPDATE CASCADE, ON DELETE CASCADE)  
  - `id_producto → producto(id_producto)` (ON UPDATE CASCADE, ON DELETE RESTRICT)
- **CK**: `cantidad > 0`, `precio_unit >= 0`
- **Llaves candidatas (3)**:  
  1) `(id_venta, id_producto)` (= PK)  
  2) `(id_venta, id_producto, precio_unit)` *(no mejora unicidad)*  
  3) `(id_venta, id_producto, cantidad)` *(no mejora unicidad)*  

---

## 14) `pedido_personalizado`
- **PK**: `(id_pedido)`
- **FKs**:  
  - `id_cliente → cliente(id_cliente)` (ON UPDATE CASCADE, ON DELETE RESTRICT)
- **UNQ/IDX**: —  
- **Llaves candidatas (3)**:  
  1) `(id_cliente, fecha_entrega)` (si no se repiten encargos idénticos por día)  
  2) `(id_cliente, fecha_entrega, anticipo)`  
  3) `id_pedido` + `id_cliente` *(contiene PK; documentada por requisito)*  
- **Notas**: `estado` es ENUM.

---

## Resumen de integridad referencial

- **FKs (mínimo exigido ≥8):**  
  1) `empleado.id_sucursal → sucursal.id_sucursal`  
  2) `producto.id_categoria → categoria.id_categoria`  
  3) `receta.id_producto → producto.id_producto`  
  4) `receta.id_ingrediente → ingrediente.id_ingrediente`  
  5) `compra.id_proveedor → proveedor.id_proveedor`  
  6) `compra_detalle.id_compra → compra.id_compra`  
  7) `compra_detalle.id_ingrediente → ingrediente.id_ingrediente`  
  8) `inventario.id_ingrediente → ingrediente.id_ingrediente`  
  9) `venta.id_sucursal → sucursal.id_sucursal`  
  10) `venta.id_cliente → cliente.id_cliente`  
  11) `venta_detalle.id_venta → venta.id_venta`  
  12) `venta_detalle.id_producto → producto.id_producto`  
  13) `pedido_personalizado.id_cliente → cliente.id_cliente`

> Se cumplen los requisitos del proyecto (PKs claras, ≥8 FKs, ≥30 registros y consultas con JOIN).

---

## Índices que apoyan las consultas proporcionadas

- `venta(fecha)` → agregados por día/sucursal.  
- `compra(fecha)` → totales por periodo.  
- `producto(id_categoria)` → ingresos por categoría.  
- `receta(id_producto)` → costo de receta y conteo de ingredientes.