SET hive.cli.print.header=true;
USE superstore_db;

-- Tabla con totales y rankings por producto
DROP TABLE IF EXISTS ranking_productos;
CREATE TABLE ranking_productos STORED AS ORC AS
WITH prod AS (
  SELECT category, product_id, product_name,
         SUM(quantity) AS unidades,
         SUM(sales)    AS ventas,
         SUM(profit)   AS ganancia
  FROM superstore
  GROUP BY category, product_id, product_name
)
SELECT category, product_id, product_name, unidades,
       ROUND(ventas, 2)                  AS ventas,
       ROUND(ganancia, 2)                AS ganancia,
       ROUND(ganancia / ventas * 100, 2) AS margen_pct,
       RANK()       OVER (PARTITION BY category ORDER BY ganancia DESC) AS rank_categoria,
       DENSE_RANK() OVER (PARTITION BY category ORDER BY ganancia DESC) AS dense_rank_categoria,
       ROUND(SUM(ganancia) OVER (PARTITION BY category ORDER BY ganancia DESC
                                 ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS ganancia_acumulada,
       RANK() OVER (ORDER BY ventas DESC)  AS rank_ventas,
       RANK() OVER (ORDER BY ganancia ASC) AS rank_menor_ganancia
FROM prod;

-- Top 5 por ganancia en cada categoría
SELECT category, rank_categoria, dense_rank_categoria, product_name,
       ventas, ganancia, margen_pct, ganancia_acumulada
FROM ranking_productos
WHERE rank_categoria <= 5
ORDER BY category, rank_categoria;

-- Top 5 por volumen de ventas
SELECT rank_ventas, category, product_name, unidades, ventas, ganancia, margen_pct
FROM ranking_productos
WHERE rank_ventas <= 5
ORDER BY rank_ventas;

-- 5 productos con menor rentabilidad
SELECT rank_menor_ganancia, category, product_name, ventas, ganancia, margen_pct,
       rank_categoria
FROM ranking_productos
WHERE rank_menor_ganancia <= 5
ORDER BY rank_menor_ganancia;

-- Resumen de márgenes por categoría
SELECT category,
       COUNT(*)                                      AS productos,
       SUM(CASE WHEN ganancia < 0 THEN 1 ELSE 0 END) AS productos_con_perdida,
       ROUND(AVG(margen_pct), 2)                     AS margen_promedio
FROM ranking_productos
GROUP BY category;
