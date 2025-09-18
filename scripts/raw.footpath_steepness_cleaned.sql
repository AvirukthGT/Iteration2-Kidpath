DROP TABLE IF EXISTS raw.footpath_steepness_cleaned;
CREATE TABLE raw.footpath_steepness_cleaned (
  "Geo Point"                 text,
  "Geo Shape"                 text,
  grade1in                    double precision,
  gradepc                     double precision,
  segside                     text,
  deltaz                      double precision,
  address                     text,
  rlmax                       double precision,
  rlmin                       double precision,
  distance                    double precision,
  latitude                    double precision,
  longitude                   double precision,
  region                      text,
  distance_from_cbd           double precision,
  steepness_category          text,
  accessibility_difficulty    integer,
  elevation_category          text,
  steepness_ratio             double precision,
  elevation_per_distance      double precision,
  accessibility_score         integer,
  has_street_side             boolean,
  is_accessible               boolean,
  is_challenging              boolean,
  -- other vendor columns like statusid, streetid, mccid_int, mcc_id, asset_type, etc.
  extras                      jsonb
);
