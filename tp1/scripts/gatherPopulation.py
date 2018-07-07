# -*- coding: utf-8 -*-


#Lo unico que hace es generar un sólo script ordenado a partir de todos los archivos de popdb
#este es lo mismo que el sh pero sin necesidad de dar permiso de ejecucion
import os

os.system('echo gathering population...')
os.system('cat populatedbFiles/popdb_global.sql populatedbFiles/popdb_ubicaciones.sql populatedbFiles/popdb_clientesYTarjetas.sql populatedbFiles/popdb_categorias.sql populatedbFiles/popdb_mediosDeEntretenimiento.sql populatedbFiles/popdb_descuentosPorCategoria.sql populatedbFiles/popdb_pagosFacturasYConsumos.sql > populatedb.sql') 
