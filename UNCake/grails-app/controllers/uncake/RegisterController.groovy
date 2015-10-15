package uncake

class RegisterController {

    def index() {

    }
    def doRegister = {
        new Usuario(email: params.email, password: params.pwd2, name: params.nombre, code: -1, programCode: -1, academicRecord: null, course: null).save()
        redirect(controller:'login',action:'index')

    }
}