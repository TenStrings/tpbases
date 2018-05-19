
/******************  PAGOS, FACTURAS Y CONSUMOS POR CLIENTE **********************/

-- Recordatorios: 
-- Un consumo tiene su numero de factura en null sii es del mes actual.
-- Una factura tiene id_pago en null sii está impaga.

-- Importes con descuentos aplicados por categoria

/*BRONCE*/
SET @importe_parque_las_venturas_bronce = @precio_parque_las_venturas * (100 - @desc_parque_las_venturas_bronce)/100;
SET @importe_la_rusa_loca_bronce = @precio_la_rusa_loca * (100 - @desc_la_rusa_loca_bronce)/100;
SET @importe_el_argento_bronce = @precio_el_argento * (100 - @desc_el_argento_bronce)/100;

SET @importe_parque_astronomicus_bronce = @precio_parque_astronomicus * (100 - @desc_parque_astronomicus_bronce)/100;
SET @importe_la_jazzy_rue_bronce = @precio_la_jazzy_rue * (100 - @desc_la_jazzy_rue_bronce)/100;
SET @importe_april_in_paris_bronce = @precio_april_in_paris * (100 - @desc_april_in_paris_bronce)/100;

SET @importe_bypass_fest_bronce = @precio_bypass_fest * (100 - @desc_bypass_fest_bronce)/100;
SET @importe_fiesta_bizarra_bronce = @precio_fiesta_bizarra * (100 - @desc_fiesta_bizarra_bronce)/100;

/*PLATA*/
SET @importe_parque_las_venturas_plata = @precio_parque_las_venturas * (100 - @desc_parque_las_venturas_plata)/100;
SET @importe_la_rusa_loca_plata = @precio_la_rusa_loca * (100 - @desc_la_rusa_loca_plata)/100;
SET @importe_el_argento_plata = @precio_el_argento * (100 - @desc_el_argento_plata)/100;

SET @importe_parque_astronomicus_plata = @precio_parque_astronomicus * (100 - @desc_parque_astronomicus_plata)/100;
SET @importe_la_jazzy_rue_plata = @precio_la_jazzy_rue * (100 - @desc_la_jazzy_rue_plata)/100;
SET @importe_april_in_paris_plata = @precio_april_in_paris * (100 - @desc_april_in_paris_plata)/100;

SET @importe_bypass_fest_plata = @precio_bypass_fest * (100 - @desc_bypass_fest_plata)/100;
SET @importe_fiesta_bizarra_plata = @precio_fiesta_bizarra * (100 - @desc_fiesta_bizarra_plata)/100;

/*ORO*/
SET @importe_parque_las_venturas_oro = @precio_parque_las_venturas * (100 - @desc_parque_las_venturas_oro)/100;
SET @importe_la_rusa_loca_oro = @precio_la_rusa_loca * (100 - @desc_la_rusa_loca_oro)/100;
SET @importe_el_argento_oro = @precio_el_argento * (100 - @desc_el_argento_oro)/100;

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
