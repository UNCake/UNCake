package uncake

class Course {

    Integer code
    Integer credits
    static hasMany = [groups: Groups]
    String name
    String typology
    Double grade
    String semester
    static constraints = {
        code nullable: false, unique: true
        name blank: false
        typology blank: false
        grade nullable: true
        credits nullable: true
        semester nullable: true
        groups nullable: true
    }
}