USE tpbases;

/*** CONVENCIONES ***/
-- El sistema comienza el 1 de enero de 2018.
-- El sistema soporta 3 medios de pago VISA, AMEX Y MASTERCARD
-- Hay 3 categorias BRONCE, PLATA Y ORO. 
-- Los descuentos de categorias superiores son mejores o iguales


/*Variables utiles*/

SET @fecha_inicio_programa = '2018-01-01';
SET @tipo_parque = 'PARQUE';
SET @tipo_atraccion = 'ATRACCION';
SET @tipo_evento = 'EVENTO';

SET @mp_visa = 'VISA';
SET @mp_amex = 'AMEX';
SET @mp_master = 'MASTERCARD';
/************  UBICACIONES  *****************/

/*** De Clientes ****/

/*Tomas ubicacion facturacion*/
INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Argentina', 'Buenos Aires', 'Olivos', '1636', 'Carlos Villate', 2132, NULL, NULL);
SET @id_ubicacion_facturacion_tomas = LAST_INSERT_ID();
/*Tomas ubicacion residencia*/
SET @id_ubicacion_residencia_tomas = @id_ubicacion_facturacion_tomas;

/*Jacinto ubicacion facturacion*/
INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Argentina', 'Buenos Aires', 'Florida', '1615', 'Gral. Roca', 2004, NULL, NULL);
SET @id_ubicacion_facturacion_jacinto = LAST_INSERT_ID();
/*Jacinto ubicacion residencia*/
SET @id_ubicacion_residencia_jacinto = @id_ubicacion_facturacion_jacinto;

/*Carmichael ubicacion facturacion*/
INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Italia', 'Roma', 'Roma', 'RA12', 'Piano', 129, 2, 'B');
SET @id_ubicacion_facturacion_carmichael = LAST_INSERT_ID();
/*Carmichael ubicacion residencia*/
INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Italia', 'Roma', 'Roma', 'RA12', 'Piero', 150, NULL, NULL);
SET @id_ubicacion_residencia_carmichael = LAST_INSERT_ID();

/*Michael ubicacion facturacion*/
INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Alemania', 'Berlín', 'Berlín', 'BE10', 'Strujenbajen', 332, 1, 'A');
SET @id_ubicacion_facturacion_michael = LAST_INSERT_ID();
/*Michael ubicacion residencia*/
INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Alemania', 'Berlín', 'Berlín', 'BE10', 'Livedij', 402, 4, 'C');
SET @id_ubicacion_residencia_michael = LAST_INSERT_ID();

/*De medios de entretenimiento*/

/*Parque las venturas*/
INSERT INTO 
	ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Argentina', 'Mendoza', 'Mendoza', '95FF', 'Rivadavia', 544, NULL, NULL);
SET @id_ubicacion_parque_las_venturas = LAST_INSERT_ID();

