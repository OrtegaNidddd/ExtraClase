
# Nero Bakery — Base de Datos (MySQL)

Proyecto académico para modelar y poblar la BD de una panadería–pastelería (**Nero Bakery**).  
Incluye scripts para **crear el esquema**, **insertar datos de ejemplo** y **probar 10 consultas** con `JOIN`.

---

## 🥐 Descripción del negocio

Nero Bakery opera dos sucursales y vende productos de panadería/pastelería en mostrador.  
Compra **ingredientes** a varios **proveedores**, produce a partir de **recetas** (producto ↔ ingredientes) y registra **ventas** con detalle de ítems. Admite clientes anónimos y registrados, y gestiona **pedidos personalizados** (encargos con fecha, anticipo y estado).

---

## 🧱 Tablas principales

- **sucursal**, **empleado**, **cliente**  
- **categoria**, **producto**  
- **ingrediente**, **receta** (BOM)  
- **proveedor**, **compra**, **compra_detalle**  
- **inventario** (por ingrediente)  
- **venta**, **venta_detalle**  
- **pedido_personalizado**

> El esquema usa `ENUM` en: `empleado.rol`, `ingrediente.unidad`, `venta.metodo_pago`, `pedido_personalizado.estado`.

---

## 📂 Estructura del repositorio

```
└── 📁nero_bakery
    ├── consultas_complejas.sql
    ├── crear_tablas.sql
    ├── general.sql
    ├── insertar_datos.sql
    ├── documetacion_llaves.md
    └── README.md
```
---

## ✅ Requisitos de la actividad (checklist)

* **Tablas**: ≥5 (este modelo incluye **14**).
* **PKs**: definidas en todas las tablas.
* **FKs**: ≥8 (cumplido, ver `crear_tablas.sql`).
* **Llaves candidatas**: nombres únicos en catálogos (producto, ingrediente, proveedor, etc.).
* **Registros**: ≥30 (superado ampliamente en `insertar_datos.sql`).
* **Consultas con JOIN**: **10** en `consultas_complejas.sql`.

---

## 👤 Autoría 

- Nick Alejandro Ortega Mendez
- Santiago Alejandro Medina Ortega
- Andres Felipe Reyes Gutierrez
- Johel Alexander Velasco Guerrero
