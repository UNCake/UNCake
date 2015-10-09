package uncake

class Course {
    Integer code
    Integer credits
    static hasMany = [groups: Group]
    static mappedBy = [groups: "none"]
    Integer course_id
    String name
    String typology
    static constraints = {
    }
}
