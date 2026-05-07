<cfoutput>#fileExists(expandPath('/models/Chemical.cfc'))#</cfoutput>
<cfscript>
    try {
        chemical = new models.Chemical();
        writeOutput("OK: " & getMetadata(chemical).name);
    } catch (any e) {
        writeOutput("FAIL: " & e.message);
    }
</cfscript>