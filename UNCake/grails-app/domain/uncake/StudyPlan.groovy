package uncake

class StudyPlan {
    Integer code
    String faculty
    String department
    Integer fundamentalCredits
    Integer freeChoiceCredits
    Integer disciplinaryCredits
    static hasMany = [course: Course]
    static mappedBy = [course: "none"]
    static constraints = {
    }
}
