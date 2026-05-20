// abstraction layer for chemicals
component accessors="true" {
    // create the new orm instance
    // flush to the database
    any function create(required String name, required String casNumber) {
        var chemical = EntityNew("Chemical");

        chemical.setName(name);

        // casNumber requires validation
        chemical.setCasNumber(casNumber);
        EntitySave(chemical);
        ormFlush();

        return chemical;
    }

    public any function retrieveAllChemicals() {
        return EntityLoad("Chemical");
    }

    public Chemical function loadById(required numeric targetID) {
        return EntityLoadByPK("Chemical", targetID);
    }
    
    public any function delete(required numeric targetID) {
        var entity = EntityLoadByPK("Chemical", targetID);
        EntityDelete(entity);
        return "done";
    }
}