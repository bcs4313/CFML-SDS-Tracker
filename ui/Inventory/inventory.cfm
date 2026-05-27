<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">

<div class="container-fluid mt-3">
  <h4>Chemical Inventory</h4>
  <p class="text-muted">
    Showing all registered chemicals. Physical stock tracking (location, quantity, storage unit)
    is planned for a future release.
  </p>

  <div class="mb-3" style="max-width:360px;">
    <input type="text" id="inventorySearch" class="form-control"
           placeholder="Search by name, CAS, or formula..." oninput="filterTable()">
  </div>

  <table class="table table-dark table-hover" id="inventoryTable">
    <thead>
      <tr>
        <th scope="col">ID</th>
        <th scope="col">Chemical Name</th>
        <th scope="col">CAS Number</th>
        <th scope="col">Molecular Formula</th>
        <th scope="col">Physical State</th>
      </tr>
    </thead>
    <tbody id="inventoryBody">
      <tr><td colspan="5" class="text-center text-muted">Loading...</td></tr>
    </tbody>
  </table>
</div>

<script>
  let allRows = [];

  function filterTable() {
    const q = document.getElementById("inventorySearch").value.toLowerCase();
    const tbody = document.getElementById("inventoryBody");
    tbody.innerHTML = "";

    const filtered = allRows.filter(c =>
      (c.name        || "").toLowerCase().includes(q) ||
      (c.casNumber   || "").toLowerCase().includes(q) ||
      (c.molecularFormula || "").toLowerCase().includes(q)
    );

    if (filtered.length === 0) {
      tbody.innerHTML = '<tr><td colspan="5" class="text-center text-muted">No matching chemicals.</td></tr>';
      return;
    }

    filtered.forEach(c => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <th scope="row">${c.id}</th>
        <td>${c.name ?? "—"}</td>
        <td>${c.casNumber ?? "—"}</td>
        <td>${c.molecularFormula || "—"}</td>
        <td>${c.physicalState || "—"}</td>
      `;
      tbody.appendChild(row);
    });
  }

  async function loadInventory() {
    try {
      const response = await fetch(window.location.origin + "/rest/api/chemicals/getall");
      if (!response.ok) throw new Error("HTTP " + response.status);
      allRows = await response.json();
      filterTable();
    } catch (err) {
      console.error("loadInventory failed:", err);
      document.getElementById("inventoryBody").innerHTML =
        '<tr><td colspan="5" class="text-center text-danger">Failed to load inventory. Check the console for details.</td></tr>';
    }
  }

  loadInventory();
</script>

<cfinclude template="/ui/shared/footer.cfm">
