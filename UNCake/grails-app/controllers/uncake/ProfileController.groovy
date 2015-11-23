package uncake

class ProfileController {

    def index() {

        def email=session.user.email
        def u=User.findWhere(email: email)

        //Pasa a la vista las historias academicas
        def academicRecords=[]
        for (ar in u.academicRecord) {
            academicRecords.add(ar)
        }


        //Pasa a la vista los horarios
        def schedules=[]
        for (sc in u.schedules) {
            schedules.add(sc)

        }



        //Pasa a la vista los amigos
        def friends=[]
        for (fr in u.friends) {
            friends.add(fr)

        }

        [academicRecords: academicRecords,friends: friends,schedules: schedules ]



    }

    def delFriend(){
        def email=session.user.email
        def u=User.findWhere(email: email)

        def friendToDelete

        if(u.friends.size()==1){

            friendToDelete = User.findWhere(email: params.dfriend)

        }else{
            friendToDelete = User.findWhere(email: params.dfriend[params.int("ind")])
        }




        u.removeFromFriends(friendToDelete).save()
        redirect(controller: "profile")
    }


    def delSchedule(){
        def email=session.user.email
        def u=User.findWhere(email: email)

        def scheduleToDelete

        if(u.schedules.size()==1){


            scheduleToDelete = Schedule.findWhere(id: params.dschedule.toLong())

        }else{
            println params.int("ind1")
            scheduleToDelete = Schedule.findWhere(id:  (params.dschedule[params.int("ind1")]).toLong() )
        }

       u.removeFromSchedules(scheduleToDelete).save()
        redirect(controller: "profile")
    }

    def delAcademicRecord(){
        def email=session.user.email
        def u=User.findWhere(email: email)

        def arToDelete

        if(u.schedules.size()==1){


            arToDelete = AcademicRecord.findWhere(id: params.dacademicrecord.toLong())

        }else{

            arToDelete = AcademicRecord.findWhere(id:  (params.dacademicrecord[params.int("ind2")]).toLong() )
        }

        u.removeFromAcademicRecord(arToDelete).save()
        redirect(controller: "profile")
    }
    def changepassword(){

    }

    def changePass() {
        def u = session.user

        if (u.password != params.actPass.encodeAsSHA1()) {
            flash.message1 = "Esa no era tu contraseña"
            redirect(action: "changepassword" )
        } else {
            u.password=params.pass2.encodeAsSHA1()
            u.save()

            redirect(action: "changepasswordok")

        }

    }

    def changepasswordok(){

    }

}
