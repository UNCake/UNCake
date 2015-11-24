package uncake

import grails.converters.JSON
import groovyx.net.http.HTTPBuilder

import static groovyx.net.http.Method.POST

class ScheduleController {
    def days = ['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo']

    def index() {
        def courseType = ["PRE": ["Todas"         : "", "Fundamentación": "B", "Disciplinar": "C",
                                  "Libre elección": "L", "Nivelación": "P"],
                          "POS": ["Todas": "", "Obligatorio": "O", "Elegible": "T"]]
        [locs: Location.list().name, courseType: courseType, days: days]
    }

    def searchByLoc() {
        if (params.selectedLoc == null)
            render StudyPlan.findAllByType(params.type).name as JSON
        else
            render StudyPlan.findAllByLocationAndType(Location.findByName(params.selectedLoc), params.type).name as JSON
    }

    def searchCourses() {
        def url = (params.selectedLoc == 'MEDELLIN') ? Location.findByName(params.selectedLoc).url + ":9401/" :
                Location.findByName(params.selectedLoc).url
        def http = new HTTPBuilder(url + '/buscador/JSON-RPC')
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
                    list.add(["name": v.nombre, "typology": v.tipologia,
                              "code": v.codigo, "credits": v.creditos])

                    if (!Course.findByCode(v.codigo)) {
                        def course = new Course(list.last())
                        course.location = Location.findByName(params.selectedLoc)
                        if (!course.save()) {
                            println "error guardando curso"
                        }
                    }
                }
            }

            // failure response handler
            response.failure = { resp ->
                println "Unexpected error: ${resp.statusLine.statusCode}"
                println "${resp.statusLine.reasonPhrase}"
            }
        }

        render list as JSON
    }

    def searchGroups() {

        def loc = Location.findByName(params.selectedLoc)
        def url = (params.selectedLoc == 'MEDELLIN') ? loc.url + ":9401/" : loc.url
        def http = new HTTPBuilder(url + '/buscador/JSON-RPC')

        def groups = []
        http.request(POST, groovyx.net.http.ContentType.JSON) { req ->
            body = [
                    "jsonrpc": "2.0",
                    "method" : "buscador.obtenerGruposAsignaturas",
                    "params" : [params.code, "0"]
            ]

            // success response handler
            response.success = { resp, json ->
                json.result.list.each { a ->
                    def temp = ["teacher"       : a.nombredocente, "code": a.codigo,
                                "availableSpots": a.cuposdisponibles, "totalSpots": a.cupostotal, "timeSlots": []]
                    days.each { d -> temp["timeSlots"].add(setTimeSlot(d, a, loc)) }
                    groups.add(temp)
                }
            }

            // failure response handler
            response.failure = { resp ->
                println "Unexpected error: ${resp.statusLine.statusCode}"
                println $ { resp.statusLine.reasonPhrase }
            }
        }

        render groups as JSON
    }

    def setTimeSlot(day, timeslot, loc) {
        def time = 'horario_' + day

        if (timeslot[time] == '--') {
            return ["endHour"  : -1, "startHour": -1, "day": day,
                    "classroom": 'no']
        }

        def t = timeslot[time].split('-')
        def place = 'aula_' + day
        def p = timeslot[place].split('-')

        return ["startHour": t[0].toInteger(),
                "endHour"  : t[t.size() - 1].toInteger(),
                "classroom": (p.size() > 1) ? p[1] : 'no', "day": day,
                "building" :  Building.findByCode(p[0]) ,
                "location" : loc.name]
    }

    def buildSchedule() {

        def reqSchedule = request.JSON
        def res = []

        if (reqSchedule.size() > 1) {
            def schedule = new Schedule(credits: 0)
            def user = User.find(session.user)
            def group, name
            reqSchedule.each { key, val ->
                if (key == "name") name = val
                else {
                    group = new Groups(course: key, code: val.code, availableSpots: val.availableSpots,
                            teacher: val.teacher, totalSpots: val.totalSpots)

                    val.timeSlots.each { ts ->

                        if (Location.findByName(ts.location) != null) {
                            def tempTS = new TimeSlot(building: ts.building, location: Location.findByName(ts.location),
                                    classroom: ts.classroom, day: ts.day, endHour: ts.endHour, startHour: ts.startHour)
                            tempTS.save(flush: true)
                            group.addToTimeSlots(tempTS)
                        }
                    }

                    group.save(flush: true)
                    schedule.addToCourses(group)
                }
            }

            schedule.name = name
            schedule.save(flush: true)

            user.addToSchedules(schedule)
            user.save(flush: true)
            res = [1]
        }

        render res as JSON
    }
}
