package uncake

class User {
    String name
    Integer codr
    Integer program_code
    static belongsTo = [timeline:Timeline]
    static hasMany = [course:Course]
    static constraints = {
    }
}
