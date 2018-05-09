USE tpbases;

/*USUARIOS*/

INSERT INTO 
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Tomás', 'Pastore', 1, NULL, NULL, 39560320);
SET @id_tomas = LAST_INSERT_ID();
INSERT INTO 
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Jacinto', 'Populea', 1, NULL, NULL, 40000000);
SET @id_jacinto = LAST_INSERT_ID();
INSERT INTO 
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Carmichael', 'Buonavita', 2, NULL, NULL, 40000001);
SET @id_carmichael = LAST_INSERT_ID();
INSERT INTO 
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Michael', 'Corleone', 2, NULL, NULL, 40000002);
SET @id_michael = LAST_INSERT_ID();


/*TARJETAS Y CATEGORIAS*/

INSERT INTO
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_tomas, NULL, false); 
SET @id_tarjeta_tomas = LAST_INSERT_ID();

INSERT INTO
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_jacinto, NULL, false); 
SET @id_tarjeta_jacinto= LAST_INSERT_ID();

INSERT INTO
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_carmichael, NULL, false); 
SET @id_tarjeta_carmichael= LAST_INSERT_ID();

INSERT INTO
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_michael, NULL, false); 
SET @id_tarjeta_michael = LAST_INSERT_ID();

INSERT INTO
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_michael, NULL, true); 
SET @id_tarjeta_michael_bloqueada = LAST_INSERT_ID();

-- Categorias
INSERT INTO
	categoria(nombre, monto_subida, monto_permanencia)
VALUES('BRONCE', 0, 0);

INSERT INTO
	categoria(nombre, monto_subida, monto_permanencia)
VALUES('PLATA', 500, 500);

INSERT INTO
	categoria(nombre, monto_subida, monto_permanencia)
VALUES('ORO', 2000, 1800);

-- Cambios de categoria

INSERT INTO
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES('2016-01-05', @id_tarjeta_tomas, 'BRONCE');

INSERT INTO
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES('2016-01-05', @id_tarjeta_carmichael, 'BRONCE');

INSERT INTO
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES('2016-01-05', @id_tarjeta_michael, 'BRONCE');

INSERT INTO
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES('2018-02-10', @id_tarjeta_tomas, 'PLATA');

-- Accesos

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, 'BRONCE', 10);

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_medio_parque_las_venturas, 'BRONCE', 10);

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, 'BRONCE', 10);

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, 'PLATA', 20);

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_medio_parque_las_venturas, 'PLATA', 20);

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, 'PLATA', 20);

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, 'ORO', 50);

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_medio_parque_las_venturas, 'ORO', 50);

INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, 'ORO', 50);



/*MEDIOS DE ENTRETENIMIENTO*/


/*Parques*/

/*Parque Las Venturas*/
/*Ubicación*/
INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Argentina', 'Mendoza', 'Mendoza', '95FF', 'Rivadavia', 544, NULL, NULL);
SET @id_ubicacion_parque_las_venturas = LAST_INSERT_ID();
/*Medio de entretenimiento*/
INSERT INTO
	medio_entretenimiento (precio, nombre, tipo)
VALUES (100, 'Parque de Las Venturas', 'PARQUE');
SET @id_medio_parque_las_venturas = LAST_INSERT_ID();
/*Parque*/
INSERT INTO
	parque (parque_id, ubicacion_id)
VALUES (@id_medio_parque_las_venturas, @id_ubicacion_parque_las_venturas); 

/*Atracciones del parque Las Venturas*/

SET @precio_la_rusa_loca = 300;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_la_rusa_loca, 'La Rusa Loca', 'ATRACCIÓN');
SET @id_la_rusa_loca = LAST_INSERT_ID();

INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_la_rusa_loca, @id_medio_parque_las_venturas, 0, 99, 2);

SET @precio_el_argento = 350;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_el_argento, 'El Argento', 'ATRACCIÓN');
SET @id_el_argento = LAST_INSERT_ID();

INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_el_argento, @id_medio_parque_las_venturas, 0, 99, 3);


/*Parque Astronomicus*/
/*Ubicación*/
INSERT INTO 
ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Francia', NULL, 'París', '2323XXRT', 'Jean Jaures', 144, NULL, NULL);
SET @id_ubicacion_parque_astronomicus = LAST_INSERT_ID();
/*Medio de entretenimiento*/
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (300.50, 'Parque Astronomicus', 'PARQUE');
SET @id_medio_parque_astronomicus = LAST_INSERT_ID();
/*Parque*/
INSERT INTO parque (parque_id, ubicacion_id)
VALUES (@id_medio_parque_astronomicus, @id_ubicacion_parque_astronomicus); 

