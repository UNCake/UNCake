package uncake

class SchType {

    StudyPlan studyPlan
    SchCourse course
    String typology

    static constraints = {
    }

    static mapping = {
        studyPlan index:'StudyPlan_Idx'
        course index:'StudyPlan_Idx,SchCourse_Idx'
        typology index:'StudyPlan_Idx,SchCourse_Idx,Typo_Idx'
        cache: true
    }
}
