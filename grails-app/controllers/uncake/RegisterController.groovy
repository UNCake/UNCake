package uncake

class RegisterController {

    def index() {

    }
    def doRegister = {


        if(User.findWhere(email: params.email)){
            flash.message1="El email ya existe"
            redirect(controller:'register',action:'index')
        }else{
            if(new User(email: params.email, password: params.pwd2, name: params.nombre).save()==null){
                flash.message1="El email es invalido"
                redirect(controller:'register',action:'index')

            }
            else{
                redirect(controller:'login',action:'index')
            }

        }

    }
}