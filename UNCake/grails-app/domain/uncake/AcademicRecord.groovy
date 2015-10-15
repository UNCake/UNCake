package uncake

class AcademicRecord {
    Integer code
    Integer studyPlanCode
    Integer credits
    Double PAPA
    Double PA
    static hasMany = [approved:Course,
    lost:Course,
    cancelled:Course]
    static mappedBy = [approved: "none",
    lost: "none",
    cancelled: "none"]
    static constraints = {
    }
}
