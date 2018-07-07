CREATE OR REPLACE VIEW categoriasActuales AS
    SELECT c.cliente_id, cs.categoria_id, t.numero_de_tarjeta, cs.fecha 
         FROM cambia_su cs, cliente c, tarjeta t
         WHERE
         NOT t.bloqueada AND
         t.cliente_id = c.cliente_id AND
         cs.fecha >= ALL (SELECT csi.fecha 
            FROM cambia_su csi, tarjeta ta
            WHERE
                ta.numero_de_tarjeta = csi.numero_de_tarjeta);
         
CREATE OR REPLACE VIEW resumenConsumos AS
SELECT ca.cliente_id, SUM(co.importe) as total 
FROM pago p, factura f, consumo co, categoriasActuales ca 
WHERE
    p.cliente_id = ca.cliente_id AND
    f.pago_id = p.pago_id AND
    co.numero_de_factura = f.numero_de_factura AND
    p.fecha > ca.fecha
GROUP BY ca.cliente_id; 

delimiter //

DROP FUNCTION IF EXISTS tpbases.new_category//
CREATE FUNCTION new_category(actual integer unsigned,
	 total decimal(10,2),
     ultimo_cambio date, fecha_actual date)
RETURNS INTEGER UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE actual_monto_subida decimal(10,2);
    DECLARE actual_monto_permanencia decimal(10,2);
    DECLARE new INTEGER UNSIGNED;
    DECLARE promedio decimal(10, 2);

    SELECT c.monto_subida, c.monto_permanencia, total / 12.0
    INTO actual_monto_subida, actual_monto_permanencia, promedio
    FROM categoria c
    WHERE c.categoria_id = actual;
    

    IF fecha_actual >= ultimo_cambio + interval '365' day THEN
        IF actual_monto_permanencia > promedio THEN
            SELECT categoria_id INTO new
            FROM categoria
            WHERE categoria.monto_permanencia <= promedio
            ORDER BY categoria.monto_permanencia DESC 
            LIMIT 1;
        ELSE RETURN (actual);
        END IF;
    
    ELSE    
        SELECT categoria_id INTO new 
        FROM categoria 
        WHERE categoria.monto_subida <= total AND 
        categoria.monto_subida >= actual_monto_subida
        ORDER BY categoria.monto_subida DESC
        LIMIT 1;
        IF new = actual THEN
            RETURN (NULL);
        END IF;
    END IF;
    RETURN (new);
END//

DROP PROCEDURE IF EXISTS update_categories//
CREATE PROCEDURE update_categories (IN fecha_actual date)
BEGIN
        INSERT INTO cambia_su
        SELECT  fecha_actual,
                numero_de_tarjeta as tarjeta,
                new_category(categoria_id, total, fecha, fecha_actual) as new 
        FROM 
            (select c.categoria_id, c.fecha, IFNULL(r.total, 0) as total, c.numero_de_tarjeta 
            from categoriasActuales c LEFT JOIN resumenConsumos r ON c.cliente_id = r.cliente_id) t 
        
        GROUP BY fecha_actual, numero_de_tarjeta, new
        HAVING new IS NOT NULL;
END//

delimiter ;
