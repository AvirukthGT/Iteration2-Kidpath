DROP TABLE IF EXISTS core.footpath_steepness;
CREATE TABLE core.footpath_steepness (
  slope_id                  bigserial PRIMARY KEY,
  grade1in                  double precision,
  gradepc                   double precision,
  segside                   text,
  deltaz                    double precision,
  address                   text,
  rlmax                     double precision,
  rlmin                     double precision,
  distance_m                double precision,
  lat                       lat_melb NOT NULL,
  lon                       lon_melb NOT NULL,
  region                    region5  NOT NULL,
  distance_km               double precision,
  steepness_category        text,
  accessibility_difficulty  integer,
  elevation_category        text,
  steepness_ratio           double precision,
  elevation_per_distance    double precision,
  accessibility_score       integer,
  has_street_side           boolean,
  is_accessible             boolean,
  is_challenging            boolean,
  geom                      geography(Point,4326),
  extras                    jsonb
);

CREATE INDEX ON core.footpath_steepness (region);
CREATE INDEX ON core.footpath_steepness USING gist (geom);

INSERT INTO core.footpath_steepness (
  grade1in,gradepc,segside,deltaz,address,rlmax,rlmin,distance_m,
  lat,lon,region,distance_km,steepness_category,accessibility_difficulty,elevation_category,
  steepness_ratio,elevation_per_distance,accessibility_score,has_street_side,is_accessible,is_challenging,geom,extras
)
SELECT
  grade1in, gradepc, segside, deltaz, address, rlmax, rlmin, distance,
  latitude, longitude, region::region5, distance_from_cbd,
  steepness_category, accessibility_difficulty, elevation_category,
  steepness_ratio, elevation_per_distance, accessibility_score,
  has_street_side, is_accessible, is_challenging,
  ST_SetSRID(ST_MakePoint(longitude,latitude),4326)::geography,
  extras
FROM raw.footpath_steepness_cleaned
WHERE latitude BETWEEN -38.5 AND -37.5 AND longitude BETWEEN 144.5 AND 145.5;
