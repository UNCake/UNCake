package uncake

import grails.converters.JSON

class ProgressController {

    def index() {

    }

    def existAcademicRecord(){
        def planPattern = "[0-9]+ \\| [A-Za-z:\\.\\- ]+"
        def record = String.valueOf( params.record )
        def codeStudyPlan = Integer.parseInt( String.valueOf( record.find(planPattern) ).split('\\|')[0].trim() )
        def studyPlan = uncake.StudyPlan.findByCode( codeStudyPlan )
        def studyPlanCreated = false;
        def newUser = uncake.User.findById( ((User)session.user).id )
        newUser.academicRecord.each{
            if( it.studyPlan.code == studyPlan.code )
                studyPlanCreated = true
        }
        if( studyPlanCreated )
            render '1'
        else
            render '0'
    }

    def loadAcademicRecord(){
        def selectedRecord = String.valueOf( params.selectedRecord )
        def selectedCode = Integer.parseInt( selectedRecord.split('\\|')[0].trim() )
        def selectedName = selectedRecord.split('\\|')[1].trim()
        def academicRecordToShow
        def periods = []
        def gradesPAPAPerPeriod = []
        def creditsPAPAPerPeriod = []
        def gradesPAPerPeriod = []
        def creditsPAPerPeriod = []
        def subjectsPAPA = []
        def subjectsPA
        def PAPAPerPeriod = []
        def PAPerPeriod = []
        def gradesPAPASoFar = 0
        def creditsPAPASoFar = 0
        def gradesPASoFar = 0
        def creditsPASoFar = 0
        def subjectsToPrint = []
        def creditsFundamentals = 0
        def creditsDisciplinary = 0
        def creditsFreeChoice = 0
        uncake.User.findById( ((User)session.user).id ).academicRecord.each {
            if( it.studyPlan.code == selectedCode && it.studyPlan.name.toUpperCase().equals(selectedName) )
                academicRecordToShow = (AcademicRecord)it
        }
        academicRecordToShow.courses.each{
            def periodNumber = ((uncake.Course)it).semesterNumber
            subjectsPAPA.add( ((uncake.Course)it) )
            if( !(periodNumber in periods) )
                periods.add(periodNumber)
        }
        subjectsPA = subjectsPAPA
        for( int i = 0; i < subjectsPAPA.size() - 1; i++ ){
            for( int j = i + 1; j < subjectsPAPA.size(); j++ ){
                if( ( (uncake.Course)subjectsPAPA[i] ).code == ( (uncake.Course)subjectsPAPA[j] ).code )
                    subjectsPA.remove(i)
            }
        }
        for( int i = 0; i < periods.size(); i++ ){
            gradesPAPAPerPeriod.add(0)
            creditsPAPAPerPeriod.add(0)
            for( int j = 0; j < subjectsPAPA.size(); j++ ){
                if( i + 1 == ( (uncake.Course)subjectsPAPA[j] ).semesterNumber ) {
                    gradesPAPAPerPeriod[i] += ( (uncake.Course)subjectsPAPA[j] ).grade * ( (uncake.Course)subjectsPAPA[j] ).credits
                    creditsPAPAPerPeriod[i] += ( (uncake.Course)subjectsPAPA[j] ).credits
                }
            }
            gradesPAPASoFar += gradesPAPAPerPeriod[i]
            creditsPAPASoFar += creditsPAPAPerPeriod[i]
            PAPAPerPeriod.add( gradesPAPASoFar/creditsPAPASoFar )
        }
        for( int i = 0; i < periods.size(); i++ ){
            gradesPAPerPeriod.add(0)
            creditsPAPerPeriod.add(0)
            for( int j = 0; j < subjectsPA.size(); j++ ){
                if( i + 1 == ( (uncake.Course)subjectsPA[j] ).semesterNumber ) {
                    gradesPAPerPeriod[i] += ( (uncake.Course)subjectsPA[j] ).grade * ( (uncake.Course)subjectsPA[j] ).credits
                    creditsPAPerPeriod[i] += ( (uncake.Course)subjectsPA[j] ).credits
                }
            }
            gradesPASoFar += gradesPAPerPeriod[i]
            creditsPASoFar += creditsPAPerPeriod[i]
            PAPerPeriod.add( gradesPASoFar / creditsPASoFar )
        }
        for( int j = 0; j < subjectsPA.size(); j++ ){
            if( ( (uncake.Course)subjectsPA[j] ).grade > 3  ){
                if( ( (uncake.Course)subjectsPA[j] ).typology.equals("Fundamentación") )
                    creditsFundamentals += ( (uncake.Course)subjectsPA[j] ).credits
                if( ( (uncake.Course)subjectsPA[j] ).typology.equals("Disciplinar") )
                    creditsDisciplinary += ( (uncake.Course)subjectsPA[j] ).credits
                if( ( (uncake.Course)subjectsPA[j] ).typology.equals("Electiva") )
                    creditsFreeChoice += ( (uncake.Course)subjectsPA[j] ).credits
            }
        }
        def plan = ( (uncake.AcademicRecord)academicRecordToShow ).studyPlan
        def advance = ( (uncake.AcademicRecord)academicRecordToShow ).credits * 100 / ( ( (uncake.StudyPlan)plan ).fundamentalCredits + ( (uncake.StudyPlan)plan ).disciplinaryCredits + ( (uncake.StudyPlan)plan ).freeChoiceCredits )
        advance = advance * 10 >= Math.floor( advance * 10 ) + 0.5 ? Math.floor( advance * 10 ) + 1 : Math.floor( advance * 10 )
        advance /= 10
        def advanceFundamentals = ( (uncake.StudyPlan)plan ).fundamentalCredits
        def advanceDisciplinary = ( (uncake.StudyPlan)plan ).disciplinaryCredits
        def advanceFreeChoice = ( (uncake.StudyPlan)plan ).freeChoiceCredits

        subjectsPAPA.sort{ ((uncake.Course)it).semester }
        subjectsPAPA.each{
            def sub = (uncake.Course)it
            subjectsToPrint.add( String.valueOf( sub.code + '\\t' + sub.name + '\\t\\t\\t\\t\\t' + sub.credits + '\\t\\t\\t' + sub.grade ) )
        }

        def averagesToSend = []
        for(int i = 0; i < PAPerPeriod.size(); i++){
            averagesToSend.add(PAPAPerPeriod[i])
            averagesToSend.add(PAPerPeriod[i])
        }
        def advanceToSend = []
        def advanceComponentsToSend = []
        advanceToSend.add(advance)
        advanceComponentsToSend.add("exigidos\\t"+advanceFundamentals+"\\t"+advanceDisciplinary+"\\t"+advanceFreeChoice+"\\t\\t\\t" )
        advanceComponentsToSend.add("aprobados plan\\t"+creditsFundamentals+"\\t"+creditsDisciplinary+"\\t"+creditsFreeChoice+"\\t\\t\\t" )

        def output = [averagesToSend] + [advanceToSend] + [advanceComponentsToSend] + [subjectsToPrint]

        render output
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

                def newCourse = new uncake.Course( code: code, name: name, typology: typology, credits: credits, grade: grade, semester: String.valueOf( periodNames[i]), semesterNumber: i + 1 )
                newCourse.save(flush: true)
                coursesToSave.add( newCourse )
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
        def newUser = uncake.User.findById( ((User)session.user).id )

        newUser.academicRecord.each{
            if( it.studyPlan.code == studyPlan.code )
                studyPlanCreated = true
        }
        println studyPlanCreated

        if( studyPlanCreated ){
            def delStudyPlan = []
            if( delStudyPlan != null ) {
                newUser.academicRecord.each{
                    if( uncake.AcademicRecord.findById( it.id ).studyPlan.code == studyPlan.code )
                        delStudyPlan.add(it)
                }
            }
            delStudyPlan.each {
                newUser.removeFromAcademicRecord( AcademicRecord.findById( ((AcademicRecord)it).id ) )
            }
        }
        def academicRecords = []
        newUser.academicRecord.each{
            academicRecords.add( ((AcademicRecord)it) )
        }
        def acadRecordToSave = new uncake.AcademicRecord( studyPlan: studyPlan, credits: totalCredits, PAPA: PAPA, PA: PA, courses: coursesToSave )
        println acadRecordToSave
        academicRecords.add( acadRecordToSave )
        academicRecords.each {
            newUser.addToAcademicRecord( it ).save(failOnError: true)
        }

        uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) ).academicRecord.each {
            println it.studyPlan.code
            println it.PAPA
            println it.courses
            it.courses.each {
                //println it.code + " " + it.name + " " + it.credits + " " + it.grade + " " + it.semester

            }
        }
        println newUser.academicRecord.size()
        render ""
    }


}


