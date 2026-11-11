SET hive.cli.print.header=true;
USE superstore_db;

-- Ventas, ganancia, margen y variación respecto al año anterior por región
WITH region_anio AS (
  SELECT region,
         year(order_date) AS anio,
         SUM(sales)       AS ventas,
         SUM(profit)      AS ganancia
  FROM superstore
  GROUP BY region, year(order_date)
),
con_anterior AS (
  SELECT region, anio, ventas, ganancia,
         LAG(ventas)   OVER (PARTITION BY region ORDER BY anio) AS ventas_ant,
         LAG(ganancia) OVER (PARTITION BY region ORDER BY anio) AS ganancia_ant
  FROM region_anio
)
SELECT region,
       anio,
       ROUND(ventas, 2)                                          AS ventas,
       ROUND(ganancia, 2)                                        AS ganancia,
       ROUND(ganancia / ventas * 100, 2)                         AS margen_pct,
       ROUND((ventas - ventas_ant) / ventas_ant * 100, 2)        AS var_ventas_pct,
       ROUND((ganancia - ganancia_ant) / ganancia_ant * 100, 2)  AS var_ganancia_pct
FROM con_anterior
ORDER BY region, anio;

-- Mejor y peor región (total 2014-2017)
WITH totales AS (
  SELECT region,
         SUM(sales)  AS ventas,
         SUM(profit) AS ganancia
  FROM superstore
  GROUP BY region
)
SELECT region,
       ROUND(ventas, 2)                   AS ventas,
       ROUND(ganancia, 2)                 AS ganancia,
       ROUND(ganancia / ventas * 100, 2)  AS margen_pct,
       RANK() OVER (ORDER BY ganancia DESC) AS ranking
FROM totales
ORDER BY ranking;
