package uncake

class Usuario {
    String nombre
    Integer codigo
    Integer cod_programa
    static belongsTo = [historia:HistoriaAcademica]
    static hasMany = [asignatura:Course]
    static constraints = {
    }
}
