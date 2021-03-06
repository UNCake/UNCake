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
        cache: true
        location index: "Loc_Idx"
        name index: "Loc_Idx,Name_Idx"
    }
}