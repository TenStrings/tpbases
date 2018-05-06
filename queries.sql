-- TODO: usar un SP?
-- Facturacion total por id de atraccion
CREATE OR REPLACE VIEW facturacionPorAtraccion AS
    SELECT c.medio_id AS idAtraccion, SUM(importe) AS facturacionTotal
	FROM consumo AS c
	INNER JOIN atraccion AS atr ON c.medio_id = atr.medio_id
	GROUP BY idAtraccion;
-- Cuanto facturo la atraccion que mas facturo
SELECT MAX(facturacionTotal) INTO @maxFacturacionAtraccion FROM facturacionPorAtraccion; 

SELECT me.nombre AS nombreAtraccion
FROM facturacionPorAtraccion AS fpa
INNER JOIN medio_de_entretenimiento as me ON fpa.idAtraccion = me.id_medio
WHERE fpa.facturacionTotal = @maxFacturacionAtraccion;

-- Facturacion total por id de parque
CREATE OR REPLACE VIEW facturacionPorParque AS
    SELECT c.medio_id AS idParque, SUM(importe) AS facturacionTotal
	FROM consumo AS c
	INNER JOIN parque AS p ON c.medio_id = p.medio_id
	GROUP BY idParque;
-- Cuanto facturo la atraccion que mas facturo
SELECT @maxFacturacionParque := MAX(facturacionTotal) FROM facturacionPorParque;

--
CREATE OR REPLACE VIEW atraccionesConNombre AS
	SELECT atr.medio_id AS idAtraccion, me.nombre AS nombreAtraccion, atr.medio_parque_id AS idParqueCorrespondiente
    FROM atraccion AS atr
	INNER JOIN medio_de_entretenimiento AS me ON atr.medio_id = me.medio_id;

SELECT nombreParque, nombreAtraccion, MAX(importeTotal)
FROM (
	SELECT me.nombre AS nombreParque, atrc.nombreAtraccion, SUM(IFNULL(c.importe, 0)) AS importeTotal
	FROM parque AS p
	LEFT JOIN atraccionesConNombre AS atrc ON p.medio_id = atrc.idParqueCorrespondiente
	INNER JOIN medio_de_entretenimiento AS me ON p.medio_id = me.medio_id
	LEFT JOIN consumo AS c ON atrc.idAtraccion = c.medio_id
	GROUP BY nombreParque, atrc.nombreAtraccion
) AS parqueAtraccionImporteTotal
GROUP BY nombreParque, nombreAtraccion;