DROP DATABASE IF EXISTS tpbases;
CREATE DATABASE tpbases;
USE tpbases;

CREATE TABLE ubicacion (
    ubicacion_id integer unsigned AUTO_INCREMENT,
    pais varchar(50),
    provincia varchar(50),
    localidad varchar(50),
    codigo_postal varchar(50),
    calle varchar(50),
    altura smallint unsigned,
    piso smallint unsigned,
    departamento varchar(2),
    PRIMARY KEY (ubicacion_id)
);

CREATE TABLE cliente (
    cliente_id integer unsigned AUTO_INCREMENT,
    nombre varchar(45) NOT NULL,
    apellido varchar(45) NOT NULL,
    medio_de_pago integer NOT NULL,
    ubicacion_facturacion integer unsigned, 
    ubicacion_residencia integer unsigned,
    numero_de_documento integer unsigned,
    PRIMARY KEY (cliente_id),
    FOREIGN KEY (ubicacion_facturacion) REFERENCES ubicacion(ubicacion_id),
    FOREIGN KEY (ubicacion_residencia) REFERENCES ubicacion(ubicacion_id)
);

CREATE TABLE pago (
    pago_id integer unsigned NOT NULL AUTO_INCREMENT,
    fecha date NOT NULL,
    cliente_id integer unsigned NOT NULL,
    PRIMARY KEY (pago_id),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE tarjeta (
    numero_de_tarjeta integer unsigned AUTO_INCREMENT,
    cliente_id integer unsigned NOT NULL,
    foto binary(10), -- ??????
    bloqueada boolean,
    PRIMARY KEY (numero_de_tarjeta),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE factura (
    numero_de_factura integer unsigned AUTO_INCREMENT,
    fecha_emision date,
    fecha_vencimiento date,
    pago_id integer unsigned,
    PRIMARY KEY (numero_de_factura),
    FOREIGN KEY (pago_id) REFERENCES pago(pago_id) 
);

CREATE TABLE telefono (
    numero integer unsigned,
    PRIMARY KEY (numero)
);

CREATE TABLE categoria (
    categoria_id integer unsigned AUTO_INCREMENT, 
    nombre varchar(30),
    monto_subida decimal(10,2),
    monto_permanencia decimal(10,2),
    PRIMARY KEY (categoria_id)
);

CREATE TABLE cambia_su (
    fecha date,
    numero_de_tarjeta integer unsigned,
    categoria_id integer unsigned,
    PRIMARY KEY (fecha, numero_de_tarjeta, categoria_id),
    FOREIGN KEY (numero_de_tarjeta) REFERENCES tarjeta(numero_de_tarjeta),
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

CREATE TABLE medio_entretenimiento (
    medio_id integer unsigned NOT NULL AUTO_INCREMENT,
    precio decimal (5, 2) unsigned,
    nombre varchar(50),
    tipo varchar(10),
    PRIMARY KEY (medio_id),
    CHECK (tipo in ('PARQUE', 'ATRACCION', 'EVENTO'))
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
    FOREIGN KEY (medio_entretenimiento_id) REFERENCES medio_entretenimiento(medio_id)
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
    parque_id integer unsigned,
    edad_desde smallint unsigned,
    edad_hasta smallint unsigned,
    altura_min smallint unsigned, -- En centimetros
    PRIMARY KEY(atraccion_id),
    FOREIGN KEY (atraccion_id) REFERENCES medio_entretenimiento(medio_id),
    FOREIGN KEY (parque_id) REFERENCES parque(parque_id)
);

CREATE TABLE empresa_organizadora (
    cuit integer unsigned,
    razon_social integer unsigned,
    PRIMARY KEY (cuit)
);

CREATE TABLE evento (
    evento_id integer unsigned,
    cuit_organizadora integer unsigned NOT NULL,
    ubicacion_id integer unsigned,
    horario_desde datetime NOT NULL,
    horario_hasta datetime NOT NULL,
    PRIMARY KEY (evento_id),
    FOREIGN KEY (evento_id) REFERENCES medio_entretenimiento(medio_id),
    FOREIGN KEY (cuit_organizadora) REFERENCES empresa_organizadora(cuit),
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id)
);

CREATE TABLE permite_acceder (
	medio_id integer unsigned,
    categoria_id integer unsigned,
    descuento integer unsigned NOT NULL,
    PRIMARY KEY (medio_id, categoria_id),
    FOREIGN KEY (medio_id) REFERENCES medio_entretenimiento(medio_id),
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);
