<cfset pageTitle = "SDSTracker Dashboard">
<!DOCTYPE html>
<html lang="en">
<cfinclude template="ui/shared/head.cfm">
<body>
    <cfinclude template="/ui/shared/header.cfm">
    <cfoutput>
        <main>
            <h1>#pageTitle#</h1>
            <p class="meta">Server time: #dateTimeFormat(now(), "yyyy-mm-dd HH:nn:ss")#</p>

            <div class="row g-3 mb-4">
                <div class="col-sm-4">
                    <div class="card text-bg-dark h-100">
                        <div class="card-body">
                            <h6 class="card-subtitle mb-1text-primary">Registered Chemicals</h6>
                            <p class="display-6 mb-0" id="statChemicals">—</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card text-bg-dark h-100">
                        <div class="card-body">
                            <h6 class="card-subtitle mb-1 text-warning">Registered Hazards</h6>
                            <p class="display-6 mb-0" id="statHazards">—</p>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="card text-bg-dark h-100">
                        <div class="card-body">
                            <h6 class="card-subtitle mb-1 text-danger">Dangerous Hazards</h6>
                            <p class="display-6 mb-0" id="statDanger">—</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-6">
                    <h5>Recent Chemicals</h5>
                    <table class="table table-dark table-sm mt-2">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">CAS Number</th>
                            </tr>
                        </thead>
                        <tbody id="recentChemicals"></tbody>
                    </table>
                </div>
                <div class="col-lg-6">
                    <h5>Recent Hazards</h5>
                    <table class="table table-dark table-sm mt-2">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Hazard Class</th>
                                <th scope="col">Signal Word</th>
                            </tr>
                        </thead>
                        <tbody id="recentHazards"></tbody>
                    </table>
                </div>
            </div>
        </main>
    </cfoutput>
</body>

<script>
    function signalWordBadge(signalWord) {
        if (!signalWord) return '<span class="badge bg-secondary">N/A</span>';
        const word = signalWord.trim().toLowerCase();
        if (word === "danger")  return `<span class="badge bg-danger">Danger</span>`;
        if (word === "warning") return `<span class="badge bg-warning text-dark">Warning</span>`;
        return `<span class="badge bg-secondary">${signalWord}</span>`;
    }

    async function loadDashboard() {
        console.log("loadDashboard()");
        const origin = window.location.origin;

        try {
            const [chemRes, hazRes] = await Promise.all([
                fetch(origin + "/rest/api/chemicals/getall"),
                fetch(origin + "/rest/api/hazards/getall")
            ]);

            const chemicals = await chemRes.json();
            const hazards   = await hazRes.json();

            console.log("chemicals =>", chemicals);
            console.log("hazards =>", hazards);

            // stat cards
            document.getElementById("statChemicals").textContent = chemicals.length;
            document.getElementById("statHazards").textContent   = hazards.length;
            document.getElementById("statDanger").textContent    = hazards.filter(h => h.signalWord?.toLowerCase() === "danger").length;

            // recent chemicals — last 5
            const chemTbody = document.getElementById("recentChemicals");
            chemTbody.innerHTML = "";
            chemicals.slice(-5).reverse().forEach(entry => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <th scope="row">${entry.id}</th>
                    <td>${entry.name}</td>
                    <td><code>${entry.casNumber}</code></td>
                `;
                chemTbody.appendChild(row);
            });

            // recent hazards — last 5
            const hazTbody = document.getElementById("recentHazards");
            hazTbody.innerHTML = "";
            hazards.slice(-5).reverse().forEach(entry => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <th scope="row">${entry.id}</th>
                    <td>${entry.hazardClass ?? '<span class="text-muted">—</span>'}</td>
                    <td>${signalWordBadge(entry.signalWord)}</td>
                `;
                hazTbody.appendChild(row);
            });

        } catch (err) {
            console.error("loadDashboard failed:", err);
        }
    }

    loadDashboard();
</script>

<cfinclude template="/ui/shared/footer.cfm">