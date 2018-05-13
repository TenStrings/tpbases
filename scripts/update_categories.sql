delimiter //
DROP FUNCTION IF EXISTS getDate//
CREATE FUNCTION getDate()
RETURNS date
DETERMINISTIC
BEGIN RETURN(curdate());
END//
delimiter ;

CREATE OR REPLACE VIEW categoriasActuales AS
    SELECT c.cliente_id, cs.categoria_id, t.numero_de_tarjeta, cs.fecha 
         FROM cambia_su cs, cliente c, tarjeta t
         WHERE
         NOT t.bloqueada AND
         t.cliente_id = c.cliente_id AND
         t.numero_de_tarjeta = cs.numero_de_tarjeta AND
         cs.fecha > ALL (SELECT csi.fecha 
            FROM cambia_su csi, tarjeta ta
            WHERE
                cs.fecha != csi.fecha AND 
                ta.numero_de_tarjeta = csi.numero_de_tarjeta AND
                ta.cliente_id = c.cliente_id);

CREATE OR REPLACE VIEW resumenConsumos AS
SELECT c.cliente_id, AVG(co.importe) as promedio, SUM(co.importe) as total 
FROM cliente c, pago p, factura f, consumo co, categoriasActuales ca
WHERE
    p.cliente_id = c.cliente_id AND
    c.cliente_id = ca.cliente_id AND
    co.numero_de_factura = f.numero_de_factura AND
    f.pago_id = p.pago_id AND
    p.fecha > getDate() - interval '365' day AND
    p.fecha > ca.fecha
GROUP BY c.cliente_id;

delimiter //

DROP FUNCTION IF EXISTS tpbases.new_category//
CREATE FUNCTION new_category(actual integer unsigned,
     promedio decimal(10,2), total decimal(10,2), ultimo_cambio date)
RETURNS INTEGER UNSIGNED
DETERMINISTIC
BEGIN
    DECLARE actual_monto_subida decimal(10,2);
    DECLARE actual_monto_permanencia decimal(10,2);
    DECLARE new INTEGER UNSIGNED;

    SELECT c.monto_subida, c.monto_permanencia
    INTO actual_monto_subida, actual_monto_permanencia
    FROM categoria c
    WHERE c.categoria_id = actual;
    
    IF total > actual_monto_subida THEN 
        SELECT categoria_id INTO new 
        FROM categoria WHERE categoria.monto_subida <= promedio
        ORDER BY categoria.monto_subida DESC
        LIMIT 1;
    ELSEIF getDate() > ultimo_cambio + interval '365' day THEN
        IF promedio < actual_monto_permanencia THEN
            SELECT categoria_id INTO new
            FROM categoria
            WHERE categoria.monto_permanencia <= promedio
            ORDER BY categoria.monto_permanencia DESC 
            LIMIT 1;
        ELSE RETURN (actual);
        END IF;
    END IF;
    RETURN (new);
END//

DROP PROCEDURE IF EXISTS update_categories//
CREATE PROCEDURE update_categories ()
BEGIN
        INSERT INTO cambia_su
        SELECT  getDate() as fecha,
                t.numero_de_tarjeta as tarjeta,
                new_category(r.categoria_id, r.promedio, r.total, r.fecha) as new
        FROM
            (select c.cliente_id, c.categoria_id, c.fecha, IFNULL(r.promedio, 0) as promedio, IFNULL(r.total, 0) as total from 
            categoriasActuales c
            LEFT OUTER JOIN resumenConsumos r ON c.cliente_id = r.cliente_id) r,
            tarjeta t
        WHERE
            NOT t.bloqueada AND
            t.cliente_id = r.cliente_id
        HAVING new IS NOT NULL;
END//

delimiter ;
