component rest="true" restpath="hazards" {
    remote any function createHazard(required string formPayload restArgSource="body") httpmethod="POST" restpath="create" {
        systemOutput("createHazard REST Call. With form data...");
        systemOutput(formPayload);
        systemOutput("converting form data to JSON...");
        var jsonPayload = application.formDataHandler.convertToJSON(formPayload);
        systemOutput("deserializing json...");
        var json = deserializeJSON(jsonPayload);
        systemOutput("Creating Hazard... -> " & jsonPayload);

        try {
            systemOutput("hazard name = " & json.hazardName);
            systemOutput("hazard class = " & json.ghsHazardClass);
            systemOutput("signalWord = " & json.signalWord);
            var result = application.chemicalService.createChemical(json.name, json.casNumber);

            if("success" == result)
            {
                systemOutput("Creation Success. Returning status of 200");
                restSetResponse({
                    status: 200,
                });
                return { msg: "Chemical Successfully Created.", name: json.name, casNumber: json.casNumber};
            }
            else {
                systemOutput("Chemical Creation Failure. Reason = " & result);
                restSetResponse({
                    status: 400,
                });
                return { error: "Chemical not created. Reason: " & result };
            }
        } catch (any e) {
            systemOutput(e);
            restSetResponse({
                status: 400,
            });
            return { error: "Chemical not created. Error: " & e.message };
        }

        return { error: "Undefined Error. This message should never be sent." }
    }
}