/*Parque astronomicus*/
INSERT INTO 
ubicacion (pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES ('Francia', 'París', 'París', '2323XXRT', 'Jean Jaures', 144, NULL, NULL);
SET @id_ubicacion_parque_astronomicus = LAST_INSERT_ID();

/*Organizadora de Bypass fest */
INSERT INTO
	ubicacion(pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES('Argentina', 'Buenos Aires', 'Vicente López', 1012, 'Av. libertador', 1225, 3, NULL);
SET @id_ubicacion_empresa_org_cara = LAST_INSERT_ID();

/*Bypass fest */
INSERT INTO
	ubicacion(pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES('Argentina', 'Rio Negro', 'Bariloche', 2410, 'Catedral', 184, NULL, NULL);
SET @id_ubicacion_evento_bypass_fest = LAST_INSERT_ID();

/*Organizadora de Fiesta Bizarra */
INSERT INTO
	ubicacion(pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES('Chile', 'Villarica', 'Villarica', 101, 'Lanín', 1003, NULL, NULL);
SET @id_ubicacion_empresa_org_barata = LAST_INSERT_ID();

/*Fiesta Bizarra*/
INSERT INTO
	ubicacion(pais, provincia, localidad, codigo_postal, calle, altura, piso, departamento)
VALUES('Argentina', 'La Pampa', 'Mitre', 1021, 'Combate de los pozos', 158, NULL, NULL);
SET @id_ubicacion_evento_fiesta_bizarra = LAST_INSERT_ID();

/****************  FIN UBICACIONES  *******************/


/*************  CLIENTES  **************/  

SET @medio_de_pago_tomas =@mp_visa;
INSERT INTO -- CONSUMIDOR FRECUENTE CATEGORIA GOLD 
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Tomás', 'Pastore', @medio_de_pago_tomas, @id_ubicacion_facturacion_tomas, @id_ubicacion_residencia_tomas, 39560320);
SET @id_tomas = LAST_INSERT_ID();

SET @medio_de_pago_jacinto =@mp_amex;
INSERT INTO -- CONSUMIDOR MEDIO CATEGORIA PLATA
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Jacinto', 'Populea',@medio_de_pago_jacinto, @id_ubicacion_facturacion_jacinto, @id_ubicacion_residencia_jacinto, 40000000);
SET @id_jacinto = LAST_INSERT_ID();

SET @medio_de_pago_carmichael = @mp_master;
INSERT INTO -- CONSUMIDOR BAJO CATEGORIA BRONCE
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Carmichael', 'Buonavita',@medio_de_pago_carmichael, @id_ubicacion_facturacion_carmichael, @id_ubicacion_residencia_carmichael, 40000001);
SET @id_carmichael = LAST_INSERT_ID();

SET @medio_de_pago_michael = @mp_master;
INSERT INTO -- CLIENTE RATA (NUNCA CONSUMIO)
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Michael', 'Corleone', @medio_de_pago_michael, @id_ubicacion_facturacion_michael, @id_ubicacion_residencia_michael, 40000002);
SET @id_michael = LAST_INSERT_ID();

/*************  FIN CLIENTES  **************/


/*************  TARJETAS  **************/	

INSERT INTO  -- TOMAS && BLOQUEADA EL 15/01/2018 PORQUE LA PERDIO 
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_tomas, NULL, true); 
SET @id_tarjeta_tomas_actualmente_bloqueada = LAST_INSERT_ID();

INSERT INTO  -- TOMAS ACTIVA ACTUALMENTE
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_tomas, NULL, false); 
SET @id_tarjeta_tomas_actualmente_activa = LAST_INSERT_ID();

INSERT INTO -- JACINTO
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_jacinto, NULL, false); 
SET @id_tarjeta_jacinto= LAST_INSERT_ID();

INSERT INTO -- CARMICHAEL
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_carmichael, NULL, false); 
SET @id_tarjeta_carmichael= LAST_INSERT_ID();

INSERT INTO -- MICHAEL
    tarjeta (cliente_id, foto, bloqueada)
VALUES(@id_michael, NULL, false); 
SET @id_tarjeta_michael = LAST_INSERT_ID();

/*************  FIN DE TARJETAS  **************/


/***************** CATEGORIAS  ******************/

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

/*************  FIN DE CATEGORIAS  **************/


/***************  CAMBIOS DE CATEGORIA  ****************/

-- HISTORIAL DE CATEGORIAS PARA LA TARJETA DE TOMÁS

INSERT INTO -- CATEGORIA INICIAL
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES(@fecha_inicio_programa, @id_tarjeta_tomas_actualmente_bloqueada, @id_categoria_bronce);

SET @fecha_tomas_pierde_tarjeta = '2018-01-15';
SET @id_categoria_tomas_tarjeta_perdida = @id_categoria_bronce;
INSERT INTO -- CATEGORIA INICIAL NUEVA TARJETA
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES(@fecha_tomas_pierde_tarjeta, @id_tarjeta_tomas_actualmente_activa, @id_categoria_tomas_tarjeta_perdida);

SET @fecha_tomas_bronce_a_oro = '2018-02-10'; -- Sí, sube 2 de una porque es un consumista
INSERT INTO -- SUBE DE CATEGORIA AL PAGAR EL MES DE ENERO
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES(@fecha_tomas_bronce_a_oro, @id_tarjeta_tomas_actualmente_activa, @id_categoria_oro);


