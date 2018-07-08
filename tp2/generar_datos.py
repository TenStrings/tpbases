#!/usr/bin/env python

# EL SCRIPT
import numpy as np
import random
import datetime
import json

clientes = []

CANT_CLIENTES = 20

np.random.seed(0)
random.seed(0)

nombres_posibles = ["nombre" + str(i + 1) for i in range(CANT_CLIENTES)]
apellidos_posibles = ["apellido" + str(i + 1) for i in range(CANT_CLIENTES)]
dnis = [int(np.random.uniform(10000000,30000000)) for i in range(CANT_CLIENTES)]
medios = ["Visa", "Mastercard", "Mercadopago", "Amex"]
telefonos = [random.sample(range(50000000,70000000), 3) for i in range(CANT_CLIENTES)]
CANT_TARJETAS = 25
tarjetas_ids = random.sample(range(80000000,90000000), CANT_TARJETAS)
tarjetas_activas = tarjetas_ids[:20]
tarjetas_bloq = tarjetas_ids[20:]

clientesXtarjeta = [] # Me guardo tarjetas en orden y sus clientes

clientes = []
for i in range(CANT_CLIENTES):
	cliente = {
		"id": i,
		"nombre": nombres_posibles[i],
		"apellido": apellidos_posibles[i],
		"dni": dnis[i],
		"medio_pago": random.choice(medios),
		"telefonos": telefonos[i],
		"tarjetas": [] #Se llena al crear las tarjetas
	}
	clientes.append(cliente)
	#falta referencia a tarjeta

#Asignarle tarjeta activa a cada cliente 
tarjetas = []
for i, c in enumerate(clientes):
	tarjeta = {
		"numero": tarjetas_activas[i],
		"bloqueada": False,
		"foto": "foto" + str(i),
		"id_cliente": c["id"],
		"consumos": [] #Se llena al crear los consumos
	}
	c["tarjetas"] += [tarjeta["numero"]]
	clientesXtarjeta.append((tarjeta["numero"], c))
	tarjetas.append(tarjeta)

#Asignar tarjetas inactivas a cada cliente
for i, c in enumerate(clientes[:5]):
	tarjeta = {
		"numero": tarjetas_bloq[i],
		"bloqueada": True,
		"foto": "foto" + str(i),
		"id_cliente": c["id"],
		"consumos": [] #Se llena al crear los consumos
	}
	c["tarjetas"] += [tarjeta["numero"]]
	clientesXtarjeta.append((tarjeta["numero"], c))
	tarjetas.append(tarjeta)

#Medios de entretenimiento
nombre_parque = ["parque" + str(i + 1) for i in range(5)]
nombre_atraccion = ["atraccion" + str(i + 1) for i in range(25)]
nombre_evento = ["evento" + str(i + 1) for i in range(10)]
id_medio = [i + 1 for i in range(40)]
precios = [round(np.random.uniform(49.99, 149.99), 2) for i in range(40)]
edad_minima = 10
edad_maxima = 50
altura_minima = 140

medios = []
#Parques
for i in range(5):
	parque = {
		"id": id_medio[i],
		"precio": precios[i],
		"nombre": nombre_parque[i],
		"tipo": "PARQUE",
		"importes_consumos": []
	}
	medios.append(parque)

#Atracciones
for i in range(5, 30):
	atraccion = {
		"id": id_medio[i],
		"precio": precios[i],
		"nombre": nombre_atraccion[i - 5],
		"tipo": "ATRACCION",
		"edad_desde": edad_minima,
		"edad_hasta": edad_maxima,
		"altura_min": altura_minima,
		"importes_consumos": []
	}
	medios.append(atraccion)

#Eventos
for i in range(30, 40):
	evento = {
		"id": id_medio[i],
		"precio": precios[i],
		"nombre": nombre_evento[i - 30],
		"tipo": "EVENTO",
		"importes_consumos": []
	}
	medios.append(evento)

#Consumos
CANT_CONSUMOS = 10000
consumos = []

start_date = datetime.datetime.strptime('1/1/2015 1:30 PM', '%d/%m/%Y %I:%M %p')
end_date = datetime.datetime.strptime('31/12/2018 4:50 AM', '%d/%m/%Y %I:%M %p')

#Devuelve una fecha random entre start y end
def random_date(start, end):
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second = random.randrange(int_delta)
    return start + datetime.timedelta(seconds=random_second)



for i in range(CANT_CONSUMOS):
	medio = random.choice(medios)
	precio_min = medio["precio"]
	tarjeta = tarjetas[(int(i/10))%CANT_TARJETAS] # 10 consumos consecutivos son de la misma tarjeta
	
	consumo = {
		"id": i,
		"importe": round(np.random.uniform(precio_min, precio_min + 100.0), 2), #Siempre el precio del medio con alguna variacion
		"fecha_hora": str(random_date(start_date, end_date)),
		"medio_entretenimiento": {
			"id": medio["id"],
			"nombre": medio["nombre"],
			"tipo": medio["tipo"]
		},
		"nro_tarjeta": tarjeta["numero"],
		"nro_factura": None #Falta crear factura	
	}
	medio["importes_consumos"] += [consumo["importe"]]
	tarjeta["consumos"] += [{"id_medio": medio["id"], "nombre_medio": medio["nombre"], "tipo_medio": medio["tipo"]}]
	consumos.append(consumo)

#Facturas
facturas = []
CANT_FACTURAS = 1000
CONSUMOS_POR_FACTURA = 10

for i in range(CANT_FACTURAS):
	consumos_de_factura = consumos[i * CONSUMOS_POR_FACTURA:i * CONSUMOS_POR_FACTURA + CONSUMOS_POR_FACTURA]
	cons = map(lambda consumo: {
				"medio_entretenimiento": consumo["medio_entretenimiento"],
				"importe": consumo["importe"]
			},
			consumos_de_factura) #Consumos de 10 en 10
	for c in consumos_de_factura:
		c["nro_factura"] = i

	factura = {
		"numero": i,
		"fecha_emision": str(end_date),
		"fecha_vencimiento": str(end_date + datetime.timedelta(days=30)),
		"consumos": cons,
		"id_pago": None #Falta referencia a pago
	}
	facturas.append(factura)

#Pagos
pagos = []
CANT_PAGOS = int(CANT_FACTURAS * 0.8) #80% de las facturas pagas. Una sola factura por pago

for i in range(CANT_PAGOS):
	factura = facturas[i]
	cliente = clientesXtarjeta[i % CANT_TARJETAS][1]
	pago = {
		"id": i,
		"medio_pago": cliente["medio_pago"],
		"fecha": factura["fecha_emision"],
		"facturas": [
			{
				"nro_factura": factura["numero"],
				"consumos": factura["consumos"]
			}
		],
		"id_cliente": cliente["id"]
	}
	factura["id_pago"] = pago["id"]
	pagos.append(pago)


def dumpToFile(listDic, filename):
	with open(filename, 'w') as f:
		for dic in listDic:
			f.write(json.dumps(dic))
			f.write("\n")


print "----------- Clientes -----------------"

dumpToFile(clientes, "clientes.dat")

print "----------- Tarjetas -----------------"
dumpToFile(tarjetas, "tarjetas.dat")


print "----------- Pagos -----------------"
dumpToFile(pagos, "pagos.dat")

print "----------- Facturas -----------------"
dumpToFile(facturas, "facturas.dat")


print "----------- Medios de entretenimiento -----------------"
dumpToFile(medios, "medios.dat")


print "----------- Consumos -----------------"
dumpToFile(consumos, "consumos.dat")














