package uncake

import grails.transaction.Transactional
import groovyx.net.http.HTTPBuilder

@Transactional
class DBconnectionService {

    /*
        Se encarga de poblar la base de datos con los planes de estudio
        y sus materias.
     */

    def initDB() {

        def pattern = ~"'.+'"
        def type = ['PRE', 'POS']
        def source, html

        //Se cargan los planes de estudio por sede
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

        //Se almacenan las materias de fundamentacion y disciplinar de cada plan de estudios (pregrado)
        StudyPlan.findAllByType("PRE").each { sp ->
            try {
                source = new HTTPBuilder(sp.location.url + '/academia/catalogo-programas/semaforo.do?plan=' + sp.code +
                        '&tipo=' + sp.type + '&tipoVista=semaforo&nodo=1&parametro=on')
                html = source.get([:])

                type = ["arco_5_6": ["fundamentalCredits", "B"], "arco_6_7": ["disciplinaryCredits", "C"],
                        "arco_8_9": ["disciplinaryCredits", "C"]]
                def pr
                type.each { key, value ->

                    html."**".find { it.@id == key }.TABLE.TBODY.each {
                        if (sp[value[0]] == null) sp[value[0]] = 0
                        sp[value[0]] += it.TR[0].TD[0].text().find(/[0-9]+/).toInteger()

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
                                "courses " + sp.courses.size()
                    }
                }

                sp.save()

            } catch (Exception e) {
                println e.stackTrace
                println "Programa academico $sp.name de la sede $sp.location.name no disponible"
            }
        }
    }

    /*
        Construye los objetos Prerequisite, a partir de la informacion de la materia
     */

    def getCourseInfo(it, typology) {
        def code, credits, name

        code = it.DIV[1].A.H5.text()
        credits = it.DIV[1].A.DIV[1].text()
        name = it.DIV[2].DIV[1].H4.text()

        if (code != "") {
            return new Prerequisite(course: new Course(name: name, code: code,
                    credits: credits, typology: typology))
        }

        return null
    }


}
