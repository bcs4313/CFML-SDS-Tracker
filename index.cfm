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
                            <h6 class="card-subtitle mb-1 text-primary">Registered Chemicals</h6>
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

            <div id="searchResults" style="display:none; margin-bottom:2rem;">
                <div class="row g-4">
                    <div class="col-lg-6">
                        <h6>Chemicals <span class="text-muted" id="chemMatchCount"></span></h6>
                        <table class="table table-dark table-sm mt-2">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">CAS Number</th>
                                </tr>
                            </thead>
                            <tbody id="searchChemicals"></tbody>
                        </table>
                    </div>
                    <div class="col-lg-6">
                        <h6>Hazards <span class="text-muted" id="hazMatchCount"></span></h6>
                        <table class="table table-dark table-sm mt-2">
                            <thead>
                                <tr>
                                    <th scope="col">ID</th>
                                    <th scope="col">Hazard Class</th>
                                    <th scope="col">Signal Word</th>
                                </tr>
                            </thead>
                            <tbody id="searchHazards"></tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row g-4" id="recentSection">
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
    // module-level cache — populated once by loadDashboard()
    let allChemicals = [];
    let allHazards   = [];

    function signalWordBadge(signalWord) {
        if (!signalWord) return '<span class="badge bg-secondary">N/A</span>';
        const word = signalWord.trim().toLowerCase();
        if (word === "danger")  return `<span class="badge bg-danger">Danger</span>`;
        if (word === "warning") return `<span class="badge bg-warning text-dark">Warning</span>`;
        return `<span class="badge bg-secondary">${signalWord}</span>`;
    }

    function runSearch(query) {
        console.log("runSearch() =>", query);
        const q = query.trim().toLowerCase();

        if (q === "") {
            clearSearch();
            return;
        }

        const matchedChems = allChemicals.filter(c =>
            c.name?.toLowerCase().includes(q) ||
            c.casNumber?.toLowerCase().includes(q)
        );

        const matchedHaz = allHazards.filter(h =>
            h.hazardClass?.toLowerCase().includes(q) ||
            h.signalWord?.toLowerCase().includes(q) ||
            h.hCodes?.toLowerCase().includes(q) ||
            h.pCodes?.toLowerCase().includes(q)
        );

        console.log("chem matches =>", matchedChems.length);
        console.log("hazard matches =>", matchedHaz.length);

        // populate chem results
        const chemTbody = document.getElementById("searchChemicals");
        chemTbody.innerHTML = "";
        if (matchedChems.length === 0) {
            chemTbody.innerHTML = '<tr><td colspan="3" class="text-muted">No matches</td></tr>';
        } else {
            matchedChems.forEach(entry => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <th scope="row">${entry.id}</th>
                    <td>${entry.name}</td>
                    <td><code>${entry.casNumber}</code></td>
                `;
                chemTbody.appendChild(row);
            });
        }

        // populate hazard results
        const hazTbody = document.getElementById("searchHazards");
        hazTbody.innerHTML = "";
        if (matchedHaz.length === 0) {
            hazTbody.innerHTML = '<tr><td colspan="3" class="text-muted">No matches</td></tr>';
        } else {
            matchedHaz.forEach(entry => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <th scope="row">${entry.id}</th>
                    <td>${entry.hazardClass ?? '<span class="text-muted">—</span>'}</td>
                    <td>${signalWordBadge(entry.signalWord)}</td>
                `;
                hazTbody.appendChild(row);
            });
        }

        document.getElementById("chemMatchCount").textContent = `(${matchedChems.length})`;
        document.getElementById("hazMatchCount").textContent  = `(${matchedHaz.length})`;
        document.getElementById("searchResults").style.display = "block";
        document.getElementById("recentSection").style.display = "none";
    }

    function clearSearch() {
        console.log("clearSearch()");
        document.getElementById("searchResults").style.display = "none";
        document.getElementById("recentSection").style.display = "flex";
    }

    // wire the header's sitewide-search form to runSearch
    function initHeaderSearch() {
        console.log("initHeaderSearch()");
        const form  = document.querySelector(".sitewide-search");
        const input = form?.querySelector("input[type='search']");

        if (!form || !input) {
            console.log("initHeaderSearch() => header search not found");
            return;
        }

        input.addEventListener("input", () => runSearch(input.value));

        form.addEventListener("submit", e => {
            e.preventDefault();
            runSearch(input.value);
        });

        // clear results when input is emptied via the browser's native clear (x) button
        input.addEventListener("search", () => {
            if (input.value === "") clearSearch();
        });
    }

    async function loadDashboard() {
        console.log("loadDashboard()");
        const origin = window.location.origin;

        try {
            const [chemRes, hazRes] = await Promise.all([
                fetch(origin + "/rest/api/chemicals/getall"),
                fetch(origin + "/rest/api/hazards/getall")
            ]);

            allChemicals = await chemRes.json();
            allHazards   = await hazRes.json();

            console.log("chemicals =>", allChemicals);
            console.log("hazards =>", allHazards);

            // stat cards
            document.getElementById("statChemicals").textContent = allChemicals.length == 0;
            document.getElementById("statHazards").textContent   = allHazards.length;
            document.getElementById("statDanger").textContent    = allHazards.filter(h => h.signalWord?.toLowerCase() === "danger").length;

            // recent chemicals — last 5
            const chemTbody = document.getElementById("recentChemicals");
            chemTbody.innerHTML = "";
            allChemicals.slice(-5).reverse().forEach(entry => {
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
            allHazards.slice(-5).reverse().forEach(entry => {
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
    initHeaderSearch();
</script>

<cfinclude template="/ui/shared/footer.cfm">