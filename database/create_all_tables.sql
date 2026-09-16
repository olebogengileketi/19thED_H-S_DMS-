-- ============================================================
-- 19edypd_db — Full Schema (Clean Create)
-- Generated: 2026-08-11
--
-- This file consolidates:
--   • rebuild_all_tables.sql
--   • recreate_members.sql
--   • schema_updates.sql
--   • includes/feature_tables.php (add_column_if_missing calls)
--   • CSV columns: Conference_Name, Member_No., Church name, Area,
--     Name, Surname, Date_of_Birth, Age, Gender, Component,
--     Joined_Member_of_the_YPD, Robed, Year_Robed,
--     Full_Member_of_the_Church, Eligible_to_Vote_at_Episcopal,
--     Elligible_to_vote_at_Conference, Occupational_Status,
--     Contact details
--
-- Safe to run on a fresh / empty database.
-- Drop order respects foreign-key dependencies (none are declared
-- with FK constraints in this project, but logical order is kept).
-- ============================================================

CREATE DATABASE IF NOT EXISTS `19edypd_db`
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE `19edypd_db`;

SET foreign_key_checks = 0;

-- ============================================================
-- Drop all tables (clean slate)
-- ============================================================
DROP TABLE IF EXISTS import_review_queue;
DROP TABLE IF EXISTS import_jobs;
DROP TABLE IF EXISTS event_attendance_breakdowns;
DROP TABLE IF EXISTS deleted_items;
DROP TABLE IF EXISTS story_pages;
DROP TABLE IF EXISTS milestones;
DROP TABLE IF EXISTS legacy_leaders;
DROP TABLE IF EXISTS media_items;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS churches;
DROP TABLE IF EXISTS areas;
DROP TABLE IF EXISTS conferences;
DROP TABLE IF EXISTS episcopal_districts;

