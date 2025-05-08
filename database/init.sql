CREATE DATABASE minimal_app;
\c minimal_app
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL
);
INSERT INTO messages (content) VALUES ('Hello from the database!');
