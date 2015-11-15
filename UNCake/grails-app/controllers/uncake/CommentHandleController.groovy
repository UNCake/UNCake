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
        render(view: "comments", model:[name: course.name, comments: course.comments, code: course.code])
        new Comment(code: 1, comment: "comment 1").save()
    }


    def saveComment() {
        println("in save")
        println(params.comment)
        println("code: "+params.code)
        def comment = new Comment(comment: params.comment)
        comment.save()
        def course = Course.findByCode(params.code)
        course.addToComments(comment)

        render ''
    }
    def not_fun() {
        render 'shet'
    }
}
