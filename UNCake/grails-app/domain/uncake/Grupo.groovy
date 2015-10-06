package uncake

class Grupo {
    //List list
    String profesor
    Integer codigo
    static hasOne = [horario:Horario]
    //salones?
    static constraints = {
    }
}
