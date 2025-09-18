DROP TABLE IF EXISTS core.public_toilets;
CREATE TABLE core.public_toilets (
  toilet_id   bigserial PRIMARY KEY,
  name        text NOT NULL,
  female      ynu  NOT NULL,
  male        ynu  NOT NULL,
  wheelchair  ynu  NOT NULL,
  baby_facil  ynu  NOT NULL,
  operator    text,
  lat         lat_melb NOT NULL,
  lon         lon_melb NOT NULL,
  region      region5  NOT NULL,
  geom        geography(Point,4326) GENERATED ALWAYS AS (ST_SetSRID(ST_MakePoint(lon,lat),4326)) STORED
);

CREATE INDEX ON core.public_toilets (region);
CREATE INDEX ON core.public_toilets USING gist (geom);
CREATE INDEX toilets_name_trgm ON core.public_toilets USING gin (name gin_trgm_ops);

INSERT INTO core.public_toilets (name,female,male,wheelchair,baby_facil,operator,lat,lon,region)
SELECT
  name,
  LOWER(female)::ynu,
  LOWER(male)::ynu,
  LOWER(wheelchair)::ynu,
  LOWER(baby_facil)::ynu,
  NULLIF(operator,''),
  lat, lon,
  region::region5
FROM raw.public_toilets_cleaned
WHERE lat BETWEEN -38.5 AND -37.5 AND lon BETWEEN 144.5 AND 145.5;
