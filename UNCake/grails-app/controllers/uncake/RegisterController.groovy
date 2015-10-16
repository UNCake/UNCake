package uncake

class RegisterController {

    def index() {

    }
    def doRegister = {
        new User(email: params.email, password: params.pwd2, name: params.nombre).save()
        redirect(controller:'login',action:'index')

    }
}