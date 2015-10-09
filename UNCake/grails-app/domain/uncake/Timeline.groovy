package uncake

class Timeline {
    Integer code
    Integer study_plan_code
    Integer credits
    Integer PAPA
    Integer PA
    static hasMany = [approved_courses:Course,
    lost_courses:Course,
    cancelled_courses:Course]
    static mappedBy = [approved_courses: "none",
    lost_courses: "none",
    cancelled_courses: "none"]
    static constraints = {
    }
}
