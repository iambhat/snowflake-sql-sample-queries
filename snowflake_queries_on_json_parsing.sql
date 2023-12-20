
-- Use Case 1: Parsing JSON data and creating a table

-- Suppose you have a JSON file with data like this:

/*json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "address": {
    "street": "123 Main St",
    "city": "New York",
    "zipcode": "10001"
  },
  "orders": [
    {
      "order_id": 101,
      "product": "Product A",
      "quantity": 2
    },
    {
      "order_id": 102,
      "product": "Product B",
      "quantity": 1
    }
  ]
}
*/

-- You can create a table in Snowflake to store this JSON data:

CREATE OR REPLACE TABLE json_data_table (
    id INT,
    name STRING,
    email STRING,
    address VARIANT,
    orders VARIANT
);


-- To load the JSON data into the table:


INSERT INTO json_data_table
SELECT
    id,
    name,
    email,
    PARSE_JSON($1:address),
    PARSE_JSON($1:orders)
FROM @stage_location/json_file.json;

----------------------------------------------------------------------------------------------------------------------------------------

-- Use Case 2: Querying JSON data

-- Let's say you want to query the JSON data stored in the table created earlier.

-- To retrieve the name and email of users:

SELECT
    id,
    name,
    email
FROM json_data_table;
```

To query specific information nested within the JSON structure:

```sql
SELECT
    id,
    orders[0]:order_id AS first_order_id,
    orders[0]:product AS first_product,
    orders[1]:order_id AS second_order_id,
    orders[1]:product AS second_product
FROM json_data_table;


----------------------------------------------------------------------------------------------------------------------------------------

-- Use Case 3: Extracting Nested JSON Data

-- Suppose you want to create a table that flattens out the nested JSON data for better querying:

CREATE OR REPLACE TABLE flattened_data AS
SELECT
    id,
    name,
    email,
    address:street AS street,
    address:city AS city,
    address:zipcode AS zipcode,
    o.value:order_id AS order_id,
    o.value:product AS product,
    o.value:quantity AS quantity
FROM json_data_table,
    LATERAL FLATTEN(input => orders) o;


----------------------------------------------------------------------------------------------------------------------------------------

-- Use Case 4: Filtering JSON Data

-- If you want to filter based on JSON content:

SELECT *
FROM json_data_table
WHERE address:city = 'New York';


