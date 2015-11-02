package uncake
import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.ContentType.*
import static groovyx.net.http.Method.*
import grails.converters.JSON

class ScheduleController {

    def index() {
        def courseType = [ "PRE" : ["Todas": "","Fundamentación" : "B", "Disciplinar": "C",
                                    "Libre elección" : "L", "Nivelación" : "P"] ,
                           "POS" : ["Todas": "","Obligatorio" : "O", "Elegible" : "T"] ]
        [locs: Location.list().name, courseType : courseType]
    }

    def searchByLoc(){
        if(params.selectedLoc == null)
            render StudyPlan.findAllByType(params.type).name as JSON
        else
            render StudyPlan.findAllByLocationAndType(Location.findByName(params.selectedLoc), params.type).name as JSON
    }

    def searchCourses(){

        def http = new HTTPBuilder(Location.findByName(params.selectedLoc).url + 'buscador/JSON-RPC')
        def codeStudyPlan = StudyPlan.findByNameAndLocation(params.studyplan, Location.findByName(params.selectedLoc)).code

        def list = []
        http.request(POST, groovyx.net.http.ContentType.JSON) { req ->

            body = [
                    "jsonrpc": "2.0",
                    "method" : "buscador.obtenerAsignaturas",
                    "params" : ["", "PRE", "", params.type, codeStudyPlan, "", 1, 999]
            ]

            // success response handler
            response.success = { resp, json ->

                json.result.asignaturas.list.each { v ->
                    list.add(["name" : v.nombre, "typology" : v.tipologia,
                              "code" : v.codigo, "credits" : v.creditos])
/*
                    v.each { a ->
                        println a
                    }*/
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

        render list as JSON
    }
}
