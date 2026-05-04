// Application.cfc
component {
    this.name = "SDSTracker";
    this.applicationTimeout = createTimeSpan(0, 2, 0, 0);

    this.webAdminPassword = "devpass";
    this.serverAdminPassword = "devpass";

    // mappings for the REST API and other critical functions
    this.mappings = {
        "/api": expandPath("./api"),
        "/services": expandPath("./services"),
        "/dao": expandPath("./dao"),
        "/models": expandPath("./models"),
        "/root": expandPath("./")
    };
    
    // REST registration
    this.restSettings = {
        skipCFCWithError: false,
        returnFormat: "json"
    };

    // define the datasource
    // (Datasource is an alias linked to Lucee's datasource service)
    // The datasource is an H2 lightweight relational databse.
    this.datasource = "sdstracker";

    public boolean function onApplicationStart() {
        writeLog(file="restdebug", text="onApplicationStart fired");
        try {
            restInitApplication(
                dirPath = expandPath("./api"),
                serviceMapping = "api",
                password = "devpass",
                default = true
            );
            writeLog(file="restdebug", text="restInitApplication succeeded");
        } catch(any e) {
            writeLog(file="restdebug", text="restInitApplication FAILED: " & e.message);
        }
        return true;
    }

    public boolean function onRequestStart(string targetPage) {
        var req = getPageContext().getRequest();
        writeLog(file="restdebug", text="ServletPath=[#req.getServletPath()#] PathInfo=[#isNull(req.getPathInfo()) ? 'NULL' : req.getPathInfo()#] RequestURI=[#req.getRequestURI()#]");
        return true;
    }
}