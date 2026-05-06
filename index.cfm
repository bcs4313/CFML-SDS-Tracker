<cfset pageTitle = "SDSTracker Dashboard">
<!DOCTYPE html>
<html lang="en">
<head>
     <!-- Bootstrap stylesheet -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
        rel="stylesheet">

    <!-- index stylesheet -->

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><cfoutput>#pageTitle#</cfoutput></title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 1rem;
            line-height: 1.5;
            color: #222;
        }
        h1 { margin-bottom: 0.25rem; }
        .meta { color: #666; font-size: 0.9rem; margin-bottom: 2rem; }
        code { background: #f4f4f4; padding: 0.1rem 0.3rem; border-radius: 3px; }
    </style>
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">SDSTracker</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.cfm">My Dashboard</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="ui/inventory/inventory.cfm">Inventory</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="ui/submit/submit.cfm" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Manage Records
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="#">Chemicals</a>
                <a class="dropdown-item" href="#">Hazards</a>
                </div>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="ui/about/about.cfm">About</a>
            </li>
            </ul>
            <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
        </nav>
        
    </header>
    
    <cfoutput>
        <main>

        </main>
        <h1>#pageTitle#</h1>
        <p class="meta">Server time: #dateTimeFormat(now(), "yyyy-mm-dd HH:nn:ss")#</p>

        <p>Application is running.</p>

        <h2>Endpoints</h2>
        <ul>
            <li><code>GET /api/...</code> — describe endpoint</li>
            <li><code>POST /api/...</code> — describe endpoint</li>
        </ul>
    </cfoutput>
    <!-- boostrap javascript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>