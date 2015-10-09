package uncake

class Building {

    String code
    String name
    String coordinates

    static constraints = {
        code nullable:false, blank:false, unique: true
        name nullable:false, blank:false
        coordinates nullable:false, blank:false
    }


}
