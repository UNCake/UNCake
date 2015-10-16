package uncake

class Location {

    Integer code
    String name
    String suffixURL
    static constraints = {
        code nullable: false
        name blank: false
    }
}
