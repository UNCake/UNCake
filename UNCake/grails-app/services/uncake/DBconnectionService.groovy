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

                    StudyPlan.list().each { sp ->
                        source = new HTTPBuilder(loc.url + '/academia/catalogo-programas/semaforo.do?plan=' + sp.code +
                                '&tipo=' + it + '&tipoVista=semaforo&nodo=1&parametro=on')
                        html = source.get([:])

                        if(sp.name == "INGENIERIA DE SISTEMAS Y COMPUTACION"){
                            println sp.name
                            println "found it"

                            html."**".find{it.@class == 'info-tabla'}.TBODY.TR.each{
                                println it

                                component = it.TD[1].text().toLowerCase()
                                credits = it.TD[2].text()
                                println component + " " + credits

                                if(component.indexOf('fund') >= 0){
                                    sp.fundamentalCredits = credits.toInteger()
                                }else if(component.contains('disci')){
                                    sp.disciplinaryCredits = credits.toInteger()
                                }else if(component.contains('libre')){
                                    sp.freeChoiceCredits = credits.toInteger()
                                }else if(component.contains('grado')){
                                    sp.disciplinaryCredits += credits.toInteger()
                                }else if(component.contains('idioma')){
                                    sp.languageCredits = credits.toInteger()
                                }

                            }

                            println sp.disciplinaryCredits + " " + sp.freeChoiceCredits + " " + sp.fundamentalCredits

                            /*
                            def courses = html."**".findAll { it.name().equals("H5")}
                            for(def i = 0; i < courses.size(); i++){

                            }*/
                        }
                        //println sp.name + '\n' + source.size()
                    }
                } catch (Exception e) {
                    println e.stackTrace
                    println "Sia sede $loc.name no disponible"
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


}
