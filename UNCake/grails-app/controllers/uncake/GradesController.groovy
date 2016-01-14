package uncake

class GradesController {

    def planPattern = "[0-9]+ \\| [A-Za-z:\\.\\- ]+"
    def subjectPattern = "[0-9][A-Z\\-0-9]*[\\t][A-Za-z:\\(\\)\\.\\- ]+[\\t][0-9]+[\\t][0-9]+[\\t][0-9]+[\\t][A-Z][\\t][0-9]+[\\t][0-9]+[\\t]+[0-9]\\.?[0-9]"
    def requiredPattern = "exigidos\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9\\-]+\\t[0-9]+"
    def approvedPattern = "aprobados\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9\\-]+\\t[0-9]+"
    def periodPattern = "[0-9]+[\\t]periodo academico[ ]*\\|[ ]*[0-9\\-A-Z]+"

    def index() { }

    def calculateAcademicRecord(){


        def academicRecord = String.valueOf( params.academicRecord )

        def codeStudyPlan = Integer.parseInt( String.valueOf( academicRecord.find(planPattern) ).split('\\|')[0].trim() )
        def studyPlan = uncake.StudyPlan.findByCode( codeStudyPlan )

        studyPlan.fundamentalCredits = studyPlan.fundamentalCredits == null ? Integer.parseInt( academicRecord.find( requiredPattern ).split('\\t')[1] ) : studyPlan.fundamentalCredits
        studyPlan.disciplinaryCredits = studyPlan.disciplinaryCredits == null ? Integer.parseInt( academicRecord.find( requiredPattern ).split('\\t')[2] ) : studyPlan.disciplinaryCredits
        studyPlan.freeChoiceCredits = studyPlan.freeChoiceCredits == null ? Integer.parseInt( academicRecord.find( requiredPattern ).split('\\t')[3] ) : studyPlan.freeChoiceCredits

        def periods = []
        def periodNames = []
        def recordSoFar = academicRecord
        while( recordSoFar.find( periodPattern ) ) {
            def periodName = recordSoFar.find( periodPattern )
            periodNames.add( periodName )
            periods.add( recordSoFar.substring( 0, recordSoFar.indexOf( periodName ) ) )
            recordSoFar = recordSoFar.substring( recordSoFar.indexOf( periodName ) ).replace( periodName, "" )
        }
        periods.add( recordSoFar )

        /*for( int i = 0; i < periods.size(); i++ ){
            def periodsText = String.valueOf( periods[i] )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find( subjectPattern ) );
                subjects.add( subject )
                def code = Integer.parseInt( (subject.split('\t')[0])[0..(subject.indexOf('-')-1)] )
                def name = subject.split('\t')[1]
                def credits = Integer.parseInt( subject.split('\t')[6] )
                def grade = Double.parseDouble( subject.split('\t')[9] )
                def typology = ""
                if( subject.split('\t')[5] == 'B' )
                    typology = "Fundamentación"
                if( subject.split('\t')[5] == 'C' )
                    typology = "Disciplinar"
                if( subject.split('\t')[5] == 'L' )
                    typology = "Electiva"

                def newCourse = new uncake.Course( code: code, name: name, typology: typology, credits: credits, grade: grade, semester: String.valueOf( periodNames[i]), semesterNumber: i + 1 )
                newCourse.save(flush: true)
                coursesToSave.add( newCourse )
                periodsText = periodsText.replace( subject, "" )
            }
        }*/

        render getSubjects( periods ).size()
    }

    def getSubjects( periods ){
        def subjects = [];
        for( int i = 0; i < periods.size(); i++ ){
            def periodsText = String.valueOf( periods[i] )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find( subjectPattern ) );
                subjects.add( subject )
                periodsText = periodsText.replace( subject, "" )
            }
        }
        return subjects
    }
}
