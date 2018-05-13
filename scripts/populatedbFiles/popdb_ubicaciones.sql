
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

