component accessors="true" {
    // Take a string representation of a form sent via HTTP and
    // convert it into a JSON object. Requires some string parsing.
    public any function convertToJSON(required string formInput) {
        systemOutput("convertToJSON");
        //var assignmentList = listToArray(formInput);
        systemOutput("convertToJSON assignment list...");
        //writeOutput(assignmentList);
        return '{ 
            "name": "water", 
            "casNumber":"7732-18-5",
        }';
    } 
}