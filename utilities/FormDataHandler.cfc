component accessors="true" {
    // Take a string representation of a form sent via HTTP and
    // convert it into a JSON object. Requires some string parsing.
    public any function convertToJSON(required string formInput) {
        try {          
            var chemicalObject = {};
            systemOutput("convertToJSON -");
            systemOutput(formInput);
            var assignmentList = listToArray(formInput, "&");
            systemOutput("convertToJSON assignment list....");
            systemOutput(assignmentList);

            for(i = 1; i <= arrayLen(assignmentList); i++)
            {
                // now we have pairs of keys and values like:
                // name=something
                var pair = listToArray(assignmentList[i], "=");
                chemicalObject[pair[1]] = pair[2];
                systemOutput(assignmentList[i]);
            }
            
            systemOutput("result object::");
            systemOutput(chemicalObject);
            
            return serializeJSON(chemicalObject);
        }
        catch (any e) {
           systemOutput("convertToJSON for chemical error: " & e.message);
        }
    } 
}