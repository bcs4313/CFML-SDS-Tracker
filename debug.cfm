<cfscript>
// Dump the entire REST application registry
local.engine = createObject("java", "lucee.runtime.rest.RestUtil");
writeDump(local.engine);
</cfscript>