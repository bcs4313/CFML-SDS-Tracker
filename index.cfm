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
</body>
</html>
<cfinclude template="\ui\shared\footer.cfm">