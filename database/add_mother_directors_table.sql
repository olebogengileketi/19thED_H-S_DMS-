-- Mother Directors table for YPD Booklet
CREATE TABLE IF NOT EXISTS ypd_mother_directors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    conference_name VARCHAR(255) DEFAULT NULL,
    years_of_service VARCHAR(100) DEFAULT NULL,
    bio TEXT,
    achievements TEXT,
    photo_id INT DEFAULT NULL,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
