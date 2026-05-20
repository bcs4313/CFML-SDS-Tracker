component accessors="true" {

    // @return information on the status of the created object
    // -> "success"
    // -> or <msg> specifying the reason for failure
    any function createHazard(required String name, required string ghsHazardClass, String pictogramUrl,
    required string signalWord, required String hCodes, required String pCodes) {

        systemOutput(getApplicationSettings().mappings);

        // create the model
        var hazardEntity = application.hazardDAO.create(name, ghsHazardClass, pictogramUrl, signalWord, hCodes, pCodes);
        
        return "success";
    }

    any function getAllHazards() {
        return application.hazardDAO.retrieveAllHazards();
    }
}