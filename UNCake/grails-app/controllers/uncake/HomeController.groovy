package uncake

class HomeController {

    def index() {
        [userlist: User.list().name]
    }

    def saveFriend = {
        print params.selectedName
        //redireccionar
        redirect(controller:'home',action:'index')
    }

}
