package uncake

class Course {

    String code
    Integer credits
    String name
    String typology

    static constraints = {
        typology nullable: true
    }
}