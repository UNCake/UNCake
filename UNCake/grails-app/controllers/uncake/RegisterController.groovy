package uncake

import grails.validation.ValidationException

class RegisterController {

    def index() {
        if(session.user!=null){
            redirect(controller:'home')
        }
    }

    def doRegister = {

        if(User.findWhere(email: params.email)){
            flash.message1="El email ya existe"
            redirect(controller:'register',action:'index')
        }else{
            try {
                def u = new User(email: params.email, password: params.pwd2.encodeAsSHA1(), name: params.nombre).save()
                session.user = u
                redirect(controller:'home')
            } catch(ValidationException ve) {
                flash.message1="El email es invalido"
                redirect(controller:'register')
            }
        }

    }
}