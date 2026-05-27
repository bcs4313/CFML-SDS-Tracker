// abstraction layer for chemicals
component accessors="true" {
    // create the new orm instance
    // flush to the database
     any function create(required String name, required String casNumber,
        String iupacName="", String molecularFormula="", String physicalState="", String molecularWeight="") {
        var chemical = EntityNew("Chemical");

        chemical.setName(name);

        // casNumber requires validation
        chemical.setCasNumber(casNumber);

        // these fields are optional. They only persist when a value was supplied by our
        // form in createChemical.cfm
        if(len(trim(iupacName)))         { chemical.setIupacName(iupacName); }
        if(len(trim(molecularFormula)))  { chemical.setMolecularFormula(molecularFormula); }
        if(len(trim(physicalState)))     { chemical.setPhysicalState(physicalState); }
        if(len(trim(molecularWeight)))   { chemical.setMolecularWeight(molecularWeight); }

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