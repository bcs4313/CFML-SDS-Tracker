<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<link rel="stylesheet" href="./manageRecords.css">

<div class="container mt-4" id="chemicalDetail">
  <p class="text-muted">Loading chemical...</p>
</div>

<div class="mt-3">
  <button type="button" onclick="history.back()" class="btn btn-secondary">Back</button>
</div>

<script>
  async function loadChemical() {
    const params = new URLSearchParams(window.location.search);
    const id = params.get("id");
    if (!id) {
      document.getElementById("chemicalDetail").innerHTML =
        '<p class="text-danger">No chemical ID specified.</p>';
      return;
    }

    try {
      const endpoint = window.location.origin + "/rest/api/chemicals/get?id=" + encodeURIComponent(id);
      const response = await fetch(endpoint);
      if (!response.ok) throw new Error("HTTP " + response.status);
      const c = await response.json();

      document.getElementById("chemicalDetail").innerHTML = `
        <h4 class="mb-3">${c.name ?? "—"}</h4>
        <table class="table table-dark table-bordered" style="max-width:600px;">
          <tbody>
            <tr><th scope="row">ID</th><td>${c.id ?? "—"}</td></tr>
            <tr><th scope="row">CAS Number</th><td>${c.casNumber ?? "—"}</td></tr>
            <tr><th scope="row">IUPAC Name</th><td>${c.iupacName || "—"}</td></tr>
            <tr><th scope="row">Molecular Formula</th><td>${c.molecularFormula || "—"}</td></tr>
            <tr><th scope="row">Physical State</th><td>${c.physicalState || "—"}</td></tr>
            <tr><th scope="row">Molecular Weight</th><td>${c.molecularWeight || "—"}</td></tr>
          </tbody>
        </table>
      `;
    } catch (err) {
      console.error("loadChemical failed:", err);
      document.getElementById("chemicalDetail").innerHTML =
        '<p class="text-danger">Failed to load chemical. Check the console for details.</p>';
    }
  }

  loadChemical();
</script>

<cfinclude template="/ui/shared/footer.cfm">
