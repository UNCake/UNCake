package uncake

class HomeController {

    def index() {
        [userlist: User.list().name]
    }

}
