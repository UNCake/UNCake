package uncake

class ProgressController {

    def index() {
       // def subjectPattern = /[0-9][A-Z\-0-9]*[\t][A-Za-záéíóúüÁÉÍÓÚÜ ]+[\t][0-9]+[\t][0-9]+[\t][0-9]+[\t][A-Z][\t][0-9]+[\t][0-9]+[\t]+[0-9]\.?[0-9]/
        /*def calculatePAPA = {
            def academicHistory = params.academicHistory
            println academicHistory
            println "hola"
            //render "hola" as JSON
        }*/
        println "\n\n\n\n\n\n"
    }

    def receiveText(){
        println params
        render params.academicHistory
        return
    }


}
