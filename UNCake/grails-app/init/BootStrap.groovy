import uncake.Usuario
class BootStrap {

    def init = { servletContext ->
        new Usuario(email:"santi@unal.com", password:"lollol12", name:"Santi", code:-1, programCode:-1, academicRecord: null, course: null ).save()
    }
    def destroy = {
    }
}
