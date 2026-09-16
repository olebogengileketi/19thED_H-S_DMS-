<?php
require_once '../includes/access_control.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: ../index.php');
    exit;
}

$role = trim($_POST['role_type'] ?? 'Other');
$name = trim($_POST['full_name'] ?? '');
$conference = trim($_POST['conference_name'] ?? '');
$startYear = (int)($_POST['start_year'] ?? 0) ?: null;
$endYear = (int)($_POST['end_year'] ?? 0) ?: null;
$descriptions = trim($_POST['descriptions'] ?? '');
$achievements = trim($_POST['achievements'] ?? '');
$photoPath = null;

// Handle photo upload
if (isset($_FILES['photo']) && $_FILES['photo']['error'] === UPLOAD_ERR_OK) {
    $uploadDir = '../uploads/leaders/';
    if (!is_dir($uploadDir)) {
        mkdir($uploadDir, 0755, true);
    }
    $ext = pathinfo($_FILES['photo']['name'], PATHINFO_EXTENSION);
    $filename = uniqid('leader_') . '.' . $ext;
    $destination = $uploadDir . $filename;
    if (move_uploaded_file($_FILES['photo']['tmp_name'], $destination)) {
        $photoPath = 'uploads/leaders/' . $filename;
    }
}

if ($name === '') {
    header('Location: ../views/media.php?error=Leader name is required');
    exit;
}

$stmt = $pdo->prepare("INSERT INTO legacy_leaders (role_type, full_name, conference_name, start_year, end_year, descriptions, achievements, photo_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->execute([$role, $name, $conference ?: null, $startYear, $endYear, $descriptions ?: null, $achievements ?: null, $photoPath]);

header('Location: ../views/media.php?leader_added=1');
exit;

