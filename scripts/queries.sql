USE tpbases;

SHOW COLUMNS FROM consumo;

/*ESTADISTICAS*/

/* Asumimos que por "que más facturaron" se refieren a todos los consumos y no solo a los que ya tienen factura cerrada*/

-- Facturación total por atracción
CREATE OR REPLACE VIEW facturacionPorAtraccion AS
    SELECT m.medio_id AS idAtraccion, m.nombre as nombreAtraccion, SUM(IFNULL(importe,0)) AS totalFacturado
	FROM medio_entretenimiento AS m
	LEFT JOIN consumo AS c ON  m.medio_id = c.medio_entretenimiento_id	 
 	WHERE m.tipo = 'ATRACCION'
    GROUP BY idAtraccion, nombreAtraccion;
	
-- Atracciones que más facturaron
SELECT idAtraccion, nombreAtraccion, totalFacturado
FROM facturacionPorAtraccion
WHERE totalFacturado >= ALL (SELECT totalFacturado FROM facturacionPorAtraccion);

-- Facturacion total por parque
CREATE OR REPLACE VIEW facturacionPorParque AS
    SELECT m.medio_id AS idParque, m.nombre AS nombreParque, SUM(IFNULL(importe,0)) AS totalFacturado
	FROM medio_entretenimiento AS m
	LEFT JOIN consumo AS c ON  m.medio_id = c.medio_entretenimiento_id
	WHERE m.tipo = 'PARQUE' 
 	GROUP BY idParque, nombreParque;

-- Parques que más facturaron
-- SELECT @maxFacturacionParque := MAX(totalFacturado) FROM facturacionPorParque;
SELECT idParque, nombreParque, totalFacturado
FROM facturacionPorParque AS fpp
WHERE totalFacturado >= ALL (SELECT totalFacturado FROM facturacionPorParque);

-- Facturacion por atraccion con info de parques correspondientes
CREATE OR REPLACE VIEW facturacionPorAtraccionConParque AS
	SELECT a.parque_id AS idParque, m.nombre AS nombreParque, fpa.idAtraccion, 
		   fpa.nombreAtraccion, fpa.totalFacturado AS totalFacturadoAtraccion
    FROM atraccion AS a, facturacionPorAtraccion AS fpa, medio_entretenimiento AS m
	WHERE a.atraccion_id = fpa.idAtraccion AND a.parque_id = m.medio_id;

-- Atracciones que más facturaron por parque 
SELECT idParque, idAtraccion, nombreParque, nombreAtraccion, totalFacturadoAtraccion
FROM facturacionPorAtraccionConParque fpap2
WHERE totalFacturadoAtraccion >= ALL (SELECT totalFacturadoAtraccion 
									  FROM facturacionPorAtraccionConParque AS fpap1 
									  WHERE fpap1.idParque = fpap2.idParque);

/* Esta estaba mal creo porque devuelve todas las atracciones para cada parque y creo que piden solo la que mas facturo para cada parque
CREATE OR REPLACE VIEW atraccionesConNombre AS
	SELECT atr.atraccion_id AS idAtraccion, me.nombre AS nombreAtraccion, atr.parque_id AS idParqueCorrespondiente
    FROM atraccion AS atr
	INNER JOIN medio_entretenimiento AS me ON atr.atraccion_id = me.medio_id;

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
*/

-- Facturas impagas  AGREGAR EN LOS DATOS MAS FACTURAS IMPAGAS, SOLO HAY UNA
SELECT f.numero_de_factura, f.fecha_vencimiento
FROM factura AS f
WHERE f.pago_id IS NULL;

-- Atracciones mas visitadas por cliente en rango de fechas 
-- ESTA ESTA MAL, TENES QUE DEVOLVER LA MAS VISITADA POR CLIENTE Y ESTAS DEVOLVIENDO LAS VISITAS A TODAS LAS ATRACCIONES POR CLIENTE :S 
SELECT cli.apellido AS apellidoCliente, cli.nombre AS nombreCliente, m.nombre AS medioEntretenimiento, count(*) AS visitasTotales
FROM consumo AS cons
INNER JOIN medio_entretenimiento AS m ON cons.medio_entretenimiento_id = m.medio_id
RIGHT JOIN tarjeta AS t ON cons.numero_de_tarjeta = t.numero_de_tarjeta -- Toma tarjetas sin consumos
INNER JOIN cliente AS cli ON cli.cliente_id = t.cliente_id -- Todas las tarjetas pertenecen a un cliente, que puede o no tener consumos
WHERE cons.fecha_hora BETWEEN '2017-02-02' AND '2018-09-03' -- Reemplazar por fechas parametrizadas
GROUP BY cli.nombre, cli.apellido, m.nombre
ORDER BY apellidoCliente ASC, visitasTotales DESC;


