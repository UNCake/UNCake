package uncake

import grails.converters.JSON

class BuildingController {

    def index() { }

    def getAllNames(){
        def buildings = Building.createCriteria().list([max: params.maxRows]) {
            and{
                ilike('name', "%${params.name_startsWith}%")
            }
        }
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