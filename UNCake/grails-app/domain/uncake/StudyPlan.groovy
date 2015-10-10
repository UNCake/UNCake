package uncake

class StudyPlan {
    Integer code
    String faculty
    String department
    Integer fundamentation_credits
    Integer free_course_credits
    Integer disciplinar_credits
    static hasMany = [course: Course]
    static mappedBy = [course: "none"]
    static constraints = {
    }
}
