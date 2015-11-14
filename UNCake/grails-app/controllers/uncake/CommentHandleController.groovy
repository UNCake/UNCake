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
        render(view: "comments", model:[name: course.name, comments: course.comments])
    }
    def saveComment() {

    }
    def not_fun() {
        render 'shet'
    }
}
