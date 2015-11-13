package uncake

class Comment {
    Long id
    String comment;
    Date date;
    static belongsTo = [user: User]
    static constraints = {
        id nullable: false, unique: true
        comment blank: false
        date nullable: true
        user nullable: true
    }
}
