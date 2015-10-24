import uncake.Location
import uncake.User
class BootStrap {
    def DBconnectionService
    def init = { servletContext ->
        new User(email:"santi@unal.com", password:"lollol12", name:"Santi" ).save()


        //Inicializacion de Sedes
        new Location(name: 'AMAZONIA', url: 'http://siaama.unal.edu.co/academia/').save()
        new Location(name: 'BOGOTA', url: 'http://sia.bogota.unal.edu.co/academia/').save()
        new Location(name: 'CARIBE', url: 'http://siacar.unal.edu.co/academia/').save()
        new Location(name: 'MANIZALES', url: 'http://sia.manizales.unal.edu.co/academia/').save()
        new Location(name: 'MEDELLIN', url: 'http://sia.medellin.unal.edu.co/academia/').save()
        new Location(name: 'ORINOQUIA', url: 'http://siaori.unal.edu.co/academia/').save()
        new Location(name: 'PALMIRA', url: 'http://sia2.palmira.unal.edu.co/academia/').save()
        new Location(name: 'TUMACO', url: 'http://siatum.unal.edu.co/academia/').save()

        DBconnectionService.initDB()
    }
    def destroy = {
    }
}
