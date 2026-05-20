<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">
<p>About page</p>


<cfoutput>
    <h2>Endpoints</h2>
    <Button class="btn btn-primary" onclick='window.location="/ui/swagger.cfm"'>REST API Docs</Button>
</cfoutput>

<cfinclude template="/ui/shared/footer.cfm">