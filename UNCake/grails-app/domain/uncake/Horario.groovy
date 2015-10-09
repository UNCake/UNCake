package uncake

class Horario {
    Integer codigo
    Integer creditos
    static belongsTo = [materia: Course]
    static constraints = {
    }
}
