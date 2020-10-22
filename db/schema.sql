CREATE DATABASE sportsgif_db;

CREATE TABLE gifs (
    id SERIAL PRIMARY KEY,
    description VARCHAR(100),
    gif_url TEXT,
    username TEXT,
    sport VARCHAR(25),
    athlete VARCHAR(50)
);

INSERT INTO gifs (description, gif_url, sport, athlete) VALUES ('Khabib post fight vs Mcgregor', 'https://media4.giphy.com/media/61UzwAfQrnSZnsZb2s/giphy.gif?cid=ecf05e47o274l9f4cr9kil0lm2q0r45rjquke2a5jrdut2um&rid=giphy.gif', 'mma', 'khabib');

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    user_id INTEGER,
    email TEXT,
    password_digest TEXT
);

ALTER TABLE users ADD COLUMN username VARCHAR(30);
