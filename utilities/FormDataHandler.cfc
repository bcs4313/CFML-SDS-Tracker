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

            for (i = 1; i <= arrayLen(assignmentList); i++) {
                // Split only on the FIRST "=" to handle values that contain "="
                var eqPos = find("=", assignmentList[i]);
                if (eqPos > 0) {
                    var key   = urlDecode(left(assignmentList[i], eqPos - 1));
                    var val   = urlDecode(mid(assignmentList[i], eqPos + 1, len(assignmentList[i])));
                    chemicalObject[key] = val;
                    systemOutput(key & " = " & val);
                }
            }

            systemOutput("result object::");
            systemOutput(chemicalObject);
            return serializeJSON(chemicalObject);
        }
        catch (any e) {
            systemOutput("convertToJSON for entity error: " & e.message);
        }
    }

}