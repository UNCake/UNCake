package uncake

class PlanEstudios {
    Integer codigo
    String facultad
    String Departamento
    Integer creditos_fundamentacion
    Integer creditos_libre_eleccion
    Integer creditos_disciplinar
    static hasMany = [materia: Course]
    static mappedBy = [materia: "none"]
    static constraints = {
    }
}
