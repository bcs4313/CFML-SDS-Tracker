// represents the concept of a chemical
// hazard classes are obtained by querying
// the ChemicalHazard JOIN table with the primary key
// uses ORM for our MySQL database.
component persistent="true" accessors="true" {
    // ORM constructors in Hibernate don't take arguments.
    // Required arguments are enforced via service factory functions.
    function init() {
        return true;
    }

    property name="id" fieldtype="id" type="numeric" ormtype="integer" generator="native";  // primary key

    // common or preferred name of chemical
    property name="name" ormtype="string" length="255";

    // unique identifier for the chemical substance
    // requires business logic to verify the property's integrity
    property name="casNumber" ormtype="string" length="255";

}