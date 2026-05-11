const Database = require('better-sqlite3');
const path = require('path');
const fs = require('fs-extra');

const dbPath = path.join(__dirname, 'photos.db');
const db = new Database(dbPath);

// Initialize database
db.exec(`
  CREATE TABLE IF NOT EXISTS photos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    path TEXT NOT NULL UNIQUE,
    size INTEGER,
    mime_type TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
  )
`);

const insertPhoto = db.prepare('INSERT OR IGNORE INTO photos (name, path, size, mime_type) VALUES (?, ?, ?, ?)');
const getAllPhotos = db.prepare('SELECT * FROM photos ORDER BY created_at DESC');

const getPhotosFiltered = (filter) => {
    let query = 'SELECT * FROM photos';
    const params = [];
    
    if (filter && filter.name) {
        query += ' WHERE name LIKE ?';
        params.push(`%${filter.name}%`);
    }

    const sortField = filter?.sortBy || 'created_at';
    const sortOrder = filter?.order || 'DESC';
    query += ` ORDER BY ${sortField} ${sortOrder}`;

    return db.prepare(query).all(params);
};

module.exports = {
    db,
    insertPhoto,
    getAllPhotos,
    getPhotosFiltered
};
