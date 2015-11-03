package uncake

class User {

    String name
    String email
    String password
    //Posible avatar Img avt
    static hasMany = [academicRecord: AcademicRecord, friends: User, schedules: Schedule]
    static constraints = {
        name blank: false
        email blank: false, email: true
        password blank: false
        friends nullable: true
        academicRecord nullable: true
    }
}
