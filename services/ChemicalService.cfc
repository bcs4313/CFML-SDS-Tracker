component accessors="true" {

    // @return information on the status of the created object
    // -> "success"
    // -> or <msg> specifying the reason for failure
    string function createChemical (String name, String casNumber) {

        // validate cas number first
        var result = CasNumberValidator::validate(casNumber);
        if(result == false) { return "Invalid casNumber for provided chemical."}

        // create the model
        var chemical = createObject("component", "Chemical")

        chemical.setName(name);

        // casNumber requires validation
        chemical.setCasNumber(casNumber);
        
    }
}