-- HISTORIAL DE CATEGORIAS PARA LA TARJETA DE JACINTO

INSERT INTO -- CATEGORIA INICIAL
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES(@fecha_inicio_programa, @id_tarjeta_jacinto, @id_categoria_bronce);

SET @fecha_jacinto_bronce_a_plata = '2018-02-11';
INSERT INTO -- SUBE DE CATEGORIA AL PAGAR EL MES DE ENERO
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES(@fecha_jacinto_bronce_a_plata, @id_tarjeta_jacinto, @id_categoria_plata);

-- HISTORIAL DE CATEGORIAS PARA LA TARJETA DE CARMICHAEL

INSERT INTO -- CATEGORIA INICIAL
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES(@fecha_inicio_programa, @id_tarjeta_carmichael, @id_categoria_bronce);

-- HISTORIAL DE CATEGORIAS PARA LA TARJETA DE MICHAEL

INSERT INTO -- CATEGORIA INICIAL
	cambia_su(fecha, numero_de_tarjeta, categoria_id)
VALUES(@fecha_inicio_programa, @id_tarjeta_michael, @id_categoria_bronce);

/*************  FIN CAMBIOS DE CATEGORIA  **************/


/*************  MEDIOS DE ENTRETENIMIENTO  **************/

/*********** Parques ************/

/*Parque Las Venturas*/
/* Lista de atracciones -> [la_rusa_loca, el_argento] */

/*Medio de entretenimiento*/
SET @precio_parque_las_venturas = 300;
INSERT INTO
	medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_parque_las_venturas, 'Parque de Las Venturas', @tipo_parque);
SET @id_parque_las_venturas = LAST_INSERT_ID();
/*Parque*/
INSERT INTO
	parque (parque_id, ubicacion_id)
VALUES (@id_parque_las_venturas, @id_ubicacion_parque_las_venturas); 

/*Atracciones del parque Las Venturas*/
SET @precio_la_rusa_loca = 100;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_la_rusa_loca, 'La Rusa Loca', @tipo_atraccion);
SET @id_la_rusa_loca = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_la_rusa_loca, @id_parque_las_venturas, 5, 80, '80 cm');

SET @precio_el_argento = 50;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_el_argento, 'El Argento', @tipo_atraccion);
SET @id_el_argento = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_el_argento, @id_parque_las_venturas, 2, 85,'50 cm');

SET @precio_barco_pirata = 30;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_barco_pirata, 'Barco pirata', @tipo_atraccion);
SET @id_barco_pirata = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_barco_pirata, @id_parque_las_venturas, 10, 50,'100 cm');

/*Parque Astronomicus*/

/* Lista de atracciones -> [la_jazzy_rue, april_in_paris] */

/*Medio de entretenimiento*/
SET @precio_parque_astronomicus = 300;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_parque_astronomicus, 'Parque Astronomicus', @tipo_parque);
SET @id_parque_astronomicus = LAST_INSERT_ID();
/*Parque*/
INSERT INTO parque (parque_id, ubicacion_id)
VALUES (@id_parque_astronomicus, @id_ubicacion_parque_astronomicus); 

/*Atracciones del parque Astronomicus*/
SET @precio_la_jazzy_rue = 200;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_la_jazzy_rue, 'La Jazzy Rue', @tipo_atraccion);
SET @id_la_jazzy_rue = LAST_INSERT_ID();
INSERT INTO
    atraccion (atraccion_id, parque_id, edad_desde, edad_hasta, altura_min)
VALUES(@id_la_jazzy_rue, @id_parque_astronomicus, 0, 99, '0 cm');

SET @precio_april_in_paris = 150;
INSERT INTO medio_entretenimiento (precio, nombre, tipo)
VALUES (@precio_april_in_paris, 'April in Paris', @tipo_atraccion);
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
VALUES (@precio_bypass_fest, 'Bypass Fest', @tipo_evento);
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
VALUES (@precio_fiesta_bizarra, 'Fiesta Bizarra', @tipo_evento);
SET @id_fiesta_bizarra = LAST_INSERT_ID();
INSERT INTO
	evento(evento_id, cuit_organizadora, ubicacion_id, horario_desde, horario_hasta)
