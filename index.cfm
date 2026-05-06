<cfset pageTitle = "SDSTracker Dashboard">
<!DOCTYPE html>
<html lang="en">
<cfinclude template="ui/shared/head.cfm">
<body>
    <cfinclude template="\ui\shared\header.cfm">
    <cfoutput>
        <main>
            <h1>#pageTitle#</h1>
            <p class="meta">Server time: #dateTimeFormat(now(), "yyyy-mm-dd HH:nn:ss")#</p>

            <p>Application is running.</p>
        </main>
    </cfoutput>
    <!-- boostrap javascript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>