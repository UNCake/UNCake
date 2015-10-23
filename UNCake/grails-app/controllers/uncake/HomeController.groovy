package uncake

class HomeController {
    def rootUser = new User(email:"root@root.com", password:"root12345", name:"RootUser")
    def index() {
        [userlist: User.list().name]
    }

    def saveFriend = {
        print params.diagNombre
        def user = User.findWhere(name:params.diagNombre)
        print user.name
        /*def a=[]
        if(!rootUser.friends) {
            a.add(user)
            rootUser.friends=a
        }else
            rootUser.friends.add(user)*/
        //redireccionar
        redirect(controller:'home',action:'index')
    }

}
