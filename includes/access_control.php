<?php

/**
 * Access Control Wrapper
 * This file handles database connection only
 * Authentication should be loaded separately if needed
 */

// Load database connection
$pdo = require __DIR__ . '/database.php';

// Check if this is being accessed directly
if (basename($_SERVER['PHP_SELF']) === 'access_control.php') {
    http_response_code(403);
    die('Access denied: access_control.php is a configuration file and cannot be accessed directly.');
}
