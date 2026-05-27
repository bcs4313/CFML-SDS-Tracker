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
        systemOutput("converting form data to JSON...");
        var jsonPayload = application.formDataHandler.convertToJSON(formPayload);
        systemOutput("deserializing json...");
        var json = deserializeJSON(jsonPayload);
        systemOutput("Creating Chemical... -> " & jsonPayload);

        try {
            systemOutput("name = " & json.name);
            systemOutput("casNumber" & json.casNumber);
            var iupacName = structKeyExists(json, "iupacName") ? json.iupacName : "";
            var molecularFormula = structKeyExists(json, "molecularFormula") ? json.molecularFormula : "";
            var physicalState = structKeyExists(json, "physicalState") ? json.physicalState : "";
            var molecularWeight = structKeyExists(json, "molecularWeight") ? json.molecularWeight : "";
            var result = application.chemicalService.createChemical(json.name, json.casNumber,
                iupacName, molecularFormula, physicalState, molecularWeight);

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

        return { error: "Undefined Error. This message should never be sent." };
    }

    remote any function getAllChem() httpmethod="GET" restpath="getall"
    {
        systemOutput("getAllChem: REST GET");
        return application.chemicalService.getAllChemicals();
    }   

    remote any function getChemicalById(required string id restArgSource="query") httpmethod="GET" restpath="get"
    {
        systemOutput("getChemicalById: REST GET id=" & id);
        try {
            var chemical = application.chemicalService.getChemicalById(id);
            if (isNull(chemical)) {
                restSetResponse({ status: 404 });
                return { error: "Chemical not found." };
            }
            return chemical;
        } catch (any e) {
            restSetResponse({ status: 400 });
            return { error: "Error retrieving chemical: " & e.message };
        }
    }

    remote any function deleteChemical(required string id restArgSource="body") httpmethod="DELETE" restpath="delete"
    {
        systemOutput("deleteChemical: REST DELETE with id = ");
        systemOutput(id);
        return application.chemicalService.deleteChemical(id);
    }
}
