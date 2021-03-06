package uncake

class AcademicRecord {

    StudyPlan studyPlan
    Integer credits
    Double PAPA
    Double PA
    static belongsTo = [user: User]
    static hasMany = [courses: ARCourse]

    static constraints = {
        courses nullable: true
    }

    static mapping = {
        courses batchSize: 10
    }
}