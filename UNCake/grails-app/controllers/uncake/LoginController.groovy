package uncake

class LoginController {

    def index = {

    }
    def doLogin = {

      def user = User.findWhere(email:params.email, password:params.password)
        session.user = user
        if (user)
            redirect(controller:'home',action:'index')
        else{
            flash.message1="*"
            flash.message2="Los datos son incorrectos"
            redirect(controller:'login',action:'index')
        }
        print session.user

    /*    println params
        println params.email
        println params.password
        if (params.email=="admin@hot.com" && params.password=="lollol")
            render "login xx"
        else
            render "sorry"*/
    }

}

