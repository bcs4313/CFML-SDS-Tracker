// A join table describing the many-to-many relationship between 
// Chemicals and their hazards
component accessors="true" {
    property name="chemicalId" type="numeric"; // Foreign key 1
    property name="hazardId" type="numeric"; // Foreign key 2
    // Composite Key as identifier -> FK1 + FK2
}