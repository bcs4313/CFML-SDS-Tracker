<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">SDSTracker</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
        <li class="nav-item active">
            <a class="nav-link" href="/index.cfm">My Dashboard</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/ui/inventory/inventory.cfm">Inventory</a>
        </li>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="/ui/submit/submit.cfm" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
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
        <form class="sitewide-search form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
    </div>
    </nav>
    
</header>