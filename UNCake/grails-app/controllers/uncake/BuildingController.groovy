package uncake

import grails.converters.JSON

class BuildingController {

    def index() { }

    def getAllNames(){
        def buildings = Building.list()
        render buildings.name as JSON
    }

    def getItemByName(){
        def selectedBuilding = Building.createCriteria().list() {
            and{
                ilike('name', "%${params.selectedName}%")
            }
        }
        render selectedBuilding.coordinates as JSON
    }

}