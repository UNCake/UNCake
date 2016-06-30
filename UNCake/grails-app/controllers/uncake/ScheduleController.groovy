package uncake

import grails.converters.JSON
import grails.validation.ValidationException
import groovyx.net.http.HTTPBuilder

import static groovyx.net.http.Method.POST

class ScheduleController {

    def DBconnectionService
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
        def location = Location.findByName(params.selectedLoc)
        def studyPlan = StudyPlan.findByNameAndLocation(params.studyplan, location)

        def list = []

        SchType.findAllByStudyPlan(studyPlan).each {c ->
            Course course = c.course
            list.add(["name": course.name, "typology": c.typology,
                      "code": course.code, "credits": course.credits])
        }

        render list as JSON
    }

    def searchGroups() {

        def loc = Location.findByName(params.selectedLoc)
        def course = SchCourse.findByCode(params.code)

        DBconnectionService.searchGroups(course, loc, true)
        course = SchCourse.findById(course.id)

        def groups = []

        course.groups.each { gr ->
            def ts = ["teacher": gr.teacher, "code": gr.code, "availableSpots": gr.availableSpots,
                      "totalSpots": gr.totalSpots, "course": gr.course.code, "timeSlots": []]
            gr.timeSlots.each { t ->
                ts["timeSlots"] << TimeSlot.findById(t.id)
            }

            groups << ts
        }

        render groups as JSON
    }

    def setTimeSlot(group, day, timeslot, loc) {
        def time = 'horario_' + day

        if (timeslot[time] == '--') {
            return ["endHour"  : -1, "startHour": -1, "day": day,
                    "classroom": 'no']
        }

        def hours = timeslot[time].split(' ')
        def place = 'aula_' + day
        def rooms = timeslot[place].split(' ')

        for (def i = 0; i < hours.size(); i++) {

            def t = hours[i].split('-')
            def p = rooms[i].split('-')

            group.add(new TimeSlot(
                    "startHour": t[0].toInteger(),
                    "endHour": t[1].toInteger(),
                    "classroom": (p.size() > 1) ? p[1] : 'no', "day": day,
                    "building": Building.findByCode(p[0]),
                    "location": loc.name))
        }
    }

    def buildSchedule() {

        def reqSchedule = request.JSON
        def res = [3]

        if (reqSchedule.size() > 1) {
            def schedule = new Schedule(credits: 0)
            def user = User.find(session.user)
            def group, name, empty = true

            reqSchedule.each { key, val ->
                if (key == "name") name = val
                else if (key == "image") schedule.image = val
                else {

                    group = new Groups(course: key, code: val.code, availableSpots: val.availableSpots,
                            teacher: val.teacher, totalSpots: val.totalSpots)
                    empty = false

                    val.timeSlots.each { ts ->

                        if (Location.findByName(ts.location) != null) {
                            def tempTS = new TimeSlot(building: ts.building, location: Location.findByName(ts.location),
                                    classroom: ts.classroom, day: ts.day, endHour: ts.endHour, startHour: ts.startHour)
                            tempTS.save()
                            group.addToTimeSlots(tempTS)
                        }
                    }

                    group.save()
                    schedule.addToCourses(group)
                }
            }

            schedule.name = name

            if(!empty) {
                schedule.save()
                user.addToSchedules(schedule)
                user.save()
                res = [1]
            }else{
                res = [2]
            }
        }

        render res as JSON
    }

    def showSchedule() {
        def res = []
        if (params.friend != null) {
            def user = User.findByName(params.friend)
            if (!user.schedules.isEmpty())
                res.add(user.schedules.first().image)
        } else {
            def schedule = Schedule.findByName(params.name)
            if (schedule != null) {
                res.add(schedule.image)
            }
        }

        render res as JSON
    }
}