VALUES(@id_fiesta_bizarra, @cuit_empresa_barata, @id_ubicacion_evento_fiesta_bizarra, '2018-01-25 08:57:59', '2018-01-25 20:57:59');

/******************** FIN EVENTOS ******************/

/***************************** FIN MEDIOS DE ENTRETENIMIENTO ************************/

/*********  DESCUENTOS POR CATEGORIA (PERMITE ACCEDER)  **********/

/****  BRONCE  ****/

/*PARQUE LAS VENTURAS */
SET @desc_parque_las_venturas_bronce = 10;
INSERT INTO -- acceso con descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_las_venturas, @id_categoria_bronce, @desc_parque_las_venturas_bronce);

SET @desc_la_rusa_loca_bronce = 10;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, @id_categoria_bronce, @desc_la_rusa_loca_bronce);

SET @desc_el_argento_bronce = 10;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, @id_categoria_bronce, @desc_el_argento_bronce);

SET @desc_barco_pirata_bronce = 10;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_barco_pirata, @id_categoria_bronce, @desc_barco_pirata_bronce);

/*PARQUE ASTRONOMICUS*/
SET @desc_parque_astronomicus_bronce = 0;
INSERT INTO -- acceso sin descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_astronomicus, @id_categoria_bronce, @desc_parque_astronomicus_bronce);

SET @desc_la_jazzy_rue_bronce = 10;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_jazzy_rue, @id_categoria_bronce, @desc_la_jazzy_rue_bronce);

SET @desc_april_in_paris_bronce = 0;
INSERT INTO -- acceso sin descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_april_in_paris, @id_categoria_bronce, @desc_april_in_paris_bronce);

/*EVENTO BYPASS FEST*/
SET @desc_bypass_fest_bronce = 10;
INSERT INTO -- acceso con descuento a evento
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_bypass_fest, @id_categoria_bronce, @desc_bypass_fest_bronce);

/*EVENTO FIESTA BIZARRA*/
SET @desc_fiesta_bizarra_bronce = 0;
INSERT INTO -- acceso con descuento a evento
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_fiesta_bizarra, @id_categoria_bronce, @desc_fiesta_bizarra_bronce);

/****  PLATA  ****/

/*PARQUE LAS VENTURAS*/
SET @desc_parque_las_venturas_plata = 20;
INSERT INTO -- acceso con descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_las_venturas, @id_categoria_plata, @desc_parque_las_venturas_plata);

SET @desc_la_rusa_loca_plata = 20;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, @id_categoria_plata, @desc_la_rusa_loca_plata);

SET @desc_el_argento_plata = 20;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, @id_categoria_plata, @desc_el_argento_plata);

SET @desc_barco_pirata_plata = 20;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_barco_pirata, @id_categoria_plata, @desc_barco_pirata_plata);

/*PARQUE ASTRONOMICUS*/
SET @desc_parque_astronomicus_plata = 10;
INSERT INTO -- acceso sin descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_astronomicus, @id_categoria_plata, @desc_parque_astronomicus_plata);

SET @desc_la_jazzy_rue_plata = 20;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_jazzy_rue, @id_categoria_plata, @desc_la_jazzy_rue_plata);

SET @desc_april_in_paris_plata = 10;
INSERT INTO -- acceso sin descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_april_in_paris, @id_categoria_plata, @desc_april_in_paris_plata);

/*EVENTO BYPASS FEST*/
SET @desc_bypass_fest_plata = 20;
INSERT INTO -- acceso con descuento a evento
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_bypass_fest, @id_categoria_plata, @desc_bypass_fest_plata);

/*EVENTO FIESTA BIZARRA*/
SET @desc_fiesta_bizarra_plata = 10;
INSERT INTO -- acceso con descuento a evento
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_fiesta_bizarra, @id_categoria_plata, @desc_fiesta_bizarra_plata);

/****  ORO  ****/

