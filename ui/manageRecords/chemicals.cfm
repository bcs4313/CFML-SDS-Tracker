<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<link rel="stylesheet" href="./manageRecords.css">
<p>Manage Chemicals</p>

<button type="button" onclick="gotoDashboard()" class="btn btn-secondary">Back to Dashboard</button>
<button type="button" onclick="gotoCreateChemical()" class="btn btn-primary">Create Chemical</button>

<!-- Table structure for defined chemicals -->
<hr></hr>
<bold>Registered Chemicals</bold>

<table style="margin-top:1em;" class="table table-dark">
  <thead>
    <tr>
      <th scope="col">id</th>
      <th scope="col">Chemical Name</th>
      <th scope="col">CAS Number</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">1</th>
      <td>Dihydrogen Monoxide</td>
      <td>7732-18-5</td>
    </tr>
    <tr>
      <th scope="row">2</th>
      <td>Ethanol (Ethyl Alcohol)</td>
      <td>64-17-5</td>
    </tr>
  </tbody>
</table>


<script>
    function gotoDashboard() {
        window.location.href = "/index.cfm";
    }
    function gotoCreateChemical() {
        window.location.href = "/ui/manageRecords/createChemical.cfm";
    }
    
</script>

<cfinclude template="/ui/shared/footer.cfm">