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
        "/utilities": expandPath("./utilities"),
        "/root": expandPath("./")
    };

    // Object Relational Model Configuration
    // sdstracler is the current datasource
    // which points to the H2 Database Engine (MySql)
    this.ormenabled = true;
    this.ormSettings = {
        cfclocation = "models", // Directory where your entities are stored
        dbcreate = "update",    // Automatically updates database schema to match CFCs
        logsql = true,           // Shows generated SQL in console for debugging
        datasource   = "sdstracker"
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
            // rest application initialization
            restInitApplication(
                dirPath = expandPath("./api"),
                serviceMapping = "api",
                password = "devpass",
                default = true
            );
            writeLog(file="restdebug", text="restInitApplication succeeded");
            
            // assign singleton objects
            application.chemicalService = CreateObject("component", "services.ChemicalService");
            application.hazardService = CreateObject("component", "services.hazardService")
            application.hazardDAO = CreateObject("component", "dao.HazardDAO");
            application.chemicalDAO = CreateObject("component", "dao.ChemicalDAO");
            application.formDataHandler = createObject("component", "utilities.FormDataHandler");
            application.casNumberValidator = createObject("component", "utilities.CasNumberValidator");
            
        } catch(any e) {
            writeLog(file="restdebug", text="restInitApplication FAILED: " & e.message);
        }
        
        return true;
    }

    public boolean function onRequestStart(string targetPage) {
        return true;
    }
}
