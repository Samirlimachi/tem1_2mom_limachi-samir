CREATE DATABASE IF NOT EXISTS superstore_db;
USE superstore_db;

CREATE EXTERNAL TABLE IF NOT EXISTS superstore_raw (
  row_id STRING, order_id STRING, order_date STRING, ship_date STRING,
  ship_mode STRING, customer_id STRING, customer_name STRING, segment STRING,
  country STRING, city STRING, state STRING, postal_code STRING,
  region STRING, product_id STRING, category STRING, sub_category STRING,
  product_name STRING, sales STRING, quantity STRING, discount STRING, profit STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES ("separatorChar"=",", "quoteChar"="\"")
STORED AS TEXTFILE
LOCATION 'hdfs://yarn-resourcemanager:9000/user/hive/superstore'
TBLPROPERTIES ("skip.header.line.count"="1");

SELECT COUNT(*) FROM superstore_raw;
