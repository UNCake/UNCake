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
        availableSpots nullable: true
        totalSpots nullable: true
    }

    static mapping = {
        timeSlots batchSize: 10, cascade: "all-delete-orphan", cache: true
        course fetch: 'join', index: 'Course_idx', cache: true
        cache: true
        teacher index: 'Teacher_Idx'
        code index: 'Code_Idx,Course_idx'
    }
}
