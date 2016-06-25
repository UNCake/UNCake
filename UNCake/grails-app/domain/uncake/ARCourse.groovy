package uncake

class ARCourse extends Course{

    Double grade
    String semester
    Integer semesterNumber

    static belongsTo = [academicRecord: AcademicRecord]

    static constraints = {
    }
}
