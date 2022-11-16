CREATE SOURCE STREAM stream_source_1 WITH (
  type = "dis",
  region = "eu-west-0",
  channel = "dis-wb-2",
  encode = "json",
  JSON_SCHEMA = '
  {
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "device_id": {
      "type": "string"
    },
    "car_id": {
      "type": "string"
    },
    "average_speed": {
      "type": "string"
    },
    "total_miles": {
      "type": "string"
    }
  },
  "required": [
    "device_id",
    "car_id",
    "average_speed",
    "total_miles"
  ]
}'
);

CREATE SINK STREAM stream_sink (
  device_id string,
  car_id string,
  average_speed string,
  total_miles string
) WITH (
  type = "obs",
  encode = "csv",
  region = "eu-west-0",
  field_delimiter = ";",
  row_delimiter = "\n",
  obs_dir = "bucket-dws/dws",
  file_prefix = "dli_data_csv",
  rolling_size = "10m"
);

insert into
  stream_sink
select 
  device_id ,car_id, average_speed, total_miles
from
  stream_source_1;
