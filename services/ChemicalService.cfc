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
        chemical = new models.Chemical();

        chemical.setName(name);

        // casNumber requires validation
        chemical.setCasNumber(casNumber);

        return "success";
    }

    string function getAllChemicals() {
        return application.chemicalDAO.retrieveAllChemicals();
    }
}