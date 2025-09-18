DROP TABLE IF EXISTS raw.footpaths_cleaned;
CREATE TABLE raw.footpaths_cleaned (
  -- always-present / used downstream
  "Geo Point"        text,
  "Geo Shape"        text,
  prop_id            bigint,
  name               text,
  addresspt1         text,
  str_id             text,
  mcc_id             text,
  asset_clas         text,
  asset_type         text,
  created_da         text,
  last_edite         text,
  latitude           double precision,
  longitude          double precision,
  region             text,
  distance_km        double precision,
  creation_year      integer,
  footpath_age       integer,
  age_category       text,
  completeness_score integer,
  -- everything else (vendor-specific columns) captured safely here:
  extras             jsonb
);
