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