DROP VIEW IF EXISTS core.amenities_all;
CREATE VIEW core.amenities_all AS
SELECT 'toilet'::text AS amenity_type, toilet_id::bigint AS amenity_id,
       name AS label, region, geom, lat, lon
FROM core.public_toilets
UNION ALL
SELECT 'playground', playground_id, name, region, geom, lat, lon
FROM core.playgrounds
UNION ALL
SELECT 'fountain', fountain_id, description AS label, region, geom, lat, lon
FROM core.drinking_fountains
UNION ALL
SELECT 'landmark', landmark_id, title AS label, region, geom, lat, lon
FROM core.landmarks
WHERE lat IS NOT NULL AND lon IS NOT NULL;
