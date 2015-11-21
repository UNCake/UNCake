package uncake

class Schedule {

    Integer credits
    static hasMany = [courses: Groups]
    static constraints = {
        courses nullable: true
        credits nullable: true
    }
}
