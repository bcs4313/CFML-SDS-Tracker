<cfset pageTitle = "Application">
<!DOCTYPE html>
<html lang="en">
<head>
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
    <cfoutput>
        <header>
            <ol>
                <li>
                    <a href="index.cfm">My Dashboard</a>
                </li>
                <li>
                    <a href="ui/inventory/inventory.cfm">Inventory</a>
                </li>
                <li>
                    <a href="ui/submit/submit.cfm">Submit</a>
                </li>
                <li>
                    <a href="ui/about/about.cfm">About</a>
                </li>
            </ol>
        </header>

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
</body>
</html>