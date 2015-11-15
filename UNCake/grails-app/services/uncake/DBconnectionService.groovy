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
/*
                    html."**".find { it.@class == 'info-tabla' }.TBODY.TR.each {

                        component = it.TD[1].text().toLowerCase()
                        credits = it.TD[2].text()

                        if (component.indexOf('fund') >= 0) {
                            sp.fundamentalCredits = credits.toInteger()
                        } else if (component.contains('disci')) {
                            sp.disciplinaryCredits = credits.toInteger()
                        } else if (component.contains('libre')) {
                            sp.freeChoiceCredits = credits.toInteger()
                        } else if (component.contains('grado')) {
                            sp.disciplinaryCredits += credits.toInteger()
                        } else if (component.contains('idioma')) {
                            sp.languageCredits = credits.toInteger()
                        }

                    }
*/
                    type = ["arco_5_6": ["fundamentalCredits", "B"]]
                    def code, name
                    type.each { key, value ->
                        println "key " + key
                        html."**".find { it.@id == key }.TABLE.TBODY.each {
                            sp[value[0]] = it.TR[0].TD[0].text().find(/[0-9]+/).toInteger()

                            it.TR[1].TD[0].TABLE.each {
                                println "materias"

                                it.TBODY.TR[0].TD[1].DIV.each {
                                    code = it.DIV[1].A.H5.text()
                                    credits = it.DIV[1].A.DIV[1].text()
                                    name = it.DIV[2].DIV[1].H4.text()
                                    println name + " " + code + " " + credits
                                }

                                it.TBODY.TR[0].TD[1].TABLE.each {
                                    //println it
                                    it.TBODY.TR[0].TD[1].DIV.each {
                                        code = it.DIV[1].A.H5.text()
                                        credits = it.DIV[1].A.DIV[1].text()
                                        name = it.DIV[2].DIV[1].H4.text()

                                        println name + " " + code + " " + credits
                                    }
                                }
                                println "fin materias"
                            }

                            //it.@class= "right"}

                            //sp.fundamentalCredits = credits

                            //println 'materias ' + it.TR[1]
                            /*
*/

                            println sp.disciplinaryCredits + " " + sp.freeChoiceCredits + " " + sp.fundamentalCredits
                        }
                    }
                    /*
                def courses = html."**".findAll { it.name().equals("H5")}
                for(def i = 0; i < courses.size(); i++){

                }*/
                }
                //println sp.name + '\n' + source.size()
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


}
