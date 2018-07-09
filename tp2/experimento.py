import rethinkdb as r
import json
import numpy as np
conn = r.connect()

r.db_list().contains('experimento')\
  .do(lambda exists:
    r.branch(
      exists,
      { 'dbs_created': 0 },
      r.db_create('experimento')
    )
  ).run(conn)


conn.use('experimento')

r.table_list().contains('consumo')\
  .do(lambda exists:
    r.branch(
      exists,
      r.table_drop('consumo'),
      {'tables_dropped': 0}
    )
  ).run(conn)

r.table_create('consumo', shards=3, primary_key='id').run(conn)

f = open('consumos.json')
consumos = json.load(f)
f.close()

n = 500
particiones = [consumos[i:i+n] for i in range(0, len(consumos), n)]
print(len(particiones))
data = []

for i, p in enumerate(particiones):
    r.table('consumo').wait().run(conn)
    print('Insertando bloque ' + str(i+1))
    r.table('consumo').insert(p).run(conn)
    print('Rebalanceando')
    r.table('consumo').rebalance().run(conn)
    r.table('consumo').wait().run(conn)
    data.append(r.table('consumo').info().run(conn)['doc_count_estimates'])
    print('')

print(data)
