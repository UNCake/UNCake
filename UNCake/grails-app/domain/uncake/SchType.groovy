package uncake

class SchType {

    StudyPlan studyPlan
    String typology

    static constraints = {
    }

    static mapping = {
        studyPlan cache: true
        cache: true
    }
}
