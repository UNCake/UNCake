package uncake

class StudyPlan {

    Integer code
    String type
    String name
    Integer fundamentalCredits
    Integer disciplinaryCredits
    Integer freeChoiceCredits
    Integer remedialCredits

    static hasMany = [courses: Prerequisite]
    static constraints = {
        code nullable: false, unique: true
        name blank: false
        type blank: false
        courses nullable: true
        fundamentalCredits nullable: true
        disciplinaryCredits nullable: true
        freeChoiceCredits nullable: true
        remedialCredits nullable: true
    }
}