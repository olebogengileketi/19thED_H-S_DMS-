-- Users table migration + superadmin seed
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('superadmin','conference_admin') NOT NULL DEFAULT 'conference_admin',
    conference_id INT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Default superadmin account:
-- username: superadmin
-- password: ChangeMe!123
INSERT INTO users (username, password_hash, role, conference_id, is_active)
SELECT 'superadmin', '$2y$12$q1eMlGiXzE00NpHZ1xAvGOeidlQW5VQo/isjdCS96OPyOJf9pPI/q', 'superadmin', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM users WHERE role = 'superadmin');

