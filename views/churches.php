<?php
require_once '../includes/access_control.php';
require_once '../includes/auth.php';
require_once '../includes/pagination.php';

$search  = $_GET['search']  ?? '';
$area_id = $_GET['area_id'] ?? '';
$status  = $_GET['status']  ?? '';
$conf_id = $_GET['conference_id'] ?? '';

$fromWhere = " FROM churches ch
               LEFT JOIN areas a ON ch.area_id = a.area_id
               LEFT JOIN conferences c ON ch.conference_id = c.conference_id
               WHERE 1=1";
$params = [];

if ($search)  { $fromWhere .= " AND (ch.local_church_name LIKE ? OR ch.local_church_president_name LIKE ?)"; $params = array_merge($params, ["%$search%", "%$search%"]); }
if ($area_id) { $fromWhere .= " AND ch.area_id = ?";       $params[] = $area_id; }
if ($status)  { $fromWhere .= " AND ch.status = ?";        $params[] = $status; }
if ($conf_id) { $fromWhere .= " AND ch.conference_id = ?"; $params[] = $conf_id; }

$pager = paginate($pdo, "SELECT COUNT(*)" . $fromWhere, $params, 20);
$query = "SELECT ch.church_id, ch.local_church_name, ch.local_church_president_name, ch.local_church_director_name,
                 ch.status, a.area_name, c.conference_name,
                 (SELECT COUNT(*) FROM members m WHERE m.church_id = ch.church_id) AS member_count"
    . $fromWhere
    . " ORDER BY c.conference_name, a.area_name, ch.local_church_name
        LIMIT {$pager['perPage']} OFFSET {$pager['offset']}";
$stmt = $pdo->prepare($query);
$stmt->execute($params);
$churches = $stmt->fetchAll();

$areas = $pdo->query("SELECT area_id, area_name FROM areas ORDER BY area_name")->fetchAll();
$conferences = $pdo->query("SELECT conference_id, conference_name FROM conferences ORDER BY conference_name")->fetchAll();

// Aggregate data for charts
$churches_by_conference = $pdo->query(
    "SELECT COALESCE(c.conference_name, 'Unassigned') AS conference_name, COUNT(ch.church_id) AS cnt
     FROM churches ch
     LEFT JOIN conferences c ON ch.conference_id = c.conference_id
     GROUP BY c.conference_id, c.conference_name
     ORDER BY cnt DESC"
)->fetchAll(PDO::FETCH_ASSOC);

$status_rows = $pdo->query("SELECT COALESCE(status,'unknown') AS status, COUNT(*) AS cnt FROM churches GROUP BY status")->fetchAll(PDO::FETCH_ASSOC);

$chart_conf_labels = array_column($churches_by_conference, 'conference_name');
$chart_conf_data   = array_map(fn($r)=> (int)$r['cnt'], $churches_by_conference);

$chart_status_labels = array_map(fn($r)=> $r['status'], $status_rows);
$chart_status_data   = array_map(fn($r)=> (int)$r['cnt'], $status_rows);

// All churches (name + member count) for line chart
$all_churches_rows = $pdo->query(
    "SELECT ch.local_church_name AS name, (SELECT COUNT(*) FROM members m WHERE m.church_id = ch.church_id) AS member_count
     FROM churches ch
     ORDER BY ch.local_church_name ASC"
)->fetchAll(PDO::FETCH_ASSOC);

$chart_all_labels = array_map(fn($r)=> $r['name'], $all_churches_rows);
$chart_all_data   = array_map(fn($r)=> (int)$r['member_count'], $all_churches_rows);
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Churches — 19th Episcopal District</title>
  <link rel="icon" type="image/png" href="../19thDistrict.png">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <link rel="stylesheet" href="../assets/css/styles.css">
</head>
<body>
<?php include '../includes/header.php'; ?>

