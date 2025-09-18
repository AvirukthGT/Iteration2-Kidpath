DROP TABLE IF EXISTS raw.drinking_fountains_cleaned;
CREATE TABLE raw.drinking_fountains_cleaned (
  "Description"         text,
  "Co-ordinates"        text,
  lat                   double precision,
  lon                   double precision,
  region                text,
  distance_from_cbd     double precision,
  has_leaf_type         boolean,
  has_stainless_steel   boolean,
  is_historic           boolean,
  has_bottle_refill     boolean,
  has_dog_bowl          boolean,
  is_accessible         boolean,
  is_park_location      boolean,
  is_street_location    boolean,
  feature_count         integer,
  feature_diversity     integer,
  description_length    integer,
  location_name         text
);
