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


    def fetchCourseByName(){
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
        if (session.user == null)
            render('El usuario no esta logeado')
        else
            render(view: "comments", model:[name: course.name, comments: course.comments, code: course.code])
    }


    def saveComment() {
        def user = User.findById(params.id)
        def comment = new Comment(comment: params.comment, date: new Date(), user: user)
        //println("In user "+user.name+ " id "+ params.id)
        comment.save()
        def course = Course.findByCode(params.code)
        course.addToComments(comment)

        render ''
    }

}
