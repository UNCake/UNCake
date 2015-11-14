package uncake

class StudyPlan {

    Integer code
    String faculty
    String type
    String name
    Location location
    Integer fundamentalCredits
    Integer freeChoiceCredits
    Integer disciplinaryCredits
    static hasMany = [courses: Prerequisite]
    static constraints = {
        code nullable: false, unique: true
        name blank: false
        faculty blank: true, nullable: true
        type blank: false
        courses nullable: true
        location nullable: false
        disciplinaryCredits nullable: true
        fundamentalCredits nullable: true
        freeChoiceCredits nullable: true
    }
}