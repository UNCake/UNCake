package uncake

import grails.converters.JSON

//BORRAR LOS PRINTLN DESPUES
class CommentHandleController {
    def index() {
        [coursesList: Course.list(), coursesNameList: Course.list().name, coursesLen:Course.count]
    }

    def list() {
        [coursesListList: Course.list(), coursesLenList:Course.count]
    }

    def getCourseById(){
        Long courseid = params.long('selectedName')
        //println courseid
        def course = Course.findWhere(id:courseid)
        //print(course.comments)
        render course as JSON
    }

    def getCourseByName(){
        def course = Course.findWhere(name:params.selectedName)
        if(course != null) {
            render course as JSON
        }else{
            def nulluser = new User(email:"nullmail", password:"nullpass", name:"null" )
            render nulluser as JSON
        }
    }

    def comments() {
        //println("in comments")
        //println(params.code)
        def course = Course.findByCode(params.code)
        render(view: "comments", model:[name: course.name, comments: course.comments, code: course.code])
    }


    def saveComment() {
        def comment = new Comment(comment: params.comment)
        def u = User.findById(params.id)
        println("In user "+u.name)
        comment.user = u
        comment.save()
        def course = Course.findByCode(params.code)
        course.addToComments(comment)

        render ''
    }

}
