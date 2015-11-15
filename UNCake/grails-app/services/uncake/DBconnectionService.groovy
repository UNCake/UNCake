package uncake

import grails.transaction.Transactional
import groovyx.net.http.HTTPBuilder

@Transactional
class DBconnectionService {

    def initDB() {

        def pattern = ~"'.+'"

        //StudyPlan.getAll().each { var -> var.delete(flush: true) }
        //Location.getAll().each { var -> var.delete(flush: true) }

        def type = ['PRE', 'POS']
        def source, html, credits, component


        Location.list().each { loc ->
            type.each {
                try {
                    source = new URL(loc.url + '/academia/scripts/catalogo-programas/items_catalogo_' + it + '.js')
                            .getText('ISO-8859-1')
                    source = source.findAll(pattern)

                    String faculty = ''

                    for (def i = 0; i < source.size(); i++) {
                        source[i] = Utility.stripAccents(source[i]).toUpperCase().replaceAll("'", "")
                        if (source[i].contains('FACULTAD')) {
                            faculty = source[i]
                        } else if (i + 1 < source.size() && source[i + 1].contains('semaforo')) {
                            new StudyPlan(location: loc, faculty: faculty, code: source[i + 1].find(/[0-9]+/),
                                    name: source[i], type: it).save()
                        }
                    }

                } catch (Exception e) {
                    println "Sia sede $loc.name no disponible"
                }
            }
        }


        StudyPlan.list().each { sp ->
            try {
                source = new HTTPBuilder(sp.location.url + '/academia/catalogo-programas/semaforo.do?plan=' + sp.code +
                        '&tipo=' + sp.type + '&tipoVista=semaforo&nodo=1&parametro=on')
                html = source.get([:])

                if (sp.name == "INGENIERIA DE SISTEMAS Y COMPUTACION") {
                    println sp.name
                    println "found it"

                    type = ["arco_5_6": ["fundamentalCredits", "B"]]
                    def pr
                    type.each { key, value ->
                        println "key " + key
                        def var = 0
                        html."**".find { it.@id == key }.TABLE.TBODY.each {
                            sp[value[0]] = it.TR[0].TD[0].text().find(/[0-9]+/).toInteger()

                            it.TR[1].TD[0].TABLE.each {
                                it.TBODY.TR[0].TD[1].DIV.each {
                                    pr = getCourseInfo(it, value[1])
                                    if (pr != null) sp.addToCourses(pr)
                                }

                                it.TBODY.TR[0].TD[1].TABLE.each {
                                    it.TBODY.TR[0].TD[1].DIV.each {
                                        pr = getCourseInfo(it, value[1])
                                        if (pr != null) sp.addToCourses(pr)
                                    }
                                }
                            }

                            println sp.disciplinaryCredits + " " + sp.freeChoiceCredits + " " + sp.fundamentalCredits +
                                    "courses " + sp.courses.size() + "  var " + var
                        }
                    }

                }
                
            } catch (Exception e) {
                println e.stackTrace
                println "Programa academico $sp.name de la sede $sp.location.name no disponible"
            }
        }
    }
    /*
    println 'Output database'
    def list_sp = StudyPlan.list()
    list_sp.each { sp ->
        println "$sp.location.name $sp.code $sp.name $sp.faculty "
    }
    */

    def getCourseInfo(it, typology) {
        def code, credits, name

        code = it.DIV[1].A.H5.text()
        credits = it.DIV[1].A.DIV[1].text()
        name = it.DIV[2].DIV[1].H4.text()

        if (code != "") {
            println name + " " + code + " " + credits
            return new Prerequisite(course: new Course(name: name, code: code,
                    credits: credits, typology: typology))
        }

        return null
    }


}
