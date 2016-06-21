package uncake

class SchCourse extends Course{

    static hasMany = [groups: Groups]

    static constraints = {
        groups nullable: true
    }

    static mapping = {
        groups batchSize: 10
    }
}
