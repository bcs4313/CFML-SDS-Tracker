// abstraction layer for hazards
component accessors="true" {
    // create the new orm instance
    // flush to the database
    any function create(required String name, required string ghsHazardClass, String pictogramUrl,
    required string signalWord, required String hCodes, required String pCodes,
    String hazardCategory="", String exposureRoutes="", String unNumber="") {
        var hazard = EntityNew("Hazard");

        hazard.setName(name);
        hazard.setHazardClass(ghsHazardClass);
        hazard.setPictogramUrl(pictogramUrl);
        hazard.setSignalWord(signalWord);
        hazard.setHCodes(hCodes);
        hazard.setPCodes(pCodes);

        // optional GHS fields.
        if(len(trim(hazardCategory))) { hazard.setHazardCategory(hazardCategory); }
        if(len(trim(exposureRoutes))) { hazard.setExposureRoutes(exposureRoutes); }
        if(len(trim(unNumber)))       { hazard.setUnNumber(unNumber); }

        EntitySave(hazard);
        ormFlush();

        return hazard;
    }

    public any function retrieveAllHazards() {
        return EntityLoad("Hazard");
    }

    public Hazard function loadById(required numeric targetID) {
        return EntityLoadByPK("Hazard", targetID);
    }

    public any function delete(required numeric targetID) {
        var entity = EntityLoadByPK("Hazard", targetID);
        EntityDelete(entity);
        return "done";
    }
}