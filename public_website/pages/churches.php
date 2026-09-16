<?php
// Public view-only page for Church List (grouped by Conference > Area)
$churches = $pdo->query("
    SELECT ch.church_id, ch.local_church_name, ch.status,
           a.area_name, c.conference_name,
           (SELECT COUNT(*) FROM members m WHERE m.church_id = ch.church_id) AS member_count
    FROM churches ch
    LEFT JOIN areas a ON ch.area_id = a.area_id
    LEFT JOIN conferences c ON ch.conference_id = c.conference_id
    ORDER BY c.conference_name, a.area_name, ch.local_church_name
")->fetchAll();

$grouped = [];
foreach ($churches as $ch) {
    $grouped[$ch['conference_name'] ?? 'Unassigned'][$ch['area_name'] ?? 'No Area'][] = $ch;
}

$totalActive = 0;
$totalInactive = 0;
foreach ($churches as $ch) {
    $ch['status'] === 'active' ? $totalActive++ : $totalInactive++;
}

$confStats = [];
foreach ($grouped as $confName => $areas) {
    $confChurchCount = 0;
    $confMemberCount = 0;
    foreach ($areas as $chs) {
        foreach ($chs as $ch) {
            $confChurchCount++;
            $confMemberCount += $ch['member_count'];
        }
    }
    $confStats[$confName] = ['churches' => $confChurchCount, 'members' => $confMemberCount];
}

$chartConfLabels = array_keys($confStats);
$chartChurchCounts = array_map(fn($s) => $s['churches'], $confStats);
$chartMemberCounts = array_map(fn($s) => $s['members'], $confStats);
?>
<h5 class="fw-bold text-success mb-1"><i class="fas fa-church me-2"></i>Churches</h5>
<p class="text-muted small mb-4">All churches organized by conference and area across the district.</p>

<div class="row g-3 mb-4">
  <div class="col-md-4">
    <div class="card border-start border-success border-4 shadow-sm">
      <div class="card-body d-flex justify-content-between align-items-center">
        <div>
          <div class="text-muted small">Total Churches</div>
          <div class="fs-3 fw-bold"><?= count($churches) ?></div>
        </div>
        <i class="fas fa-church fa-2x text-success opacity-50"></i>
      </div>
    </div>
  </div>
  <div class="col-md-4">
    <div class="card border-start border-primary border-4 shadow-sm">
      <div class="card-body d-flex justify-content-between align-items-center">
        <div>
          <div class="text-muted small">Active</div>
          <div class="fs-3 fw-bold"><?= $totalActive ?></div>
        </div>
        <i class="fas fa-check-circle fa-2x text-primary opacity-50"></i>
      </div>
    </div>
  </div>
  <div class="col-md-4">
    <div class="card border-start border-secondary border-4 shadow-sm">
      <div class="card-body d-flex justify-content-between align-items-center">
        <div>
          <div class="text-muted small">Conferences</div>
          <div class="fs-3 fw-bold"><?= count($grouped) ?></div>
        </div>
        <i class="fas fa-sitemap fa-2x text-secondary opacity-50"></i>
      </div>
    </div>
  </div>
</div>

<?php foreach ($grouped as $confName => $areas): ?>
  <h6 class="text-primary fw-semibold mt-3 mb-2">
    <i class="fas fa-sitemap me-1"></i><?= h($confName) ?>
    <span class="badge bg-primary ms-1"><?= $confStats[$confName]['churches'] ?></span>
  </h6>
  <?php foreach ($areas as $areaName => $chs): ?>
    <div class="ms-3 mb-3">
      <div class="text-muted small fw-semibold mb-1"><i class="fas fa-map-marker-alt me-1"></i><?= h($areaName) ?></div>
      <div class="card shadow-sm">
        <div class="card-body p-0">
          <table class="table table-sm table-bordered mb-0">
            <thead class="table-light"><tr><th>#</th><th>Church</th><th>Members</th><th>Status</th></tr></thead>
            <tbody>
              <?php foreach ($chs as $i => $ch): ?>
                <tr>
                  <td><?= $i + 1 ?></td>
                  <td><?= h($ch['local_church_name']) ?></td>
                  <td><span class="badge bg-success"><?= $ch['member_count'] ?></span></td>
                  <td><span class="badge bg-<?= $ch['status']==='active'?'success':'secondary' ?>"><?= h($ch['status']) ?></span></td>
                </tr>
              <?php endforeach; ?>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  <?php endforeach; ?>
<?php endforeach; ?>

<?php if (empty($grouped)): ?>
  <div class="alert alert-info">No churches found.</div>
<?php endif; ?>

<div class="row g-3 mt-3 mb-4">
  <div class="col-lg-6">
    <div class="card shadow-sm">
      <div class="card-header bg-white fw-semibold text-success">Churches by Conference</div>
      <div class="card-body" style="height:300px;">
        <canvas id="confChurchChart"></canvas>
      </div>
    </div>
  </div>
  <div class="col-lg-6">
    <div class="card shadow-sm">
      <div class="card-header bg-white fw-semibold text-success">Members by Conference</div>
      <div class="card-body" style="height:300px;">
        <canvas id="confMemberChart"></canvas>
      </div>
    </div>
  </div>
</div>

<script>
const confLabels = <?= json_encode($chartConfLabels) ?>;
const churchCounts = <?= json_encode($chartChurchCounts) ?>;
const memberCounts = <?= json_encode($chartMemberCounts) ?>;

new Chart(document.getElementById('confChurchChart'), {
  type: 'bar',
  data: {
    labels: confLabels,
    datasets: [{
      label: 'Churches',
      data: churchCounts,
      backgroundColor: 'rgba(54,162,235,0.6)',
      borderColor: 'rgba(54,162,235,1)',
      borderWidth: 1,
      maxBarThickness: 64
    }]
  },
  options: {
    responsive: true, maintainAspectRatio: false,
    plugins: { legend: { display: false } },
    scales: { y: { beginAtZero: true, ticks: { precision: 0 } } }
  }
});

new Chart(document.getElementById('confMemberChart'), {
  type: 'line',
  data: {
    labels: confLabels,
    datasets: [{
      label: 'Members',
      data: memberCounts,
      borderColor: 'rgba(75,192,192,0.9)',
      backgroundColor: 'rgba(75,192,192,0.2)',
      tension: 0.2,
      pointRadius: 4
    }]
  },
  options: {
    responsive: true, maintainAspectRatio: false,
    plugins: { legend: { display: false } },
    scales: { y: { beginAtZero: true, ticks: { precision: 0 } } }
  }
});
</script>
