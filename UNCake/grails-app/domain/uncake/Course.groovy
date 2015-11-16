package uncake

class Course {

    String code
    Integer credits
    static hasMany = [groups: Groups]
    String name
    String typology
    Double grade
    String semester
    Location location
    static constraints = {
        code nullable: true
        name nullable: true
        typology nullable: true
        grade nullable: true
        credits nullable: true
        semester nullable: true
        groups nullable: true
        location nullable: true
    }
}
