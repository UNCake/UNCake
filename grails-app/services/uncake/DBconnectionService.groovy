package uncake

import grails.transaction.Transactional

@Transactional
class DBconnectionService {

    def initDB() {

        def pattern = ~"'.+'"

        //StudyPlan.getAll().each { var -> var.delete(flush: true) }
        //Location.getAll().each { var -> var.delete(flush: true) }

        def type = ['PRE', 'POS']
        def source

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

        println 'Output database'
        def list_sp = StudyPlan.list()
        list_sp.each { sp ->
            println "$sp.location.name $sp.code $sp.name $sp.faculty "
        }
    }


}
