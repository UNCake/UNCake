package uncake

class SchCourse extends Course{

    Date lastUpdated
    static hasMany = [groups: Groups, plans: SchType]

    static constraints = {
        groups nullable: true
    }

    static mapping = {
        groups batchSize: 20
    }
}
