// abstraction layer for chemicals
// uses ORM for our MySQL database.
component persistent="true" accessors="true" {
    property name="id" fieldtype="id" generator="native";
    property name="name" ormtype="string" length="255";
    property name="casNumber" ormtype="string" length="string";

    // ORM constructors in Hibernate don't take arguments.
    // Required arguments are enforced via service factory functions.
    function init() {
        return true;
    }

    // create the new orm instance
    // flush to the database
    function create(required Chemical chemical) {
        EntitySave(chemical);
        ormFlush();
    }

    public Chemical function loadById(required numeric targetID) {
        return EntityLoadByPK("Chemical", targetID);
    }
}