<?php

/**
 * Centralized configuration file
 * This file contains all configuration values
 * Update these values for different environments
 */

return [
    // Database configuration - Update for different hosting environments
    'db' => [
        'host' => '127.0.0.1',
        'port' => '3307',
        'name' => '19edypd_db',
        'user' => 'root',
        'pass' => '',
        'charset' => 'utf8mb4',
    ],
    
    // Application settings
    'app' => [
        'debug' => false,
        'name' => '19th Episcopal District AdminDash',
        'timezone' => 'UTC',
    ],
    
    // Security settings
    'security' => [
        'session_timeout' => 3600, // 1 hour in seconds
        'csrf_token_length' => 32,
        'password_min_length' => 8,
        'login_rate_limit' => [
            'attempts' => 5,
            'window' => 900, // 15 minutes in seconds
        ],
    ],
    
    // File upload settings
    'uploads' => [
        'max_file_size' => 52428800, // 50MB in bytes
        'allowed_images' => ['jpg', 'jpeg', 'png', 'gif', 'webp'],
        'allowed_videos' => ['mp4', 'webm', 'ogg', 'mov'],
        'allowed_audio' => ['mp3', 'wav', 'ogg', 'm4a'],
        'upload_dir' => __DIR__ . '/assets/uploads/media',
    ],
    
    // URL paths
    'urls' => [
        'base' => '/PhpstormProjects/19thepiscopaldistrict/AdminDash',
        'login' => '/PhpstormProjects/19thepiscopaldistrict/AdminDash/login.php',
        'home' => '/PhpstormProjects/19thepiscopaldistrict/AdminDash/index.php',
    ],
    
    // District information
    'district' => [
        'id' => 19,
        'name' => '19th Episcopal District',
    ],
];