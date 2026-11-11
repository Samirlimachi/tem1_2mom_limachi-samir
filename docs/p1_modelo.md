# Pregunta 1. Diseño e implementación del modelo de datos

## Diccionario de datos

| Campo | Tipo Hive | Descripción | Restricción |
|-------|-----------|-------------|-------------|
| row_id | INT | Número de fila | Único |
| order_id | STRING | Código de la orden | No nulo |
| order_date | DATE | Fecha del pedido | No nulo |
| ship_date | DATE | Fecha de envío | >= order_date |
| ship_mode | STRING | Tipo de envío | |
| customer_id | STRING | Código del cliente | No nulo |
| customer_name | STRING | Nombre del cliente | |
| segment | STRING | Segmento del cliente | |
| country | STRING | País | |
| city | STRING | Ciudad | |
| state | STRING | Estado | |
| postal_code | STRING | Código postal | |
| region | STRING | Región | |
| product_id | STRING | Código del producto | No nulo |
| category | STRING | Categoría | |
| sub_category | STRING | Subcategoría | |
| product_name | STRING | Nombre del producto | |
| sales | DECIMAL(12,4) | Monto de venta | > 0 |
| quantity | INT | Cantidad | > 0 |
| discount | DECIMAL(4,2) | Descuento | Entre 0 y 1 |
| profit | DECIMAL(12,4) | Ganancia | Puede ser negativa |

## DDL
- `sql/01_ddl.sql`: base de datos y tabla `superstore_raw`
- `sql/01_tabla.sql`: tabla `superstore`

## Procedimiento de carga

1. Convertir el CSV a UTF-8:
   ```bash
   iconv -f WINDOWS-1252 -t UTF-8 data/superstore_original.csv | sed 's/\r$//' > data/superstore.csv
   ```
2. Subir el archivo a HDFS:
   ```bash
   docker cp data/superstore.csv bigdata-dockerspark-transnochados-yarn-resourcemanager-1:/tmp/
   docker exec -it bigdata-dockerspark-transnochados-yarn-resourcemanager-1 bash
   hdfs dfs -mkdir -p /user/hive/superstore
   hdfs dfs -put /tmp/superstore.csv /user/hive/superstore/
   ```
3. Crear la tabla staging `superstore_raw`:
   ```bash
   docker cp sql/01_ddl.sql hive-server:/tmp/
   docker exec -it hive-server hive -f /tmp/01_ddl.sql
   ```
   Resultado: 9994 registros.
4. Crear la tabla `superstore` en ORC con los tipos:
   ```bash
   docker cp sql/01_tabla.sql hive-server:/tmp/
   docker exec -it hive-server hive -f /tmp/01_tabla.sql
   ```
   Resultado: 9994 registros.

## Evidencia
- `evidencias/p1_staging.png`
- `evidencias/p1_tabla.png`
