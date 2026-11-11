SET hive.cli.print.header=true;
USE superstore_db;

-- Resumen de calidad
SELECT
  COUNT(*)                                                      AS total_registros,
  COUNT(*) - COUNT(DISTINCT row_id)                             AS row_id_duplicados,
  COUNT(DISTINCT order_id)                                      AS ordenes_unicas,
  COUNT(DISTINCT customer_id)                                   AS clientes_unicos,
  SUM(CASE WHEN order_date IS NULL OR ship_date IS NULL THEN 1 ELSE 0 END) AS fechas_invalidas,
  SUM(CASE WHEN sales <= 0 THEN 1 ELSE 0 END)                   AS ventas_cero_o_menos,
  SUM(CASE WHEN discount < 0 OR discount > 1 THEN 1 ELSE 0 END) AS descuentos_fuera_rango,
  SUM(CASE WHEN ship_date < order_date THEN 1 ELSE 0 END)       AS envio_antes_pedido
FROM superstore;

-- Campos con NULL o vacíos
SELECT
  SUM(CASE WHEN row_id IS NULL THEN 1 ELSE 0 END)                               AS row_id,
  SUM(CASE WHEN order_id IS NULL OR order_id = '' THEN 1 ELSE 0 END)            AS order_id,
  SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END)                           AS order_date,
  SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END)                            AS ship_date,
  SUM(CASE WHEN ship_mode IS NULL OR ship_mode = '' THEN 1 ELSE 0 END)          AS ship_mode,
  SUM(CASE WHEN customer_id IS NULL OR customer_id = '' THEN 1 ELSE 0 END)      AS customer_id,
  SUM(CASE WHEN customer_name IS NULL OR customer_name = '' THEN 1 ELSE 0 END)  AS customer_name,
  SUM(CASE WHEN segment IS NULL OR segment = '' THEN 1 ELSE 0 END)              AS segment,
  SUM(CASE WHEN country IS NULL OR country = '' THEN 1 ELSE 0 END)              AS country,
  SUM(CASE WHEN city IS NULL OR city = '' THEN 1 ELSE 0 END)                    AS city,
  SUM(CASE WHEN state IS NULL OR state = '' THEN 1 ELSE 0 END)                  AS state,
  SUM(CASE WHEN postal_code IS NULL OR postal_code = '' THEN 1 ELSE 0 END)      AS postal_code,
  SUM(CASE WHEN region IS NULL OR region = '' THEN 1 ELSE 0 END)                AS region,
  SUM(CASE WHEN product_id IS NULL OR product_id = '' THEN 1 ELSE 0 END)        AS product_id,
  SUM(CASE WHEN category IS NULL OR category = '' THEN 1 ELSE 0 END)            AS category,
  SUM(CASE WHEN sub_category IS NULL OR sub_category = '' THEN 1 ELSE 0 END)    AS sub_category,
  SUM(CASE WHEN product_name IS NULL OR product_name = '' THEN 1 ELSE 0 END)    AS product_name,
  SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END)                                AS sales,
  SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END)                             AS quantity,
  SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END)                             AS discount,
  SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END)                               AS profit
FROM superstore;

-- Rangos de fechas y descuentos
SELECT MIN(order_date) AS primer_pedido, MAX(order_date) AS ultimo_pedido,
       MIN(ship_date) AS primer_envio, MAX(ship_date) AS ultimo_envio,
       MIN(discount) AS desc_min, MAX(discount) AS desc_max
FROM superstore;
