package uncake

class HomeController {
    def index() {}
/*
    def saveFriend = {
        def friend = User.findWhere(name:params.diagNombre, email: params.diagMail)
        def user= User.find(session.user)

        user.addToFriends(friend)
        //redireccionar
        redirect(controller:'home',action:'index')
    }

    def getUserByName(){
        def user = User.findWhere(name:params.selectedName)
        if(user != null) {
            render user as JSON
        }else{
            def nulluser = new User(email:"nullmail", password:"nullpass", name:"null" )
            render nulluser as JSON
        }
    }
    */
}
