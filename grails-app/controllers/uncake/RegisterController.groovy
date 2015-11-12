package uncake

class RegisterController {

    def index() {
        if(session.user!=null){
            render{
                div(id: "myDiv", "Ya iniciaste sesión, si no eres ${session.user.name} y quieres registrate oprime atrás y luego el botón de salir")
            }

        }

    }
    def doRegister = {


        if(User.findWhere(email: params.email)){
            flash.message1="El email ya existe"
            redirect(controller:'register',action:'index')
        }else{
            if(new User(email: params.email, password: params.pwd2.encodeAsSHA1(), name: params.nombre).save()==null){
                flash.message1="El email es invalido"
                redirect(controller:'register')

            }
            else{
                redirect(controller:'login')
            }

        }

    }
}