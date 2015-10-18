package uncake

class Location {

    Integer code
    String name
    String url
    static constraints = {
        code nullable: false
        name blank: false
        url blank: false
    }
}
