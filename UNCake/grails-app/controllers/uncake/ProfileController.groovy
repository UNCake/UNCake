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
        def u = Person.get(1)
        p.delete()
    }
}
