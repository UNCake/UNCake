package uncake

class Course {
    Integer code
    Integer credits
    static hasMany = [groups: Group]
    static mappedBy = [groups: "none"]
    Integer courseId
    String name
    String typology
    static constraints = {
    }
}
