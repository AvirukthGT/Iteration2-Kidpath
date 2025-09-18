DROP TABLE IF EXISTS core.footpaths;
CREATE TABLE core.footpaths (
  footpath_id        bigserial PRIMARY KEY,
  prop_id            bigint,
  name               text,
  addresspt1         text,
  str_id             text,
  mcc_id             text,
  asset_clas         text,
  asset_type         text,
  created_date       date,
  last_edited        timestamptz,
  lat                lat_melb NOT NULL,
  lon                lon_melb NOT NULL,
  region             region5  NOT NULL,
  distance_km        double precision,
  creation_year      integer,
  footpath_age       integer,
  age_category       text,
  completeness_score integer,
  geom               geography(Point,4326),
  extras             jsonb               -- vendor columns preserved here
);

CREATE INDEX ON core.footpaths (region);
CREATE INDEX ON core.footpaths USING gist (geom);

INSERT INTO core.footpaths (
  prop_id,name,addresspt1,str_id,mcc_id,asset_clas,asset_type,created_date,last_edited,
  lat,lon,region,distance_km,creation_year,footpath_age,age_category,completeness_score,geom,extras
)
SELECT
  prop_id, name, addresspt1, str_id, mcc_id, asset_clas, asset_type,
  NULLIF(created_da,'')::date,
  NULLIF(last_edite,'')::timestamptz,
  latitude, longitude, region::region5, distance_km,
  creation_year, footpath_age, age_category, completeness_score,
  ST_SetSRID(ST_MakePoint(longitude,latitude),4326)::geography,
  extras
FROM raw.footpaths_cleaned
WHERE latitude BETWEEN -38.5 AND -37.5 AND longitude BETWEEN 144.5 AND 145.5;
