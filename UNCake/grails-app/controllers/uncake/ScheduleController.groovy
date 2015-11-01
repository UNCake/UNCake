package uncake

import grails.converters.JSON

class ScheduleController {

    def index() {
        [plans: StudyPlan.list().name, locs: Location.list().name]
    }

    def searchByLoc(){
        if(params.selectedLoc == null)
            render StudyPlan.findAllByType(params.type).name as JSON
        else
            render StudyPlan.findAllByLocationAndType(Location.findByName(params.selectedLoc), params.type).name as JSON
    }
}
