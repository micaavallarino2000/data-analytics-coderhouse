/* ============================================================
   1) Actualización de las tablas de datos 
   =========================================================== */


CREATE TABLE dbo.Territorios
(id_Territorio INT PRIMARY KEY,
nombre_region VARCHAR (50) NOT NULL,
nombre_pais VARCHAR (50))


   INSERT INTO dbo.Territorios
         (id_Territorio, nombre_region, nombre_pais)
   VALUES 
    (1, 'Canelones', 'Uruguay'),
    (2, 'Montevideo', 'Uruguay'),
    (3,'Buenos Aires', 'Argentina')
    
 SELECT * FROM dbo.Territorios

 ALTER TABLE dbo.Ventas
 ADD id_Territorio INT FOREIGN KEY (id_Territorio) REFERENCES dbo.Territorios

SELECT * FROM dbo.Ventas

UPDATE dbo.Ventas
SET id_Territorio = 3,
WHERE id_venta = 1

UPDATE dbo.Ventas
SET id_Territorio = 3 
WHERE id_venta = 2

UPDATE dbo.Ventas
SET id_Territorio = 1
WHERE id_venta = 3

UPDATE dbo.Ventas
SET id_Territorio = 3 
WHERE id_venta = 4

UPDATE dbo.Ventas
SET id_Territorio = 1
WHERE id_venta = 5

UPDATE dbo.Ventas
SET id_Territorio = 2
WHERE id_venta = 6


UPDATE dbo.Ventas
SET id_Territorio = 2
WHERE id_venta = 7

UPDATE dbo.Ventas
SET id_Territorio = 3
WHERE id_venta = 8

UPDATE dbo.Ventas
SET id_Territorio = 3
WHERE id_venta = 9

UPDATE dbo.Ventas
SET id_Territorio = 1
WHERE id_venta = 10

SELECT * FROM dbo.Ventas

/* ============================================================
   2) Consulta 1 - INNER JOIN 
   ============================================================ */

SELECT v. id_venta,
       v. fecha_venta AS Fecha, 
       c.nombre AS Cliente,
       p.nombre_producto AS Producto,
       v.precio_unitario AS Costo,
       v.cantidad,
       ISNULL(v.precio_unitario * cantidad,0) AS Precio_Total,
       t.nombre_region AS Region

FROM dbo.Ventas v
JOIN dbo.Productos p
ON v.id_producto = p.id_producto 

JOIN dbo.Clientes c
ON v.id_cliente = c.id_cliente

JOIN  dbo.Territorios t
ON  v.id_Territorio = t.id_Territorio

/* ============================================================
   3) Consulta 2 - LEFT JOIN 
   ============================================================ */

   SELECT c.id_cliente,
          c.nombre AS Cliente, 
          c.email,
          c. fecha_registro AS Fecha

   FROM dbo.Clientes c
   LEFT JOIN dbo.Ventas v
   ON c.id_cliente = v.id_cliente
   WHERE v.id_cliente IS NULL

   /* ============================================================
   4) Consulta 3 - LEFT JOIN 
   ============================================================ */

   SELECT p.nombre_producto AS Producto,
          p.id_categoria AS Categoria, 
          p.precio

   FROM dbo.Productos p
   LEFT JOIN dbo.Ventas v
   ON p.id_producto = v.id_producto
    WHERE v.id_venta IS NULL

  /* ============================================================
   5) Consulta 4 - UNION ALL 
   ============================================================ */
   SELECT canal,
        SUM (PrecioTotal) AS Total
   FROM (

  SELECT v. fecha_venta,
          v. precio_unitario * cantidad AS PrecioTotal,
          'Primer semestre' AS canal

   FROM dbo.Ventas v
   WHERE v. fecha_venta < '2026-07-01'

   UNION ALL

   SELECT v. fecha_venta,
          v. precio_unitario * cantidad AS PrecioTotal,
          'Segundo semestre' AS canal

   FROM dbo.Ventas v
   WHERE v. fecha_venta >= '2026-07-01') AS VentaTotal

   GROUP BY canal 