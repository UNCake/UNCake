package uncake

class Schedule {

    Integer credits
    String name
    static hasMany = [courses: Groups]
    static constraints = {
        courses nullable: true
        credits nullable: true
        name nullable: true
    }
}
