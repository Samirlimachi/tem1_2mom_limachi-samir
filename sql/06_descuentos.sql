SET hive.cli.print.header=true;
USE superstore_db;

-- Resumen por rango de descuento
WITH rangos AS (
  SELECT *,
         CASE
           WHEN discount = 0    THEN '1. Sin descuento'
           WHEN discount <= 0.2 THEN '2. Bajo (0-20%)'
           WHEN discount <= 0.5 THEN '3. Medio (20-50%)'
           ELSE                      '4. Alto (>50%)'
         END AS rango
  FROM superstore
)
SELECT rango,
       COUNT(*)                                                   AS registros,
       ROUND(SUM(sales), 2)                                       AS ventas,
       ROUND(SUM(profit), 2)                                      AS ganancia,
       ROUND(SUM(profit) / SUM(sales) * 100, 2)                   AS margen_pct,
       SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END)                AS con_perdida,
       ROUND(SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pct_no_rentables,
       ROUND(AVG(discount) * 100, 2)                              AS descuento_prom_pct
FROM rangos
GROUP BY rango
ORDER BY rango;

-- Categorías y subcategorías más afectadas por descuentos altos y medios
WITH rangos AS (
  SELECT *,
         CASE
           WHEN discount = 0    THEN '1. Sin descuento'
           WHEN discount <= 0.2 THEN '2. Bajo (0-20%)'
           WHEN discount <= 0.5 THEN '3. Medio (20-50%)'
           ELSE                      '4. Alto (>50%)'
         END AS rango
  FROM superstore
)
SELECT category,
       sub_category,
       COUNT(*)                                                   AS registros,
       ROUND(AVG(discount) * 100, 2)                              AS descuento_prom_pct,
       ROUND(SUM(profit), 2)                                      AS ganancia,
       SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END)                AS con_perdida,
       ROUND(SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pct_no_rentables
FROM rangos
WHERE rango IN ('3. Medio (20-50%)', '4. Alto (>50%)')
GROUP BY category, sub_category
ORDER BY ganancia ASC
LIMIT 10;