/*PARQUE LAS VENTURAS*/
SET @desc_parque_las_venturas_oro = 50;
INSERT INTO -- acceso con descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, @id_categoria_oro, @desc_parque_las_venturas_oro);

SET @desc_la_rusa_loca_oro = 50;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_las_venturas, @id_categoria_oro, @desc_la_rusa_loca_oro);

SET @desc_el_argento_oro = 50;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, @id_categoria_oro, @desc_el_argento_oro);

SET @desc_barco_pirata_oro = 50;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_barco_pirata, @id_categoria_oro, @desc_barco_pirata_oro);

/*PARQUE ASTRONOMICUS*/
SET @desc_parque_astronomicus_oro = 40;
INSERT INTO -- acceso sin descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_astronomicus, @id_categoria_oro, @desc_parque_astronomicus_oro);

SET @desc_la_jazzy_rue_oro = 50;
INSERT INTO -- acceso con descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_jazzy_rue, @id_categoria_oro, @desc_la_jazzy_rue_oro);

SET @desc_april_in_paris_oro = 40;
INSERT INTO -- acceso sin descuento a atraccion
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_april_in_paris, @id_categoria_oro, @desc_april_in_paris_oro);

/*EVENTO BYPASS FEST*/
SET @desc_bypass_fest_oro = 30;
INSERT INTO -- acceso con descuento a evento
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_bypass_fest, @id_categoria_oro, @desc_bypass_fest_oro);

/*EVENTO FIESTA BIZARRA*/
SET @desc_fiesta_bizarra_oro = 20;
INSERT INTO -- acceso con descuento a evento
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_fiesta_bizarra, @id_categoria_oro, @desc_fiesta_bizarra_oro);


/*****************  FIN DESCUENTOS POR CATEGORIA  ****************/

/******************  PAGOS, FACTURAS Y CONSUMOS POR CLIENTE **********************/

-- Recordatorios: 
-- Un consumo tiene su numero de factura en null sii es del mes actual.
-- Una factura tiene id_pago en null sii está impaga.

-- Importes con descuentos aplicados por categoria

/*BRONCE*/
SET @importe_parque_las_venturas_bronce = @precio_parque_las_venturas * (100 - @desc_parque_las_venturas_bronce)/100;
SET @importe_la_rusa_loca_bronce = @precio_la_rusa_loca * (100 - @desc_la_rusa_loca_bronce)/100;
SET @importe_el_argento_bronce = @precio_el_argento * (100 - @desc_el_argento_bronce)/100;
SET @importe_barco_pirata_bronce = @precio_barco_pirata * (100 - @desc_barco_pirata_bronce)/100;

SET @importe_parque_astronomicus_bronce = @precio_parque_astronomicus * (100 - @desc_parque_astronomicus_bronce)/100;
SET @importe_la_jazzy_rue_bronce = @precio_la_jazzy_rue * (100 - @desc_la_jazzy_rue_bronce)/100;
SET @importe_april_in_paris_bronce = @precio_april_in_paris * (100 - @desc_april_in_paris_bronce)/100;

SET @importe_bypass_fest_bronce = @precio_bypass_fest * (100 - @desc_bypass_fest_bronce)/100;
SET @importe_fiesta_bizarra_bronce = @precio_fiesta_bizarra * (100 - @desc_fiesta_bizarra_bronce)/100;

/*PLATA*/
SET @importe_parque_las_venturas_plata = @precio_parque_las_venturas * (100 - @desc_parque_las_venturas_plata)/100;
SET @importe_la_rusa_loca_plata = @precio_la_rusa_loca * (100 - @desc_la_rusa_loca_plata)/100;
SET @importe_el_argento_plata = @precio_el_argento * (100 - @desc_el_argento_plata)/100;
SET @importe_barco_pirata_plata = @precio_barco_pirata * (100 - @desc_barco_pirata_plata)/100;

SET @importe_parque_astronomicus_plata = @precio_parque_astronomicus * (100 - @desc_parque_astronomicus_plata)/100;
SET @importe_la_jazzy_rue_plata = @precio_la_jazzy_rue * (100 - @desc_la_jazzy_rue_plata)/100;
SET @importe_april_in_paris_plata = @precio_april_in_paris * (100 - @desc_april_in_paris_plata)/100;

