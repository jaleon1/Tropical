#!/bin/sh
dt=`date +%d%m%Y%H%M%S`
echo "Inicia Resplado"
mysqldump -u [user] -p[passwd] [database] > bk_[database]_$dt.sql
echo "Respaldo Listo. Archivo -> bk_tropical_$dt.sql"
echo "++++++++++++++++++++++++++++++++++++++++++++++ \n"
echo "Inicia copia a CERTIFICACION."
scp -P 2200 bk_[database]_$dt.sql [user]@[servidor]:[ruta]
echo "FINALIZA COPIA DE BASE DE DATOS A SERVIDOR DE CERTIFICACION \n"
echo "INICIA RESTORE EN BASE DE DATOS DE CERTIFICACION \n"
ssh -p 2200 [user]@[servidor] "mysql -u [database] -p[passwd] [database] < /var/www/vhost/[ruta]/BK_DB/bk_tropical_$dt.sql"
echo "Proceso Finalizado"
