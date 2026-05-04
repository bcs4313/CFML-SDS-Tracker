// represents an individual hazard level for a chemical (concept)
component accessors="true" {
    property name="id" type="numeric";   // primary key
    
    property name="code" type="string";   // Hazard code ("FLAM", "CORR", "TOX")
    property name="label" type="string";   // hazard label in readable english
    property name="description" type="string";  // describe the nature of the hazard
    property name="pictogram" type="string";   // optional path to an image
    property name="severity" type="numeric" default="1";  // 1-5 range
}