SET @importe_bypass_fest_plata = @precio_bypass_fest * (100 - @desc_bypass_fest_plata)/100;
SET @importe_fiesta_bizarra_plata = @precio_fiesta_bizarra * (100 - @desc_fiesta_bizarra_plata)/100;

/*ORO*/
SET @importe_parque_las_venturas_oro = @precio_parque_las_venturas * (100 - @desc_parque_las_venturas_oro)/100;
SET @importe_la_rusa_loca_oro = @precio_la_rusa_loca * (100 - @desc_la_rusa_loca_oro)/100;
SET @importe_el_argento_oro = @precio_el_argento * (100 - @desc_el_argento_oro)/100;
SET @importe_barco_pirata_oro = @precio_barco_pirata * (100 - @desc_barco_pirata_oro)/100;

SET @importe_parque_astronomicus_oro = @precio_parque_astronomicus * (100 - @desc_parque_astronomicus_oro)/100;
SET @importe_la_jazzy_rue_oro = @precio_la_jazzy_rue * (100 - @desc_la_jazzy_rue_oro)/100;
SET @importe_april_in_paris_oro = @precio_april_in_paris * (100 - @desc_april_in_paris_oro)/100;

SET @importe_bypass_fest_oro = @precio_bypass_fest * (100 - @desc_bypass_fest_oro)/100;
SET @importe_fiesta_bizarra_oro = @precio_fiesta_bizarra * (100 - @desc_fiesta_bizarra_oro)/100;


/******** CLIENTE TOMAS (FRECUENCIA ALTA) ********/

/*** Enero 2018 ***/

-- PAGO
INSERT INTO
	pago(fecha, cliente_id, medio_de_pago)
VALUES(@fecha_tomas_bronce_a_oro, @id_tomas, @medio_de_pago_tomas);
SET @id_pago_tomas_enero = LAST_INSERT_ID();

-- FACTURA  
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES('2018-02-01', '2018-02-15', @id_pago_tomas_enero);
SET @nro_factura_tomas_enero = LAST_INSERT_ID();

-- Consumos
-- Para subir a oro debe consumir 2000 antes del pago

-- Visita parque las venturas | total = 270+45+90+45 = 450 | acumulado enero = 450
INSERT INTO -- Ingresa a parque las venturas en bronce -> $270
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_bloqueada, @id_parque_las_venturas, @importe_parque_las_venturas_bronce, '2018-01-01 9:01:10');

INSERT INTO -- El argento en bronce -> $ 45
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_bloqueada, @id_el_argento, @importe_el_argento_bronce, '2018-01-01 9:10:50');

INSERT INTO -- La rusa loca en bronce -> $90
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_bloqueada, @id_la_rusa_loca, @importe_la_rusa_loca_bronce, '2018-01-01 9:20:42');

INSERT INTO -- El argento en bronce -> $ 45
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_bloqueada, @id_el_argento, @importe_el_argento_bronce, '2018-01-01 9:40:50');

-- Pierde la tarjeta el 15 de enero y le dan otra 
-- Visita parque astronomicus con su nueva tarjeta  -> total = 300+150+180 = 630  -> acumulado enero = 450+630 = 1080

INSERT INTO -- Ingresa a parque astronomicus en bronce -> $300 
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_activa, @id_parque_astronomicus, @importe_parque_astronomicus_bronce, '2018-01-20 9:05:10');

INSERT INTO -- Ingresa a april in paris en bronce-> $150
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_activa, @id_april_in_paris, @importe_april_in_paris_bronce, '2018-01-20 9:10:10');

INSERT INTO -- Ingresa a la jazzy rue en bronce -> $180
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_activa, @id_la_jazzy_rue, @importe_la_jazzy_rue_bronce, '2018-01-20 10:02:10');

-- Asiste a evento fiesta bizzarra en bronce total = 300 | acumulado 1080+300 = 1380
INSERT INTO
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_activa, @id_fiesta_bizarra, @importe_fiesta_bizarra_bronce, '2018-01-25 11:02:10');

