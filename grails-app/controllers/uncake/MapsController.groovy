package uncake

class MapsController {

    def index() {
        def buildingController = new BuildingController()
        buildingController.insertBogotaBuildings()
        //def build = Building.findAll()
    }

    def pointer(){

    }
}
