-- Create table
CREATE TABLE IF NOT EXISTS messages (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL
);

-- Insert initial data
INSERT INTO messages (content) VALUES ('Hello World') ON CONFLICT DO NOTHING;
