package uncake


class SecurityInterceptor {

    SecurityInterceptor() {
        //poner aqui las paginas que solo se peudan ver si el usuario esta loggeado

        //matchAll()
        //        .except(controller:'user', action:'login')
    }

    boolean before() {
        if (!session.user && actionName != "index" && controllerName != "login") {
            redirect(controller: "login", action: "index")
            return false
        }
        return true
    }

    boolean after() { true }

    void afterView() {
        // no-op
    }
}
