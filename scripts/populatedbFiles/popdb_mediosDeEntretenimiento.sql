

/*************  MEDIOS DE ENTRETENIMIENTO  **************/

/*********** Parques ************/

/*Parque Las Venturas*/
/* Lista de atracciones -> [la_rusa_loca, el_argento] */

/*Medio de entretenimiento*/
SET @precio_parque_las_venturas = 300;
INSERT INTO
	medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_parque_las_venturas, 'Parque de Las Venturas', 'PARQUE');
SET @id_parque_las_venturas = LAST_INSERT_ID();
/*Parque*/
INSERT INTO
	parque (parque_id, ubicacion_id)
VALUES (@id_parque_las_venturas, @id_ubicacion_parque_las_venturas); 

/*Atracciones del parque Las Venturas*/

SET @precio_la_rusa_loca = 100;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_la_rusa_loca, 'La Rusa Loca', 'ATRACCION');
SET @id_la_rusa_loca = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_la_rusa_loca, @id_parque_las_venturas, 5, 80, '80 cm');

SET @precio_el_argento = 50;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_el_argento, 'El Argento', 'ATRACCION');
SET @id_el_argento = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_el_argento, @id_parque_las_venturas, 2, 85,'50 cm');


/*Parque Astronomicus*/

/* Lista de atracciones -> [la_jazzy_rue, april_in_paris] */

/*Medio de entretenimiento*/
SET @precio_parque_astronomicus = 300;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_parque_astronomicus, 'Parque Astronomicus', 'PARQUE');
SET @id_parque_astronomicus = LAST_INSERT_ID();
/*Parque*/
INSERT INTO parque (parque_id, ubicacion_id)
VALUES (@id_parque_astronomicus, @id_ubicacion_parque_astronomicus); 

/*Atracciones del parque Astronomicus*/
SET @precio_la_jazzy_rue = 200;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_la_jazzy_rue, 'La Jazzy Rue', 'ATRACCION');
SET @id_la_jazzy_rue = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_la_jazzy_rue, @id_parque_astronomicus, 0, 99, '0 cm');

SET @precio_april_in_paris = 150;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_april_in_paris, 'April in Paris', 'ATRACCION');
SET @id_april_in_paris = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_april_in_paris, @id_parque_astronomicus, 0, 99, '0 cm');

/***************** FIN PARQUES *****************/

/******************** EVENTOS ******************/

/* BYPASS FEST */

/* Empresa organizadora*/
SET @cuit_empresa_cara = '30-71004052-0';
INSERT INTO 
	empresa_organizadora(cuit, razon_social, ubicacion_id)
VALUES(@cuit_empresa_cara,'STARBUCKS COFFE ARGENTINA S.R.L.', @id_ubicacion_empresa_org_cara);

/*EVENTO*/
SET @precio_bypass_fest = 300;
INSERT INTO 
	medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_bypass_fest, 'Bypass Fest', 'EVENTO');
SET @id_bypass_fest = LAST_INSERT_ID();

INSERT INTO
	evento(evento_id, cuit_organizadora, ubicacion_id, horario_desde, horario_hasta)
VALUES(@id_bypass_fest, @cuit_empresa_cara, @id_ubicacion_evento_bypass_fest, '2018-02-15 01:00:00', '2018-02-05 07:00:00');


/* FIESTA BIZARRA */

/*Empresa organizadora*/
SET @cuit_empresa_barata = '30-71004032-3';
INSERT INTO 
	empresa_organizadora(cuit, razon_social, ubicacion_id)
VALUES(@cuit_empresa_barata, 'ANONIMUS S.A.', @id_ubicacion_empresa_org_barata);

SET @precio_fiesta_bizarra = 200;
INSERT INTO 
	medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_fiesta_bizarra, 'Fiesta Bizarra', 'EVENTO');
SET @id_fiesta_bizarra = LAST_INSERT_ID();
INSERT INTO
	evento(evento_id, cuit_organizadora, ubicacion_id, horario_desde, horario_hasta)
VALUES(@id_fiesta_bizarra, @cuit_empresa_barata, @id_ubicacion_evento_fiesta_bizarra, '2018-01-25 08:57:59', '2018-01-25 20:57:59');

/******************** FIN EVENTOS ******************/

/***************************** FIN MEDIOS DE ENTRETENIMIENTO ************************/
