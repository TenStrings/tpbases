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


/*CONSUMOS*/
/*mmm*/
