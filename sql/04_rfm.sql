SET hive.cli.print.header=true;
USE superstore_db;

-- Tabla RFM por cliente (se guarda como tabla para no recalcularla en cada consulta)
DROP TABLE IF EXISTS rfm_clientes;
CREATE TABLE rfm_clientes STORED AS ORC AS
WITH fecha_ref AS (
  SELECT MAX(order_date) AS fecha_max FROM superstore
),
base AS (
  SELECT s.customer_id,
         MAX(s.customer_name)                          AS customer_name,
         DATEDIFF(MAX(f.fecha_max), MAX(s.order_date)) AS recency,
         COUNT(DISTINCT s.order_id)                    AS frequency,
         SUM(s.sales)                                  AS monetary
  FROM superstore s
  CROSS JOIN fecha_ref f
  GROUP BY s.customer_id
),
puntajes AS (
  SELECT customer_id, customer_name, recency, frequency, monetary,
         NTILE(5) OVER (ORDER BY recency DESC)  AS r_score,
         NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
         NTILE(5) OVER (ORDER BY monetary ASC)  AS m_score
  FROM base
)
SELECT customer_id, customer_name, recency, frequency,
       ROUND(monetary, 2) AS monetary,
       r_score, f_score, m_score,
       CONCAT(r_score, f_score, m_score) AS rfm,
       CASE
         WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4  THEN 'Alto valor'
         WHEN r_score >= 3 AND f_score >= 4                   THEN 'Recurrente'
         WHEN r_score <= 2 AND (f_score >= 3 OR m_score >= 4) THEN 'En riesgo'
         WHEN r_score >= 4 AND f_score <= 2                   THEN 'Nuevo'
         WHEN r_score <= 2 AND f_score <= 2                   THEN 'Perdido'
         ELSE 'Potencial'
       END AS segmento
FROM puntajes;

-- Fecha de referencia
SELECT MAX(order_date) AS fecha_referencia FROM superstore;

-- Resumen por segmento
SELECT segmento,
       COUNT(*)                 AS clientes,
       ROUND(AVG(recency), 1)   AS recency_prom,
       ROUND(AVG(frequency), 1) AS frequency_prom,
       ROUND(AVG(monetary), 2)  AS monetary_prom,
       ROUND(SUM(monetary), 2)  AS ventas_total
FROM rfm_clientes
GROUP BY segmento
ORDER BY ventas_total DESC;

-- Top 10 clientes de alto valor
SELECT customer_name, recency, frequency, monetary, rfm
FROM rfm_clientes
WHERE segmento = 'Alto valor'
ORDER BY monetary DESC
LIMIT 10;

-- Top 10 clientes en riesgo
SELECT customer_name, recency, frequency, monetary, rfm
FROM rfm_clientes
WHERE segmento = 'En riesgo'
ORDER BY monetary DESC
LIMIT 10;
