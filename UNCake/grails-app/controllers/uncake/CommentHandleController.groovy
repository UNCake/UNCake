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
        render(view: "comments", model:[name: course.name, comments: course.comments, courseId: course.id])
        new Comment(code: 1, comment: "comment 1").save()
    }


    def saveComment() {
        println("in save")
        println(params.comment)
        println(params.id)
        def comment = new Comment(comment: params)

        render ''
    }
    def not_fun() {
        render 'shet'
    }
}
