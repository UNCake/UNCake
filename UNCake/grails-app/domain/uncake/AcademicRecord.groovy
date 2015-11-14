package uncake

class AcademicRecord {

    StudyPlan studyPlan
    Integer credits
    Double PAPA
    Double PA
    static belongsTo = [user: User]
    static hasMany = [courses: Course]

    static constraints = {
        studyPlan nullable: false
        courses nullable: true
    }
}