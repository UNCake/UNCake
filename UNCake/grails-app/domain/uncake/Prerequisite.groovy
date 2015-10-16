package uncake

class Prerequisite {

    Course course
    static hasMany = [prerequistes: Course]

    static constraints = {
        course nullable: false
        prerequistes nullable: true
    }
}
