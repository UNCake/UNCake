package uncake

class User {
    String name
    Integer code
    Integer program_code
    static belongsTo = [academicRecord:AcademicRecord]
    static hasMany = [course:Course]
    static constraints = {
    }
}
