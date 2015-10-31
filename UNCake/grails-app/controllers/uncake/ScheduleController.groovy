package uncake

import grails.converters.JSON

class ScheduleController {

    def index() {
        [plans: StudyPlan.list().name, locs: Location.list().name]
    }

    def searchByLoc(){
        render StudyPlan.findAllByLocation(Location.findByName(params.selectedLoc)).name as JSON
    }
}
