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
Hice la carga en dos pasos. Primero creé `superstore_raw`, una tabla externa que lee el CSV desde HDFS con `OpenCSVSerde`. Así pude leer bien los nombres de productos que incluyen comas entre comillas. En esta primera tabla, todos los campos se leyeron como texto.

Después creé `superstore` en formato ORC con `CREATE TABLE ... AS SELECT` (CTAS). En ese paso usé `unix_timestamp(..., 'M/d/yyyy')` para interpretar las fechas del CSV y convertirlas a `DATE`. También guardé los montos como `DECIMAL`.

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
1. Convertí el CSV a UTF-8 con `iconv`.
   ```bash
   iconv -f WINDOWS-1252 -t UTF-8 data/superstore_original.csv | sed 's/\r$//' > data/superstore.csv
   ```
2. Copié el archivo al contenedor con `docker cp`, creé el directorio `/user/hive/superstore` en HDFS y subí el CSV con `hdfs dfs -put`.
   ```bash
   docker cp data/superstore.csv bigdata-dockerspark-transnochados-yarn-resourcemanager-1:/tmp/
   docker exec -it bigdata-dockerspark-transnochados-yarn-resourcemanager-1 hdfs dfs -mkdir -p /user/hive/superstore
   docker exec -it bigdata-dockerspark-transnochados-yarn-resourcemanager-1 hdfs dfs -put /tmp/superstore.csv /user/hive/superstore/
   ```
3. Ejecuté `01_ddl.sql` para crear la tabla externa `superstore_raw` en formato `TEXTFILE`.
   ```bash
   docker cp sql/01_ddl.sql hive-server:/tmp/
   docker exec -it hive-server hive -f /tmp/01_ddl.sql
   ```
4. Ejecuté `01_tabla.sql` para crear la tabla `superstore` en formato ORC con los tipos de datos definidos.
   ```bash
   docker cp sql/01_tabla.sql hive-server:/tmp/
   docker exec -it hive-server hive -f /tmp/01_tabla.sql
   ```

## Resultado
El CSV tenía 21 campos y 9.994 registros. Al contar las filas en `superstore_raw` y en `superstore`, obtuve los mismos 9.994 registros en ambas tablas. También comprobé que la fecha `11/8/2016` se convirtió en `2016-11-08` y que el nombre `Hon Deluxe Fabric Upholstered Stacking Chairs, Rounded Back` quedó completo en un solo campo.

| Tabla | Formato | Registros |
|-------|---------|----------:|
| `superstore_raw` | TEXTFILE (externa) | 9994 |
| `superstore` | ORC | 9994 |

## Interpretación
El conteo muestra que se conservó la cantidad de registros durante la carga. Dejé `postal_code` como texto para conservar los ceros a la izquierda y usé `DECIMAL` para mantener la precisión de los montos en los cálculos.

## Conclusión
La tabla `superstore` quedó lista para las consultas del examen. Los datos están en HDFS, en formato ORC y con los tipos definidos desde la carga, así que pude usar las fechas y los montos directamente en las consultas.

## Evidencia
- `evidencias/p1_staging.png`
- `evidencias/p1_tabla.png`
