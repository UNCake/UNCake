package uncake

class ScheduleController {

    def index() {
        [lista: StudyPlan.list().name]
    }
}
