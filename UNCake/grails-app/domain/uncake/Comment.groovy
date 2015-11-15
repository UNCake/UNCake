package uncake

class Comment {
    Long code
    String comment;
    Date date;
    static belongsTo = [user: User, course: Course]
    

    static constraints = {
        code nullable: false, unique: true
        comment blank: false
        date nullable: true
        user nullable: true
        course nullable: true
    }
}
