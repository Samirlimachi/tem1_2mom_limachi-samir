# tem1_2mom_limachi-samir

Examen práctico individual · Segundo momento
Tecnologías Emergentes · Universidad del Valle
Autor — Samir Limachi

## Descripción

En este proyecto trabajé con Sample Superstore, un conjunto de datos de Kaggle, para analizar cómo se relacionan las ventas, los descuentos y la ganancia. Cargué el archivo en HDFS y preparé las tablas en Apache Hive dentro de un clúster Hadoop que corre en Docker.

El examen tiene ocho preguntas. La primera cubre el modelo de datos y la carga del archivo. En las siguientes revisé la calidad de los registros y analicé las ventas y la rentabilidad por región, cliente, producto, nivel de descuento y mes. Cerré con un análisis de Pareto para ver cuántos productos concentran la mayor parte de las ventas y de la ganancia.

## Objetivos

- Diseñar las tablas en Hive y cargar los datos en HDFS.
- Revisar la calidad de los registros antes de usarlos en el análisis.
- Resolver las consultas con HiveQL, usando CTE y funciones de ventana como `LAG()`, `RANK()`, `DENSE_RANK()`, `NTILE()`, `SUM() OVER` y `AVG() OVER`.
- Interpretar los resultados para entender dónde se concentra la ganancia y qué factores vale la pena revisar.
- Usar el formato ORC y tablas materializadas para optimizar las consultas.

## Requisitos

- Docker con el clúster Hadoop y Hive en ejecución.
  - Servicios de Hive — `hive-server` y `hive-metastore`.
  - Contenedor desde el que se ejecutan los comandos de HDFS — `bigdata-dockerspark-transnochados-yarn-resourcemanager-1`.
  - DataNodes — `datanode1Grupo2`, `datanode2Grupo2` y `datanode3Grupo2`.
- Hive 3.1.3.
- Git e `iconv`.
- Dataset [Sample Superstore en Kaggle](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final).

## Estructura del repositorio

| Carpeta | Qué contiene |
|---------|--------------|
| `data/` | El CSV original en Windows-1252 y su versión convertida a UTF-8. |
| `sql/` | Los scripts HiveQL de cada pregunta. |
| `docs/` | El diccionario de datos, los resultados y la interpretación de cada pregunta. |
| `evidencias/` | Las capturas de la ejecución de los scripts. |

## Cómo ejecutar el proyecto

### 1. Verificar que el clúster esté activo

Desde la raíz del repositorio, revisa que los contenedores de Hadoop y Hive estén en ejecución.

```bash
docker ps
```

### 2. Preparar el CSV

Convierte el archivo original de Windows-1252 a UTF-8 y elimina el retorno de carro al final de cada línea.

```bash
iconv -f WINDOWS-1252 -t UTF-8 data/superstore_original.csv | sed 's/\r$//' > data/superstore.csv
```

### 3. Subir el archivo a HDFS

Copia el CSV al contenedor desde el que se ejecutan los comandos de HDFS. Luego crea el directorio de destino y sube el archivo.

```bash
docker cp data/superstore.csv bigdata-dockerspark-transnochados-yarn-resourcemanager-1:/tmp/
docker exec -it bigdata-dockerspark-transnochados-yarn-resourcemanager-1 hdfs dfs -mkdir -p /user/hive/superstore
docker exec -it bigdata-dockerspark-transnochados-yarn-resourcemanager-1 hdfs dfs -put /tmp/superstore.csv /user/hive/superstore/
```

### 4. Ejecutar los scripts de Hive

Copia el primer script al contenedor `hive-server` y ejecútalo.

```bash
docker cp sql/01_ddl.sql hive-server:/tmp/
docker exec -it hive-server hive -f /tmp/01_ddl.sql
```

Repite esos dos comandos con `01_tabla.sql`, `02_calidad.sql`, `03_region.sql`, `04_rfm.sql`, `05_productos.sql`, `06_descuentos.sql`, `07_tendencias.sql` y `08_pareto.sql`, en ese orden.

> Ejecuta `05_productos.sql` antes de `08_pareto.sql`. El análisis de Pareto usa la tabla `ranking_productos` que se crea en la pregunta 5.

## Preguntas del examen

| N.º | Tema | Script | Documento |
|----:|------|--------|-----------|
| 1 | Modelo de datos y carga | `sql/01_ddl.sql`, `sql/01_tabla.sql` | [Modelo de datos](docs/p1_modelo.md) |
| 2 | Calidad de datos | `sql/02_calidad.sql` | [Controles y resultados](docs/p2_calidad.md) |
| 3 | Evolución por región | `sql/03_region.sql` | [Ventas y ganancias por región](docs/p3_region.md) |
| 4 | Segmentación RFM | `sql/04_rfm.sql` | [Segmentación de clientes](docs/p4_rfm.md) |
| 5 | Ranking de productos | `sql/05_productos.sql` | [Productos por ventas y ganancias](docs/p5_productos.md) |
| 6 | Impacto de los descuentos | `sql/06_descuentos.sql` | [Descuentos y rentabilidad](docs/p6_descuentos.md) |
| 7 | Tendencias mensuales | `sql/07_tendencias.sql` | [Evolución y estacionalidad de las ventas](docs/p7_tendencias.md) |
| 8 | Análisis de Pareto | `sql/08_pareto.sql` | [Concentración de ventas y ganancias](docs/p8_pareto.md) |

## Optimización

En [este documento](docs/optimizacion.md) explico cómo usé el formato ORC y las tablas materializadas para preparar los datos y reutilizar resultados entre consultas.

## Conclusiones generales

Al comparar las regiones y los productos, encontré casos en los que las ventas subieron mientras la ganancia bajó. La revisión de los descuentos mostró que las operaciones con descuentos medios y altos fueron las que perdieron dinero con mayor frecuencia. El análisis de clientes también dejó una prioridad clara. Los clientes en riesgo fueron el grupo que más había comprado y llevaban, en promedio, unos ocho meses sin volver.
