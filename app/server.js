const express = require('express');
const { Pool } = require('pg');
const favicon = require('serve-favicon');
const fs = require('fs');
const app = express();
const path = require('path');
const PORT = process.env.PORT || 8080;

app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));

// Configure dotenv
require('dotenv').config();

const pool = new Pool({
    user: process.env.PGUSER,
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    password: process.env.PGPASSWORD,
    port: process.env.PGPORT,
});


// can increase security using ORM lib for db queries
const initDb = async () => {
    const sql = fs.readFileSync('./db/init_db.sql').toString();
    try {
        await pool.query(sql);
        console.log('Database initialized successfully');
    } catch (err) {
        console.error('Failed to initialize database:', err);
    }
};

app.get('/', async (req, res) => {
    try {
        const result = await pool.query('SELECT content FROM messages WHERE id = 1;');
        const message = result.rows[0].content;
        res.send(`<h1>${message}</h1>`);
    } catch (err) {
        console.error(err);
        res.send('Error fetching data');
    }
});

app.get('/health', async (req, res) => {
    try {
        let date = new Date();
        res.send(`<h1>${date.toUTCString()}</h1>`);
    } catch (err) {
        console.error(err);
        res.send('Error fetching data');
    }
});

app.listen(PORT, () => {
    console.log(`App running on port:${PORT}`);
    initDb(); // Initialize the database when the server starts
});
