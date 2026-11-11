USE superstore_db;

DROP TABLE IF EXISTS superstore;
CREATE TABLE superstore STORED AS ORC AS
SELECT
  CAST(row_id AS INT)                                            AS row_id,
  order_id,
  to_date(from_unixtime(unix_timestamp(order_date, 'M/d/yyyy'))) AS order_date,
  to_date(from_unixtime(unix_timestamp(ship_date,  'M/d/yyyy'))) AS ship_date,
  ship_mode, customer_id, customer_name, segment, country, city, state,
  postal_code, region, product_id, category, sub_category, product_name,
  CAST(sales    AS DECIMAL(12,4)) AS sales,
  CAST(quantity AS INT)           AS quantity,
  CAST(discount AS DECIMAL(4,2))  AS discount,
  CAST(profit   AS DECIMAL(12,4)) AS profit
FROM superstore_raw;

DESCRIBE superstore;
SELECT COUNT(*) FROM superstore;
SELECT row_id, order_date, ship_date, product_name, sales, discount, profit
FROM superstore LIMIT 5;
