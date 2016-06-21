package uncake

class TimeSlot {

    String day
    Integer startHour
    Integer endHour
    String classroom
    Building building

    static constraints = {
        day nullable: true
        startHour nullable: true
        endHour nullable: true
        classroom nullable: true
        building nullable: true
    }

    static mapping = {
        building fetch: 'join'
    }
}
