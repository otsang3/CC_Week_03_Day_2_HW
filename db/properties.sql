DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  no_of_bedrooms INT,
  year_built INT
);
