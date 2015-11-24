package uncake

class User {

    String name
    String email
    String password
    byte[] avatar
    String avatarType
    //Posible avatar Img avt
    static hasMany = [academicRecord: AcademicRecord, friends: User, schedules: Schedule]
    static constraints = {
        name blank: false
        email blank: false, email: true
        password blank: false
        friends nullable: true
        academicRecord nullable: true
        avatar(nullable:true, maxSize: 1000000 /* 1000k */)
        avatarType(nullable:true)
    }
}
