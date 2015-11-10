package uncake

class User {

    private static final long serialVersionUID = 1

    transient springSecurityService

    String name
    String email
    String password
    //Posible avatar Img avt

    //SS
    boolean enabled = true
    boolean accountExpired
    boolean accountLocked
    boolean passwordExpired


    static hasMany = [academicRecord: AcademicRecord, friends: User, schedules: Schedule]


    //SS
    @Override
    int hashCode() {
        email?.hashCode() ?: 0
    }

    @Override
    boolean equals(other) {
        is(other) || (other instanceof User && other.email == email)
    }

    @Override
    String toString() {
        email
    }

    Set<Role> getAuthorities() {
        UserRole.findAllByUser(this)*.role
    }

    def beforeInsert() {
        encodePassword()
    }

    def beforeUpdate() {
        if (isDirty('password')) {
            encodePassword()
        }
    }

    protected void encodePassword() {
        password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
    }

    static transients = ['springSecurityService']

    static mapping = {
        password column: '`password`'
    }


    static constraints = {
        name blank: false
        email blank: false, email: true
        password blank: false
        friends nullable: true
        academicRecord nullable: true
    }
}
