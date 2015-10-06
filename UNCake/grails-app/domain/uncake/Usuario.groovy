package uncake

class Usuario {
    String nombre
    Integer codigo
    Integer cod_programa
    static hasOne = [historia:HistoriaAcademica]
    static hasMany = [asignatura:Asignatura]
    static constraints = {
    }
}
