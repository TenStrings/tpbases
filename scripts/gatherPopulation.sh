#!/bin/bash
# -*- coding: utf-8 -*-


#Lo unico que hace es generar un sólo script ordenado a partir de todos los archivos de popdb
#tienen que dar permisos de ejecucion en el directorio del script: chmod +x gatherPopulation.sh

echo 'gathering population...'
cat populatedbFiles/popdb_global.sql populatedbFiles/popdb_ubicaciones.sql populatedbFiles/popdb_clientesYTarjetas.sql populatedbFiles/popdb_categorias.sql populatedbFiles/popdb_mediosDeEntretenimiento.sql populatedbFiles/popdb_descuentosPorCategoria.sql populatedbFiles/popdb_pagosFacturasYConsumos.sql > populatedb.sql
