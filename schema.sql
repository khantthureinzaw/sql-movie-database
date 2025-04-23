--Studios table
CREATE TABLE "studios" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE,
    "founded" INTEGER NOT NULL CHECK("founded" > 0),
    "ended" INTEGER
);

-- Directors table
CREATE TABLE "directors" (
    "id" INTEGER PRIMARY KEY,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL
);

-- Movies table
CREATE TABLE "movies" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE,
    "release_date" NUMERIC NOT NULL,
    "runtime_minutes" INTEGER NOT NULL,
    "budget_millions" NUMERIC,
    "box_office_millions" NUMERIC,
    "studio_id" INTEGER NOT NULL,
    "rotten_tomatoes_score" NUMERIC CHECK ("rotten_tomatoes_score" >= 0 AND "rotten_tomatoes_score" <= 100),
    "cinemascore" TEXT,
    FOREIGN KEY ("studio_id") REFERENCES "studios"("id")
);

-- Source materials table
CREATE TABLE "source_materials" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "creator" TEXT NOT NULL
);

-- Genres table
CREATE TABLE "genres" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE
);

-- Awards table
CREATE TABLE "awards" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE
);

-- Movie_directors table (junction table)
CREATE TABLE "movie_directors" (
    "movie_id" INTEGER,
    "director_id" INTEGER,
    PRIMARY KEY("movie_id", "director_id"),
    FOREIGN KEY ("movie_id") REFERENCES "movies"("id"),
    FOREIGN KEY ("director_id") REFERENCES "directors"("id")
);

-- Movie_genres table (junction table)
CREATE TABLE "movie_genres" (
    "movie_id" INTEGER,
    "genre_id" INTEGER,
    PRIMARY KEY ("movie_id", "genre_id"),
    FOREIGN KEY ("movie_id") REFERENCES "movies"("id"),
    FOREIGN KEY ("genre_id") REFERENCES "genres"("id")
);

-- Movie_sources table (junction table)
CREATE TABLE "movie_sources" (
    "movie_id" INTEGER,
    "source_id" INTEGER,
    PRIMARY KEY ("movie_id", "source_id"),
    FOREIGN KEY ("movie_id") REFERENCES "movies"("id"),
    FOREIGN KEY ("source_id") REFERENCES "source_materials"("id")
);

-- Movie_awards table (junction table)
CREATE TABLE "movie_awards" (
    "id" INTEGER,
    "movie_id" INTEGER,
    "award_id" INTEGER,
    "type" TEXT NOT NULL CHECK ("type" IN ('nominated', 'won')),
    PRIMARY KEY ("id"),
    FOREIGN KEY ("movie_id") REFERENCES "movies"("id"),
    FOREIGN KEY ("award_id") REFERENCES "awards"("id")
);

-- Indexes for foreign keys in movies
CREATE INDEX "idx_movies_studio_id" ON "movies"("studio_id");

-- Indexes for junction tables
CREATE INDEX "idx_movie_directors_movie_id" ON "movie_directors"("movie_id");
CREATE INDEX "idx_movie_directors_director_id" ON "movie_directors"("director_id");

CREATE INDEX "idx_movie_genres_movie_id" ON "movie_genres"("movie_id");
CREATE INDEX "idx_movie_genres_genre_id" ON "movie_genres"("genre_id");

CREATE INDEX "idx_movie_sources_movie_id" ON "movie_sources"("movie_id");
CREATE INDEX "idx_movie_sources_source_id" ON "movie_sources"("source_id");

CREATE INDEX "idx_movie_awards_movie_id" ON "movie_awards"("movie_id");
CREATE INDEX "idx_movie_awards_award_id" ON "movie_awards"("award_id");

-- Create indexes to speed common searches
CREATE INDEX "idx_directors_name" ON "directors"("last_name", "first_name");
CREATE INDEX "idx_movies_release_date" ON "movies"("release_date");
CREATE INDEX "idx_movies_box_office" ON "movies"("box_office_millions" DESC);
CREATE INDEX "idx_source_materials_name" ON "source_materials"("name");
CREATE INDEX "idx_movie_awards_type" ON "movie_awards"("type");
CREATE INDEX "idx_movies_name" ON "movies"("name");