<div class="container-fluid mt-4 px-4">
  <div class="d-flex justify-content-between align-items-center mb-3">
    <h5 class="fw-bold text-success mb-0"><i class="fas fa-church me-2"></i>Churches</h5>
    <div class="d-flex gap-2">
      <a href="../actions/export.php?<?= http_build_query(['type' => 'churches', 'conference_id' => $conf_id]) ?>" class="btn btn-outline-success btn-sm js-confirm-export"><i class="fas fa-file-csv me-1"></i>Export CSV</a>
      <a href="../forms/add_church.php" class="btn btn-success btn-sm"><i class="fas fa-plus me-1"></i>Add Church</a>
    </div>
  </div>

  <?php if (isset($_GET['success'])): ?><div class="alert alert-success alert-dismissible py-2">Church added! <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><?php endif; ?>
  <?php if (isset($_GET['updated'])): ?><div class="alert alert-info alert-dismissible py-2">Church updated. <button type="button" class="btn-close" data-bs-dismiss="alert"></button></div><?php endif; ?>
  <?php if (isset($_GET['deleted']) && isset($_GET['deleted_item_id'])): ?><div class="alert alert-warning py-2">Church deleted. <a href="../actions/restore_deleted.php?id=<?= (int)$_GET['deleted_item_id'] ?>">Undo</a></div><?php endif; ?>

  <form method="GET" class="row g-2 mb-3">
    <div class="col-md-3">
      <input type="text" name="search" class="form-control form-control-sm" placeholder="Search church / president" value="<?= htmlspecialchars($search) ?>">
    </div>
    <div class="col-md-2">
      <select name="area_id" class="form-select form-select-sm">
        <option value="">-- Area --</option>
        <?php foreach ($areas as $a): ?>
          <option value="<?= $a['area_id'] ?>" <?= $area_id==$a['area_id']?'selected':'' ?>><?= htmlspecialchars($a['area_name']) ?></option>
        <?php endforeach; ?>
      </select>
    </div>
    <div class="col-md-2">
      <select name="conference_id" class="form-select form-select-sm">
        <option value="">-- Conference --</option>
        <?php foreach ($conferences as $c): ?>
          <option value="<?= $c['conference_id'] ?>" <?= $conf_id==$c['conference_id']?'selected':'' ?>><?= htmlspecialchars($c['conference_name']) ?></option>
        <?php endforeach; ?>
      </select>
    </div>
    <div class="col-md-2">
      <select name="status" class="form-select form-select-sm">
        <option value="">-- Status --</option>
        <option value="active"   <?= $status==='active'  ?'selected':'' ?>>Active</option>
        <option value="inactive" <?= $status==='inactive'?'selected':'' ?>>Inactive</option>
      </select>
    </div>
    <div class="col-auto">
      <button type="submit" class="btn btn-primary btn-sm">Filter</button>
      <a href="churches.php" class="btn btn-secondary btn-sm">Reset</a>
    </div>
  </form>

  <div class="card shadow-sm">
    <div class="card-body p-0">
      <table class="table table-bordered table-hover table-sm mb-0">
        <thead class="table-success">
          <tr><th>#</th><th>Church</th><th>Conference</th><th>Area</th><th>President</th><th>Director</th><th>Members</th><th>Status</th><th>Actions</th></tr>
        </thead>
        <tbody>
          <?php if (empty($churches)): ?>
            <tr><td colspan="9" class="text-center text-muted py-3">No churches found.</td></tr>
          <?php else: foreach ($churches as $i => $ch): ?>
            <tr>
              <td><?= $pager['offset'] + $i + 1 ?></td>
              <td><?= htmlspecialchars($ch['local_church_name']) ?></td>
              <td><?= htmlspecialchars($ch['conference_name'] ?? '—') ?></td>
              <td><?= htmlspecialchars($ch['area_name'] ?? '—') ?></td>
              <td><?= htmlspecialchars($ch['local_church_president_name'] ?? '—') ?></td>
              <td><?= htmlspecialchars($ch['local_church_director_name'] ?? '—') ?></td>
              <td><?= $ch['member_count'] ?></td>
              <td><span class="badge bg-<?= $ch['status']==='active'?'success':'secondary' ?>"><?= $ch['status'] ?></span></td>
              <td>
                <a href="../forms/edit_church.php?id=<?= $ch['church_id'] ?>" class="btn btn-warning btn-sm">Edit</a>
                <a href="../actions/delete_church.php?id=<?= $ch['church_id'] ?>" class="btn btn-danger btn-sm js-confirm-delete">Del</a>
              </td>
            </tr>
          <?php endforeach; endif; ?>
        </tbody>
      </table>
    </div>
    <div class="card-footer d-flex justify-content-between align-items-center">
      <span class="text-muted small">Total: <?= $pager['total'] ?> church(es)</span>
      <?= render_pagination($pager) ?>
    </div>
  </div>
</div>

<div class="container-fluid px-4">
  <!-- Charts (moved after table, constrained height for performance) -->
  <div class="row mb-3">
    <div class="col-md-6">
      <div class="card shadow-sm chart-card">
        <div class="card-body p-2" style="height:220px;">
          <h6 class="card-title small mb-2">Churches by Conference</h6>
          <canvas id="chartConf" style="width:100%;height:100%;"></canvas>
        </div>
      </div>
    </div>

  </div>

  <div class="row mb-3">
    <div class="col-12">
      <div class="card shadow-sm chart-card">
        <div class="card-body p-2" style="height:300px;">
          <h6 class="card-title small mb-2">All Churches — Member count</h6>
          <canvas id="chartAllChurches" style="width:100%;height:100%;"></canvas>
        </div>
      </div>
    </div>
  </div>

<?php include '../includes/footer.php'; ?>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
// Chart data from server
const confLabels = <?= json_encode($chart_conf_labels) ?>;
const confData   = <?= json_encode($chart_conf_data) ?>;
// Churches by conference - bar chart
const ctxConf = document.getElementById('chartConf');
if (ctxConf) {
  new Chart(ctxConf, {
    type: 'bar',
    data: {
      labels: confLabels,
      datasets: [{
        label: 'Churches',
        data: confData,
        backgroundColor: 'rgba(54,162,235,0.6)',
        borderColor: 'rgba(54,162,235,1)',
        borderWidth: 1,
        maxBarThickness: 56
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: { duration: 0 },
      plugins: { legend: { display: false } },
      scales: { y: { beginAtZero: true, ticks: { precision:0 } } }
    }
  });
}

// All churches - line chart (may be many points; optimize for performance)
const allLabels = <?= json_encode($chart_all_labels) ?>;
const allData   = <?= json_encode($chart_all_data) ?>;
const ctxAll = document.getElementById('chartAllChurches');
if (ctxAll) {
  new Chart(ctxAll, {
    type: 'line',
    data: {
      labels: allLabels,
      datasets: [{
        label: 'Members',
        data: allData,
        fill: false,
        borderColor: 'rgba(75,192,192,0.9)',
        backgroundColor: 'rgba(75,192,192,0.5)',
        pointRadius: 2,
        pointHoverRadius: 4,
        tension: 0.25
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      animation: { duration: 0 },
      elements: { point: { radius: 0 } },
      scales: {
        x: { display: false }, // hide dense x labels for readability
        y: { beginAtZero: true, ticks: { precision: 0 } }
      },
      plugins: { legend: { display: false }, tooltip: { mode: 'index', intersect: false } }
    }
  });
}
</script>
</body>
</html>
