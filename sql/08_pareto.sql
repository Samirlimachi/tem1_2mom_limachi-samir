SET hive.cli.print.header=true;
USE superstore_db;

-- Usa la tabla ranking_productos creada en la Pregunta 5 (ventas y ganancia por producto)

-- a) Pareto de VENTAS
DROP TABLE IF EXISTS pareto_ventas;
CREATE TABLE pareto_ventas STORED AS ORC AS
SELECT product_name, category, ventas,
       ROW_NUMBER() OVER (ORDER BY ventas DESC)                         AS posicion,
       ROUND(ventas / SUM(ventas) OVER () * 100, 4)                     AS pct_individual,
       ROUND(SUM(ventas) OVER (ORDER BY ventas DESC
                               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
             / SUM(ventas) OVER () * 100, 2)                            AS pct_acumulado
FROM ranking_productos;

-- Top 10 productos por contribución a ventas
SELECT posicion, product_name, category, ventas, pct_individual, pct_acumulado
FROM pareto_ventas
WHERE posicion <= 10
ORDER BY posicion;

-- ¿Cuántos productos hacen el 80% de las ventas?
SELECT COUNT(*)                                   AS total_productos,
       SUM(CASE WHEN pct_acumulado <= 80 THEN 1 ELSE 0 END) + 1 AS productos_80pct,
       ROUND((SUM(CASE WHEN pct_acumulado <= 80 THEN 1 ELSE 0 END) + 1) * 100.0 / COUNT(*), 2)
                                                  AS pct_de_productos
FROM pareto_ventas;

-- b) Pareto de GANANCIAS
DROP TABLE IF EXISTS pareto_ganancias;
CREATE TABLE pareto_ganancias STORED AS ORC AS
SELECT product_name, category, ganancia,
       ROW_NUMBER() OVER (ORDER BY ganancia DESC)                       AS posicion,
       ROUND(ganancia / SUM(ganancia) OVER () * 100, 4)                 AS pct_individual,
       ROUND(SUM(ganancia) OVER (ORDER BY ganancia DESC
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
             / SUM(ganancia) OVER () * 100, 2)                          AS pct_acumulado
FROM ranking_productos;

-- Top 10 productos por contribución a ganancias
SELECT posicion, product_name, category, ganancia, pct_individual, pct_acumulado
FROM pareto_ganancias
WHERE posicion <= 10
ORDER BY posicion;

-- ¿Cuántos productos hacen el 80% de las ganancias?
SELECT COUNT(*)                                   AS total_productos,
       MIN(CASE WHEN pct_acumulado >= 80 THEN posicion END) AS productos_80pct,
       ROUND(MIN(CASE WHEN pct_acumulado >= 80 THEN posicion END) * 100.0 / COUNT(*), 2)
                                                  AS pct_de_productos,
       SUM(CASE WHEN ganancia > 0 THEN 1 ELSE 0 END) AS productos_con_ganancia,
       SUM(CASE WHEN ganancia < 0 THEN 1 ELSE 0 END) AS productos_con_perdida,
       MAX(pct_acumulado)                         AS pct_acumulado_maximo
FROM pareto_ganancias;
