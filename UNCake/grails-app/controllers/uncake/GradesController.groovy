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
        def codeStudyPlan = Integer.parseInt( String.valueOf( academicRecord.find( planPattern ) ).split('\\|')[0].trim() )
        def studyPlan = uncake.StudyPlan.findByCode( codeStudyPlan )

        studyPlan.fundamentalCredits = studyPlan.fundamentalCredits == null ? Integer.parseInt( academicRecord.find( requiredPattern ).split('\\t')[1] ) : studyPlan.fundamentalCredits
        studyPlan.disciplinaryCredits = studyPlan.disciplinaryCredits == null ? Integer.parseInt( academicRecord.find( requiredPattern ).split('\\t')[2] ) : studyPlan.disciplinaryCredits
        studyPlan.freeChoiceCredits = studyPlan.freeChoiceCredits == null ? Integer.parseInt( academicRecord.find( requiredPattern ).split('\\t')[3] ) : studyPlan.freeChoiceCredits

        //render getCoursesToSave( getPeriods( academicRecord ), getPeriodNames( academicRecord ) ).size()
        render getPAPA( getPeriods( academicRecord ) )
    }

    def getPAPA( periods ){
        def papa = []
        def sumGrades = 0;
        def sumCredits = 0;
        for( int i = 0; i < periods.size(); i++ ){
            def periodsText = String.valueOf( periods[i] )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find( subjectPattern ) )
                def credits = Integer.parseInt( subject.split('\t')[6] )
                def grade = Double.parseDouble( subject.split('\t')[9] )
                sumGrades += grade * credits
                sumCredits += credits
                periodsText = periodsText.replace( subject, "" )
            }

            papa[i] = sumCredits > 0 ? sumGrades / sumCredits : 0
        }
        return papa
    }

    def getPeriods( academicRecord ){
        def periods = []
        def recordSoFar = academicRecord
        while( recordSoFar.find( periodPattern ) ) {
            def periodName = recordSoFar.find( periodPattern )
            periods.add( recordSoFar.substring( 0, recordSoFar.indexOf( periodName ) ) )
            recordSoFar = recordSoFar.substring( recordSoFar.indexOf( periodName ) ).replace( periodName, "" )
        }
        periods.add( recordSoFar )
        return periods
    }

    def getPeriodNames( academicRecord ){
        def periodNames = []
        def recordSoFar = academicRecord
        while( recordSoFar.find( periodPattern ) ) {
            def periodName = recordSoFar.find( periodPattern )
            periodNames.add( periodName )
            recordSoFar = recordSoFar.substring( recordSoFar.indexOf( periodName ) ).replace( periodName, "" )
        }
        return periodNames
    }

    def getSubjects( periods ){
        def subjects = [];
        for( int i = 0; i < periods.size(); i++ ){
            def periodsText = String.valueOf( periods[i] )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find( subjectPattern ) )
                subjects.add( subject )
                periodsText = periodsText.replace( subject, "" )
            }
        }
        return subjects
    }

    def getCoursesToSave( periods, periodNames ){
        def coursesToSave = []
        for( int i = 0; i < periods.size(); i++ ){
            def periodsText = String.valueOf( periods[i] )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find( subjectPattern ) )
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

                def newCourse = new uncake.Course( code: code, name: name, typology: typology, credits: credits, grade: grade, semester: String.valueOf( periodNames[i-1].split("\\|")[1] ), semesterNumber: i + 1 )
                coursesToSave.add( newCourse )
                periodsText = periodsText.replace( subject, "" )
            }
        }
        return coursesToSave
    }
}
