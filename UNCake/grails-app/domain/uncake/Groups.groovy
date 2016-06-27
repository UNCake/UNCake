package uncake

class Groups {

    String teacher
    String code
    Integer availableSpots
    Integer totalSpots
    Collection timeSlots
    static hasMany = [timeSlots: TimeSlot]
    static belongsTo = [course: SchCourse]
    static constraints = {
        code nullable: false
        timeSlots nullable: true
        availableSpots nullable: true
        totalSpots nullable: true
    }

    static mapping = {
        timeSlots batchSize: 10, cache: true
        course fetch: 'join', cache: true
        cache: true
    }
}
