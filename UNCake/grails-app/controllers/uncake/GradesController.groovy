package uncake

class GradesController {

    final SUBJECT_CREDITS = 6, SUBJECT_GRADE = 9, SUBJECT_NAME = 1, SUBJECT_CODE = 0, SUBJECT_TYPOLOGY = 5

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

        render getCoursesToSave( getPeriods( academicRecord ), getPeriodNames( academicRecord ) ).typology
        //render getPA( getPeriods( academicRecord ) )
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

    def getPA( periods ){
        def pa = []
        def subjects = []
        def subsPerPeriod = []
        def duplicatedSubject
        for( int i = 0; i < periods.size(); i++ ){
            def periodsText = String.valueOf( periods[i] )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find( subjectPattern ) )
                subjects.add( subject )
                periodsText = periodsText.replace( subject, "" )
            }
            def subjectsPA = []
            for( int j = 0; j < subjects.size(); j++ ){
                duplicatedSubject = false
                def code1 = Integer.parseInt( (subjects[j].split('\t')[0])[0..(subjects[j].indexOf('-')-1)] )
                def grade1 = Double.parseDouble( subjects[j].split('\t')[9] )
                for( int k = 0; k < subjects.size(); k++){
                    if( j != k ){
                        def code2 = Integer.parseInt( (subjects[k].split('\t')[0])[0..(subjects[k].indexOf('-')-1)] )
                        if( code1 == code2 ) {
                            duplicatedSubject = true
                            def grade2 = Double.parseDouble( subjects[k].split('\t')[9] )
                            if( grade2 >= grade1 ) {
                                if( !subjectsPA.contains( subjects[k] ) )
                                    subjectsPA.add(subjects[k])
                                if( subjectsPA.contains( subjects[j] ) )
                                    subjectsPA.remove( subjects[j] )
                            }
                            else {
                                if( !subjectsPA.contains( subjects[j] ) )
                                    subjectsPA.add(subjects[j])
                                if( subjectsPA.contains( subjects[k] ) )
                                    subjectsPA.remove( subjects[k] )
                            }
                        }
                    }
                }
                if(!duplicatedSubject)
                    subjectsPA.add( subjects[j] )
            }
            def sumGrades = 0;
            def sumCredits = 0;
            for( int j = 0; j < subjectsPA.size(); j++ ){
                def grade = Double.parseDouble( subjectsPA[j].split('\t')[9] )
                def credits = Integer.parseInt( subjectsPA[j].split('\t')[6] )
                sumGrades += grade * credits
                sumCredits += credits
            }
            pa[i] = sumCredits > 0 ? sumGrades / sumCredits : 0
        }
        return pa
    }

    def getPeriods( academicRecord ){
        def periods = []
        def recordSoFar = academicRecord
        def periodName = recordSoFar.find( periodPattern )
        recordSoFar = recordSoFar.substring( recordSoFar.indexOf( periodName ) ).replace( periodName, "" )
        while( recordSoFar.find( periodPattern ) ) {
            periodName = recordSoFar.find( periodPattern )
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

    def getSubjects = { periods ->
        def subjects = []
        periods.each{
            def periodsText = String.valueOf( it )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find( subjectPattern ) )
                subjects.add( subject )
                periodsText = periodsText.replace( subject, "" )
            }
        }
        return subjects
    }

    def getCoursesToSave = { periods, periodNames ->
        def coursesToSave = []
        def typoligies = [ 'B' : 'Fundamentación', 'C' : 'Disciplinar', 'L' : 'Electiva', 'P' : 'Idioma y nivelación' ]
        periods.eachWithIndex{ it, i ->
            def periodsText = String.valueOf( it )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find( subjectPattern ) )
                def code = Integer.parseInt( ( subject.split('\t')[SUBJECT_CODE] )[0..(subject.indexOf('-')-1)] )
                def name = subject.split('\t')[SUBJECT_NAME]
                def credits = Integer.parseInt( subject.split('\t')[SUBJECT_CREDITS] )
                def grade = Double.parseDouble( subject.split('\t')[SUBJECT_GRADE] )
                def typology = typoligies[ subject.split('\t')[SUBJECT_TYPOLOGY] ]

                def newCourse = new uncake.Course( code: code, name: name, typology: typology, credits: credits, grade: grade, semester: String.valueOf( periodNames[i].split("\\|")[1] ), semesterNumber: i + 1 )
                coursesToSave.add( newCourse )
                periodsText = periodsText.replace( subject, "" )
            }
        }
        return coursesToSave
    }
}
