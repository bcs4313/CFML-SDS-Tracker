component accessors="true" {

    // @return information on the status of the created object
    // -> "success"
    // -> or <msg> specifying the reason for failure
    string function createChemical (String name, String casNumber) {

        systemOutput(getApplicationSettings().mappings);

        // validate cas number first
        var result = application.CasNumberValidator.validate(casNumber);
        if(result == false) { return "Invalid casNumber for provided chemical."; }

        // create the model
        var chemEntity = application.chemicalDAO.create(name, casNumber);
        
        return {"result:": "success", 
        "data": deserializeJSON(chemEntity)};
    }

    any function getAllChemicals() {
        return application.chemicalDAO.retrieveAllChemicals();
    }
}