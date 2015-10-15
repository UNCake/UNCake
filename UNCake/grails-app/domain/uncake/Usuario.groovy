package uncake

class Usuario {
    String name
    String email
    String password
    Integer code
    Integer programCode
    static belongsTo = [academicRecord:HistoriaAcademica]
    static hasMany = [course:Asignatura]
    static constraints = {
        academicRecord nullable:true
        course nullable: true
        email unique: true
    }
}
