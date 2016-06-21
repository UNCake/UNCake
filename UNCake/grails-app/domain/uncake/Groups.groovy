package uncake

class Groups {

    String teacher
    String code
    Integer availableSpots
    Integer totalSpots
    static hasMany = [timeSlots: TimeSlot]
    static belongsTo = [course: SchCourse]
    static constraints = {
        code nullable: false
        timeSlots nullable: true
    }

    static mapping = {
        timeSlots batchSize: 10
        course fetch: 'join'
    }
}
