package uncake

class Building {

    String code
    String name
    String coordinates
    Location location

    static constraints = {
        code nullable: false, blank: false, unique: true
        name nullable: false, blank: false
        coordinates nullable: false, blank: false
        location nullable: true
    }

    static mapping = {
        location fetch: 'join', cache: true
        cache: true
    }
}
