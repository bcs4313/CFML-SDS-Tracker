component accessors="true" {

    function createChemical (String name, String casNumber) singleton {
        // create the model
        var chemical = createObject("component", "Chemical")

        chemical.setName(name);

        // casNumber requires validation

        chemical.setCasNumber(casNumber);
    }
}