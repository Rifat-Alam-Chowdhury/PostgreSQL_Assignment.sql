--  rangers table
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    region TEXT NOT NULL
);

--  species table
CREATE TABLE species (
    species_id SERIAL PRIMARY KEY,
    common_name TEXT NOT NULL,
    scientific_name TEXT NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status TEXT NOT NULL
);

--  sightings table
CREATE TABLE sightings (
    sighting_id SERIAL PRIMARY KEY,
    species_id INTEGER REFERENCES species(species_id),
    ranger_id INTEGER REFERENCES rangers(ranger_id),
    location TEXT NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes TEXT
);

--  data into rangers
INSERT INTO rangers (ranger_id, name, region) VALUES
(1, 'Alice Green', 'Northern Hills'),
(2, 'Bob White', 'River Delta'),
(3, 'Carol King', 'Mountain Range');

--  data into species
INSERT INTO species (species_id, common_name, scientific_name, discovery_date, conservation_status) VALUES
(1, 'Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
(2, 'Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
(3, 'Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
(4, 'Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- data into sightings
INSERT INTO sightings (sighting_id, species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);


select * from rangers;
select * from species;  
select * from sightings;


--question 1:1️⃣ Register a new ranger with provided data with name = 'Derek Fox' and region = 'Coastal Plains'

INSERT INTO rangers (name, region) VALUES ('Derek Fox', 'Coastal Plains');

--question 2:2️⃣ Count unique species ever sighted.

SELECT COUNT(DISTINCT species_id) FROM sightings;

--question 3:3️⃣ Find all sightings where the location includes "Pass".

SELECT * FROM sightings WHERE location LIKE '%Pass%';

--question 4:4️⃣ List each ranger's name and their total number of sightings.
SELECT ranger.name AS ranger_name, COUNT(sighting.sighting_id) AS total_sightings
FROM rangers AS ranger
JOIN sightings AS sighting ON ranger.ranger_id = sighting.ranger_id
GROUP BY ranger.name;



--question 5:5️⃣ List species that have never been sighted.
SELECT species.common_name, species.scientific_name
FROM species 
LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE sightings.sighting_id IS NULL;

--question 6:6️⃣Show the most recent 2 sightings.
SELECT * FROM sightings ORDER BY sighting_time DESC LIMIT 2;

--question 7:7️⃣ Update all species discovered before year 1800 to have status 'Historic'.
UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date < '1800-01-01';

--question 8:8️⃣ Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.
SELECT sighting_id, 
       CASE 
           WHEN EXTRACT(HOUR FROM sighting_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sighting_time) < 18 THEN 'Afternoon'
           ELSE 'Evening'
       END AS time_of_day
FROM sightings;

--question 9: Delete rangers who have never sighted any species.
DELETE FROM rangers
WHERE ranger_id NOT IN (SELECT DISTINCT ranger_id FROM sightings);              