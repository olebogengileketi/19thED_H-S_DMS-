<?php

/**
 * Database Connection Wrapper
 * This file provides backward compatibility while using the new separated structure
 * For new code, use includes/database.php directly
 */

// Load database connection
$pdo = require __DIR__ . '/includes/database.php';
