package uncake

class Usuario {
    String nombre
    String email
    String password
    Integer codigo
    Integer cod_programa
    static belongsTo = [historia:HistoriaAcademica]
    static hasMany = [asignatura:Asignatura]
    static constraints = {
        historia nullable:true
        asignatura nullable: true
        email unique: true
    }
}
