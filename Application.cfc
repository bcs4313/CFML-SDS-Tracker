// Application.cfc
component {
    this.name = "SDSTracker";
    this.applicationTimeout = createTimeSpan(0, 2, 0, 0);

    this.mappings = {
        "/api" = expandPath("./api"),
        "/services" = expandPath("./services"),
        "/dao" = expandPath("./dao"),
        "/models" = expandPath("./models")
    };

    // REST registration
    this.restSettings = {
        skipCFCWithError = false,
        returnFormat = "json"
    };

    // define the datasource
    this.datasource = "sdstracker";

    public boolean function onApplicationStart() {
        // Initialize singletons here later
        return true;
    }

    public boolean function onRequestStart(string targetPage) {
        return true;
    }
}