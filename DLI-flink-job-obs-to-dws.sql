CREATE SOURCE STREAM data_source (
  device_id STRING,
  car_id STRING,
  average_speed STRING,
  total_miles STRING
) WITH (
  type = "obs",
  bucket = "bucket-dws",
  region = "eu-west-0",
  object_name = "dws/dli_data_csv.1",
  row_delimiter = "\n",
  field_delimiter = ";"
);
CREATE SINK STREAM audi_cheaper_than_30w (
  device_id STRING,
  car_id STRING,
  average_speed STRING,
  total_miles STRING
) WITH (
  type = "rds",
  username = "dbadmin",
  password = "******",
  db_url = "postgresql://192.168.0.105:8000/gaussdb",
  table_name = "audi_cheaper_than_30w"
);

INSERT INTO
  audi_cheaper_than_30w
SELECT
  *
FROM
  data_source;
