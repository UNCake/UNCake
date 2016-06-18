package uncake

class Schedule {

    Integer credits
    String name
    String image
    static belongsTo = [user: User]
    static hasMany = [courses: Groups]
    static constraints = {
        courses nullable: true
        credits nullable: true
        name nullable: true
        image nullable: true, maxSize: 9999999
    }
}
