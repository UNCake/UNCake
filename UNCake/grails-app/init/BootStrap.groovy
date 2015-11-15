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



        //DBconnectionService.initDB()

        //Materias de prueba
        new Course(code: 1, credits: 4, name: "Calculo diferencial", typology: "Fundamentacion").save()
        new Course(code: 2, credits: 3, name: "Teoria de la informacion y sistemas de comunicacion", typology: "Disciplinar").save()
        //println(Course.list())
        def srch = Course.findByCode(2)
        //println("course id found "+srch.name)

        //Adicion de comentarios de prueba
        new Comment(comment: "comment 1").save()
        new Comment(comment: "comment 2").save()
        new Comment(comment: "comment 6").save()
        new Comment(comment: "Comentario largo largo largo largo largo largo largo largo largo largo largo largo largo largo largo").save()
        new Comment(comment: "comment 8").save()
        new Comment(comment: "comment 9").save()
        new Comment(comment: "comment 10").save()
        new Comment(comment: "comment 11").save()
        new Comment(comment: "comment asdasdsa").save()
        Comment.list().each {
            comm ->
                println(comm.id)
                if (comm.id > 3)
                    Course.findByCode(1).addToComments(comm)

                else
                    Course.findByCode(2).addToComments(comm)

        }
        println Course.findByCode(1).comments
        println Course.findByCode(2).comments
    }
    def destroy = {
    }
}
