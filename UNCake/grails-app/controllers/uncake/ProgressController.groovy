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
        def planPattern = "[0-9]+ \\| [A-Za-z·ÈÌÛ˙¸¡…Õ”⁄‹:\\.\\- ]+"
        def subjectPattern = "[0-9][A-Z\\-0-9]*[\\t][A-Za-z·ÈÌÛ˙¸¡…Õ”⁄‹:\\.\\- ]+[\\t][0-9]+[\\t][0-9]+[\\t][0-9]+[\\t][A-Z][\\t][0-9]+[\\t][0-9]+[\\t]+[0-9]\\.?[0-9]"
        def requiredPattern = "exigidos\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9]+\\t[0-9\\-]+\\t[0-9]+";
        def periodPattern = "[0-9]+[\\t]periodo acadÈmico[ ]*\\|[ ]*[0-9\\-A-Z]+";
        def subjects = []
        def sumSubjects = 0.0;
        def sumCredits = 0;
        def record = params.record
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
            recordSoFar = recordSoFar.replace( periodName, "" )
        }

        for( int i = 0; i < periods.size(); i++ ){
            def periodsText = periods[i]
            while( periodsText.find( subjectPattern ) ){
                def subject = String.valueOf( record.find(subjectPattern) );
                subjects.add( subject )
                def code = Integer.parseInt( (subject.split('\t')[0])[0..(subject.indexOf('-')-1)] )
                def name = subject.split('\t')[1]
                def credits = subject.split('\t')[6]
                def grade = Double.parseDouble( subject.split('\t')[9] )

                def typology = ""
                if( subject.split('\t')[5] == 'B' )
                    typology = "FundamentaciÛn"
                if( subject.split('\t')[5] == 'C' )
                    typology = "Disciplinar"
                if( subject.split('\t')[5] == 'L' )
                    typology = "Electiva"

                coursesToSave.add( new uncake.Course( code: code, name: name, typology: typology, credits: credits, grade: grade, semester: periodName[i] ) )
                sumSubjects += Float.parseFloat( subject.split('\t')[9] ) * Integer.parseInt( subject.split('\t')[6] )
                sumCredits += Integer.parseInt( subject.split('\t')[6] )
                periodsText = periodsText.replace( subject, "" )
            }
        }

        def PAPA = sumSubjects / sumCredits;

        def subjectsAux = subjects;
        for( def i = 0; i < subjects.size() - 1; i++ ){
            for( def j = i + 1; j < subjects.size(); j++ ){
                if( String.valueOf( subjects[i].split('\t')[0] ) == String.valueOf( subjects[j].split('\t')[0] ) )
                    subjectsAux.remove(i)
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

        def studyPlanCreated = false;
        def newUser = uncake.User.findById( Integer.parseInt( String.valueOf(session.user).split(':')[1].trim() ) )

        newUser.academicRecord.each{
            if( it.studyPlan.code == studyPlan.code )
                studyPlanCreated = true
        }

        if( studyPlanCreated ){
            def delStudyPlan = []
            if( delStudyPlan != null ) {
                newUser.academicRecord.each{
                    if( uncake.AcademicRecord.findById( it.id ).studyPlan.code == studyPlan.code )
                        delStudyPlan.add(it)
                }
            }
            delStudyPlan.each {
                newUser.removeFromAcademicRecord( it )
            }
            newUser.addToAcademicRecord( new uncake.AcademicRecord( studyPlan: studyPlan, credits: totalCredits, PAPA: PAPA, PA: PA, courses: coursesToSave ) )
        }
        else
            newUser.addToAcademicRecord( new uncake.AcademicRecord( studyPlan: studyPlan, credits: totalCredits, PAPA: PAPA, PA: PA, courses: coursesToSave ) )

        newUser.academicRecord.each {
            println it.studyPlan.code
            println it.PAPA
            it.courses.each {
                println it.code + " " + it.name + " " + it.credits + " " + it.grade + " " + it.semester
            }
        }
        render ""
    }


}

