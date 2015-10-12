package uncake

class StudyPlan {
    Integer code
    String faculty
    String department
    Integer basis_credits
    Integer free_choice_credits
    Integer disciplinary_credits
    static hasMany = [course: Course]
    static mappedBy = [course: "none"]
    static constraints = {
    }
}
