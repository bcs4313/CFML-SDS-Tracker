<header>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="/index.cfm">SDS<span>Tracker</span></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto">
            <li class="nav-item">
                <a class="nav-link" href="/index.cfm">Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/ui/inventory/inventory.cfm">Inventory</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Manage Records
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="/ui/manageRecords/chemicals.cfm">Chemicals</a>
                <a class="dropdown-item" href="/ui/manageRecords/hazards.cfm">Hazards</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/ui/about/about.cfm">About</a>
            </li>
            </ul>
            <form class="sitewide-search" onsubmit="return false;">
                <input class="form-control" type="search" placeholder="Search chemicals, hazards…" aria-label="Search">
                <button class="btn" type="submit">Search</button>
            </form>
        </div>
    </div>
    </nav>
    
</header>