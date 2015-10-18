package uncake

class Location {

    String name
    String url
    static constraints = {

        name blank: false
        url blank: false
    }
}
