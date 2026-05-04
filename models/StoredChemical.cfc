// The chemical as stored in a specific location (represents a physical thing)
// has a many to one relationship to Chemical.cfc 
component accessors="true" {
    property name="id" type="numeric"; // primary key
    property name="chemicalId" type="numeric"; // foreign key

    property name="quantity" type="numeric";
    property name="quantityUnit" type="string";  // unit type should be validated

    property name="location" type="string"; // location in the facility
    property name="expirationDate" type="date";
    property name="dateReceived" type="date";
    property name="lotNumber" type="string";
}