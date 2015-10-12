package uncake

class Timeline {
    Integer code
    Integer study_plan_code
    Integer credits
    Integer PAPA
    Integer PA
    static hasMany = [approved:Course,
    lost:Course,
    cancelled:Course]
    static mappedBy = [approved: "none",
    lost: "none",
    cancelled: "none"]
    static constraints = {
    }
}
