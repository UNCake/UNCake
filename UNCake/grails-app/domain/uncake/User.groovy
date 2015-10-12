package uncake

class User {
    String name
    Integer code
    Integer program_code
    static belongsTo = [history:HistoriaAcademica]
    static hasMany = [course:Course]
    static constraints = {
    }
}
