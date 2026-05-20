// represents an individual hazard level for a chemical (concept)
component persistent="true" accessors="true" {
    property name="id" fieldtype="id" ormtype="integer" generator="native" type="numeric";   // primary key
    
    property name="name" ormtype="string";  
    property name="hazardClass" ormtype="string";   
    property name="pictogramUrl" ormtype="string"; 
    property name="signalWord" ormtype="string";   
    property name="hCodes" ormtype="string";  
    property name="pCodes" ormtype="string";  
}