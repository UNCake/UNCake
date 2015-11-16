package uncake

import grails.converters.JSON

class ProgressController {

    def index() {

    }

    def receiveText(){
        /*println params
        render params.academicHistory
        return*/
    }

    def saveAcademicRecord(){
        def planPattern = "[0-9]+ \\| [A-Za-z:\\.\\- ]+"
        def subjectPattern = "[0-9][A-Z\\-0-9]*[\\t][A-Za-z:\\.\\- ]+[\\t][0-9]+[\\t][0-9]+[\\t][0-9]+[\\t][A-Z][\\t][0-9]+[\\t][0-9]+[\\t]+[0-9]\\.?[0-9]"
        def requiredPattern = "exigidos\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9\\-]+\\t[0-9]+";
        def periodPattern = "[0-9]+[\\t]periodo academico[ ]*\\|[ ]*[0-9\\-A-Z]+";
        def subjects = []
        def sumSubjects = 0.0;
        def sumCredits = 0;
        def record = String.valueOf( params.record )
        def codeStudyPlan = Integer.parseInt( String.valueOf( record.find(planPattern) ).split('\\|')[0].trim() )
        def studyPlan = uncake.StudyPlan.findByCode( codeStudyPlan )

        studyPlan.fundamentalCredits = studyPlan.fundamentalCredits == null ? Integer.parseInt( record.find( requiredPattern ).split('\\t')[1] ) : studyPlan.fundamentalCredits
        studyPlan.disciplinaryCredits = studyPlan.disciplinaryCredits == null ? Integer.parseInt( record.find( requiredPattern ).split('\\t')[2] ) : studyPlan.disciplinaryCredits
        studyPlan.freeChoiceCredits = studyPlan.freeChoiceCredits == null ? Integer.parseInt( record.find( requiredPattern ).split('\\t')[3] ) : studyPlan.freeChoiceCredits

        def coursesToSave = []

        def periods = []
        def periodNames = []
        def recordSoFar = record
        def periodName = recordSoFar.find( periodPattern )
        periodNames.add( periodName )
        recordSoFar = recordSoFar.replace( periodName, "" )
        while( recordSoFar.find( periodPattern ) ) {
            periodName = recordSoFar.find( periodPattern )
            periodNames.add( periodName )
            periods.add( recordSoFar.substring( 0, recordSoFar.indexOf( periodName ) ) )
            recordSoFar = recordSoFar.substring( recordSoFar.indexOf( periodName ) )
            recordSoFar = recordSoFar.replace( periodName, "" )
        }
        periods.add( recordSoFar.substring( 0 ) )

        for( int i = 0; i < periods.size(); i++ ){
            def periodsText = String.valueOf( periods[i] )
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( periodsText.find(subjectPattern) );
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

                coursesToSave.add( new uncake.Course( code: code, name: name, typology: typology, credits: credits, grade: grade, semester: String.valueOf( periodNames[i]) ) )
                periodsText = periodsText.replace( subject, "" )
            }
        }

        for( int i = 0; i < subjects.size(); i++ ){
            sumSubjects += Float.parseFloat( subjects[i].split('\t')[9] ) * Integer.parseInt( subjects[i].split('\t')[6] );
            sumCredits += Integer.parseInt( subjects[i].split('\t')[6] );
        }

        def PAPA = sumSubjects / sumCredits;

        def subjectsAux = subjects;
        for( int i = 0; i < subjects.size() - 1; i++ ){
            for( int j = i + 1; j < subjects.size(); j++ ){
                if( String.valueOf( subjects[i].split('\t')[0] ).equals( String.valueOf( subjects[j].split('\t')[0] ) ) )
                    subjectsAux.remove(i)
            }
        }
        def totalCredits = sumCredits
        sumSubjects = 0.0;
        sumCredits = 0;
        for( int i = 0; i < subjectsAux.size(); i++ ){
            sumSubjects += Float.parseFloat( subjectsAux[i].split('\t')[9] ) * Integer.parseInt( subjectsAux[i].split('\t')[6] );
            sumCredits += Integer.parseInt( subjectsAux[i].split('\t')[6] );
        }

        def PA = sumSubjects / sumCredits;
        def studyPlanCreated = false;
        def newUser = uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) )

        newUser.academicRecord.each{
            if( it.studyPlan.code == studyPlan.code )
                studyPlanCreated = true
        }

        def acadRecordToSave = new AcademicRecord( studyPlan: studyPlan, credits: totalCredits, PAPA: PAPA, PA: PA, courses: coursesToSave )
        acadRecordToSave.save()

        if( studyPlanCreated ){
            def delStudyPlan = []
            if( delStudyPlan != null ) {
                newUser.academicRecord.each{
                    if( uncake.AcademicRecord.findById( it.id ).studyPlan.code == studyPlan.code )
                        delStudyPlan.add(it)
                }
            }
            delStudyPlan.each {
                newUser.removeFromAcademicRecord( (AcademicRecord)it )
                uncake.AcademicRecord.deleteAll( (AcademicRecord)it )
            }

            if( newUser.academicRecord.size() > 0 )
                newUser.addToAcademicRecord( acadRecordToSave )
            else
                newUser.academicRecord = [ acadRecordToSave ]
        }
        else
            newUser.addToAcademicRecord( acadRecordToSave )

        /*newUser.academicRecord.each {
            println it.studyPlan.code
            println it.PAPA
            it.courses.each {
                println it.code + " " + it.name + " " + it.credits + " " + it.grade + " " + it.semester
            }
        }*/
        render ""
    }


}

