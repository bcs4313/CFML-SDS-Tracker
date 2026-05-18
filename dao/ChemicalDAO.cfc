// abstraction layer for chemicals
component accessors="true" {
    // create the new orm instance
    // flush to the database
    function create(required Chemical chemical) {
        EntitySave(chemical);
        ormFlush();
    }

    public Chemical function retrieveAllChemicals() {
        return EntityLoad("Chemical");
    }

    public Chemical function loadById(required numeric targetID) {
        return EntityLoadByPK("Chemical", targetID);
    }
}