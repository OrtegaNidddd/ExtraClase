USE nero_bakery;

-- TABLAS BASE
CREATE TABLE sucursal (
  id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(80) NOT NULL,
  direccion   VARCHAR(160) NOT NULL,
  UNIQUE KEY uk_sucursal_nombre (nombre)
);

CREATE TABLE empleado (
  id_empleado INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(120) NOT NULL,
  rol         ENUM('cajero','panadero','pastelero','repartidor','admin') NOT NULL,
  id_sucursal INT NOT NULL,
  CONSTRAINT fk_empleado_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE cliente (
  id_cliente  INT AUTO_INCREMENT PRIMARY KEY,
  nombre      VARCHAR(120) NOT NULL,
  email       VARCHAR(120),
  telefono    VARCHAR(40),
  UNIQUE KEY uk_cliente_email (email)
);

CREATE TABLE categoria (
  id_categoria INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(60) NOT NULL,
  UNIQUE KEY uk_categoria_nombre (nombre)
);

CREATE TABLE producto (
  id_producto  INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(120) NOT NULL,
  id_categoria INT NOT NULL,
  precio       DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
  activo       TINYINT(1) NOT NULL DEFAULT 1,
  CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  UNIQUE KEY uk_producto_nombre (nombre)
);

CREATE TABLE ingrediente (
  id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
  nombre         VARCHAR(120) NOT NULL,
  unidad         ENUM('kg','g','L','ml','unidad') NOT NULL,
  UNIQUE KEY uk_ingrediente_nombre (nombre)
);

CREATE TABLE proveedor (
  id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
  nombre       VARCHAR(120) NOT NULL,
  contacto     VARCHAR(120),
  telefono     VARCHAR(40),
  UNIQUE KEY uk_proveedor_nombre (nombre)
);

-- PRODUCCIÓN / RECETAS
CREATE TABLE receta (
  id_producto    INT NOT NULL,
  id_ingrediente INT NOT NULL,
  cantidad       DECIMAL(12,3) NOT NULL CHECK (cantidad > 0),
  PRIMARY KEY (id_producto, id_ingrediente),
  CONSTRAINT fk_receta_producto    FOREIGN KEY (id_producto)    REFERENCES producto(id_producto)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_receta_ingrediente FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- COMPRAS / INVENTARIO
CREATE TABLE compra (
  id_compra     INT AUTO_INCREMENT PRIMARY KEY,
  fecha         DATE NOT NULL,
  id_proveedor  INT NOT NULL,
  total         DECIMAL(12,2) NOT NULL DEFAULT 0,
  CONSTRAINT fk_compra_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE compra_detalle (
  id_compra      INT NOT NULL,
  id_ingrediente INT NOT NULL,
  cantidad       DECIMAL(12,3) NOT NULL CHECK (cantidad > 0),
  costo_unit     DECIMAL(12,3) NOT NULL CHECK (costo_unit >= 0),
  PRIMARY KEY (id_compra, id_ingrediente),
  CONSTRAINT fk_cdet_compra      FOREIGN KEY (id_compra)      REFERENCES compra(id_compra)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_cdet_ingrediente FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE inventario (
  id_ingrediente INT PRIMARY KEY,
  stock_actual   DECIMAL(12,3) NOT NULL DEFAULT 0,
  stock_min      DECIMAL(12,3) NOT NULL DEFAULT 0,
  CONSTRAINT fk_inventario_ingrediente FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- VENTAS
CREATE TABLE venta (
  id_venta    INT AUTO_INCREMENT PRIMARY KEY,
  fecha       DATETIME NOT NULL,
  id_sucursal INT NOT NULL,
  id_cliente  INT NULL,
  metodo_pago ENUM('efectivo','tarjeta','transferencia') NOT NULL,
  total       DECIMAL(12,2) NOT NULL DEFAULT 0,
  CONSTRAINT fk_venta_sucursal FOREIGN KEY (id_sucursal) REFERENCES sucursal(id_sucursal)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_venta_cliente  FOREIGN KEY (id_cliente)  REFERENCES cliente(id_cliente)
    ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE venta_detalle (
  id_venta    INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad    INT NOT NULL CHECK (cantidad > 0),
  precio_unit DECIMAL(12,2) NOT NULL CHECK (precio_unit >= 0),
  PRIMARY KEY (id_venta, id_producto),
  CONSTRAINT fk_vdet_venta    FOREIGN KEY (id_venta)    REFERENCES venta(id_venta)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_vdet_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- PEDIDOS PERSONALIZADOS 
CREATE TABLE pedido_personalizado (
  id_pedido    INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente   INT NOT NULL,
  fecha_entrega DATE NOT NULL,
  especificaciones TEXT NOT NULL,
  anticipo     DECIMAL(12,2) NOT NULL DEFAULT 0,
  estado       ENUM('pendiente','en_produccion','entregado','cancelado') NOT NULL DEFAULT 'pendiente',
  CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Índices útiles
CREATE INDEX idx_venta_fecha ON venta(fecha);
CREATE INDEX idx_compra_fecha ON compra(fecha);
CREATE INDEX idx_producto_categoria ON producto(id_categoria);
CREATE INDEX idx_receta_producto ON receta(id_producto);
