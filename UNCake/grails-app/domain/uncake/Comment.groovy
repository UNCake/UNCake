package uncake

class Comment {
    String comment;
    Date date;
    static belongsTo = [user: User]
    static constraints = {
    }
}
