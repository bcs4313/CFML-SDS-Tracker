<cfset pageTitle = "SDSTracker About">
<cfinclude template="/ui/shared/head.cfm">
<cfinclude template="/ui/shared/header.cfm">

<main>
    <h1>About</h1>
    <p class="meta">SDS Tracker - Chemical inventory and GHS hazard management</p>

    <p>SDS Tracker is a Safety Data Sheet management application for registering chemicals, defining GHS hazard records, and maintaining a searchable inventory.</p>

    <hr>

    <h5>Tech Stack</h5>
    <ul>
        <li>CFML on Lucee</li>
        <li>H2 embedded database with Hibernate ORM</li>
        <li>RESTful API -> handler -> service -> DAO -> model</li>
        <li>Bootstrap 5.3</li>
    </ul>

    <hr>

    <h5>API</h5>
    <p>All endpoints are documented via Swagger/OpenAPI 3.0.</p>
    <button class="btn btn-primary" onclick='window.location="/ui/swagger.cfm"'>REST API Docs</button>
</main>

<cfinclude template="/ui/shared/footer.cfm">
