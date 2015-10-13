package uncake

class User {
    String name
    Integer code
    Integer programCode
    static belongsTo = [academicRecord:AcademicRecord]
    static hasMany = [course:Course]
    static constraints = {
    }
}
