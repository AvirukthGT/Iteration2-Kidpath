DROP TABLE IF EXISTS raw.playgrounds_cleaned;
CREATE TABLE raw.playgrounds_cleaned (
  "Geo Point"          text,
  "Geo Shape"          text,
  council_re           integer,
  features             text,
  location_d           text,
  name                 text,
  latitude             double precision,
  longitude            double precision,
  region               text,
  distance_from_cbd    double precision,
  -- equipment flags (12)
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
  -- derived text metrics
  equipment_count      integer,
  equipment_diversity  integer,
  features_length      integer,
  name_length          integer
);
