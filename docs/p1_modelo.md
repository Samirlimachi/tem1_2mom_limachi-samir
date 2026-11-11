# Pregunta 1. Diseño e implementación del modelo de datos

## Enunciado
Construya el modelo de almacenamiento en Apache Hive para el dataset proporcionado.

Actividades:
- Identificar todos los campos del dataset.
- Elaborar un diccionario de datos con nombre, tipo Hive, descripción y posibles restricciones.
- Crear una tabla analítica con tipos de datos apropiados.
- Documentar el procedimiento de carga.

Entregables: diccionario de datos, DDL, instrucciones de carga y evidencia de registros importados.

## Estrategia
Primero creé `superstore_raw`, una tabla externa que lee el CSV desde HDFS con `OpenCSVSerde`. Esto me permitió leer correctamente los nombres de productos que tienen comas dentro de las comillas. En esa etapa, todos los campos se leen como texto.

Después usé `CREATE TABLE ... AS SELECT` (CTAS) para crear `superstore` en formato ORC con los tipos que necesitaba. Convertí las fechas a `DATE` con `unix_timestamp(..., 'M/d/yyyy')` y los montos a `DECIMAL`.

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

## Resultado

| Tabla | Formato | Registros |
|-------|---------|----------:|
| `superstore_raw` | TEXTFILE (CSV, externa) | 9994 |
| `superstore` | ORC | 9994 |

Las fechas se convirtieron correctamente (por ejemplo, `11/8/2016` pasó a `2016-11-08`) y el nombre `Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back` se leyó completo pese a la coma.

## Interpretación
El archivo tiene 21 campos y 9994 registros. La tabla analítica conserva los 9994 registros del CSV, por lo que la carga no perdió filas. `postal_code` se dejó como texto para no perder ceros a la izquierda, y los montos se guardaron como `DECIMAL` para evitar errores de redondeo.

## Conclusión
El modelo quedó listo para las consultas del examen: los datos están en HDFS, tipados y en formato ORC.

## Evidencia
- `evidencias/p1_staging.png`
- `evidencias/p1_tabla.png`
