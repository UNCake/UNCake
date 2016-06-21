package uncake

class StudyPlan {

    Integer code
    Location location
    String type
    String name
    Integer fundamentalCredits
    Integer disciplinaryCredits
    Integer freeChoiceCredits
    Integer remedialCredits

    static hasMany = [courses: Prerequisite]
    static constraints = {
        code nullable: false, unique: true
        location nullable: true
        name blank: false
        type blank: false
        courses nullable: true
        fundamentalCredits nullable: true
        disciplinaryCredits nullable: true
        freeChoiceCredits nullable: true
        remedialCredits nullable: true
    }

    static mapping = {
        courses batchSize: 20
    }
}