package uncake


//BORRAR LOS PRINTLN DESPUES
class CommentHandleController {
    def index() {
        println("index")
    }

    def comments() {
        println("in comments")
        println(params.code)
        def course = Course.findByCode(params.code)
        course.comments.each {
            comm ->
            println comm.comment
        }
        render(view: "comments", model:[name: course.name, comments: course.comments])
    }


    def saveComment() {
        println("in save")
        println(params.comment)
        render ''
    }
    def not_fun() {
        render 'shet'
    }
}
