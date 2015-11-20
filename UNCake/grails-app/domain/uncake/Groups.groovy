package uncake

class Groups {

    String course
    String teacher
    Integer code
    Integer availableSpots
    Integer totalSpots
    static hasMany = [timeSlots: TimeSlot]

    static constraints = {
        code nullable: false
        timeSlots nullable: true
    }
}
