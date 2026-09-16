-- ============================================================
-- YPD History Booklet Integration - Migration Script
-- Adds YPD-specific tables to existing 19edypd_db
-- This script integrates the YPD booklet functionality into AdminDash
-- ============================================================

USE `19edypd_db`;

-- ============================================================
-- YPD Booklet Tables
-- ============================================================

-- Single-row table holding cover / foreword / district identity info
CREATE TABLE IF NOT EXISTS ypd_booklet_meta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    district_name TEXT,
    booklet_title TEXT,
    subtitle TEXT,
    foreword TEXT,
    historiographer_name VARCHAR(255),
    cover_photo_id INT,
    published_year INT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_cover_photo (cover_photo_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- History narrative — long-form chapter content, chronologically or thematically grouped
CREATE TABLE IF NOT EXISTS ypd_history_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    era_label VARCHAR(120),
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_sort_order (sort_order),
    INDEX idx_era_label (era_label)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Officers / leadership roster (can reference existing legacy_leaders)
CREATE TABLE IF NOT EXISTS ypd_officers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    position VARCHAR(150) NOT NULL,
    term_start VARCHAR(20),
    term_end VARCHAR(20),
    bio TEXT,
    photo_id INT,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_sort_order (sort_order),
    INDEX idx_photo_id (photo_id),
    INDEX idx_position (position)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Timeline / milestones (can link to existing milestones table)
CREATE TABLE IF NOT EXISTS ypd_timeline_events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_date VARCHAR(20) NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_event_date (event_date),
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Achievements / recognitions / notable projects
CREATE TABLE IF NOT EXISTS ypd_achievements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    achievement_date VARCHAR(20),
    category VARCHAR(100),
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_achievement_date (achievement_date),
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Statistics — for the historiographer/statistician side of the role
CREATE TABLE IF NOT EXISTS ypd_statistics (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(120) NOT NULL,
    label VARCHAR(150) NOT NULL,
    value REAL NOT NULL,
    unit VARCHAR(50),
    year INT,
    sort_order INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_year (year),
    INDEX idx_sort_order (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Photo gallery metadata (files stored in assets/uploads/ypd_photos via api_ypd/upload.php)
CREATE TABLE IF NOT EXISTS photos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    filename VARCHAR(255) NOT NULL,
    caption TEXT,
    related_type VARCHAR(50),
    related_id INT,
    uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================
-- Foreign Key Relationships (Optional - linking to existing AdminDash tables)
-- ============================================================

-- Link YPD officers photos to AdminDash media_items if desired
-- ALTER TABLE ypd_officers 
-- ADD CONSTRAINT fk_ypd_officers_media 
-- FOREIGN KEY (photo_id) REFERENCES media_items(media_id) 
-- ON DELETE SET NULL;

-- Link YPD timeline events to AdminDash milestones if desired
-- ALTER TABLE ypd_timeline_events 
-- ADD CONSTRAINT fk_ypd_timeline_milestones 
-- FOREIGN KEY (id) REFERENCES milestones(milestone_id) 
-- ON DELETE CASCADE;

-- ============================================================
-- Insert default meta row if none exists
-- ============================================================
INSERT INTO ypd_booklet_meta (district_name, booklet_title, subtitle, foreword, historiographer_name, published_year)
SELECT '19th Episcopal District', 'Grow, Glow, and Go: A History of the YPD', 'Young People\'s Division — 19th Episcopal District, AME Church', 
'This booklet preserves the story of our District\'s Young People\'s Division — its leaders, milestones, and the young people who carried its mission forward. Compiled and maintained by the Office of the Historiographer/Statistician.', 
'Michelle Williams', YEAR(CURRENT_DATE)
WHERE NOT EXISTS (SELECT 1 FROM ypd_booklet_meta WHERE id = 1);

-- ============================================================
-- Verification - List all YPD tables
-- ============================================================
SELECT TABLE_NAME, ENGINE, TABLE_COLLATION
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = '19edypd_db' 
AND TABLE_NAME LIKE 'ypd_%'
ORDER BY TABLE_NAME;