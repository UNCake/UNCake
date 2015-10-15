package uncake

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class AsignaturaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Asignatura.list(params), model:[asignaturaCount: Asignatura.count()]
    }

    def show(Asignatura asignatura) {
        respond asignatura
    }

    def create() {
        respond new Asignatura(params)
    }

    @Transactional
    def save(Asignatura asignatura) {
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
                flash.message = message(code: 'default.created.message', args: [message(code: 'course.label', default: 'Asignatura'), asignatura.id])
                redirect asignatura
            }
            '*' { respond asignatura, [status: CREATED] }
        }
    }

    def edit(Asignatura asignatura) {
        respond asignatura
    }

    @Transactional
    def update(Asignatura asignatura) {
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
                flash.message = message(code: 'default.updated.message', args: [message(code: 'course.label', default: 'Asignatura'), asignatura.id])
                redirect asignatura
            }
            '*'{ respond asignatura, [status: OK] }
        }
    }

    @Transactional
    def delete(Asignatura asignatura) {

        if (asignatura == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        asignatura.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'course.label', default: 'Asignatura'), asignatura.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'course.label', default: 'Asignatura'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
