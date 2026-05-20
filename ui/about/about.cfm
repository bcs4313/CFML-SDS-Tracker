<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<p>About page</p>


<cfoutput>
    <Button class="btn btn-primary" onclick='window.location="/ui/swagger.cfm"'>REST API Docs</Button>
    <h2>Endpoints</h2>
    <ul>
        <li><code>GET /api/...</code> — describe endpoint</li>
        <li><code>POST /api/...</code> — describe endpoint</li>
    </ul>
</cfoutput>

<cfinclude template="/ui/shared/footer.cfm">