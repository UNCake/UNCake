import uncake.User
class BootStrap {

    def init = { servletContext ->
        new User(email:"santi@unal.com", password:"lollol12", name:"Santi" ).save()
    }
    def destroy = {
    }
}
