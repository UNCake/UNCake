package uncake

class Schedule {
    Integer code
    Integer credits
    static belongsTo = [course: Course]
    static constraints = {
    }
}
