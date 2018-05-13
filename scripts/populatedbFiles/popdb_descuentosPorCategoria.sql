
/*********  DESCUENTOS POR CATEGORIA (PERMITE ACCEDER)  **********/
-- VER QUE ONDA LOS DESCUENTOS DE LOS EVENTOS, NO DEBERIAN ESTAR ATADOS A LA VIGENCIA DEL EVENTO DE ALGUNA FORMA?

/****  BRONCE  ****/

/*PARQUE LAS VENTURAS */
SET @desc_parque_las_venturas_bronce = 10;
INSERT INTO -- acceso con descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_las_venturas, @id_categoria_bronce, @desc_parque_las_venturas_bronce);

SET @desc_la_rusa_loca_bronce = 10;
INSERT INTO -- acceso con descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, @id_categoria_bronce, @desc_la_rusa_loca_bronce);

SET @desc_el_argento_bronce = 10;
INSERT INTO -- acceso con descuento a parque
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, @id_categoria_bronce, @desc_el_argento_bronce);

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
INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_las_venturas, @id_categoria_plata, @desc_parque_las_venturas_plata);

SET @desc_la_rusa_loca_plata = 20;
INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, @id_categoria_plata, @desc_la_rusa_loca_plata);

SET @desc_el_argento_plata = 20;
INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, @id_categoria_plata, @desc_el_argento_plata);

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
INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_la_rusa_loca, @id_categoria_oro, @desc_parque_las_venturas_oro);

SET @desc_la_rusa_loca_oro = 50;
INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_parque_las_venturas, @id_categoria_oro, @desc_la_rusa_loca_oro);

SET @desc_el_argento_oro = 50;
INSERT INTO
	permite_acceder(medio_id, categoria_id, descuento)
VALUES(@id_el_argento, @id_categoria_oro, @desc_el_argento_oro);

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
