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
}
