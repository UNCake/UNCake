package uncake

class SchCourse extends Course{

    Date lastUpdated
    static hasMany = [groups: Groups]

    static constraints = {
        groups nullable: true
    }

    static mapping = {
        groups batchSize: 20, cache: true
        cache: true
    }
}
