package uncake

import grails.converters.JSON
import grails.transaction.Transactional
import grails.validation.ValidationException
import groovy.time.TimeCategory
import groovy.time.TimeDuration
import groovyx.net.http.HTTPBuilder

import static groovyx.net.http.Method.POST

@Transactional
class DBconnectionService {
    static transactional = false
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

                    for (def i = 0; i < source.size(); i++) {
                        source[i] = Utility.stripAccents(source[i]).toUpperCase().replaceAll("'", "")

                        if (!source[i].contains('FACULTAD') && i + 1 < source.size() && source[i + 1].contains('semaforo')) {
                            def sp = new StudyPlan(location: loc, code: source[i + 1].find(/[0-9]+/),
                                    name: source[i], type: it)
                            sp.save()
                            searchCourses(loc, sp.code, sp.type)
                        }
                    }

                } catch (IOException e) {
                    println "Sia sede $loc.name no disponible"
                }
            }
        }
/*
        //Se almacenan las materias de cada plan de estudios (pregrado)
        StudyPlan.findAllByType("PRE").each { sp ->

            try {
                source = new HTTPBuilder(sp.location.url + '/academia/catalogo-programas/semaforo.do?plan=' + sp.code +
                        '&tipo=' + sp.type + '&tipoVista=semaforo&nodo=1&parametro=on')
                html = source.get([:])

                type = [["fundamentalCredits", "B"], ["disciplinaryCredits", "C"], ["freeChoiceCredits", "L"]]
                def pr

                html."**".findAll { it.@id.text().find(/arco_[0-9]+/) }.TABLE.TBODY.each {

                        def value = -1
                        def component = it.TR[0].TD[0].text().toUpperCase()
                        //Se obtiene la cantidad de creditos por componente
                        if (component.contains("FUND")) {
                            value = type[0]
                            sp[value[0]] = component.find(/[0-9]+/).toInteger()
                        } else if (component.contains("DISC") || component.contains("GRAD")) {
                            value = type[1]
                            if (sp[value[0]] == null) sp[value[0]] = 0
                            sp[value[0]] += component.find(/[0-9]+/).toInteger()
                        }else if (component.contains("LIBRE")) {
                            value = type[2]
                            sp[value[0]] = component.find(/[0-9]+/).toInteger()
                        }

                        if (value != -1) {

                            it.TR[1].TD[0].TABLE.each {

                                it.TBODY.TR[0].TD[1].DIV.each {
                                    pr = getCourseInfo(it, sp)
                                    if (pr != null) sp.addToCourses(pr)
                                }

                                it.TBODY.TR[0].TD[1].TABLE.each {

                                    it.TBODY.TR[0].TD[1].DIV.each {
                                        pr = getCourseInfo(it, sp)
                                        if (pr != null) sp.addToCourses(pr)
                                    }
                                }
                            }

                        }
                }

                println sp.name + " " +sp.disciplinaryCredits + " " + sp.freeChoiceCredits + " " + sp.fundamentalCredits +
                        ((sp.courses != null) ? "courses " + sp.courses.size() : "no courses")
                sp.save( )

            } catch (Exception e) {
                println "Programa academico $sp.name de la sede $sp.location.name no disponible"
            }
        }
*/
    }

    /*
        Construye los objetos Prerequisite, a partir de la informacion de la materia
     */

    def getCourseInfo(it, plan) {
        def fcode, credits, name

        fcode = it.DIV[1].A.H5.text()
        credits = it.DIV[1].A.DIV[1].text()
        name = it.DIV[2].DIV[1].H4.text()

        if (fcode != null && fcode != "") {

            def course = Course.find { code == fcode }

            if (course == null) {
                course = new Course(name: name, code: fcode, credits: credits)
                course.save()
            }

            def pre = new Prerequisite(course: course, studyPlan: plan)
            pre.save()

            return pre
        }

        return null
    }

    def searchCourses(location, codeStudyPlan, type) {
        def url = (location.name == 'MEDELLIN') ? location.url + ":9401/" : location.url
        def http = new HTTPBuilder(url + '/buscador/JSON-RPC')
        def course

        http.request(POST, groovyx.net.http.ContentType.JSON) { req ->

            body = [
                    "jsonrpc": "2.0",
                    "method" : "buscador.obtenerAsignaturas",
                    "params" : ["", "PRE", "", type, codeStudyPlan, "", 1, 999]
            ]

            // success response handler
            response.success = { resp, json ->

                json.result.asignaturas.list.each { v ->

                    course = SchCourse.findByCodeAndStudyPlan(v.codigo, codeStudyPlan)

                    if (!course) {
                        course = new SchCourse(name: v.nombre, code: v.codigo, credits: v.creditos,
                                typology: v.tipologia, studyPlan: codeStudyPlan)
                        try {
                            course.save()
                        } catch (ValidationException ve) {
                            println "error guardando curso"
                        }
                    }

                    searchGroups(course, location, v.codigo, false)
                    course.save()
                }
            }

            // failure response handler
            response.failure = { resp ->
                println "Unexpected error: ${resp.statusLine.statusCode}"
                println "${resp.statusLine.reasonPhrase}"
            }
        }
    }

    def searchGroups(course, location, code, update) {
        def url = (location.name == 'MEDELLIN') ? location.url + ":9401/" : location.url
        def http = new HTTPBuilder(url + '/buscador/JSON-RPC')
        def days = ['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo']
        def group

        if (update && TimeCategory.minus(course.lastUpdated, new Date()).minutes > 30) {
            return
        }

        http.request(POST, groovyx.net.http.ContentType.JSON) { req ->
            body = [
                    "jsonrpc": "2.0",
                    "method" : "buscador.obtenerGruposAsignaturas",
                    "params" : [code, "0"]
            ]

            // success response handler
            response.success = { resp, json ->
                json.result.list.each { a ->

                    group = Groups.findByCourseAndCode(course, a.codigo)

                    if(!group) {
                        group = new Groups(teacher: (a.nombredocente.trim().size() == 0) ? 'Profesor no asignado' : a.nombredocente,
                                            code: a.codigo, availableSpots: a.cuposdisponibles, totalSpots: a.cupostotal,
                                            timeSlots: [], course: course)
                        group.save()
                        course.addToGroups(group)
                        course.save()
                    } else {
                        group.teacher =  (a.nombredocente.trim().size() == 0) ? 'Profesor no asignado' : a.nombredocente
                        group.availableSpots = a.cuposdisponibles
                        group.totalSpots = a.cupostotal
                        group.save()
                    }

                    days.each { d -> setTimeSlot(group["timeSlots"], d, a, location) }
                    group.save()
                }
            }

            // failure response handler
            response.failure = { resp ->
                println "Unexpected error: ${resp.statusLine.statusCode}"
                println ${ resp.statusLine.reasonPhrase }
            }
        }
    }

    def setTimeSlot(group, day, timeslot, loc) {
        def time = 'horario_' + day

        if (timeslot[time] == '--') {
            return
        }

        def hours = timeslot[time].split(' ')
        def place = 'aula_' + day
        def rooms = timeslot[place].split(' ')

        for (def i = 0; i < hours.size(); i++) {

            def t = hours[i].split('-')
            def p = rooms[i].split('-')

            group.add(new TimeSlot(
                    startHour: t[0].toInteger(),
                    endHour: t[1].toInteger(),
                    classroom: (p.size() > 1) ? p[1] : 'no', "day": day,
                    building: loc.name != "BOGOTA" ? null :Building.findByCode(p[0])))
        }
    }

}
