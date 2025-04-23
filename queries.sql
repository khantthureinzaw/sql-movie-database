-- making sure empty values are stored as NULL in "movies" table
UPDATE "movies" SET "cinemascore" = NULL WHERE "cinemascore" = '';
UPDATE "movies" SET "budget_millions" = NULL WHERE "budget_millions" = '';
UPDATE "movies" SET "box_office_millions" = NULL WHERE "box_office_millions" = '';

-- making sure empty values are stored as NULL in "studios" table
UPDATE "studios" SET "ended" = NULL WHERE "ended" = '';

-- Find all the names of movies along with their genres ordered alphabetically by movie name
SELECT m."name" AS "movie", GROUP_CONCAT(g."name", ', ') AS "genres" FROM "movies" m
JOIN "movie_genres" mg ON m."id" = mg."movie_id"
JOIN "genres" g ON g."id" = mg."genre_id"
GROUP BY m."id"
ORDER BY m."name";

-- Find all movies by a specific director ordered by release date (oldest to newest)
SELECT m."name", m."release_date"
FROM "movies" m
JOIN "movie_directors" md ON md."movie_id" = m."id"
JOIN "directors" d ON d."id" = md."director_id"
WHERE d."first_name" = 'David' AND d."last_name" = 'Hand'
ORDER BY m."release_date";

-- Find the top 10 highest grossing movies
SELECT "name", "box_office_millions"
FROM "movies"
ORDER BY "box_office_millions" DESC
LIMIT 10;

-- Find all awards a movie has won or has been nominated for
SELECT m."name" AS "movie", a."name" AS "award", ma."type" AS "type"
FROM "movies" m
JOIN "movie_awards" ma ON ma."movie_id" = m."id"
JOIN "awards" a ON a."id" = ma."award_id"
ORDER BY m."name", ma."type" DESC;

-- Find all movies that are originals
SELECT m."name" AS "movie", s."name" AS "source"
FROM "movies" m
JOIN "movie_sources" ms ON ms."movie_id" = m."id"
JOIN "source_materials" s ON s."id" = ms."source_id"
WHERE s."name" = 'original';

-- Find the full movie info including studio, directors and genres
SELECT m."name" AS "movie",
       s."name" AS "studio",
       GROUP_CONCAT(DISTINCT d."first_name" || '' || d."last_name") AS "directors",
       GROUP_CONCAT(DISTINCT g."name") AS "genres"
FROM "movies" m
LEFT JOIN "studios" s ON s."id" = m."studio_id"
LEFT JOIN "movie_directors" md ON md."movie_id" = m."id"
LEFT JOIN "directors" d ON d."id" = md."director_id"
LEFT JOIN "movie_genres" mg ON mg."movie_id" = m."id"
LEFT JOIN "genres" g ON g."id" = mg."genre_id"
GROUP BY m."id"
ORDER BY m."name";

