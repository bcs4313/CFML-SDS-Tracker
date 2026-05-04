// represents the concept of a chemical
// hazard classes are obtained by querying
// the ChemicalHazard JOIN table with the primary key
component accessors="true" {
    property name="id" type="numeric";  // primary key

    // common or preferred name of chemical
    property name="name" type="string";

    // unique identifier for the chemical substance
    // requires business logic to verify the property's integrity
    property name="casNumber" type="string";

}