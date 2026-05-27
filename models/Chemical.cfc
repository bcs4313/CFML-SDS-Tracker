// represents the concept of a chemical
// hazard classes are obtained by querying
// the ChemicalHazard JOIN table with the primary key
// uses ORM for our MySQL database.
component persistent="true" accessors="true" {
    property name="id" fieldtype="id" type="numeric" ormtype="integer" generator="native";  // primary key

    // common or preferred name of chemical
    property name="name" ormtype="string" length="255";

    // unique identifier for the chemical substance
    // requires business logic to verify the property's integrity
    property name="casNumber" ormtype="string" length="255";

    // optional GHS / SDS fields
    // IUPAC systematic name (e.g. "oxidane" for water)
    property name="iupacName" ormtype="string" length="255";
    // molecular formula in Hill notation (e.g. "H2O", "C6H6")
    property name="molecularFormula" ormtype="string" length="100";
    // physical state at standard conditions: solid | liquid | gas | unknown
    property name="physicalState" ormtype="string" length="20";
    // molecular weight in g/mol (e.g. "18.015")
    property name="molecularWeight" ormtype="string" length="50";

}
