package uncake

class Course {

    Integer code
    Integer credits
    static hasMany = [groups: Groups, comments: Comment]
    String name
    String typology
    static constraints = {
        code nullable: false, unique: true
        name blank: false
        typology blank: false
    }
}
