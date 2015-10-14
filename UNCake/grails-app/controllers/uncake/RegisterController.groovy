package uncake

class RegisterController {

    def index() {

    }
    def doRegister = {
        new Usuario(email: params.email, password: params.pwd2, nombre: params.nombre, codigo: -1, cod_programa: -1, historia: null, asignatura: null).save()
        redirect(controller:'login',action:'index')

    }
}