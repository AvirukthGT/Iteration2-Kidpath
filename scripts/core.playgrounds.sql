DROP TABLE IF EXISTS core.playgrounds;
CREATE TABLE core.playgrounds (
  playground_id bigserial PRIMARY KEY,
  name          text NOT NULL,
  features_text text,
  council_re    integer,
  lat           lat_melb NOT NULL,
  lon           lon_melb NOT NULL,
  region        region5  NOT NULL,
  distance_km   double precision,
  geom          geography(Point,4326),
  -- equipment flags
  has_swing            boolean,
  has_slide            boolean,
  has_climbing         boolean,
  has_sand             boolean,
  has_water            boolean,
  has_shade            boolean,
  has_fence            boolean,
  has_basketball       boolean,
  has_tower            boolean,
  has_seesaw           boolean,
  has_spring           boolean,
  has_accessible       boolean,
  equipment_count      integer,
  equipment_diversity  integer,
  features_length      integer,
  name_length          integer
);

CREATE INDEX ON core.playgrounds (region);
CREATE INDEX ON core.playgrounds USING gist (geom);
CREATE INDEX playgrounds_name_trgm ON core.playgrounds USING gin (name gin_trgm_ops);

INSERT INTO core.playgrounds (name,features_text,council_re,lat,lon,region,distance_km,geom,
  has_swing,has_slide,has_climbing,has_sand,has_water,has_shade,has_fence,has_basketball,
  has_tower,has_seesaw,has_spring,has_accessible,equipment_count,equipment_diversity,features_length,name_length)
SELECT
  name, features, council_re, latitude, longitude, region::region5,
  distance_from_cbd, ST_SetSRID(ST_MakePoint(longitude,latitude),4326)::geography,
  has_swing,has_slide,has_climbing,has_sand,has_water,has_shade,has_fence,has_basketball,
  has_tower,has_seesaw,has_spring,has_accessible,equipment_count,equipment_diversity,features_length,name_length
FROM raw.playgrounds_cleaned
WHERE latitude BETWEEN -38.5 AND -37.5 AND longitude BETWEEN 144.5 AND 145.5;