-- Cambios de categoria entre fechas
delimiter //
DROP PROCEDURE IF EXISTS cambios_categoria_entre //
CREATE PROCEDURE cambios_categoria_entre (IN desde date, IN hasta date) 
BEGIN	
    SELECT cli.numero_de_documento AS nroDocumento, cli.apellido AS apellidoCliente, cli.nombre AS nombreCliente, 
		   cam.fecha AS fechaCambio, cat.nombre AS nuevaCategoria
	FROM cambia_su AS cam, tarjeta AS t, cliente as cli, categoria AS cat
	WHERE t.cliente_id = cli.cliente_id AND
	      cam.numero_de_tarjeta = t.numero_de_tarjeta AND
          cam.categoria_id = cat.categoria_id AND
          cam.fecha BETWEEN desde AND hasta
	ORDER BY nroDocumento ASC, fechaCambio ASC;
END//
delimiter ;
CALL cambios_categoria_entre ('2018-01-01', '2019-01-01'); -- Ejemplo

/* me parece un poco mas clara como está escrito arriba pero como quieras, tambien le agregue los parametros que querias
SELECT cli.numero_de_documento AS nroDocumento, cli.apellido AS apellidoCliente, cli.nombre AS nombreCliente, 
	   cam.fecha AS fechaCambio, cat.nombre AS nuevaCategoria
FROM cambia_su AS cam
INNER JOIN tarjeta AS t ON cam.numero_de_tarjeta = t.numero_de_tarjeta
INNER JOIN cliente AS cli ON t.cliente_id = cli.cliente_id
INNER JOIN categoria AS cat ON cam.categoria_id = cat.categoria_id
WHERE cam.fecha BETWEEN '2018-01-01' AND '2019-01-01' -- Reemplazar por fechas parametrizadas
ORDER BY nroDocumento ASC, fechaCambio ASC;
*/

-- Atracciones con descuento para cada categoria

-- Asumimos que quieren las que tienen descuento > 0, es decir filtramos las que sólo te deja acceder pero sin descuento.
SELECT cat.nombre AS categoria, me.nombre AS nombreAtraccion, CONCAT(pa.descuento, '%') AS descuento
FROM permite_acceder AS pa
INNER JOIN atraccion AS atr ON pa.medio_id = atr.atraccion_id
INNER JOIN medio_entretenimiento AS me ON atr.atraccion_id = me.medio_id
INNER JOIN categoria AS cat ON pa.categoria_id = cat.categoria_id
WHERE pa.descuento > 0;

-- Empresa organizadora con mayor facturacion

-- Facturación por empresa organizadora
CREATE OR REPLACE VIEW facturacionPorEmpresaOrganizadora AS
	SELECT eo.cuit AS cuitEmpresaOrganizadora, eo.razon_social AS razonSocial, SUM(importe) AS totalFacturado
	FROM consumo AS cons
	INNER JOIN evento AS ev ON cons.medio_entretenimiento_id = ev.evento_id
	INNER JOIN empresa_organizadora AS eo ON ev.cuit_organizadora = eo.cuit
	GROUP BY cuitEmpresaOrganizadora, razonSocial;

-- Empresas organizadoras que más facturaron
SELECT cuitEmpresaOrganizadora, razonSocial, totalFacturado
FROM facturacionPorEmpresaOrganizadora
WHERE totalFacturado = (SELECT MAX(totalFacturado) FROM facturacionPorEmpresaOrganizadora);

-- Store procedure de categorias está en update_categories.sql

-- Ranking de visitas a parques/atracciones 
SELECT me.nombre AS medioEntretenimiento, me.tipo, count(*) AS visitasTotales
FROM consumo AS cons
INNER JOIN medio_entretenimiento AS me ON cons.medio_entretenimiento_id = me.medio_id
WHERE me.tipo IN ('PARQUE', 'ATRACCION') AND
	  cons.fecha_hora BETWEEN '2016-01-01' AND '2019-01-01' -- Reemplazar por fechas parametrizadas se puede hacer con lo de sp como hice en el de cambios de categorias
GROUP BY medioEntretenimiento, me.tipo
ORDER BY visitasTotales DESC;



-- Selects para tener a mano
SELECT * FROM medio_entretenimiento;
SELECT * FROM atraccion;
SELECT * FROM parque;
SELECT * FROM consumo;
SELECT * FROM facturacionPorAtraccion;
SELECT * FROM facturacionPorParque;
SELECT * FROM facturacionPorAtraccionConParque;
SELECT * FROM facturacionPorEmpresaOrganizadora;
--