package uncake

class User {
    String name
    Integer code
    Integer program_code
    static belongsTo = [timeline:Timeline]
    static hasMany = [course:Course]
    static constraints = {
    }
}
