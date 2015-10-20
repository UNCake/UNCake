package uncake

import groovyx.net.http.HTTPBuilder

import static groovyx.net.http.ContentType.*
import static groovyx.net.http.Method.*

class DBConnectionController {
    def http = new HTTPBuilder('http://sia.bogota.unal.edu.co/academia/scripts/catalogo-programas/items_catalogo_PRE.js')
    def res

    def initDB() {
        def pattern = ~"'.+'"
        //Location.getAll().each { var -> var.delete(flush: true) }
        if (Location.count == 0) {
            new Location(name: 'AMAZONIA', url: 'http://siaama.unal.edu.co/academia/').save()
            new Location(name: 'BOGOTÁ', url: 'http://sia.bogota.unal.edu.co/academia/').save()
            new Location(name: 'CARIBE', url: 'http://siacar.unal.edu.co/academia/').save()
            new Location(name: 'MANIZALES', url: 'http://sia.manizales.unal.edu.co/academia/').save()
            new Location(name: 'MEDELLÍN', url: 'http://sia.medellin.unal.edu.co/academia/').save()
            new Location(name: 'ORINOQUIA', url: 'http://siaori.unal.edu.co/academia/').save()
            new Location(name: 'PALMIRA', url: 'http://sia2.palmira.unal.edu.co/academia/').save()
            new Location(name: 'TUMACO', url: 'http://siatum.unal.edu.co/academia/').save()

            def type = ['PRE', 'POS']
            def source
            //StudyPlan.getAll().each { var -> var.delete() }

            Location.list().each { loc ->
                type.each {
                    source = new URL(loc.url + 'scripts/catalogo-programas/items_catalogo_' + it + '.js').getText('ISO-8859-1')
                    source = source.findAll(pattern)

                    String faculty = ''

                    for (def i = 0; i < source.size(); i++) {
                        source[i] = source[i].toUpperCase().replaceAll("'", "")
                        if (source[i].contains('FACULTAD')) {
                            faculty = source[i]
                        } else if (i + 1 < source.size() && source[i + 1].contains('semaforo')) {
                            new StudyPlan(location: loc, faculty: faculty, code: source[i + 1].find(/[0-9]+/),
                                    name: source[i], type: it).save()
                        }
                    }
                }
            }
        }

        println 'Output database'
        def list_sp = StudyPlan.list()
        list_sp.each { sp ->
            println "$sp.location.name $sp.code $sp.name $sp.faculty "
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
