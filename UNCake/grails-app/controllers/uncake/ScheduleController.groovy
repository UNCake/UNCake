package uncake
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.ContentType.*
import static groovyx.net.http.Method.*
import grails.converters.JSON

class ScheduleController {

    def index() {
        [locs: Location.list().name]
    }

    def searchByLoc(){
        if(params.selectedLoc == null)
            render StudyPlan.findAllByType(params.type).name as JSON
        else
            render StudyPlan.findAllByLocationAndType(Location.findByName(params.selectedLoc), params.type).name as JSON
    }

    def geturlSIA(){
        render Location.findByName(params.selectedLoc).url
    }

    def searchCourses(){
        println params
        def http = new HTTPBuilder(Location.findByName(params.selectedLoc).url + 'buscador/JSON-RPC')
        def codeStudyPlan = StudyPlan.findByNameAndLocation(params.studyplan, Location.findByName(params.selectedLoc)).code
        println codeStudyPlan
        def list = []
        http.request(POST, groovyx.net.http.ContentType.JSON) { req ->

            body = [
                    "jsonrpc": "2.0",
                    "method" : "buscador.obtenerAsignaturas",
                    "params" : [params.name, "PRE", "", params.type, codeStudyPlan, "", 1, 999]
            ]

            // success response handler
            response.success = { resp, json ->

                json.result.asignaturas.list.each { v ->
                    list.add(v.nombre)
                    def params = [:]

                    v.each { a ->
                        if (!a.toString().startsWith("j") || !a.toString().startsWith("g")) {
                            params << a
                        }
                    }

                    params.each { a ->
                        println a
                    }
/*
                    res = new Course(params)

                    if (!res.save(flush: true)) {
                        res.errors.each {
                            println it
                        }
                    }
*/
                }
            }

            // failure response handler
            response.failure = { resp ->
                println "Unexpected error: ${resp.statusLine.statusCode}"
                println "${ resp.statusLine.reasonPhrase }"
            }
        }

        println list
        render list as JSON
    }
}
