package uncake

class Schedule {

    Integer credits
    String name
    Location location
    static belongsTo = [user: User]
    static hasMany = [courses: Groups]
    static constraints = {
        courses nullable: true
        credits nullable: true
        name nullable: true
    }

    static mapping = {
        courses batchSize: 10
        user index: "User_idx"
        name index: "User_idx,Name_idx"
    }
}