-- Visita de nuevo parque astronomicus  -> total = 300+150+180 = 630  -> acumulado enero = 1380+630 = 2010

INSERT INTO -- Ingresa a parque astronomicus en bronce -> $300 
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_activa, @id_parque_astronomicus, @importe_parque_astronomicus_bronce, '2018-01-27 9:05:10');

INSERT INTO -- Ingresa a april in paris en bronce-> $150
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_activa, @id_april_in_paris, @importe_april_in_paris_bronce, '2018-01-27 9:10:10');

INSERT INTO -- Ingresa a la jazzy rue en bronce-> $180
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_enero, @id_tarjeta_tomas_actualmente_activa, @id_la_jazzy_rue, @importe_la_jazzy_rue_bronce, '2018-01-27 10:02:10');

/**** FIN ENERO 2018 ***/

/*** FEBRERO 2018 ***/

-- PAGO
INSERT INTO
	pago(fecha, cliente_id, medio_de_pago)
VALUES('2018-03-10', @id_tomas, @medio_de_pago_tomas);
SET @id_pago_tomas_febrero = LAST_INSERT_ID();

-- FACTURA  
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES('2018-03-01', '2018-03-15', @id_pago_tomas_febrero);
SET @nro_factura_tomas_febrero = LAST_INSERT_ID();

-- CONSUMOS

INSERT INTO -- Asiste a Bypass fest en oro -> $210  | acumulado de febrero = 210
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_febrero, @id_tarjeta_tomas_actualmente_activa, @id_bypass_fest, @importe_bypass_fest_oro, '2018-02-15 02:45:09');

-- Visita parque las venturas | total = 150+25+50+25 = 250 | acumulado febrero = 250 + 210 = 460
INSERT INTO -- Ingresa a parque las venturas en oro -> $150
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_febrero, @id_tarjeta_tomas_actualmente_activa, @id_parque_las_venturas, @importe_parque_las_venturas_oro, '2018-02-17 9:01:10');

INSERT INTO -- El argento en oro -> $ 25
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_febrero, @id_tarjeta_tomas_actualmente_activa, @id_el_argento, @importe_el_argento_oro, '2018-02-17 10:10:50');

INSERT INTO -- La rusa loca en oro -> $50
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_febrero, @id_tarjeta_tomas_actualmente_activa, @id_la_rusa_loca, @importe_la_rusa_loca_oro, '2018-02-17 10:20:42');

INSERT INTO -- El argento en oro -> $ 25
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_tomas_febrero, @id_tarjeta_tomas_actualmente_activa, @id_el_argento, @importe_el_argento_oro, '2018-02-17 11:40:50');

/*** FIN FEBRERO 2018***/



/******** CLIENTE JACINTO (FRECUENCIA MEDIA) ********/

/*** Enero 2018 ***/

-- PAGO

INSERT INTO
	pago(fecha, cliente_id, medio_de_pago)
VALUES(@fecha_jacinto_bronce_a_plata, @id_jacinto, @medio_de_pago_jacinto);
SET @id_pago_jacinto_enero = LAST_INSERT_ID();

-- FACTURA  
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES('2018-02-01', '2018-02-15', @id_pago_jacinto_enero);
SET @nro_factura_jacinto_enero = LAST_INSERT_ID();

-- Consumos
-- Para subir a plata debe consumir 500 antes del pago

-- Visita parque astronomicus -> total = 300+150+180 = 630  
INSERT INTO -- Ingresa a parque astronomicus en bronce -> $300 
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_jacinto_enero, @id_tarjeta_jacinto, @id_parque_astronomicus, @importe_parque_astronomicus_bronce, '2018-01-14 12:05:10');

INSERT INTO -- Ingresa a april in paris en bronce-> $150
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_jacinto_enero, @id_tarjeta_jacinto, @id_april_in_paris, @importe_april_in_paris_bronce, '2018-01-14 12:10:10');

INSERT INTO -- Ingresa a la jazzy rue en bronce -> $180
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_jacinto_enero, @id_tarjeta_jacinto, @id_la_jazzy_rue, @importe_la_jazzy_rue_bronce, '2018-01-14 14:02:10');

