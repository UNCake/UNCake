package uncake

class Asignatura {
    Integer codigo
    Integer creditos
    static hasMany = [grupos: Grupo]
    static mappedBy = [grupos: "none"]
    Integer id_asignatura
    String nombre
    String tipologia
    static constraints = {
    }
}
