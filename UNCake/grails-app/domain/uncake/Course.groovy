package uncake

class Course {

    String code
    Integer credits
    String name

    static constraints = {
    }

    static mapping = {
        cache: true
    }
}