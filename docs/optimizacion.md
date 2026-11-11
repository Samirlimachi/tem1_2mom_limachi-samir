# Análisis de optimización

## 1. Formato ORC

Guardé la tabla principal `superstore` en formato ORC. Como ORC organiza los datos por columnas, una consulta que solo usa `region`, `sales` y `profit` puede leer esas tres columnas sin recorrer las otras 18.

También se redujo el espacio de almacenamiento. El CSV ocupaba 2.278.521 bytes en HDFS y, según la salida `HDFS Write` de la pregunta 1, Hive escribió 266.312 bytes al crear la tabla ORC. Eso equivale a una reducción de aproximadamente el 88 %.

## 2. Carga en dos pasos

Primero creé `superstore_raw`, una tabla externa que lee el CSV desde HDFS con `OpenCSVSerde`. Esto me permitió leer correctamente los nombres de productos que tienen comas dentro de las comillas. En esa etapa, todos los campos se leen como texto.

Después usé `CREATE TABLE ... AS SELECT` (CTAS) para crear `superstore` con los tipos que necesitaba. Convertí las fechas a `DATE` con ayuda de `unix_timestamp(..., 'M/d/yyyy')` y los montos a `DECIMAL`. Así hice la conversión una sola vez durante la carga y pude trabajar con los datos ya tipados en las consultas del examen.

## 3. Reutilización de resultados intermedios

Guardé en tablas ORC los resultados que iba a consultar varias veces.

| Tabla | Pregunta | Para qué la reutilicé |
|-------|----------|-----------------------|
| `rfm_clientes` | P4 | Resumen por segmento y listas de clientes de alto valor y en riesgo. |
| `ranking_productos` | P5 | Las cuatro consultas de productos y los dos análisis de Pareto de la P8. |
| `ventas_mensuales` | P7 | Evolución mensual y los tres meses con más y menos ventas. |
| `pareto_ventas` y `pareto_ganancias` | P8 | Los diez primeros productos y el conteo de los que alcanzan el 80 % del total. |

Por ejemplo, para el análisis de Pareto pude partir de los 1.894 productos ya agrupados en `ranking_productos`. Así evité volver a agrupar los 9.994 registros de la tabla principal.

En la primera prueba del RFM usé una vista. Cada vez que la consultaba, Hive volvía a ejecutar las tres funciones `NTILE()` y el `CROSS JOIN`. Durante una de esas ejecuciones en modo local apareció el error `OutOfMemoryError: Java heap space`. Cuando guardé el resultado en `rfm_clientes`, esos cálculos se hicieron al crear la tabla y las consultas posteriores tardaron unos dos segundos.

## 4. Ruta de HDFS en la tabla externa

Al principio usé `LOCATION '/user/hive/superstore'` y la tabla externa devolvía cero registros. Al revisar la ubicación, vi que Hive estaba buscando el archivo en el disco local (`file:/`). Lo resolví indicando la ruta completa de HDFS en `LOCATION`.

```
hdfs://yarn-resourcemanager:9000/user/hive/superstore
```

## 5. Posibles mejoras

- **Particionar `superstore` por año.** Si el volumen de datos aumenta, una partición por `anio` permitiría que las consultas que filtren por ese campo lean solo los años solicitados.
- **Calcular estadísticas de las columnas.** Durante la ejecución, Hive mostró el aviso `No Stats for superstore_db@superstore`. Con `ANALYZE TABLE superstore COMPUTE STATISTICS FOR COLUMNS;`, el optimizador tendría más información para elegir un plan de ejecución.
- **Probar la ejecución en YARN.** El mensaje `Job running in-process (local Hadoop)` confirmó que las consultas se ejecutaron en modo local. Con un volumen de datos mayor, probaría YARN para distribuir el trabajo entre los nodos del clúster.
