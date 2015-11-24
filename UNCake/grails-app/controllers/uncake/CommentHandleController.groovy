package uncake

import grails.converters.JSON

//BORRAR LOS PRINTLN DESPUES
class CommentHandleController {
    def index() {
        println("index")
        [coursesList: Course.list(), coursesNameList: Course.list().name]
    }

    def getCourseById(){
        Long courseid = params.long('selectedName')
        println courseid
        def course = Course.findWhere(id:courseid)
        def testL = course.comments
        render course as JSON

    }

    def comments() {
        println("in comments")
        println(params.code)
        def course = Course.findByCode(params.code)
        render(view: "comments", model:[name: course.name, comments: course.comments, code: course.code])
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
