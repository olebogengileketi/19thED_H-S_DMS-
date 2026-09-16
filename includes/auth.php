<?php

/**
 * Simplified Authentication Functions
 * Minimalistic authentication without CSRF tokens and complex session management
 */

require_once __DIR__ . '/url_helper.php';

function ensure_session_started(): void
{
    if (session_status() !== PHP_SESSION_ACTIVE) {
        session_start();
    }
}

function current_auth_user(): ?array
{
    ensure_session_started();
    return isset($_SESSION['auth_user']) && is_array($_SESSION['auth_user']) ? $_SESSION['auth_user'] : null;
}

function require_auth(): void
{
    ensure_session_started();
    $user = current_auth_user();
    if (!$user) {
        header('Location: ' . base_url('login.php'));
        exit;
    }
}

function require_role(string $allowedRole): void
{
    require_auth();
    $user = current_auth_user();
    if (!$user || $user['role'] !== $allowedRole) {
        http_response_code(403);
        exit('Access denied: insufficient permissions');
    }
}

function require_conference_admin(int $conferenceId): void
{
    require_auth();
    $user = current_auth_user();
    if ($user['role'] === 'superadmin') return;
    if ($user['role'] === 'conference_admin' && (int)$user['conference_id'] === $conferenceId) return;
    http_response_code(403);
    exit('Access denied: you do not manage this conference');
}

