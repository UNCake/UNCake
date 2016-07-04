package uncake

import grails.converters.JSON
import grails.validation.ValidationException
import groovyx.net.http.HTTPBuilder

import static groovyx.net.http.Method.POST

class ScheduleController {

    def DBconnectionService
    def days = ['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo']

    def index() {
        def schedule = null
        if(params.name) {
            schedule = showSchedule(params.name)
        }
        def courseType = ["PRE": ["Todas"         : "", "Fundamentación": "B", "Disciplinar": "C",
                                  "Libre elección": "L", "Nivelación": "P"],
                          "POS": ["Todas": "", "Obligatorio": "O", "Elegible": "T"]]
        [locs: Location.list().name, courseType: courseType, days: days, schedule: schedule as JSON]
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

        SchType.findAllByStudyPlan(studyPlan).each { c ->
            Course course = c.course
            list.add(["name": course.name, "typology": c.typology,
                      "code": course.code, "credits": course.credits])
        }

        render list as JSON
    }

    def searchTeacher() {
        def list = []
        def courses = []

        Groups.findAllByTeacherIlike('%' + params.teacher + '%').each { c ->
            Course course = c.course
            if (!courses.contains(course)) {
                list.add(["name": course.name, "code": course.code, "credits": course.credits])
                courses.add(course)
            }
        }

        render list as JSON
    }

    def searchCourse() {
        def list = []
        def courses = []

        SchCourse.findAllByNameIlike('%' + params.course + '%').each { c ->
            if (!courses.contains(c)) {
                list.add(["name": c.name, "code": c.code, "credits": c.credits])
                courses.add(c)
            }
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
            def ts = ["teacher"   : gr.teacher, "code": gr.code, "availableSpots": gr.availableSpots,
                      "totalSpots": gr.totalSpots, "course": gr.course.code, "timeSlots": []]

            TimeSlot.findAllByGroup(gr).each { t ->
                ts["timeSlots"] << t
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
            def name, empty = true, exists = false, prev

            reqSchedule.each { key, val ->
                if (key == "name") {
                    name = val
                    prev = Schedule.findByUserAndName(user,name)
                    if(prev) exists = true
                } else if (key == "loc"){
                    schedule.location = Location.findByName(val)
                }
                else {
                    def course = SchCourse.findByCode(val.course)
                    schedule.addToCourses(Groups.findByCodeAndCourse(val.code, course))
                    empty = false
                }
            }

            if (!empty) {
                if (exists) {
                    res = [4]
                    prev.delete()
                } else res = [1]
                schedule.name = name
                schedule.save()
            } else {
                res = [2]
            }
        }

        render res as JSON
    }

    def showSchedule(name) {
        def user = User.find(session.user)
        def schedule = Schedule.findByUserAndName(user, name)
        def res = ['name': name, 'courses': [], 'groups':[:], 'loc':'', 'schedule' : []]


        schedule.courses.each { gr_sch ->
            def course = SchCourse.findById(gr_sch.course.id)

            def groups = [], index

            if(course != null) {

                course.groups.eachWithIndex { gr, i ->
                    def ts = ["id": i, "teacher"   : gr.teacher, "code": gr.code, "availableSpots": gr.availableSpots,
                              "totalSpots": gr.totalSpots, "course": gr.course.code, "timeSlots": []]

                    TimeSlot.findAllByGroup(gr).each { t ->
                        ts["timeSlots"] << t
                    }

                    if (gr_sch == gr) index = i

                    groups << ts
                }

                res['courses'].add(["name": course.name, "code": course.code, "credits": course.credits])
                res['groups'][course.name] = groups
                res['schedule'].add(["id" : index, "name": course.name, "code": course.code])
                if (res['loc'] == '') {
                    res['loc'] = schedule.location.name
                }
            }
        }

        return res
    }
}
