package uncake

class LogoutController {

    def index() {
        //log.info "User agent: " + request.getHeader("User-Agent")
        session.invalidate()
        redirect(controller: "home")
    }
}
