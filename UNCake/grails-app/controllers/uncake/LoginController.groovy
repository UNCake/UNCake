package uncake

class LoginController {

    def index = {

    }
    def doLogin = {
        // good request
        withForm {

            def user = User.findWhere(email:params.email, password:params.password.encodeAsSHA1())
            session.user = user

            if (user)
                redirect(controller:'home',action:'index')
            else{
                flash.message2="*"
                flash.message1="Los datos son incorrectos"
                redirect(controller:'login',action:'index')
            }

        }



    }

}

