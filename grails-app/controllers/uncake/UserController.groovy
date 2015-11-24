package uncake

class UserController {

    def index() {
        render (view: "selectavatar") }
    private static final okcontents = ['image/png', 'image/jpeg', 'image/gif']

    def upload_avatar() {

            def user = session.user // or however you select the current user

            // Get the avatar file from the multi-part request
            def f = request.getFile('avatar')

            // List of OK mime-types
            if (!okcontents.contains(f.getContentType())) {
                flash.message = "Formato incorrecto, la foto debe ser : ${okcontents}"
                //render(view:'selectavatar', model:[user:user])
                redirect(action: "index")
                return
            }

            // Save the image and mime type

                user.avatar = f.bytes
                user.avatarType = f.contentType



            log.info("File uploaded: $user.avatarType")

            // Validation works, will check if the image is too big


        if (!user.save(flush: true)) {
            flash.message ="imagen muy grande"
            redirect( action:"index" )
            //render(view:'selectavatar', model:[user:user])
            return
        }
        flash.message = "Avatar (${user.avatarType}, ${user.avatar.size()} bytes) uploaded."
        redirect(controller: "profile" )

    }

    def avatar_image() {
        def avatarUser = User.get(params.id)
        if (!avatarUser || !avatarUser.avatar || !avatarUser.avatarType) {
            response.sendError(404)
            return
        }
        response.contentType = avatarUser.avatarType
        response.contentLength = avatarUser.avatar.size()
        OutputStream out = response.outputStream
        out.write(avatarUser.avatar)
        out.close()
    }
}
