package uncake


class SecurityInterceptor {

    SecurityInterceptor() {
        match(controller:'profile')
        match(controller:'user')
    }

    boolean before() {
        if (!session.user) {
            redirect(controller: "home", action: "index")
            return false
        }
        return true
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
