// abstraction layer for hazards
component accessors="true" {
    // create the new orm instance
    // flush to the database
    any function create(required String name, required string ghsHazardClass, String pictogramUrl,
    required string signalWord, required String hCodes, required String pCodes) {
        var hazard = EntityNew("Hazard");

        hazard.setName(name);
        hazard.setHazardClass(ghsHazardClass);
        hazard.setPictogramUrl(pictogramUrl);
        hazard.setSignalWord(signalWord);
        hazard.setHCodes(hCodes);
        hazard.setPCodes(pCodes);

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