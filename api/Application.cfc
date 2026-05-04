component {
    this.name = "SDSTracker";
    this.datasource = "sdstracker";
    
    this.mappings = {
        "/api": expandPath("../api"),
        "/services": expandPath("../services"),
        "/dao": expandPath("../dao"),
        "/models": expandPath("../models")
    };
}z