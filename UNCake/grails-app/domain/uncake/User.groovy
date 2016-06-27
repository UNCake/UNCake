package uncake

class User {

    String name
    String email
    String password
    byte[] avatar
    String avatarType

    static hasMany = [academicRecord: AcademicRecord, friends: User, schedules: Schedule]
    static constraints = {
        name blank: false
        email blank: false, unique: true
        password blank: false
        friends nullable: true
        academicRecord nullable: true
        avatar(nullable:true, maxSize: 2097152 /* 2MB */)
        avatarType(nullable:true)
    }

    static mapping = {
        schedules batchSize: 5
        academicRecord batchSize: 5
    }
}
