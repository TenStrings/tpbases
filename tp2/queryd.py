# This Python file uses the following encoding: utf-8
from __future__ import print_function
import rethinkdb as r
import sys

def queryd(id_parque):
    #Si se la importa, hay que llamarla con run(conn)
    return r.table("medio_entretenimiento").\
        filter(
            r.row['tipo']['nombre'] == 'ATRACCION' and
            r.row['tipo']['id_parque'] == id_parque
        ).\
        map(
            r.row.merge(lambda d:
            {
                'total_consumos': r.sum(d['importes_consumos'])
            })
        ).\
        pluck('id', 'nombre', 'total_consumos')

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

if __name__ == '__main__':
    parque_id = 2
    if(len(sys.argv) == 2):
        parque_id = int(sys.argv[1])
    conn = r.connect()
    conn.use('tp2')
    print('TOP FIVE EVENTOS - EJ3')
    for value in topFiveEventos().run(conn):
        print(value)
    print('ATRACCIONES POR PARQUE:', parque_id, '- EJ4')
    for value in queryd(parque_id).run(conn):
        print(value)
    print('ATRACCIONES POR CLIENTE:', parque_id, '- EJ1')
    for value in atrPorCliente(parque_id).run(conn):
        print(value)
 
