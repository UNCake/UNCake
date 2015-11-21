import uncake.Location
import uncake.User
class BootStrap {
    def DBconnectionService
    def init = { servletContext ->
        def user1=new User(email:"santi@unal.com", password:"lollol12".encodeAsSHA1(), name:"Santi" ).save()
        def user2=new User(email:"alejandro@unal.com", password:"lollol12".encodeAsSHA1(), name:"Alejandro" ).save()
        def user3=new User(email:"saniagoH@unal.com", password:"lollol12".encodeAsSHA1(), name:"Santiago" ).save()
        def user4=new User(email:"hugo@unal.com", password:"lollol12".encodeAsSHA1(), name:"Hugo" ).save()
        def user5=new User(email:"ana@unal.com", password:"lollol12".encodeAsSHA1(), name:"Ana" ).save()


        user1.addToFriends(user2).save()
        user1.addToFriends(user3).save()
        user1.addToFriends(user4).save()
        user1.addToFriends(user5).save()

       println user1.friends



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
