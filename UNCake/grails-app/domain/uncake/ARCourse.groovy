package uncake

class ARCourse extends Course{

    String typology
    Double grade
    String semester
    Integer semesterNumber

    static belongsTo = [academicRecord: AcademicRecord]

    static constraints = {
    }
}
