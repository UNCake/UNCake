package uncake

class RegisterController {

    def index() {

    }
    def doRegister = {
        if(User.findWhere(email: params.email)){
            flash.message1="El email ya existe"
            redirect(controller:'register',action:'index')
        }else{
            new User(email: params.email, password: params.pwd2, name: params.nombre).save()
            redirect(controller:'login',action:'index')
        }

    }
}