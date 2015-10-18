package uncake

import groovyx.net.http.HTTPBuilder

import static groovyx.net.http.ContentType.*
import static groovyx.net.http.Method.*

class DBConnectionController {
    def http = new HTTPBuilder('http://sia.bogota.unal.edu.co/academia/scripts/catalogo-programas/items_catalogo_PRE.js')
    def res

    def initDB() {
        def pattern = ~"'.+'"
        def loc = "BOGOTÁ"
        StudyPlan.getAll().each { var -> var.delete(flush: true) }
        def source = new URL('http://sia.bogota.unal.edu.co/academia/scripts/catalogo-programas/items_catalogo_PRE.js').getText("ISO-8859-1")

        source = source.replaceAll(loc, "")
        source = source.findAll(pattern)

        String faculty
        for (def i = 0; i < source.size(); i++) {

            if (!source[i].toLowerCase().contains("sede") && source[i].toLowerCase().contains("facultad")) {
                faculty = source[i]
            } else if (i + 1 < source.size() && source[i + 1].contains("semaforo")) {
                new StudyPlan(faculty: faculty, code: source[i + 1].find(/[0-9]+/), name: source[i], type: "PRE").save(flush: true)
            }
        }

        println "Output database"
        def list_sp = StudyPlan.list()
        list_sp.each { sp ->
            println " $sp.code $sp.name $sp.faculty "
        }
    }

    def index() {
        initDB()
/*
        http.request(POST, JSON) { req ->
            body = [
                    "jsonrpc": "2.0",
                    "method" : "buscador.obtenerAsignaturas",
                    "params" : ["CALC", "PRE", "", "PRE", "", "", 1, 20],
                    "id"     : 1
            ]

            // success response handler
            response.success = { resp, json ->

                json.result.asignaturas.list.each { v ->

                    def params = [:]

                    v.each { a ->
                        if (!a.toString().startsWith("j") || !a.toString().startsWith("g")) {
                            params << a
                        }
                    }

                    params.each { a ->
                        println a
                    }

                    res = new Course(params)

                    if (!res.save(flush: true)) {
                        res.errors.each {
                            println it
                        }
                    }

                }
            }

            // failure response handler
            response.failure = { resp ->
                println "Unexpected error: ${resp.statusLine.statusCode}"
                println $ { resp.statusLine.reasonPhrase }
            }
        }
        def list_as = Course.list()
        list_as.each { asig ->
            http.request(POST, JSON) { req ->
                body = [
                        "jsonrpc": "2.0",
                        "method" : "buscador.obtenerGruposAsignaturas",
                        "params" : [asig.codigo.toString(), "0"],
                        "id"     : 1
                ]
                println asig.nombre
                // success response handler
                response.success = { resp, json ->
                    println json
                    //asig.grupos = json.toString()
                }

                // failure response handler
                response.failure = { resp ->
                    println "Unexpected error: ${resp.statusLine.statusCode}"
                    println $ { resp.statusLine.reasonPhrase }
                }
            }
        }*/


        render "datos cargados"
    }
}
