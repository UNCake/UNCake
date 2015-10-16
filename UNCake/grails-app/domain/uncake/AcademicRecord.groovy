package uncake

class AcademicRecord {

    StudyPlan studyPlan
    Integer credits
    Double PAPA
    Double PA
    static belongsTo = [user: User]
    static hasMany = [approved: Course, lost: Course, cancelled: Course]

    static constraints = {
        studyPlan nullable: false
        approved nullable: true
        lost nullable: true
        cancelled nullable: true
    }
}
