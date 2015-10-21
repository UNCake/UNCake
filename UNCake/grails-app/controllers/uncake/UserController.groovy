package uncake

import grails.converters.JSON

class UserController {

    def index() { }

    def getAllNames(){
        def users = User.createCriteria().list([max: params.maxRows]) {
            and{
                ilike('name', "%${params.name_startsWith}%")
            }
        }
        print(users)
    }

    def getItemByName(){
        def selectedUser = User.createCriteria().list() {
            and{
                ilike('name', "%${params.selectedName}%")
            }
        }
        print(selectedUser)
    }
    def insertUsers(){
        new User(email:"alejandro@unal.com", password:"lollol12", name:"Alejandro" ).save(flush: true)
        new User(email:"saniagoH@unal.com", password:"lollol12", name:"Santiago" ).save(flush: true)
        new User(email:"hugo@unal.com", password:"lollol12", name:"Hugo" ).save(flush: true)
        new User(email:"ana@unal.com", password:"lollol12", name:"Ana" ).save(flush: true)
    }
}
