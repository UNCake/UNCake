package uncake

class Course {

    String code
    Integer credits
    String name

    static constraints = {
    }

    static mapping = {
        code index: 'Code_Idx'
        cache: true
    }
}