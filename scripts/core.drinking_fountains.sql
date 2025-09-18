DROP TABLE IF EXISTS core.drinking_fountains;
CREATE TABLE core.drinking_fountains (
  fountain_id   bigserial PRIMARY KEY,
  description   text NOT NULL,
  lat           lat_melb NOT NULL,
  lon           lon_melb NOT NULL,
  region        region5  NOT NULL,
  distance_km   double precision,
  geom          geography(Point,4326),
  has_leaf_type       boolean,
  has_stainless_steel boolean,
  is_historic         boolean,
  has_bottle_refill   boolean,
  has_dog_bowl        boolean,
  is_accessible       boolean,
  is_park_location    boolean,
  is_street_location  boolean,
  feature_count       integer,
  feature_diversity   integer,
  description_length  integer,
  location_name       text
);

CREATE INDEX ON core.drinking_fountains (region);
CREATE INDEX ON core.drinking_fountains USING gist (geom);
CREATE INDEX fountains_desc_trgm ON core.drinking_fountains USING gin (description gin_trgm_ops);

INSERT INTO core.drinking_fountains (description,lat,lon,region,distance_km,geom,
  has_leaf_type,has_stainless_steel,is_historic,has_bottle_refill,has_dog_bowl,is_accessible,
  is_park_location,is_street_location,feature_count,feature_diversity,description_length,location_name)
SELECT
  "Description", lat, lon, region::region5, distance_from_cbd,
  ST_SetSRID(ST_MakePoint(lon,lat),4326)::geography,
  has_leaf_type,has_stainless_steel,is_historic,has_bottle_refill,has_dog_bowl,is_accessible,
  is_park_location,is_street_location,feature_count,feature_diversity,description_length,location_name
FROM raw.drinking_fountains_cleaned
WHERE lat BETWEEN -38.5 AND -37.5 AND lon BETWEEN 144.5 AND 145.5;
