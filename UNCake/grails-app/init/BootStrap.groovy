import uncake.Location
import uncake.User
class BootStrap {
    def DBconnectionService
    def init = { servletContext ->
        new User(email:"santi@unal.com", password:"lollol12", name:"Santi" ).save()
        new User(email:"alejandro@unal.com", password:"lollol12", name:"Alejandro" ).save()
        new User(email:"saniagoH@unal.com", password:"lollol12", name:"Santiago" ).save()
        new User(email:"hugo@unal.com", password:"lollol12", name:"Hugo" ).save()
        new User(email:"ana@unal.com", password:"lollol12", name:"Ana" ).save()



        //Inicializacion de Sedes
        new Location(name: 'AMAZONIA', url: 'http://siaama.unal.edu.co').save()
        new Location(name: 'BOGOTA', url: 'http://sia.bogota.unal.edu.co').save()
        new Location(name: 'CARIBE', url: 'http://siacar.unal.edu.co').save()
        new Location(name: 'MANIZALES', url: 'http://sia.manizales.unal.edu.co').save()
        new Location(name: 'MEDELLIN', url: 'http://sia.medellin.unal.edu.co').save()
        new Location(name: 'ORINOQUIA', url: 'http://siaori.unal.edu.co').save()
        new Location(name: 'PALMIRA', url: 'http://sia2.palmira.unal.edu.co').save()
        new Location(name: 'TUMACO', url: 'http://siatum.unal.edu.co').save()

        DBconnectionService.initDB()

    }
    def destroy = {
    }
}
