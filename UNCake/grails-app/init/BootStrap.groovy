import uncake.User
class BootStrap {

    def init = { servletContext ->
        new User(email:"santi@unal.com", password:"lollol12", name:"Santi" ).save()
        new User(email:"alejandro@unal.com", password:"lollol12", name:"Alejandro" ).save()
        new User(email:"saniagoH@unal.com", password:"lollol12", name:"Santiago" ).save()
        new User(email:"hugo@unal.com", password:"lollol12", name:"Hugo" ).save()
        new User(email:"ana@unal.com", password:"lollol12", name:"Ana" ).save()
    }
    def destroy = {
    }
}
