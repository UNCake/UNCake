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

    def buildSchedule() {

        def reqSchedule = request.JSON
        def res = [3]

        if (reqSchedule.size() > 1) {
            def user = User.find(session.user)
            def schedule = new Schedule(credits: 0, user: user)
            def name, empty = true

            reqSchedule.each { key, val ->
                if (key == "name") name = val
                else {
                    def course = SchCourse.findByCode(val.course)
                    schedule.addToCourses(Groups.findByCodeAndCourse(val.code, course))
                    empty = false
                }
            }

            schedule.name = name

            if(!empty) {
                schedule.save()
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
