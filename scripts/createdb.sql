DROP DATABASE IF EXISTS tpbases;
CREATE DATABASE tpbases;
USE tpbases;

/*******  UBICACIONES   *******/

CREATE TABLE ubicacion (
    ubicacion_id integer unsigned AUTO_INCREMENT,
    pais varchar(50) NOT NULL,
    provincia varchar(50) NOT NULL,
    localidad varchar(50),
    codigo_postal varchar(50),
    calle varchar(50) NOT NULL,
    altura smallint unsigned NOT NULL,
    piso smallint unsigned,
    departamento varchar(2),
    PRIMARY KEY (ubicacion_id)
);

/*********  CLIENTES  *************/

CREATE TABLE cliente (
    cliente_id integer unsigned AUTO_INCREMENT,
    nombre varchar(45) NOT NULL,
    apellido varchar(45) NOT NULL,
    medio_de_pago varchar(10) NOT NULL,
    ubicacion_facturacion integer unsigned NOT NULL, 
    ubicacion_residencia integer unsigned NOT NULL,
    numero_de_documento integer unsigned NOT NULL,
    PRIMARY KEY (cliente_id),
    FOREIGN KEY (ubicacion_facturacion) REFERENCES ubicacion(ubicacion_id),
    FOREIGN KEY (ubicacion_residencia) REFERENCES ubicacion(ubicacion_id),
	CHECK (medio_de_pago in ('VISA', 'AMEX', 'MASTERCARD'))
);

CREATE TABLE telefono (
	cliente_id integer unsigned NOT NULL,
    numero integer unsigned,
    PRIMARY KEY (cliente_id, numero),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

/**********  Tarjetas y Categorias  ************/

CREATE TABLE tarjeta (
    numero_de_tarjeta integer unsigned AUTO_INCREMENT,
    cliente_id integer unsigned NOT NULL,
    foto binary(10), -- ??????
    bloqueada boolean NOT NULL,
    PRIMARY KEY (numero_de_tarjeta),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE categoria (
    categoria_id integer unsigned AUTO_INCREMENT, 
    nombre varchar(10) NOT NULL,
    monto_subida decimal(10,2) NOT NULL,
    monto_permanencia decimal(10,2) NOT NULL,
    PRIMARY KEY (categoria_id),
    CHECK (nombre in ('BRONCE', 'PLATA', 'ORO')),
    CHECK (monto_subida >= 0),
    CHECK (monto_permanencia >= 0)
);

CREATE TABLE cambia_su (
    fecha date,
    numero_de_tarjeta integer unsigned,
    categoria_id integer unsigned,
    PRIMARY KEY (fecha, numero_de_tarjeta, categoria_id),
    FOREIGN KEY (numero_de_tarjeta) REFERENCES tarjeta(numero_de_tarjeta),
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

/*********  MEDIOS DE ENTRETENIMIENTOS Y DESCUENTOS  ******************/

CREATE TABLE medio_entretenimiento (
    medio_id integer unsigned AUTO_INCREMENT,
    precio decimal (5, 2) unsigned NOT NULL,
    nombre varchar(50) NOT NULL,
    tipo varchar(10) NOT NULL,
    PRIMARY KEY (medio_id),
    CHECK (tipo in ('PARQUE', 'ATRACCION', 'EVENTO'))
);

CREATE TABLE parque (
    parque_id integer unsigned,
    ubicacion_id integer unsigned NOT NULL,
    PRIMARY KEY (parque_id),
    FOREIGN KEY (parque_id) REFERENCES medio_entretenimiento(medio_id),
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id)
);

CREATE TABLE atraccion (
    atraccion_id integer unsigned,
    parque_id integer unsigned NOT NULL,
    edad_desde smallint unsigned NOT NULL,
    edad_hasta smallint unsigned NOT NULL,
    altura_min varchar(6) NOT NULL, -- CONVENCIÓN MEDIDA EN 'XX cm'
    PRIMARY KEY(atraccion_id),
    FOREIGN KEY (atraccion_id) REFERENCES medio_entretenimiento(medio_id),
    FOREIGN KEY (parque_id) REFERENCES parque(parque_id),
    CHECK (edad_desde <= edad_hasta),
    CHECK (edad_desde >= 0)
    
);

CREATE TABLE empresa_organizadora (
    cuit varchar(13),
    razon_social varchar(40) NOT NULL,
    ubicacion_id integer unsigned NOT NULL,
    PRIMARY KEY (cuit),
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id)
);

CREATE TABLE evento (
    evento_id integer unsigned,
    cuit_organizadora varchar(13) NOT NULL,
    ubicacion_id integer unsigned NOT NULL,
    horario_desde datetime NOT NULL,
    horario_hasta datetime NOT NULL,
    PRIMARY KEY (evento_id),
    FOREIGN KEY (evento_id) REFERENCES medio_entretenimiento(medio_id),
    FOREIGN KEY (cuit_organizadora) REFERENCES empresa_organizadora(cuit),
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id),
    CHECK (horario_desde <= horario_hasta)
);

