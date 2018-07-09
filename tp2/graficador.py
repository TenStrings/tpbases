#Graficador
import seaborn as sns
import pandas as pd


data = pd.DataFrame.from_csv("datos_exp.csv")

sns.set(style="darkgrid")

plot = sns.pointplot(data=data, x="cant_docs_total", xlabel="Cantidad total de documentos en la tabla",
           hue="shard", y="cant_docs_shard", legend="Numero de shard")

plot.set_xticklabels(plot.get_xticklabels(), rotation=30)
plot.set(xlabel="Documentos en tabla", ylabel="Documentos en shard")

plot.figure.savefig("grafico_shards.pdf", bbox_inches='tight')

