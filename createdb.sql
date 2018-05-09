DROP DATABASE IF EXISTS tpbases;
CREATE DATABASE tpbases;
USE tpbases;

CREATE TABLE ubicacion (
    codigo_de_ubicacion integer unsigned NOT NULL AUTO_INCREMENT,
    pais varchar(50),
    provincia varchar(50),
    localidad varchar(50),
    codigo_postal varchar(50),
    calle varchar(50),
    altura smallint unsigned,
    piso smallint unsigned,
    departamento varchar(2),
    PRIMARY KEY (codigo_de_ubicacion)
);

CREATE TABLE cliente (
    cliente_id integer unsigned NOT NULL AUTO_INCREMENT,
    nombre varchar(45) NOT NULL,
    apellido varchar(45) NOT NULL,
    medio_de_pago integer NOT NULL,
    codigo_ubicacion_facturacion integer, 
    codigo_ubicacion_residencia integer,
    numero_de_documento integer unsigned,
    PRIMARY KEY (cliente_id)
);

CREATE TABLE pago (
    pago_id integer unsigned NOT NULL AUTO_INCREMENT,
    medio_de_pago integer unsigned unique NOT NULL,
    fecha date NOT NULL,
    cliente_id integer unsigned NOT NULL,
    PRIMARY KEY (pago_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE tarjeta (
    numero_de_tarjeta integer unsigned NOT NULL AUTO_INCREMENT,
    cliente_id integer unsigned NOT NULL,
    foto binary(10),
    bloqueada boolean,
    PRIMARY KEY (numero_de_tarjeta),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE factura (
    numero_de_factura integer unsigned unique NOT NULL,
    fecha_emision date,
    fecha_vencimiento date,
    pago_id integer unsigned,
    PRIMARY KEY (numero_de_factura),
    FOREIGN KEY (pago_id) REFERENCES pago(pago_id) 
);

CREATE TABLE telefono (
    numero integer unique,
    PRIMARY KEY (numero)
);

CREATE TABLE consumo (
    consumo_id integer unsigned NOT NULL AUTO_INCREMENT,
    numero_de_factura integer unsigned,
    numero_de_tarjeta integer unsigned NOT NULL,
    medio_id integer unsigned,
    importe decimal(10, 2),
    hora time,
    fecha date,
    PRIMARY KEY (consumo_id),
    FOREIGN KEY (numero_de_factura) REFERENCES factura(numero_de_factura),
    FOREIGN KEY (numero_de_tarjeta) REFERENCES tarjeta(numero_de_tarjeta)
);

CREATE TABLE categoria (
    categoria_id integer unsigned NOT NULL auto_increment, 
    nombre varchar(30),
    monto_subida decimal(5,2),
    monto_bajada decimal(5,2),
    PRIMARY KEY (categoria_id)
);

CREATE TABLE cambia_su (
    fecha date,
    numero_de_tarjeta integer unsigned,
    categoria_id integer unsigned,
    FOREIGN KEY (numero_de_tarjeta) REFERENCES tarjeta(numero_de_tarjeta),
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

CREATE TABLE medio_de_entretenimiento (
    medio_id integer unsigned NOT NULL AUTO_INCREMENT,
    precio decimal(5, 2),
    nombre varchar(50),
    tipo varchar(10),/*Podría ser una foreign key*/
    PRIMARY KEY (medio_id),
    CHECK (tipo in ('PARQUE', 'ATRACCIÓN', 'EVENTO')) /*Y esto no haría falta*/
);

CREATE TABLE parque (
    medio_id integer unsigned unique NOT NULL,
    codigo_de_ubicacion integer unsigned NOT NULL,
    PRIMARY KEY (medio_id),
    FOREIGN KEY (medio_id) REFERENCES medio_de_entretenimiento(medio_id),
    FOREIGN KEY (codigo_de_ubicacion) REFERENCES ubicacion(codigo_de_ubicacion)
);

CREATE TABLE atraccion (
    medio_id integer unsigned unique NOT NULL,
    medio_parque_id integer unsigned,
    edad_desde smallint,
    edad_hasta smallint,
    altura_min varchar(10),
    PRIMARY KEY(medio_id),
    FOREIGN KEY (medio_id) REFERENCES medio_de_entretenimiento(medio_id),
    FOREIGN KEY (medio_parque_id) REFERENCES parque(medio_id)
);

CREATE TABLE empresa_organizadora (
    razon_social integer unsigned,
    cuit integer,
    PRIMARY KEY (razon_social)
);

CREATE TABLE evento (
    evento_id integer unsigned NOT NULL AUTO_INCREMENT,
    cuit_organizadora integer unsigned NOT NULL,
    codigo_de_ubicacion integer,
    vigencia_desde timestamp DEFAULT '1970-01-01 00:00:01',
    vigencia_hasta timestamp DEFAULT '1970-01-01 00:00:01',
    PRIMARY KEY (evento_id),
    FOREIGN KEY(evento_id) REFERENCES medio_de_entretenimiento(medio_id)
);