-- ============================================================
-- 1. episcopal_districts
-- ============================================================
CREATE TABLE episcopal_districts (
    district_id   INT AUTO_INCREMENT PRIMARY KEY,
    district_name VARCHAR(255) NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed the 19th district row so all FK defaults resolve
INSERT INTO episcopal_districts (district_id, district_name)
VALUES (19, '19th Episcopal District');

-- ============================================================
-- 2. conferences
--    CSV column: Conference_Name
--    Added via schema_updates.sql: conference_president,
--    conference_director
-- ============================================================
CREATE TABLE conferences (
    conference_id        INT AUTO_INCREMENT PRIMARY KEY,
    district_id          INT NOT NULL DEFAULT 19,
    conference_name      VARCHAR(255) NOT NULL,
    conference_president VARCHAR(255) NULL,
    conference_director  VARCHAR(255) NULL,
    created_at           TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 3. areas
--    CSV column: Area
-- ============================================================
CREATE TABLE areas (
    area_id             INT AUTO_INCREMENT PRIMARY KEY,
    district_id         INT NOT NULL DEFAULT 19,
    conference_id       INT NULL,
    area_name           VARCHAR(255) NULL,
    area_president_name VARCHAR(255) NULL,
    area_director_name  VARCHAR(255) NULL,
    created_at          TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 4. churches
--    CSV column: Church name
-- ============================================================
CREATE TABLE churches (
    church_id                   INT AUTO_INCREMENT PRIMARY KEY,
    district_id                 INT NOT NULL DEFAULT 19,
    conference_id               INT NULL,
    area_id                     INT NULL,
    local_church_name           VARCHAR(255) NOT NULL,
    local_church_president_name VARCHAR(255) NULL,
    local_church_director_name  VARCHAR(255) NULL,
    status                      VARCHAR(20) NOT NULL DEFAULT 'active',
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 5. members
--    Full column set matching the CSV export:
--      Conference_Name       → conference_id (FK lookup)
--      Member_No.            → member_no
--      Church name           → church_id  (FK lookup)
--      Area                  → area_id    (FK lookup)
--      Name                  → name
--      Surname               → surname_name
--      Date_of_Birth         → dob
--      Age                   → (calculated, not stored)
--      Gender                → gender
--      Component             → component
--      Joined_Member_of_the_YPD    → joined_ypd
--      Robed                       → robbed
--      Year_Robed                  → year_robbed
--      Full_Member_of_the_Church   → full_member_of_church
--      Eligible_to_Vote_at_Episcopal        → eligible_to_vote_episcopal
--      Elligible_to_vote_at_Conference      → eligible_to_vote_conference
--      Occupational_Status         → occupational_status
--      Contact details             → contact
--
--    Columns added by schema_updates / feature_tables patches:
--      member_no, joined_ypd, full_member_of_church, occupational_status
-- ============================================================
CREATE TABLE members (
    member_id                   INT AUTO_INCREMENT PRIMARY KEY,
    district_id                 INT NOT NULL DEFAULT 19,
    conference_id               INT NULL,
    area_id                     INT NULL,
    church_id                   INT NULL,
    member_no                   VARCHAR(30)  NULL    COMMENT 'Member_No. from CSV',
    name                        VARCHAR(120) NOT NULL,
    surname_name                VARCHAR(120) NOT NULL,
    gender                      ENUM('M','F') NULL,
    dob                         DATE NULL,
    current_status              VARCHAR(60)  NOT NULL DEFAULT 'Other',
    occupational_status         VARCHAR(60)  NULL    COMMENT 'Occupational_Status from CSV',
    component                   ENUM('MB','AS','Y','YA') NULL,
    joined_ypd                  ENUM('Yes','No') NULL COMMENT 'Joined_Member_of_the_YPD',
    full_member_of_church       ENUM('Yes','No') NULL COMMENT 'Full_Member_of_the_Church',
    eligible_to_vote_conference ENUM('Yes','No') NOT NULL DEFAULT 'No',
    eligible_to_vote_episcopal  ENUM('Yes','No') NOT NULL DEFAULT 'No',
    robbed                      ENUM('Yes','No') NOT NULL DEFAULT 'No',
    year_robbed                 INT NULL,
    contact                     VARCHAR(30)  NULL,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at                  DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 6. events
--    Added via schema_updates.sql: conference_id,
--    attendance_count, episcopal_district_id
-- ============================================================
CREATE TABLE events (
    event_id              INT AUTO_INCREMENT PRIMARY KEY,
    episcopal_district_id INT NULL DEFAULT 19,
    conference_id         INT NULL,
    event_name            VARCHAR(255) NOT NULL,
    event_date            DATE NULL,
    location              VARCHAR(255) NULL,
    description           TEXT NULL,
    attendance_count      INT NOT NULL DEFAULT 0,
    created_at            TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 7. event_attendance_breakdowns
-- ============================================================
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

-- ============================================================
-- 8. media_items
--    Added via feature_tables patches: tags, event_tag,
--    person_tag, media_year, deleted_at
-- ============================================================
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

-- ============================================================
-- 9. legacy_leaders
-- ============================================================
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

-- ============================================================
-- 10. milestones
-- ============================================================
CREATE TABLE milestones (
    milestone_id   INT AUTO_INCREMENT PRIMARY KEY,
    title          VARCHAR(255) NOT NULL,
    milestone_year INT NOT NULL,
    descriptions   TEXT NULL,
    achievements   TEXT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 11. story_pages
--     Added via feature_tables patches: status,
--     cover_media_id, deleted_at
-- ============================================================
CREATE TABLE story_pages (
    story_id       INT AUTO_INCREMENT PRIMARY KEY,
    title          VARCHAR(255) NOT NULL,
    slug           VARCHAR(255) NOT NULL,
    story_year     INT NULL,
    status         VARCHAR(20) NOT NULL DEFAULT 'draft',
    cover_media_id INT NULL,
    content        LONGTEXT NULL,
    media_ids_json LONGTEXT NULL,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at     DATETIME NULL,
    CONSTRAINT uq_story_slug UNIQUE (slug)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 12. import_jobs
-- ============================================================
CREATE TABLE import_jobs (
    job_id           INT AUTO_INCREMENT PRIMARY KEY,
    job_type         VARCHAR(60)  NOT NULL,
    source_file_name VARCHAR(255) NULL,
    conference_id    INT NULL,
    status           VARCHAR(40)  NOT NULL DEFAULT 'previewed',
    valid_count      INT NOT NULL DEFAULT 0,
    invalid_count    INT NOT NULL DEFAULT 0,
    inserted_count   INT NOT NULL DEFAULT 0,
    skipped_count    INT NOT NULL DEFAULT 0,
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at     DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
-- 13. import_review_queue
-- ============================================================
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

-- ============================================================
-- 14. deleted_items  (soft-delete recycle bin)
--     Added via feature_tables patches: source_path
-- ============================================================
CREATE TABLE deleted_items (
    deleted_id   INT AUTO_INCREMENT PRIMARY KEY,
    entity_table VARCHAR(80)   NOT NULL,
    entity_id    INT NOT NULL,
    source_path  VARCHAR(255) NULL,
    data_json    LONGTEXT NOT NULL,
    deleted_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    restored_at  DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================
SET foreign_key_checks = 1;
-- ============================================================

-- ============================================================
-- Verify — list all tables that were just created
-- ============================================================
SELECT TABLE_NAME, ENGINE, TABLE_COLLATION
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = '19edypd_db'
ORDER BY TABLE_NAME;
