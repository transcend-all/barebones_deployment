-- init.sql
CREATE TABLE IF NOT EXISTS messages (
  id SERIAL PRIMARY KEY,
  content TEXT
);

INSERT INTO messages (content)
VALUES ('Hello from the Dockerized database!')
ON CONFLICT DO NOTHING;
