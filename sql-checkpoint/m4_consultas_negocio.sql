/* ------- Consigna 1 */

SELECT
MONTH (fecha_venta) AS Mes,
SUM (cantidad * precio_unitario) AS TotalFacturado,
COUNT (id_venta) AS CantidadPedidos,
AVG (cantidad * precio_unitario) AS TicketPromedio
FROM dbo.FactVentas
GROUP BY MONTH (fecha_venta)

/* ------- Consigna 2 */
SELECT TOP 5
id_producto,
SUM (cantidad) AS UnidadesVendidas,
SUM (cantidad * precio_unitario) AS TotalGenerado
FROM FactVentas
GROUP BY id_producto
ORDER BY TotalGenerado DESC


/* ------- Consigna 3 */
SELECT id_cliente,
COUNT (id_venta) AS TotalPedidos,
SUM (cantidad * precio_unitario) AS TotalGastado
FROM FactVentas
GROUP BY id_cliente
HAVING COUNT (id_venta) >1


/* ------- Consigna 4 */


SELECT 
MONTH (fecha_venta) AS mes,
SUM (cantidad * precio_unitario) AS TotalFacturado,
CASE WHEN SUM (cantidad * precio_unitario) > 644.4 THEN 'Por encima'
ELSE 'Por debajo'
END AS Comparacion
FROM FactVentas
GROUP BY MONTH (fecha_venta)


/* Hallazgos */

1- El producto 1 representa mas del 56% de las ventas del mes de marzo

2- Todos los clientes realizaron la misma cantidad de pedidos durante el mes pero el cliente 1 realizó el pedido de mayor valor

3- El producto 2 tuvo la mayor cantidad de productos vendidos en el mes de marzo