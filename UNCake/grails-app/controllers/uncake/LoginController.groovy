package uncake

class LoginController {

    def index = {

    }
    def doLogin = {

      def usuario = Usuario.findWhere(email:params.email, password:params.password)
        session.user = usuario
        if (usuario)
            redirect(controller:'home',action:'index')
        else{
            flash.message1="*"
            flash.message2="Los datos son incorrectos"
            redirect(controller:'login',action:'index')
        }

    /*    println params
        println params.email
        println params.password
        if (params.email=="admin@hot.com" && params.password=="lollol")
            render "login xx"
        else
            render "sorry"*/
    }

}

