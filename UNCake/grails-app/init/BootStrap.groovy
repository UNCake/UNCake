import uncake.Comment
import uncake.Course
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

        //Materias de prueba

        new Course(code: 1, name: "Calculo diferencial", typology: "Fundamentacion").save()
        new Course(code: 2, name: "Teoria de la informacion y sistemas de comunicacion", typology: "").save()
        def srch = Course.findById(2)
        println("course id found "+srch.name)

        //Adicion de comentarios de prueba

        def c = new Comment(id: 1, comment: "Esa materia es una mierda")
        c.save()
        srch.addToComments(c)
        def srch2 = srch.comments.findAll {
            comment -> comment.id == 1
        }
        srch2.each {
            println(it.comment)
        }

    }
    def destroy = {
    }
}
