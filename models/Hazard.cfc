// represents an individual hazard level for a chemical (concept)
component persistent="true" accessors="true" {
    property name="id" fieldtype="id" ormtype="integer" generator="native" type="numeric";   // primary key
    
    property name="name" ormtype="string";  
    property name="hazardClass" column="hazardClass" ormtype="string";   
    property name="pictogramUrl" column="pictogramUrl" ormtype="string"; 
    property name="signalWord" column="signalWord" ormtype="string";   
    property name="hCodes" column="hCodes" ormtype="string";  
    property name="pCodes" column="pCodes" ormtype="string";  

    // Optional GHS / SDS fields
    // hazard category within the class (e.g. "1", "2A", "3")
    property name="hazardCategory" column="hazardCategory" ormtype="string" length="20";
    // routes of exposure relevant to this hazard - stored comma-separated
    // typical values: inhalation, skin contact, eye contact, ingestion
    property name="exposureRoutes" column="exposureRoutes" ormtype="string" length="255";
    // UN transport number for dangerous goods (e.g. "UN1090")
    property name="unNumber" column="unNumber" ormtype="string" length="20";
}