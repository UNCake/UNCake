package uncake

class StudyPlan {

    Integer code
    String type
    String name
    static hasMany = [courses: Prerequisite]
    static constraints = {
        code nullable: false, unique: true
        name blank: false
        type blank: false
        courses nullable: true
    }
}