-- Asiste a evento fiesta bizzarra en bronce total = 300 | acumulado 630+300 = 930
INSERT INTO
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_jacinto_enero, @id_tarjeta_jacinto, @id_fiesta_bizarra, @importe_fiesta_bizarra_bronce, '2018-01-25 13:02:10');


/**** FIN ENERO 2018 ***/

/*** FEBRERO 2018 ***/

-- PAGO
INSERT INTO
	pago(fecha, cliente_id, medio_de_pago)
VALUES('2018-03-10', @id_jacinto, @medio_de_pago_jacinto);
SET @id_pago_jacinto_febrero = LAST_INSERT_ID();

-- FACTURA  
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES('2018-03-01', '2018-03-15', @id_pago_jacinto_febrero);
SET @nro_factura_jacinto_febrero = LAST_INSERT_ID();

-- CONSUMOS

INSERT INTO -- Asiste a Bypass fest en plata -> $240 | acumulado de febrero = 240
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_jacinto_febrero, @id_tarjeta_jacinto, @id_bypass_fest, @importe_bypass_fest_plata, '2018-02-15 02:30:09');

-- Visita parque las venturas | total = 240+80+80 = 400 | acumulado febrero = 240 + 400 = 640
INSERT INTO -- Ingresa a parque las venturas en plata -> $240
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_jacinto_febrero, @id_tarjeta_jacinto, @id_parque_las_venturas, @importe_parque_las_venturas_plata, '2018-02-20 9:31:10');

INSERT INTO -- La rusa loca en plata -> $80
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_jacinto_febrero, @id_tarjeta_jacinto, @id_la_rusa_loca, @importe_la_rusa_loca_plata, '2018-02-20 10:20:42');

INSERT INTO -- La rusa loca en plata -> $80
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_jacinto_febrero, @id_tarjeta_jacinto, @id_la_rusa_loca, @importe_la_rusa_loca_plata, '2018-02-20 10:42:42');


/*** FIN FEBRERO 2018***/



/******** CLIENTE CARMICHAEL (FRECUENCIA BAJA) ********/

/*** Enero 2018 ***/

-- PAGO

INSERT INTO
	pago(fecha, cliente_id, medio_de_pago)
VALUES('2018-02-12', @id_carmichael, @medio_de_pago_carmichael);
SET @id_pago_carmichael_enero = LAST_INSERT_ID();

-- FACTURA  
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES('2018-02-01', '2018-02-15', @id_pago_carmichael_enero);
SET @nro_factura_carmichael_enero = LAST_INSERT_ID();

-- Consumos
-- Para no subir a plata debe consumir menos de 500 antes del pago

-- Visita parque astronomicus -> total = 300+150 = 450  
INSERT INTO -- Ingresa a parque astronomicus en bronce -> $300 
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_carmichael_enero, @id_tarjeta_carmichael, @id_parque_astronomicus, @importe_parque_astronomicus_bronce, '2018-01-19 12:05:10');

INSERT INTO -- Ingresa a april in paris en bronce-> $150
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_carmichael_enero, @id_tarjeta_carmichael, @id_april_in_paris, @importe_april_in_paris_bronce, '2018-01-19 12:10:10');

/**** FIN ENERO 2018 ***/

/*** FEBRERO 2018 ***/

-- FACTURA IMPAGA 
INSERT INTO
	factura(fecha_emision, fecha_vencimiento, pago_id)
VALUES('2018-03-01', '2018-03-15', @id_pago_carmichael_febrero);
SET @nro_factura_carmichael_febrero = LAST_INSERT_ID();

-- CONSUMOS

INSERT INTO -- Asiste a Bypass fest en bronce -> $290 | acumulado de febrero = 290
	 consumo(numero_de_factura, numero_de_tarjeta, medio_entretenimiento_id, importe, fecha_hora)
VALUES(@nro_factura_carmichael_febrero, @id_tarjeta_carmichael, @id_bypass_fest, @importe_bypass_fest_plata, '2018-02-15 02:35:09');


/*** FIN FEBRERO 2018***/


/*  */ 
