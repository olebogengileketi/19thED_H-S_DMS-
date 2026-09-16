<?php
require_once '../includes/access_control.php';
require_once '../includes/auth.php';

// Church list grouped by conference > area
$churches = $pdo->query("
    SELECT ch.church_id, ch.local_church_name, ch.status,
           a.area_name, c.conference_name,
           (SELECT COUNT(*) FROM members m WHERE m.church_id = ch.church_id) AS member_count
    FROM churches ch
    LEFT JOIN areas a ON ch.area_id = a.area_id
    LEFT JOIN conferences c ON ch.conference_id = c.conference_id
    ORDER BY c.conference_name, a.area_name, ch.local_church_name
")->fetchAll();

// Group by conference
$grouped = [];
foreach ($churches as $ch) {
    $grouped[$ch['conference_name']][$ch['area_name']][] = $ch;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Church List — 19th Episcopal District</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="../assets/css/styles.css">
</head>
<body>
<?php include '../includes/header.php'; ?>

<div class="container-fluid mt-4 px-4">
  <h5 class="fw-bold text-success mb-4"><i class="fas fa-list me-2"></i>Church List by Conference & Area</h5>

  <?php foreach ($grouped as $confName => $areas): ?>
    <h6 class="text-primary fw-semibold mt-3"><?= htmlspecialchars($confName) ?></h6>
    <?php foreach ($areas as $areaName => $chs): ?>
      <div class="ms-3 mb-3">
        <div class="text-muted small fw-semibold mb-1"><i class="fas fa-map-marker-alt me-1"></i><?= htmlspecialchars($areaName ?? 'No Area') ?></div>
        <table class="table table-sm table-bordered mb-0">
          <thead class="table-light"><tr><th>#</th><th>Church</th><th>Members</th><th>Status</th></tr></thead>
          <tbody>
            <?php foreach ($chs as $i => $ch): ?>
              <tr>
                <td><?= $i+1 ?></td>
                <td><?= htmlspecialchars($ch['local_church_name']) ?></td>
                <td><?= $ch['member_count'] ?></td>
                <td><span class="badge bg-<?= $ch['status']==='active'?'success':'secondary' ?>"><?= $ch['status'] ?></span></td>
              </tr>
            <?php endforeach; ?>
          </tbody>
        </table>
      </div>
    <?php endforeach; ?>
  <?php endforeach; ?>

  <?php if (empty($grouped)): ?>
    <p class="text-muted">No churches found.</p>
  <?php endif; ?>
</div>

<?php include '../includes/footer.php'; ?>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
