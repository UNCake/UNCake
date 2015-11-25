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
    Integer languageCredits
    static hasMany = [courses: Prerequisite]
    static constraints = {
        code nullable: true, unique: true
        name blank: false, nullable: true
        faculty blank: true, nullable: true
        type blank: false, nullable: true
        courses nullable: true
        location nullable: true
        disciplinaryCredits nullable: true
        fundamentalCredits nullable: true
        freeChoiceCredits nullable: true
        languageCredits nullable: true
    }
}