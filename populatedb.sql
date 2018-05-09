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


/*TARJETAS*/

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



/*MEDIOS DE ENTRETENIMIENTO*/


/*Parques*/

/*Parque Las Venturas*/
/*Ubicación*/
INSERT INTO 
ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Argentina', 'Mendoza', 'Mendoza', '95FF', 'Rivadavia', 544, NULL, NULL);
SET @id_ubicacion_parque_las_venturas = LAST_INSERT_ID();
/*Medio de entretenimiento*/
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (100.50, 'Parque de Las Venturas', 'PARQUE');
SET @id_medio_parque_las_venturas = LAST_INSERT_ID();
/*Parque*/
INSERT INTO parque (parque_id, ubicacion_id)
VALUES (@id_medio_parque_las_venturas, @id_ubicacion_parque_las_venturas); 

/*Atracciones del parque Las Venturas*/

INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (10.50, 'La Rusa Loca', 'ATRACCIÓN');
SET @id_la_rusa_loca = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_la_rusa_loca, @id_medio_parque_las_venturas, 0, 99, 2);

INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (11.50, 'El Argento', 'ATRACCIÓN');
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

INSERT INTO 
	medio_entretenimiento (precio, nombre, tipo)
VALUES (300, 'Bypass Fest', 'EVENTO');
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


/*CONSUMOS*/
/*mmm*/
