<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<link rel="stylesheet" href="./manageRecords.css">
<p>Manage Chemicals</p>

<button type="button" onclick="gotoDashboard()" class="btn btn-secondary">Back to Dashboard</button>
<button type="button" onclick="gotoCreateChemical()" class="btn btn-primary">Create Chemical</button>

<!-- Table structure for defined chemicals -->
<hr></hr>
<bold>Registered Chemicals</bold>

<table style="margin-top:1em;" class="chemContainer table table-dark">
  <thead>
    <tr>
      <th scope="col">id</th>
      <th scope="col">Chemical Name</th>
      <th scope="col">CAS Number</th>
      <th scope="col">Actions</th>
    </tr>
  </thead>
  <tbody class="chemRows">
  </tbody>
</table>


<script>
    function gotoDashboard() {
        window.location.href = "/index.cfm";
    }
    
    function gotoCreateChemical() {
        window.location.href = "/ui/manageRecords/createChemical.cfm";
    }

    function editChemical(id) {
        console.log("editChemical => " + id);
        window.location.href = "/ui/manageRecords/editChemical.cfm?id=" + id;
    }

    async function deleteChemical(id) {
        console.log("deleteChemical => " + id);
        try {
        const endpoint = window.location.origin + "/rest/api/chemicals/delete";
        const response = await fetch(endpoint, {
            method: 'DELETE',
            body: id,
        });
        const data = await response.json();
        console.log("deletion call done:::");
        console.log(data);
        } catch (error) {
            console.log(error);
        }
        await fetchChemicals();
    }

    async function fetchChemicals() {
      console.log("fetchChemicals()");
      console.log(window.location.origin + "/rest/api/chemicals/getall");
      try
      {
        const response = await fetch(window.location.origin + "/rest/api/chemicals/getall");
        const data = await response.json();
        console.log(data);

        // construct a table
        const tbody = document.querySelector(".chemRows");
        tbody.innerHTML = "";
        data.forEach(entry => {
          console.log("entry => ");
          console.log(entry);
          const tableRow = document.createElement('tr');
          tableRow.innerHTML = `
            <th scope="row">${entry.id}</th>
            <td>${entry.name}</td>
            <td>${entry.casNumber}</td>
            <td>
              <button type="button" onclick="editChemical(${entry.id})" class="btn btn-warning btn-sm">Edit</button>
              <button type="button" onclick="deleteChemical(${entry.id})" class="btn btn-danger btn-sm">Delete</button>
            </td>
          `;
          tbody.appendChild(tableRow);
        });

        console.log("dTable populated");
        return tbody;
      }
      catch (err) {
        console.error("fetchHazards failed:", err);
        const tbody = document.querySelector(".hazardRows");
        tbody.innerHTML = `
          <tr>
            <td colspan="7" class="text-center text-danger">Failed to load hazard data. Check the console for details.</td>
          </tr>
        `;
      }
    }
    fetchChemicals()
</script>

<cfinclude template="/ui/shared/footer.cfm">