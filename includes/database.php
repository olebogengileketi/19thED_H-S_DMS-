<?php

/**
 * Database Connection Handler
 * This file handles all database connections using centralized configuration
 * No authentication logic - pure database connection management
 */

// Load configuration
$config = require __DIR__ . '/../config.php';

// Get database configuration
$dbConfig = $config['db'];

// Build DSN
$dsn = "mysql:host={$dbConfig['host']};port={$dbConfig['port']};dbname={$dbConfig['name']};charset={$dbConfig['charset']}";

// Create PDO connection
try {
    $pdo = new PDO($dsn, $dbConfig['user'], $dbConfig['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, false);
} catch (PDOException $e) {
    // Fallback to basic error logging (error handler may not be loaded yet)
    error_log("Database connection failed: " . $e->getMessage());
    
    // Show user-friendly error if possible
    $errorMessage = "Database connection failed. Please check configuration.";
    if ($config['app']['debug']) {
        $errorMessage .= " Error: " . $e->getMessage();
    }
    die($errorMessage);
}

// Return the PDO instance
return $pdo;
