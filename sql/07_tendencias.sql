SET hive.cli.print.header=true;
USE superstore_db;

-- Tabla de ventas y ganancias por mes
DROP TABLE IF EXISTS ventas_mensuales;
CREATE TABLE ventas_mensuales STORED AS ORC AS
SELECT year(order_date)                  AS anio,
       month(order_date)                 AS mes,
       date_format(order_date, 'yyyy-MM') AS periodo,
       SUM(sales)                        AS ventas,
       SUM(profit)                       AS ganancia
FROM superstore
GROUP BY year(order_date), month(order_date), date_format(order_date, 'yyyy-MM');

-- Evolución mensual
SELECT periodo,
       ROUND(ventas, 2)   AS ventas,
       ROUND(ganancia, 2) AS ganancia,
       -- variación respecto al mes anterior
       ROUND((ventas - LAG(ventas) OVER (ORDER BY periodo))
             / LAG(ventas) OVER (ORDER BY periodo) * 100, 2)        AS var_mes_ant_pct,
       -- mismo mes del año anterior
       ROUND(LAG(ventas) OVER (PARTITION BY mes ORDER BY anio), 2)  AS ventas_mismo_mes_ant,
       ROUND((ventas - LAG(ventas) OVER (PARTITION BY mes ORDER BY anio))
             / LAG(ventas) OVER (PARTITION BY mes ORDER BY anio) * 100, 2) AS var_anual_pct,
       -- promedio móvil de 3 meses
       ROUND(AVG(ventas) OVER (ORDER BY periodo
                               ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS prom_movil_3m
FROM ventas_mensuales
ORDER BY periodo;

-- 3 meses con mayores ventas
SELECT periodo, ROUND(ventas, 2) AS ventas, ROUND(ganancia, 2) AS ganancia
FROM ventas_mensuales
ORDER BY ventas DESC
LIMIT 3;

-- 3 meses con menores ventas
SELECT periodo, ROUND(ventas, 2) AS ventas, ROUND(ganancia, 2) AS ganancia
FROM ventas_mensuales
ORDER BY ventas ASC
LIMIT 3;
