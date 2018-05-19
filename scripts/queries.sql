USE tpbases;

SHOW COLUMNS FROM consumo;

-- TODO: usar un SP?  
-- ****** estas tomando los consumos que aun no estan en facturas, o sea los del mes actual, deberiamos? ***** Tomi
-- es un WHERE c.fecha es de mes anterior al actual, 
-- tambien te comes las que facturaron 0 , agrego una version 2 para tener a todos y con los nombres.

-- Facturacion total por id de atraccion
CREATE OR REPLACE VIEW facturacionPorAtraccion AS
    SELECT c.medio_entretenimiento_id AS idAtraccion, SUM(importe) AS facturacionTotal
	FROM consumo AS c
	INNER JOIN atraccion AS atr ON c.medio_entretenimiento_id = atr.atraccion_id
	GROUP BY idAtraccion;

CREATE OR REPLACE VIEW facturacionPorAtraccion2 AS
    SELECT m.medio_id AS id, m.nombre, SUM(IFNULL(importe,0)) AS total
	FROM medio_entretenimiento AS m
	LEFT JOIN consumo AS c ON  m.medio_id = c.medio_entretenimiento_id
	GROUP BY id, m.nombre
	HAVING m.tipo = @tipo_atraccion;

-- Cuánto facturaron las atracciones que más facturaron
SELECT MAX(facturacionTotal) INTO @maxFacturacionAtraccion FROM facturacionPorAtraccion;

SELECT me.nombre AS nombreAtraccion
FROM facturacionPorAtraccion AS fpa
INNER JOIN medio_entretenimiento as me ON fpa.idAtraccion = me.medio_id
WHERE fpa.facturacionTotal = @maxFacturacionAtraccion;

-- Facturacion total por id de parque
CREATE OR REPLACE VIEW facturacionPorParque AS
    SELECT p.parque_id AS idParque, SUM(c.importe) AS facturacionTotal
	FROM consumo AS c
	INNER JOIN parque AS p ON c.medio_entretenimiento_id = p.parque_id
	GROUP BY idParque;
-- Cuanto facturo la atraccion que mas facturo
SELECT @maxFacturacionParque := MAX(facturacionTotal) FROM facturacionPorParque;

--
CREATE OR REPLACE VIEW atraccionesConNombre AS
	SELECT atr.atraccion_id AS idAtraccion, me.nombre AS nombreAtraccion, atr.parque_id AS idParqueCorrespondiente
    FROM atraccion AS atr
	INNER JOIN medio_entretenimiento AS me ON atr.atraccion_id = me.medio_id;

/*el primer left join no va porque todo parque tiene al menos una atraccion
el segundo es consecuencia de que antes no pusiste que facturaban 0 */
SELECT nombreParque, nombreAtraccion, MAX(importeTotal)
FROM (
	SELECT me.nombre AS nombreParque, atrc.nombreAtraccion, SUM(IFNULL(c.importe, 0)) AS importeTotal
	FROM parque AS p
	LEFT JOIN atraccionesConNombre AS atrc ON p.parque_id = atrc.idParqueCorrespondiente
	INNER JOIN medio_entretenimiento AS me ON p.parque_id = me.medio_id
	LEFT JOIN consumo AS c ON atrc.idAtraccion = c.medio_entretenimiento_id
	GROUP BY nombreParque, atrc.nombreAtraccion
) AS parqueAtraccionImporteTotal
GROUP BY nombreParque, nombreAtraccion;

-- Facturas impagas
SELECT f.numero_de_factura
FROM factura AS f
WHERE f.pago_id IS NULL;

-- Atracciones mas visitadas por cliente en rango de fechas
SELECT cli.apellido AS apellidoCliente, cli.nombre AS nombreCliente,  me.nombre AS medioEntretenimiento, count(*) AS visitasTotales
FROM consumo AS cons
INNER JOIN medio_entretenimiento AS me ON cons.medio_entretenimiento_id = me.medio_id
RIGHT JOIN tarjeta AS t ON cons.numero_de_tarjeta = t.numero_de_tarjeta -- Toma tarjetas sin consumos
INNER JOIN cliente AS cli ON cli.cliente_id = t.cliente_id -- Todas las tarjetas pertenecen a un cliente, que puede o no tener consumos
WHERE cons.fecha_hora BETWEEN '2017-02-02' AND '2018-09-03' -- Reemplazar por fechas parametrizadas
GROUP BY cli.nombre, cli.apellido, me.nombre
ORDER BY apellidoCliente ASC, visitasTotales DESC;

-- Cambios de categoria entre fechas
SELECT cli.apellido AS apellidoCliente, cli.nombre AS nombreCliente,  cam.fecha AS fechaCambio, cat.nombre AS nuevaCategoria
FROM cambia_su AS cam
INNER JOIN tarjeta AS t ON cam.numero_de_tarjeta = t.numero_de_tarjeta
INNER JOIN cliente AS cli ON t.cliente_id = cli.cliente_id
INNER JOIN categoria AS cat ON cam.categoria_id = cat.categoria_id
WHERE cam.fecha BETWEEN '2016-01-05' AND '2019-01-01' -- Reemplazar por fechas parametrizadas
ORDER BY apellidoCliente ASC, fechaCambio ASC;

-- Atracciones con descuento para cada categoria
SELECT cat.nombre AS categoria, me.nombre AS nombreAtraccion, CONCAT(pa.descuento, '%') AS descuento
FROM permite_acceder AS pa
INNER JOIN atraccion AS atr ON pa.medio_id = atr.atraccion_id
INNER JOIN medio_entretenimiento AS me ON atr.atraccion_id = me.medio_id
INNER JOIN categoria AS cat ON pa.categoria_id = cat.categoria_id;

-- Empresa organizadora con mayor facturacion
CREATE OR REPLACE VIEW facturacionPorEmpresaOrganizadora AS
	SELECT eo.cuit AS cuitEmpresaOrganizadora, SUM(importe) AS facturacionTotal
	FROM consumo AS cons
	INNER JOIN evento AS ev ON cons.medio_entretenimiento_id = ev.evento_id
	INNER JOIN empresa_organizadora AS eo ON ev.cuit_organizadora = eo.cuit
	GROUP BY cuitEmpresaOrganizadora;

SELECT cuitEmpresaOrganizadora
FROM facturacionPorEmpresaOrganizadora
WHERE facturacionTotal = (SELECT MAX(facturacionTotal) FROM facturacionPorEmpresaOrganizadora);

-- TODO: Store procedure de categorias


-- Ranking de parques/atracciones de visitas
SELECT me.nombre AS medioEntretenimiento, count(*) AS visitasTotales
FROM consumo AS cons
INNER JOIN medio_entretenimiento AS me ON cons.medio_entretenimiento_id = me.medio_id
WHERE me.tipo IN ('PARQUE', 'ATRACCIÓN')
	AND cons.fecha_hora BETWEEN '2016-01-01' AND '2019-01-01' -- Reemplazar por fechas parametrizadas
GROUP BY medioEntretenimiento
ORDER BY visitasTotales DESC;



-- Selects para tener a mano
SELECT * FROM medio_entretenimiento;
SELECT * FROM atraccion;
SELECT * FROM parque;
SELECT * FROM consumo;
SELECT * FROM facturacionPorAtraccion;
SELECT * FROM facturacionPorParque;
SELECT * FROM facturacionPorEmpresaOrganizadora;
--