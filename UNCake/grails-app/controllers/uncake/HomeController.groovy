package uncake

import grails.converters.JSON

class HomeController {
    def rootUser = new User(email:"root@root.com", password:"root12345", name:"RootUser")
    def index() {
        [userlist: User.list().name]
    }

    def saveFriend = {
        def user = User.findWhere(name:params.diagNombre, email: params.diagMail)
        def a=[]
        if(!rootUser.friends) {
            a.add(user)
            rootUser.friends=a
        }else
            rootUser.friends.add(user)
        //redireccionar
        redirect(controller:'home',action:'index')
        print rootUser.friends
    }

    def getUserByName(){
        def user = User.findWhere(name:params.selectedName)
        render user as JSON
    }

}