/*Atracciones del parque Astronomicus*/

INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (13.50, 'La Jazzy Rue', 'ATRACCIÓN');
SET @id_la_jazzy_rue = LAST_INSERT_ID();

INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_la_jazzy_rue, @id_medio_parque_astronomicus, 0, 99, 2);

INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (15.50, 'April in Paris', 'ATRACCIÓN');
SET @id_april_in_paris = LAST_INSERT_ID();

INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_april_in_paris, @id_medio_parque_astronomicus, 0, 99, 3);

/* Eventos */
/* Ubicacion */

-- Bypass fest
INSERT INTO
	ubicacion(pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES('Argentina', 'Rio Negro', 'Bariloche', 8400, 'Catedral', 184, NULL, NULL);
SET @id_ubicacion_evento_bypass_fest = LAST_INSERT_ID();

SET @precio_bypass_fest = 300;
INSERT INTO 
	medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_bypass_fest, 'Bypass Fest', 'EVENTO');
SET @id_bypass_fest = LAST_INSERT_ID();

SET @cuit_empresa_cara = 12345678;
INSERT INTO 
	empresa_organizadora(cuit, razon_social)
VALUES(@cuit_empresa_cara, 1);

INSERT INTO
	evento(evento_id, cuit_organizadora, ubicacion_id, horario_desde, horario_hasta)
VALUES(@id_bypass_fest, @cuit_empresa_cara, @id_ubicacion_evento_bypass_fest, '2018-06-04 01:00:15', '2018-06-04 07:00:30');

-- Fiesta bizarra

INSERT INTO
	ubicacion(pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES('Argentina', 'Buenos Aires', 'CABA', 5842, 'Combate de los pozos', 58, 4, 8);
SET @id_ubicacion_evento_fiesta_bizarra = LAST_INSERT_ID();

INSERT INTO 
	medio_entretenimiento (precio, nombre, tipo)
VALUES (50, 'Fiesta Bizarra', 'EVENTO');
SET @id_fiesta_bizarra = LAST_INSERT_ID();

SET @cuit_empresa_barata = 87654321;
INSERT INTO 
	empresa_organizadora(cuit, razon_social)
VALUES(@cuit_empresa_barata, 2);

INSERT INTO
	evento(evento_id, cuit_organizadora, ubicacion_id, horario_desde, horario_hasta)
VALUES(@id_fiesta_bizarra, @cuit_empresa_barata, @id_ubicacion_evento_fiesta_bizarra, '2017-06-04 08:37:59', '2017-06-04 20:37:59');

/*CONSUMOS Y FACTURAS*/
INSERT INTO
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(NULL, @id_tajeta_tomas, @id_la_rusa_loca, @precio_la_rusa_loca, '2018-01-05 14:43:42');
SET @id_consumo_tomas_1 = LAST_INSERT_ID();

INSERT INTO
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(NULL, @id_tajeta_tomas, @id_la_rusa_loca, @precio_la_rusa_loca, '2018-01-05 15:43:42');
SET @id_consumo_tomas_2 = LAST_INSERT_ID();

INSERT INTO
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(NULL, @id_tajeta_tomas, @id_el_argento, @precio_el_argento, '2018-02-03 16:49:34');
SET @id_consumo_tomas_3 = LAST_INSERT_ID();

-- Todavia no tiene factura
INSERT INTO
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(NULL, @id_tajeta_tomas, @id_bypass_fest, @precio_bypass_fest, '2018-05-05 02:45:09');
SET @id_consumo_tomas_4 = LAST_INSERT_ID();

-- Pago de la factura de consumos tomas 1 y 2
INSERT INTO
	pago(fecha, cliente_id)
VALUES('2018-02-10', @id_tomas);
SET @id_pago_tomas_1 = LAST_INSERT_ID();

-- Factura consumos tomas 1 y 2
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES('2018-02-01', '2018-03-01', @id_pago_tomas_1);

-- Factura impaga de consumo tomas 3
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES('2018-03-01', '2018-04-01', NULL)


/*  */ 
