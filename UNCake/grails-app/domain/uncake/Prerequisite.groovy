package uncake

class Prerequisite {

    String code
    Course course
    static hasMany = [prerequistes: Course]

    static constraints = {
        code nullable: true
        course nullable: true
        prerequistes nullable: true
    }
}