CREATE TABLE permite_acceder (
	medio_id integer unsigned,
    categoria_id integer unsigned,
    descuento integer unsigned NOT NULL,
    PRIMARY KEY (medio_id, categoria_id),
    FOREIGN KEY (medio_id) REFERENCES medio_entretenimiento(medio_id),
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id),
    CHECK (descuento >= 0 and descuento <= 100)
);


/*****************  FACTURACION  ***************************/

CREATE TABLE pago (
    pago_id integer unsigned NOT NULL AUTO_INCREMENT,
    fecha date NOT NULL,
    cliente_id integer unsigned NOT NULL,
    medio_de_pago varchar(10) NOT NULL,
    PRIMARY KEY (pago_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id),
    CHECK (medio_de_pago in ('VISA', 'AMEX', 'MASTERCARD'))
);

CREATE TABLE factura ( 
    numero_de_factura integer unsigned AUTO_INCREMENT,
    fecha_emision date NOT NULL,
    fecha_vencimiento date NOT NULL,
    pago_id integer unsigned, -- si es NULL es que está impaga
    PRIMARY KEY (numero_de_factura),
    FOREIGN KEY (pago_id) REFERENCES pago(pago_id),
	CHECK (fecha_emision <= fecha_vencimiento)
     
);

CREATE TABLE consumo (
    consumo_id integer unsigned AUTO_INCREMENT,
    numero_de_factura integer unsigned,
    numero_de_tarjeta integer unsigned NOT NULL,
    medio_entretenimiento_id integer unsigned NOT NULL,
    importe decimal(10, 2) NOT NULL,
    fecha_hora datetime NOT NULL,
    PRIMARY KEY (consumo_id),
    FOREIGN KEY (numero_de_factura) REFERENCES factura(numero_de_factura),
    FOREIGN KEY (numero_de_tarjeta) REFERENCES tarjeta(numero_de_tarjeta),
    FOREIGN KEY (medio_entretenimiento_id) REFERENCES medio_entretenimiento(medio_id),
    CHECK ( importe = 
    ( 
		(select precio from medio_entretenimiento as me 
		where medio_entretenimiento_id = me.medio_id) * 
		(100 - (select descuento from permite_acceder as pe 
		where medio_entretenimiento_id = pe.medio_id and 
		pe.categoria_id = (select categoria_id from cambia_su as cs 
		where numero_de_tarjeta = cs.numero_de_tarjeta ))
		)
    ) / 100 ),
    CHECK (
		(select categoria_id from cambia_su as cs 
			where numero_de_tarjeta = cs.numero_de_tarjeta ) IN 
        (select categoria_id from permite_acceder as pe 
			where medio_entretenimiento_id = pe.medio_id)
        )
);
