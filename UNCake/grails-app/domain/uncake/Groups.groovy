package uncake

class Groups {

    String teacher
    Integer code
    Integer availableSpots
    Integer totalSpots
    static hasMany = [timeSlots: TimeSlot]
    //Faltan agregar limitaciones de inscripcion por carrera
    static constraints = {
        code nullable: false
    }
}
