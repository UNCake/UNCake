package uncake

class CommentHandleController {
    def index() {
        println("index")
    }


    def comments() {
        println("in comments")
        println(params.id)
        render(view: "comments", model:[name: params.name, id: params.id])
    }
    def saveComment() {

    }
    def not_fun() {
        render 'shet'
    }
}
