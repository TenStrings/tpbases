
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
