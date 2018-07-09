# This Python file uses the following encoding: utf-8
from __future__ import print_function
import rethinkdb as r
import sys

##################################        
############ EJ 2.4.a ############

def atrPorClienteConRepeticiones(cliente_id): 
    return r.table('tarjeta').\
        filter( r.row['id_cliente'] == cliente_id).\
        concat_map(
            lambda doc: doc['consumos'].\
                concat_map(lambda cons: [
                    {
                    'id': cons['medio_entretenimiento']['id'],
                    'nombre': cons['medio_entretenimiento']['nombre'],
                    'tipo': cons['medio_entretenimiento']['tipo']['nombre']
                    }
                    ])).\
        filter( r.row['tipo'] == ('ATRACCION')).\
        pluck('id', 'nombre')

def atrPorCliente(cliente_id):
    return atrPorClienteConRepeticiones(cliente_id).distinct()

##################################        
############ EJ 2.4.b ############

def visitasAtrPorParque(parque_id): 
    return r.table('medio_entretenimiento').\
        filter(
            r.row['tipo']['nombre'] == 'ATRACCION' and
            r.row['tipo']['id_parque'] == parque_id
        ).map(
            r.row.merge(lambda d:
            {
                'visitas': r.count(d['importes_consumos'])
            })
        ).\
        pluck('id', 'nombre', 'visitas')

###### MAP REDUCE VERSION?

def mapReduceVisitasAtrPorParque(parque_id):
    return r.table('medio_entretenimiento').\
        filter(
            r.row['tipo']['nombre'] == 'ATRACCION' and
            r.row['tipo']['id_parque'] == parque_id
        ).concat_map(lambda doc:
            doc['importes_consumos'].map(lambda m: 
            {   
                'id': doc['id'],
                'atraccion': doc['nombre'],
                'visitas': 1
            })).\
        group('id').\
        reduce(lambda left, right: 
            {
                'id': left['id'],
                'atraccion': left['atraccion'],
                'visitas': left['visitas'] + right['visitas']
            }).\
        ungroup().\
        map(lambda group: group['reduction'])
##################################        
############ EJ 2.4.c ############

def topFiveEventos():
    return r.table('pago').\
        concat_map(
            lambda doc: doc['facturas'].\
                concat_map(lambda fact: fact['consumos'].\
                    concat_map(lambda cons: [
                        {
                        'id_medio': cons['medio_entretenimiento']['id'], 
                        'tipo': cons['medio_entretenimiento']['tipo']['nombre'],
                        'nombre': cons['medio_entretenimiento']['nombre'],
                        'importe': cons['importe']
                        }
                        ]))).\
        filter( r.row['tipo'] == ('EVENTO')).group('id_medio', 'nombre').\
        sum('importe').\
        ungroup().\
        map(
            lambda val:
            {
            'id': val['group'][0],
            'evento': val['group'][1],
            'importe': val['reduction']
            }).\
        order_by(r.desc('importe')).\
        slice(0,5)

##################################        
############ EJ 2.4.d ############

def importesPorAtraccionEnParque(parque_id):
    #Si se la importa, hay que llamarla con run(conn)
    return r.table("medio_entretenimiento").\
        filter(
            r.row['tipo']['nombre'] == 'ATRACCION' and
            r.row['tipo']['id_parque'] == parque_id
        ).\
        map(
            r.row.merge(lambda d:
            {
                'total_consumos': r.sum(d['importes_consumos'])
            })
        ).\
        pluck('id', 'nombre', 'total_consumos')


##################################        
############   TEST   ############

if __name__ == '__main__':
    input_id = 2
    if(len(sys.argv) == 2):
        input_id = int(sys.argv[1])
    conn = r.connect()
    conn.use('tp2')
    print('ATRACCIONES POR CLIENTE:', input_id, '- EJ1')
    for value in atrPorCliente(input_id).run(conn):
        print(value)
    print('VISITAS A ATRACIONES POR PARQUE:', input_id, '- EJ2')
    for value in visitasAtrPorParque(input_id).run(conn):
        print(value)
    print('VISITAS A ATRACIONES POR PARQUE(MAP REDUCE):', input_id, '- EJ2')
    for value in mapReduceVisitasAtrPorParque(input_id).run(conn):
        print(value) 
    print('TOP FIVE EVENTOS - EJ3')
    for value in topFiveEventos().run(conn):
        print(value)
    print('ATRACCIONES POR PARQUE:', input_id, '- EJ4')
    for value in importesPorAtraccionEnParque(input_id).run(conn):
        print(value)
