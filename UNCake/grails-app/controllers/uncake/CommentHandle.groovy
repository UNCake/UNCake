package uncake

class CommentHandle {

    def index() {
    }

    def commentView() {
        render(view: "commentView", model:[name: params.name, id: params.id])
    }
    def saveComment() {

    }
    def not_fun() {
        render 'shet'
    }
}
