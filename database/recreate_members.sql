-- Run this AFTER deleting the orphaned members.ibd file from the filesystem
-- and restarting XAMPP MySQL.

USE 19edypd_db;

SET foreign_key_checks = 0;

-- Drop the orphaned dictionary entry (safe after .ibd file is deleted)
DROP TABLE IF EXISTS members;

-- Recreate with full schema matching the application
CREATE TABLE members (
    member_id                   INT AUTO_INCREMENT PRIMARY KEY,
    district_id                 INT NOT NULL DEFAULT 19,
    conference_id               INT NULL,
    area_id                     INT NULL,
    church_id                   INT NULL,
    name                        VARCHAR(120) NOT NULL,
    surname_name                VARCHAR(120) NOT NULL,
    gender                      ENUM('M','F') NULL,
    dob                         DATE NULL,
    contact                     VARCHAR(30) NULL,
    current_status              VARCHAR(60) NOT NULL DEFAULT 'Other',
    component                   ENUM('MB','AS','Y','YA') NULL,
    eligible_to_vote_conference ENUM('Yes','No') NOT NULL DEFAULT 'No',
    eligible_to_vote_episcopal  ENUM('Yes','No') NOT NULL DEFAULT 'No',
    robbed                      ENUM('Yes','No') NOT NULL DEFAULT 'No',
    year_robbed                 INT NULL,
    created_at                  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deleted_at                  DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET foreign_key_checks = 1;

-- Verify
SHOW CREATE TABLE members\G
