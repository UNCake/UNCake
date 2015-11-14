package uncake

import java.util.regex.*

class ProgressController {

    def index() {

    }

    def receiveText(){
        /*println params
        render params.academicHistory
        return*/
    }

    def saveAcademicRecord(){
        def planPattern = "[0-9]+ \\| [A-Za-záéíóúüÁÉÍÓÚÜ:\\.\\- ]+"
        def subjectPattern = "[0-9][A-Z\\-0-9]*[\\t][A-Za-záéíóúüÁÉÍÓÚÜ:\\.\\- ]+[\\t][0-9]+[\\t][0-9]+[\\t][0-9]+[\\t][A-Z][\\t][0-9]+[\\t][0-9]+[\\t]+[0-9]\\.?[0-9]"
        def requiredPattern = "exigidos\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9\\-]+\\t[0-9]+";
        def subjects = []
        def sumSubjects = 0.0;
        def sumCredits = 0;
        def record = params.record
        def codeStudyPlan = Integer.parseInt( String.valueOf( record.find(planPattern) ).split('\\|')[0].trim() )
        def studyPlan = uncake.StudyPlan.findByCode( codeStudyPlan )

        studyPlan.fundamentalCredits = studyPlan.fundamentalCredits == null ? Integer.parseInt( record.find( requiredPattern ).split('\\t')[1] ) : studyPlan.fundamentalCredits
        studyPlan.disciplinaryCredits = studyPlan.disciplinaryCredits == null ? Integer.parseInt( record.find( requiredPattern ).split('\\t')[2] ) : studyPlan.disciplinaryCredits
        studyPlan.freeChoiceCredits = studyPlan.freeChoiceCredits == null ? Integer.parseInt( record.find( requiredPattern ).split('\\t')[3] ) : studyPlan.freeChoiceCredits

        while( record.find(subjectPattern) ){
            def subject = String.valueOf( record.find(subjectPattern) );
            subjects.add( subject )
            sumSubjects += Float.parseFloat( subject.split('\t')[9] ) * Integer.parseInt( subject.split('\t')[6] );
            sumCredits += Integer.parseInt( subject.split('\t')[6] );
            record = record.replace( subject, "" );
        }
        def PAPA = sumSubjects / sumCredits;

        def subjectsAux = subjects;
        for( def i = 0; i < subjects.size() - 1; i++ ){
            for( def j = i + 1; j < subjects.size(); j++ ){
                if( String.valueOf( subjects[i].split('\t')[0] ) == String.valueOf( subjects[j].split('\t')[0] ) ){
                    subjectsAux.remove(i)
                }
            }
        }
        def totalCredits = sumCredits
        sumSubjects = 0.0;
        sumCredits = 0;
        for( def i = 0; i < subjectsAux.size(); i++ ){
            sumSubjects += Float.parseFloat( subjectsAux[i].split('\t')[9] ) * Integer.parseInt( subjectsAux[i].split('\t')[6] );
            sumCredits += Integer.parseInt( subjectsAux[i].split('\t')[6] );
        }
        def PA = sumSubjects / sumCredits;

        def myRecord = new uncake.AcademicRecord( studyPlan: studyPlan, credits: totalCredits, PAPA: PAPA, PA: PA )

        def studyPlanCreated = false;

        uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) ).academicRecord.each{
            if( it.studyPlan.code == studyPlan.code )
                studyPlanCreated = true
        }

        if( studyPlanCreated ){
            def delStudyPlan = []
            if( delStudyPlan != null ) {
                uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) ).academicRecord.each{
                    if( uncake.AcademicRecord.findById( it.id ).studyPlan.code == studyPlan.code )
                        delStudyPlan.add(it)
                }
            }
            delStudyPlan.each {
                uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) ).removeFromAcademicRecord( it )
            }
            uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) ).addToAcademicRecord( myRecord )
        }
        else
            uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) ).addToAcademicRecord( myRecord )

        uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) ).academicRecord.each {
            println it.studyPlan.code
            println it.PAPA

        }

        //newUser.academicRecord = academicRecord
        //println newUser.academicRecord
        render ""
    }


}

