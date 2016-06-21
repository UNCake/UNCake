package uncake

class Prerequisite {

    Course course
    static belongsTo = [studyPlan: StudyPlan]
    static hasMany = [prerequistes: Course]

    static constraints = {
        prerequistes nullable: true
    }

    static mapping = {
        prerequistes batchSize: 10
    }
}
