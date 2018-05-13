
/*************  CLIENTES  **************/  

SET @medio_de_pago_tomas ='VISA';
INSERT INTO -- CONSUMIDOR FRECUENTE CATEGORIA GOLD 
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Tomás', 'Pastore', @medio_de_pago_tomas, @id_ubicacion_facturacion_tomas, @id_ubicacion_residencia_tomas, 39560320);
SET @id_tomas = LAST_INSERT_ID();

SET @medio_de_pago_jacinto ='AMEX';
INSERT INTO -- CONSUMIDOR MEDIO CATEGORIA PLATA
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Jacinto', 'Populea',@medio_de_pago_jacinto, @id_ubicacion_facturacion_jacinto, @id_ubicacion_residencia_jacinto, 40000000);
SET @id_jacinto = LAST_INSERT_ID();

SET @medio_de_pago_carmichael = 'MASTERCARD';
INSERT INTO -- CONSUMIDOR BAJO CATEGORIA BRONCE
    cliente(nombre, apellido, medio_de_pago, ubicacion_facturacion, 
            ubicacion_residencia,
            numero_de_documento)
VALUES ('Carmichael', 'Buonavita',@medio_de_pago_carmichael, @id_ubicacion_facturacion_carmichael, @id_ubicacion_residencia_carmichael, 40000001);
SET @id_carmichael = LAST_INSERT_ID();

SET @medio_de_pago_michael = 'MASTERCARD';
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

