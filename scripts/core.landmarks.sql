DROP TABLE IF EXISTS core.landmarks;
CREATE TABLE core.landmarks (
  landmark_id   bigserial PRIMARY KEY,
  pid           text,
  title         text NOT NULL,
  description   text,
  identifier    text,
  format        text,
  landmark_type text,              -- from Type
  date_text     text,              -- freeform date
  creator       text,              -- Creator/Contributor
  lat           lat_melb,
  lon           lon_melb,
  region        region5,
  distance_km   double precision,
  geom          geography(Point,4326),
  -- flags & derived
  is_building boolean, is_church boolean, is_park boolean, is_street boolean, is_historic boolean,
  is_cultural boolean, is_commercial boolean, is_government boolean, is_transport boolean, is_architectural boolean,
  feature_count integer, feature_diversity integer, description_length integer, title_length integer,
  historical_period text
);

CREATE INDEX ON core.landmarks (region);
CREATE INDEX ON core.landmarks USING gist (geom);
CREATE INDEX landmarks_title_trgm ON core.landmarks USING gin (title gin_trgm_ops);

INSERT INTO core.landmarks (
  pid,title,description,identifier,format,landmark_type,date_text,creator,lat,lon,region,distance_km,geom,
  is_building,is_church,is_park,is_street,is_historic,is_cultural,is_commercial,is_government,is_transport,is_architectural,
  feature_count,feature_diversity,description_length,title_length,historical_period
)
SELECT
  "PID","Title","Description","Identifier","Format","Type","Date","Creator/Contributor",
  latitude, longitude, region::region5, distance_from_cbd,
  CASE WHEN latitude IS NOT NULL AND longitude IS NOT NULL
       THEN ST_SetSRID(ST_MakePoint(longitude,latitude),4326)::geography END,
  is_building,is_church,is_park,is_street,is_historic,is_cultural,is_commercial,is_government,is_transport,is_architectural,
  feature_count,feature_diversity,description_length,title_length,historical_period
FROM raw.landmarks_cleaned
WHERE latitude IS NULL OR (latitude BETWEEN -38.5 AND -37.5 AND longitude BETWEEN 144.5 AND 145.5);
