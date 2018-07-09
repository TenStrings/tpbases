import rethinkdb as r
import json
import numpy as np
import seaborn as sns
import pandas as pd

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

CANT_SHARDS = 3

r.table_create('consumo', shards=CANT_SHARDS, primary_key='id').run(conn)

f = open('consumos.json')
consumos = json.load(f)
f.close()

docs_por_medicion = 500
particiones = [consumos[i : i + docs_por_medicion] for i in range(0, len(consumos), docs_por_medicion)]
print(len(particiones))

data = {'cant_docs_total': [], 'cant_docs_shard': [], 'shard': []}

docs_agregados = 0
for i, p in enumerate(particiones):
    r.table('consumo').wait().run(conn)
    print('Insertando bloque ' + str(i+1))
    r.table('consumo').insert(p).run(conn)
    docs_agregados += docs_por_medicion
    print('Rebalanceando')
    r.table('consumo').rebalance().run(conn)
    r.table('consumo').wait().run(conn)
    doc_count_estimates = r.table('consumo').info().run(conn)['doc_count_estimates']
    for i in range(len(doc_count_estimates)):
      data['cant_docs_total'] += [docs_agregados]
      data["cant_docs_shard"] += [doc_count_estimates[i]]
      data["shard"] += [i+1]
    print('')

df = pd.DataFrame(data=data)
df.to_csv("datos_exp.csv")


