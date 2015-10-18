package uncake

class StudyPlan {

    Integer code
    String faculty
    String type
    String name
    Integer fundamentalCredits
    Integer freeChoiceCredits
    Integer disciplinaryCredits
    static hasMany = [courses: Prerequisite]
    static constraints = {
        code nullable: false, unique: true
        name blank: false
        faculty blank: false
        type blank: false
        courses nullable: true
        disciplinaryCredits nullable: true
        fundamentalCredits nullable: true
        freeChoiceCredits nullable: true
    }
}
