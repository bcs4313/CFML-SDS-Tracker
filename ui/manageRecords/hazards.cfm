<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<link rel="stylesheet" href="./manageRecords.css">

<p>Manage Hazards</p>
<button type="button" onclick="gotoDashboard()" class="btn btn-secondary">Back to Dashboard</button>
<button type="button" onclick="gotoCreateHazard()" class="btn btn-primary">Create Hazard</button>

<hr />
<bold>Registered Hazards</bold>

<table style="margin-top:1em;" class="hazardContainer table table-dark">
  <thead>
    <tr>
      <th scope="col">ID</th>
      <th scope="col">GHS Pictogram</th>
      <th scope="col">GHS Hazard Class</th>
      <th scope="col">Signal Word</th>
      <th scope="col">H-Codes</th>
      <th scope="col">P-Codes</th>
      <th scope="col">Actions</th>
    </tr>
  </thead>
  <tbody class="hazardRows">
  </tbody>
</table>

<script>
  function gotoDashboard() {
    window.location.href = "/index.cfm";
  }

  function gotoCreateHazard() {
    window.location.href = "/ui/manageRecords/createHazard.cfm";
  }

  function editHazard(id) {
    console.log("editHazard => " + id);
    window.location.href = "/ui/manageRecords/editHazard.cfm?id=" + id;
  }

  function deleteHazard(id) {
    console.log("deleteHazard => " + id);
    // hook up to your DELETE endpoint here
  }

  // Maps signal word to a Bootstrap badge color
  function signalWordBadge(signalWord) {
    if (!signalWord) return '<span class="badge bg-secondary">N/A</span>';
    const word = signalWord.trim().toLowerCase();
    if (word === "danger")  return `<span class="badge bg-danger">Danger</span>`;
    if (word === "warning") return `<span class="badge bg-warning text-dark">Warning</span>`;
    return `<span class="badge bg-secondary">${signalWord}</span>`;
  }

  // Renders a GHS pictogram image if a URL is provided, otherwise falls back to text
  function pictogramCell(entry) {
    if (entry.pictogramUrl) {
      return `<img src="${entry.pictogramUrl}" alt="${entry.ghsHazardClass || 'GHS Pictogram'}" style="width:48px;height:48px;object-fit:contain;" title="${entry.ghsHazardClass || ''}">`;
    }
    if (entry.pictogram) {
      return `<span>${entry.pictogram}</span>`;
    }
    return '<span class="text-muted">—</span>';
  }

  async function fetchHazards() {
    console.log("fetchHazards()");
    const endpoint = window.location.origin + "/rest/api/hazards/getall";
    console.log(endpoint);

    try {
      const response = await fetch(endpoint);
      if (!response.ok) throw new Error(`HTTP ${response.status}`);
      const data = await response.json();
      console.log(data);

      const tbody = document.querySelector(".hazardRows");
      tbody.innerHTML = "";

      data.forEach(entry => {
        console.log("entry => ", entry);
        const tableRow = document.createElement('tr');
        tableRow.innerHTML = `
          <th scope="row">${entry.id}</th>
          <td>${pictogramCell(entry)}</td>
          <td>${entry.ghsHazardClass ?? '<span class="text-muted">—</span>'}</td>
          <td>${signalWordBadge(entry.signalWord)}</td>
          <td><code>${entry.hCodes ?? '—'}</code></td>
          <td><code>${entry.pCodes ?? '—'}</code></td>
          <td>
            <button type="button" onclick="editHazard(${entry.id})" class="btn btn-warning btn-sm">Edit</button>
            <button type="button" onclick="deleteHazard(${entry.id})" class="btn btn-danger btn-sm">Delete</button>
          </td>
        `;
        tbody.appendChild(tableRow);
      });

      console.log("hazard table populated");
    } catch (err) {
      console.error("fetchHazards failed:", err);
      const tbody = document.querySelector(".hazardRows");
      tbody.innerHTML = `
        <tr>
          <td colspan="7" class="text-center text-danger">Failed to load hazard data. Check the console for details.</td>
        </tr>
      `;
    }
  }

  fetchHazards();
</script>

<cfinclude template="/ui/shared/footer.cfm">
