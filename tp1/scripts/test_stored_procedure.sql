/*No correr el populatedb, estos son datos frescos xD*/
use tpbases;

SET @inicio = '2018-01-01';

INSERT INTO
	categoria(nombre, monto_subida, monto_permanencia)
VALUES('BRONCE', 0, 0);
SET @id_categoria_bronce = LAST_INSERT_ID();

INSERT INTO
	categoria(nombre, monto_subida, monto_permanencia)
VALUES('PLATA', 500, 500);
SET @id_categoria_plata = LAST_INSERT_ID();

INSERT INTO
	categoria(nombre, monto_subida, monto_permanencia)
VALUES('ORO', 2000, 1800);
SET @id_categoria_oro = LAST_INSERT_ID();

INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Argentina', 'Buenos Aires', 'Gato', '333333', '312', 2132, NULL, NULL);
SET @ubicacion = LAST_INSERT_ID();

INSERT INTO
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Foo', 'Bar', 'VISA', @ubicacion, @ubicacion, 11110);
SET @foobar = LAST_INSERT_ID();

INSERT INTO
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@foobar, NULL, false); 
SET @tarjeta_foobar = LAST_INSERT_ID();


INSERT INTO
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES(@inicio, @tarjeta_foobar, 1/*despues veo*/);

SET @cuit = '30-7104032-3';
INSERT INTO 
	empresa_organizadora(cuit, razon_social, ubicacion_id)
VALUES(@cuit, 'Sarif Industries', @ubicacion);

INSERT INTO 
	medio_entretenimiento (precio, nombre, tipo)
VALUES (501, 'Cyborgs 901', 'EVENTO');
SET @id_evento_plata = LAST_INSERT_ID();
INSERT INTO
	evento(evento_id, cuit_organizadora, ubicacion_id, horario_desde, horario_hasta)
VALUES(@id_evento_plata, @cuit, @ubicacion, '2018-01-01 00:00:00', '2019-02-01 00:00:00');

INSERT INTO
	pago(fecha, cliente_id, medio_de_pago)
VALUES(@inicio + interval '2' day, @foobar, 'VISA');
SET @id_pago = LAST_INSERT_ID();

-- FACTURA  
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES(@inicio + interval '1' day, @inicio + interval '10' day , @id_pago);
SET @factura1 = LAST_INSERT_ID();

-- CONSUMO
INSERT INTO
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@factura1, @tarjeta_foobar, @id_evento_plata, 501, '2018-01-01 12:05:10');

SELECT 'Deberia ser 1:' as m, c.categoria_id, c.fecha from categoriasActuales c 
WHERE c.cliente_id = @foobar;

CALL update_categories(@inicio + interval '2' day);

SELECT 'Deberia ser 2:' as m, c.categoria_id, c.fecha from categoriasActuales c 
WHERE c.cliente_id = @foobar;

INSERT INTO
	pago(fecha, cliente_id, medio_de_pago)
VALUES(@inicio + interval '40' day, @foobar, 'VISA');
SET @id_pago2 = LAST_INSERT_ID();

-- FACTURA  
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES(@inicio + interval '39' day, @inicio + interval '50' day , @id_pago2);
SET @factura2 = LAST_INSERT_ID();

-- CONSUMO
INSERT INTO
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@factura2, @tarjeta_foobar, @id_evento_plata, 3501, '2018-02-01 12:05:10');

CALL update_categories(@inicio + interval '41' day);

SELECT 'Deberia ser 3:' as m, c.categoria_id, c.fecha from categoriasActuales c 
WHERE c.cliente_id = @foobar;

CALL update_categories(@inicio + interval '41' day + interval '366' day);

SELECT 'Deberia ser 1:' as m, c.categoria_id, c.fecha from categoriasActuales c 
WHERE c.cliente_id = @foobar;
