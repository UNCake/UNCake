package uncake

class ScheduleController {

    def index() {
        [plans: StudyPlan.list().name, locs: Location.list().name]
    }
}
