DROP TABLE IF EXISTS raw.public_toilets_cleaned;
CREATE TABLE raw.public_toilets_cleaned (
  name        text,
  female      text,
  male        text,
  wheelchair  text,
  operator    text,
  baby_facil  text,
  lat         double precision,
  lon         double precision,
  region      text
);
