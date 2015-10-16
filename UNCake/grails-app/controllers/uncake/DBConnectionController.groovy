package uncake

import groovyx.net.http.HTTPBuilder
import static groovyx.net.http.ContentType.*
import static groovyx.net.http.Method.*

class DBConnectionController {
    def http = new HTTPBuilder('http://sia.bogota.unal.edu.co/buscador/JSON-RPC')
    def res

    def index() {

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

                    /*res = new Course(params)

                    if (!res.save(flush: true)) {
                        res.errors.each {
                            println it
                        }
                    }*/

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
        }

        render "datos cargados"
    }
}
