#!/usr/bin/env bash
{
rethinkdb import -f clientes.json --table tp2.cliente --pkey id --force & 
rethinkdb import -f facturas.json --table tp2.factura --pkey numero --force &
rethinkdb import -f pagos.json --table tp2.pago --pkey id --force & 
rethinkdb import -f medios.json --table tp2.medio_entretenimiento --pkey id --force &
rethinkdb import -f consumos.json --table tp2.consumo --pkey id --force & 
rethinkdb import -f tarjetas.json --table tp2.tarjeta --pkey numero --force 
} >> /dev/null && 
cat << "EOF"
.------.------.------.------.------.
|L.--. |I.--. |S.--. |T.--. |O.--. |
| :/\: | (\/) | :/\: | :/\: | :/\: |
| (__) | :\/: | :\/: | (__) | :\/: |
| '--'L| '--'I| '--'S| '--'T| '--'O|
`------`------`------`------`------'
EOF
