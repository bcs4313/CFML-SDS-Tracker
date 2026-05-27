<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<link rel="stylesheet" href="./manageRecords.css">

<div class="container mt-4" id="hazardDetail">
  <p class="text-muted">Loading hazard...</p>
</div>

<div class="mt-3">
  <button type="button" onclick="history.back()" class="btn btn-secondary">Back</button>
</div>

<script>
  function signalWordBadge(signalWord) {
    if (!signalWord) return '<span class="badge bg-secondary">N/A</span>';
    const word = signalWord.trim().toLowerCase();
    if (word === "danger")  return '<span class="badge bg-danger">Danger</span>';
    if (word === "warning") return '<span class="badge bg-warning text-dark">Warning</span>';
    return `<span class="badge bg-secondary">${signalWord}</span>`;
  }

  async function loadHazard() {
    const params = new URLSearchParams(window.location.search);
    const id = params.get("id");
    if (!id) {
      document.getElementById("hazardDetail").innerHTML =
        '<p class="text-danger">No hazard ID specified.</p>';
      return;
    }

    try {
      const endpoint = window.location.origin + "/rest/api/hazards/get?id=" + encodeURIComponent(id);
      const response = await fetch(endpoint);
      if (!response.ok) throw new Error("HTTP " + response.status);
      const h = await response.json();

      const pictogram = h.pictogramUrl
        ? `<img src="${h.pictogramUrl}" alt="GHS Pictogram" style="width:64px;height:64px;object-fit:contain;">`
        : "—";

      document.getElementById("hazardDetail").innerHTML = `
        <h4 class="mb-3">${h.name ?? "—"}</h4>
        <table class="table table-dark table-bordered" style="max-width:640px;">
          <tbody>
            <tr><th scope="row">ID</th><td>${h.id ?? "—"}</td></tr>
            <tr><th scope="row">GHS Hazard Class</th><td>${h.hazardClass || "—"}</td></tr>
            <tr><th scope="row">Signal Word</th><td>${signalWordBadge(h.signalWord)}</td></tr>
            <tr><th scope="row">Pictogram</th><td>${pictogram}</td></tr>
            <tr><th scope="row">H-Codes</th><td><code>${h.hCodes || "—"}</code></td></tr>
            <tr><th scope="row">P-Codes</th><td><code>${h.pCodes || "—"}</code></td></tr>
            <tr><th scope="row">Hazard Category</th><td>${h.hazardCategory || "—"}</td></tr>
            <tr><th scope="row">Exposure Routes</th><td>${h.exposureRoutes || "—"}</td></tr>
            <tr><th scope="row">UN Number</th><td>${h.unNumber || "—"}</td></tr>
          </tbody>
        </table>
      `;
    } catch (err) {
      console.error("loadHazard failed:", err);
      document.getElementById("hazardDetail").innerHTML =
        '<p class="text-danger">Failed to load hazard. Check the console for details.</p>';
    }
  }

  loadHazard();
</script>

<cfinclude template="/ui/shared/footer.cfm">
