package uncake

class Schedule {

    Integer credits
    static hasMany = [courses: Course]
    static constraints = {
        courses nullable: true
        credits nullable: true
    }
}
