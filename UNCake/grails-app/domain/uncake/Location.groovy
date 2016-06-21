package uncake

class Location {

    String name
    String url
    static constraints = {
        name blank: false, unique: true
        url blank: false
    }
}
