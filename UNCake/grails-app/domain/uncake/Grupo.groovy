package uncake

class Grupo {
    //List list
    String profesor
    Integer codigo
    static belongsTo = [horario:Horario]
    //salones?
    static constraints = {
    }
}
