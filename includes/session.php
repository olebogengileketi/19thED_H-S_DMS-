<?php

/**
 * Session Configuration and Initialization
 * This file handles session setup and security
 * No database connection - pure session management
 */

// Load configuration
$config = require __DIR__ . '/../config.php';

// Session security configuration
ini_set('session.use_strict_mode', 1);
ini_set('session.gc_maxlifetime', $config['security']['session_timeout']);

session_set_cookie_params([
    'lifetime' => $config['security']['session_timeout'],
    'path' => '/',
    'domain' => '',
    'secure' => false, // Set to true when using HTTPS
    'httponly' => true,
    'samesite' => 'Strict'
]);

// Start session if not already started
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}
