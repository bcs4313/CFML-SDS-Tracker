component accessors="true" {

    // @return information on the status of the created object
    // -> "success"
    // -> or <msg> specifying the reason for failure
    any function createChemical(String name, String casNumber,
        String iupacName="", String molecularFormula="", String physicalState="", String molecularWeight="") {

        systemOutput(getApplicationSettings().mappings);

        // validate cas number first
        var result = application.CasNumberValidator.validate(casNumber);
        if(result == false) { return "Invalid casNumber for provided chemical."; }

        // create the model
        var chemEntity = application.chemicalDAO.create(name, casNumber, iupacName, molecularFormula, 
        physicalState, molecularWeight);
        
        return "success";
    }

    any function getAllChemicals() {
        return application.chemicalDAO.retrieveAllChemicals();
    }


    any function getChemicalById(required numeric id) {
        return application.chemicalDAO.loadById(id);
    }
    any function deleteChemical(required numeric id)
    {
        return application.chemicalDao.delete(id);
    }
}