-- ============================================================
-- Full schema rebuild for 19edypd_db
-- Run this AFTER deleting all .ibd/.frm files from:
--   /Applications/XAMPP/xamppfiles/var/mysql/19edypd_db/
-- ============================================================

USE 19edypd_db;

SET foreign_key_checks = 0;

DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS churches;
DROP TABLE IF EXISTS areas;
DROP TABLE IF EXISTS conferences;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS event_attendance_breakdowns;
DROP TABLE IF EXISTS episcopal_districts;
DROP TABLE IF EXISTS media_items;
DROP TABLE IF EXISTS legacy_leaders;
DROP TABLE IF EXISTS milestones;
DROP TABLE IF EXISTS story_pages;
DROP TABLE IF EXISTS import_jobs;
DROP TABLE IF EXISTS import_review_queue;
DROP TABLE IF EXISTS deleted_items;

-- ----------------------------------------------------------------
-- episcopal_districts
-- ----------------------------------------------------------------
CREATE TABLE episcopal_districts (
    district_id   INT AUTO_INCREMENT PRIMARY KEY,
    district_name VARCHAR(255) NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO episcopal_districts (district_id, district_name) VALUES (19, '19th Episcopal District');

-- ----------------------------------------------------------------
-- conferences
-- ----------------------------------------------------------------
CREATE TABLE conferences (
    conference_id       INT AUTO_INCREMENT PRIMARY KEY,
    district_id         INT NOT NULL DEFAULT 19,
    conference_name     VARCHAR(255) NOT NULL,
    conference_president VARCHAR(255) NULL,
    conference_director  VARCHAR(255) NULL,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- areas
-- ----------------------------------------------------------------
CREATE TABLE areas (
    area_id               INT AUTO_INCREMENT PRIMARY KEY,
    district_id           INT NOT NULL DEFAULT 19,
    conference_id         INT NULL,
    area_name             VARCHAR(255) NULL,
    area_president_name   VARCHAR(255) NULL,
    area_director_name    VARCHAR(255) NULL,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- churches
-- ----------------------------------------------------------------
CREATE TABLE churches (
    church_id                     INT AUTO_INCREMENT PRIMARY KEY,
    district_id                   INT NOT NULL DEFAULT 19,
    conference_id                 INT NULL,
    area_id                       INT NULL,
    local_church_name             VARCHAR(255) NOT NULL,
    local_church_president_name   VARCHAR(255) NULL,
    local_church_director_name    VARCHAR(255) NULL,
    status                        VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at                    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- members
-- ----------------------------------------------------------------
CREATE TABLE members (
    member_id                   INT AUTO_INCREMENT PRIMARY KEY,
    district_id                 INT NOT NULL DEFAULT 19,
    conference_id               INT NULL,
    area_id                     INT NULL,
    church_id                   INT NULL,
    member_no                   VARCHAR(30) NULL COMMENT 'Member_No. from CSV',
    name                        VARCHAR(120) NOT NULL,
    surname_name                VARCHAR(120) NOT NULL,
    gender                      ENUM('M','F') NULL,
    dob                         DATE NULL,
    contact                     VARCHAR(30) NULL,
    current_status              VARCHAR(60) NOT NULL DEFAULT 'Other',
    occupational_status         VARCHAR(60) NULL COMMENT 'Occupational_Status from CSV',
    component                   ENUM('MB','AS','Y','YA') NULL,
    joined_ypd                  ENUM('Yes','No') NULL COMMENT 'Joined_Member_of_the_YPD',
    full_member_of_church       ENUM('Yes','No') NULL COMMENT 'Full_Member_of_the_Church',
    eligible_to_vote_conference ENUM('Yes','No') NOT NULL DEFAULT 'No',
    eligible_to_vote_episcopal  ENUM('Yes','No') NOT NULL DEFAULT 'No',
    robbed                      ENUM('Yes','No') NOT NULL DEFAULT 'No',
    year_robbed                 INT NULL,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at                  DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- events
-- ----------------------------------------------------------------
CREATE TABLE events (
    event_id               INT AUTO_INCREMENT PRIMARY KEY,
    episcopal_district_id  INT NULL DEFAULT 19,
    conference_id          INT NULL,
    event_name             VARCHAR(255) NOT NULL,
    event_date             DATE NULL,
    location               VARCHAR(255) NULL,
    description            TEXT NULL,
    attendance_count       INT NOT NULL DEFAULT 0,
    created_at             TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- event_attendance_breakdowns
-- ----------------------------------------------------------------
CREATE TABLE event_attendance_breakdowns (
    breakdown_id     INT AUTO_INCREMENT PRIMARY KEY,
    event_id         INT NOT NULL,
    conference_id    INT NULL,
    area_id          INT NULL,
    church_id        INT NULL,
    attendance_count INT NOT NULL DEFAULT 0,
    notes            VARCHAR(255) NULL,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- media_items
-- ----------------------------------------------------------------
CREATE TABLE media_items (
    media_id    INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(255) NOT NULL,
    media_type  ENUM('image','video','audio') NOT NULL,
    category    VARCHAR(120) NULL,
    tags        VARCHAR(255) NULL,
    event_tag   VARCHAR(120) NULL,
    person_tag  VARCHAR(120) NULL,
    media_year  INT NULL,
    description TEXT NULL,
    file_path   VARCHAR(255) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at  DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- legacy_leaders
-- ----------------------------------------------------------------
CREATE TABLE legacy_leaders (
    leader_id       INT AUTO_INCREMENT PRIMARY KEY,
    role_type       ENUM('Bishop','Director','President','Mother Director','Other') NOT NULL DEFAULT 'Other',
    full_name       VARCHAR(255) NOT NULL,
    conference_name VARCHAR(255) NULL,
    start_year      INT NULL,
    end_year        INT NULL,
    descriptions    TEXT NULL,
    achievements    TEXT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- milestones
-- ----------------------------------------------------------------
CREATE TABLE milestones (
    milestone_id  INT AUTO_INCREMENT PRIMARY KEY,
    title         VARCHAR(255) NOT NULL,
    milestone_year INT NOT NULL,
    descriptions  TEXT NULL,
    achievements  TEXT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- story_pages
-- ----------------------------------------------------------------
CREATE TABLE story_pages (
    story_id       INT AUTO_INCREMENT PRIMARY KEY,
    title          VARCHAR(255) NOT NULL,
    slug           VARCHAR(255) NOT NULL UNIQUE,
    story_year     INT NULL,
    status         VARCHAR(20) NOT NULL DEFAULT 'draft',
    cover_media_id INT NULL,
    content        LONGTEXT NULL,
    media_ids_json LONGTEXT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at     DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- import_jobs
-- ----------------------------------------------------------------
CREATE TABLE import_jobs (
    job_id           INT AUTO_INCREMENT PRIMARY KEY,
    job_type         VARCHAR(60) NOT NULL,
    source_file_name VARCHAR(255) NULL,
    conference_id    INT NULL,
    status           VARCHAR(40) NOT NULL DEFAULT 'previewed',
    valid_count      INT NOT NULL DEFAULT 0,
    invalid_count    INT NOT NULL DEFAULT 0,
    inserted_count   INT NOT NULL DEFAULT 0,
    skipped_count    INT NOT NULL DEFAULT 0,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at     DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- import_review_queue
-- ----------------------------------------------------------------
CREATE TABLE import_review_queue (
    queue_id     INT AUTO_INCREMENT PRIMARY KEY,
    job_id       INT NOT NULL,
    row_number   INT NOT NULL,
    issue_reason VARCHAR(255) NOT NULL,
    row_json     LONGTEXT NULL,
    status       VARCHAR(30) NOT NULL DEFAULT 'pending',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at  DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- deleted_items
-- ----------------------------------------------------------------
CREATE TABLE deleted_items (
    deleted_id   INT AUTO_INCREMENT PRIMARY KEY,
    entity_table VARCHAR(80) NOT NULL,
    entity_id    INT NOT NULL,
    source_path  VARCHAR(255) NULL,
    data_json    LONGTEXT NOT NULL,
    deleted_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    restored_at  DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET foreign_key_checks = 1;

-- ----------------------------------------------------------------
-- Verify all tables created successfully
-- ----------------------------------------------------------------
SELECT TABLE_NAME, ENGINE, TABLE_ROWS
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = '19edypd_db'
ORDER BY TABLE_NAME;
