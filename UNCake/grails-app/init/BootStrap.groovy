import uncake.Usuario
class BootStrap {

    def init = { servletContext ->
        new Usuario(email:"santi@unal.com", password:"lollol12",nombre:"Santi",codigo:-1,cod_programa:-1, historia: null, asignatura: null ).save()
    }
    def destroy = {
    }
}
