package uncake

class Group {
    //List list
    String teacher
    Integer code
    static belongsTo = [schedule:Schedule]
    //salones?
    static constraints = {
    }
}
