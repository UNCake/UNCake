package uncake

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AsignaturaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Course.list(params), model:[asignaturaCount: Course.count()]
    }

    def show(Course asignatura) {
        respond asignatura
    }

    def create() {
        respond new Course(params)
    }

    @Transactional
    def save(Course asignatura) {
        if (asignatura == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (asignatura.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond asignatura.errors, view:'create'
            return
        }

        asignatura.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'asignatura.label', default: 'Course'), asignatura.id])
                redirect asignatura
            }
            '*' { respond asignatura, [status: CREATED] }
        }
    }

    def edit(Course asignatura) {
        respond asignatura
    }

    @Transactional
    def update(Course asignatura) {
        if (asignatura == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (asignatura.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond asignatura.errors, view:'edit'
            return
        }

        asignatura.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'asignatura.label', default: 'Course'), asignatura.id])
                redirect asignatura
            }
            '*'{ respond asignatura, [status: OK] }
        }
    }

    @Transactional
    def delete(Course asignatura) {

        if (asignatura == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        asignatura.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'asignatura.label', default: 'Course'), asignatura.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'asignatura.label', default: 'Course'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
