-- Conference leadership fields
ALTER TABLE conferences
  ADD COLUMN conference_president VARCHAR(255) NULL AFTER conference_name,
  ADD COLUMN conference_director VARCHAR(255) NULL AFTER conference_president;

-- Event analytics fields (attendance)
ALTER TABLE events
  ADD COLUMN conference_id INT NULL AFTER event_id,
  ADD COLUMN attendance_count INT NOT NULL DEFAULT 0 AFTER description;

-- Media gallery table
CREATE TABLE IF NOT EXISTS media_items (
    media_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    media_type ENUM('image','video','audio') NOT NULL,
    category VARCHAR(120) NULL,
    tags VARCHAR(255) NULL,
    event_tag VARCHAR(120) NULL,
    person_tag VARCHAR(120) NULL,
    media_year INT NULL,
    description TEXT NULL,
    file_path VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Legacy leaders table
CREATE TABLE IF NOT EXISTS legacy_leaders (
    leader_id INT AUTO_INCREMENT PRIMARY KEY,
    role_type ENUM('Bishop','Director','President','Mother Director','Other') NOT NULL DEFAULT 'Other',
    full_name VARCHAR(255) NOT NULL,
    conference_name VARCHAR(255) NULL,
    start_year INT NULL,
    end_year INT NULL,
    descriptions TEXT NULL,
    achievements TEXT NULL,
    photo_path VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add photo_path column if it doesn't exist
ALTER TABLE legacy_leaders
  ADD COLUMN IF NOT EXISTS photo_path VARCHAR(255) NULL AFTER achievements;

-- Milestones table
CREATE TABLE IF NOT EXISTS milestones (
    milestone_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    milestone_year INT NOT NULL,
    descriptions TEXT NULL,
    achievements TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Story pages
CREATE TABLE IF NOT EXISTS story_pages (
    story_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE,
    story_year INT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'draft',
    cover_media_id INT NULL,
    content LONGTEXT NULL,
    media_ids_json LONGTEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Event attendance breakdowns
CREATE TABLE IF NOT EXISTS event_attendance_breakdowns (
    breakdown_id INT AUTO_INCREMENT PRIMARY KEY,
    event_id INT NOT NULL,
    conference_id INT NULL,
    area_id INT NULL,
    church_id INT NULL,
    attendance_count INT NOT NULL DEFAULT 0,
    notes VARCHAR(255) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Import jobs and review queue
CREATE TABLE IF NOT EXISTS import_jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    job_type VARCHAR(60) NOT NULL,
    source_file_name VARCHAR(255) NULL,
    conference_id INT NULL,
    status VARCHAR(40) NOT NULL DEFAULT 'previewed',
    valid_count INT NOT NULL DEFAULT 0,
    invalid_count INT NOT NULL DEFAULT 0,
    inserted_count INT NOT NULL DEFAULT 0,
    skipped_count INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS import_review_queue (
    queue_id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    row_number INT NOT NULL,
    issue_reason VARCHAR(255) NOT NULL,
    row_json LONGTEXT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Soft delete recycle bin
CREATE TABLE IF NOT EXISTS deleted_items (
    deleted_id INT AUTO_INCREMENT PRIMARY KEY,
    entity_table VARCHAR(80) NOT NULL,
    entity_id INT NOT NULL,
    source_path VARCHAR(255) NULL,
    data_json LONGTEXT NOT NULL,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    restored_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
