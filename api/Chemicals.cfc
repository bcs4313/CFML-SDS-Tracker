component rest="true" restpath="/chemicals" {
    remote string function sayHello() httpmethod="GET" restpath="" {
        return "Hello my chemical friends";
    }

    // @param jsonPayload: A serialized json file containing the data needed for a chemical
    // to be created in the database. It is assumed that the http request has this payload in the body
    // @return a message dictating the results of the POST request
    remote any function createChemical(required string formPayload restArgSource="body") httpmethod="POST" restpath="create" {
        systemOutput("createChemical REST Call. With form data...");
        systemOutput(formPayload);
        var jsonPayload = application.formDataHandler.convertToJSON(formPayload);
        systemOutput("func2");
        var json = deserializeJSON(jsonPayload);
        systemOutput("Creating Chemical... -> " & jsonPayload);

        try {
            systemOutput("name = " & json.name);
            systemOutput("casNumber" & json.casNumber);
            var result = application.chemicalService.createChemical(json.name, json.casNumber);

            if("success" == result)
            {
                systemOutput("Creation Success. Returning status of 200");
                restSetResponse({
                    status: 200,
                    content: {
                        msg: "Chemical Successfully Created."
                    }
                });
                return;
            }
            else {
                systemOutput("Chemical Creation Failure. Reason = " & result);
                restSetResponse({
                    status: 400,
                    content: {
                        error: "Chemical not created. Reason: " & result
                    }
                });
                return;
            }
        } catch (any e) {
            systemOutput(e);
            restSetResponse({
                status: 400,
                content: {
                    error: "Chemical not created. Error: " & e.message
                }
            });
            return;
        }

        return "Undefined Error. This message should never be sent.";
    }
}