package uncake

class ProfileController {
    def friendToGo//=new User(email:"xxxxxxxxxx@unal.com", password:"lollol12".encodeAsSHA1(), name:"Pedro" ).save();
    def index() {
        friendToGo=null
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

        [academicRecords: academicRecords,friends: friends,schedules: schedules, ftg: friendToGo]

    }

/*
    def index2() {
        [ ftg: friendToGo]
    }

    def delFriend(){
        def email=session.user.email
        def u=User.findWhere(email: email)

        if(params.ind!=null){
            def friendToDelete

            if(u.friends.size()==1){

                friendToDelete = User.findWhere(email: params.dfriend)

            }else{
                friendToDelete = User.findWhere(email: params.dfriend[params.int("ind")])
            }

            u.removeFromFriends(friendToDelete).save()
            redirect(controller: "profile")
        }else{


            if(u.friends.size()==1){

                friendToGo = User.findWhere(email: params.dfriend)

            }else{
                friendToGo = User.findWhere(email: params.dfriend[params.int("indexf")])
            }

            redirect( controller: "profile", action: "index2")

        }






    }

    def goToFriend(){
        def email=session.user.email
        def u=User.findWhere(email: email)

        def friendToGo

        if(u.friends.size()==1){

            friendToGo = User.findWhere(email: params.dfriend)

        }else{
            friendToGo = User.findWhere(email: params.dfriend[params.int("indexf")])
        }
        println friendToGo.name

redirect(controller: "profile")
        //render(view: "index", model: [ftg: friendToGo ])
    }

*/
    def delSchedule(){
        def email=session.user.email
        def u=User.findWhere(email: email)

        def scheduleToDelete
        
        if(!params.ind1) {
            redirect(controller: "profile")
            return
        }
        
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
        
        if(!params.ind2) {
            redirect(controller: "profile")
            return
        }
        
        if(u.schedules.size()==1){

            arToDelete = AcademicRecord.findWhere(id: params.dacademicrecord.toLong())

        }else{

            arToDelete = AcademicRecord.findWhere(id:  (params.dacademicrecord[params.int("ind2")]).toLong() )
        }

        u.removeFromAcademicRecord(arToDelete).save()
        redirect(controller: "profile")
    }

    def changePass() {
        def u = session.user
        if(!params.actPass) {
            redirect(controller: "profile")
            return
        }
        if (u.password != params.actPass.encodeAsSHA1()) {
            flash.message = "Esa no era tu contraseña"
            redirect(action: "index" )
        } else {
            u.password=params.pass2.encodeAsSHA1()
            u.save()
            flash.message = "Contraseña cambiada correctamente"
            redirect(action: "index")
        }

    }

}
