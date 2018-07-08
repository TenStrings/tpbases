# This Python file uses the following encoding: utf-8
from __future__ import print_function
import rethinkdb as r
import sys

def queryd(id_parque):
    #Si se la importa, hay que llamarla con run(conn)
    return r.table("medio_entretenimiento").\
        filter(
            r.row['tipo'] == 'ATRACCION' and
            r.row['id_parque'] == id_parque
        ).\
        map(
            r.row.merge(lambda d:
            {
                'total_consumos': r.sum(d['importes_consumos'])
            })
        ).\
        pluck('id', 'nombre', 'total_consumos')

if __name__ == '__main__':
    if(len(sys.argv) != 2):
        print(u"Ingresar el id del parque")
    else:
        conn = r.connect()
        conn.use('tp2')
        for value in queryd(int(sys.argv[1])).run(conn):
            print(value)
