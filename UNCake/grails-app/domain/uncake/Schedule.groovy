package uncake

class Schedule {

    Integer credits
    static hasMany = [courses: Course]
    static belongsTo = [user: User]
    static constraints = {

    }
}
