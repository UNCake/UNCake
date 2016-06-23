package uncake

import grails.validation.ValidationException

class UserController {

    def index() {
        redirect(controller: "profile")
    }
    private static final okcontents = ['image/png', 'image/jpeg', 'image/gif']

    def upload_avatar() {

        def user = User.findById(session.user.id) // or however you select the current user
        
        if(request.get) {
            redirect(controller: "profile")
            return
        }
        
        // Get the avatar file from the multi-part request
        if (request.getAttribute(CustomMultipartResolver.FILE_SIZE_EXCEEDED_ERROR)) {
            flash.message = "La imagen es demasiado grande, no puede superar 2MB"
            redirect(controller: "profile")
            return
        }

        if (request.getAttribute(CustomMultipartResolver.FILE_UPLOADING_ERROR)) {
            flash.message = "Ocurrio un error subiendo la imagen"
            redirect(controller: "profile")
            return
        }
        def f = request.getFile('avatar')

        // List of OK mime-types
        if(!f){
            flash.message = "Selecciona una imagen"
            redirect(controller: "profile")
            return
        }

        if (!okcontents.contains(f.getContentType())) {
            flash.message = "Formato incorrecto, la foto debe ser : ${okcontents}"
            redirect(controller: "profile")
            return
        }

        // Save the image and mime type

        user.avatar = f.bytes
        user.avatarType = f.contentType

        log.info("File uploaded: $user.avatarType")

        // Validation works, will check if the image is too big

        try {
            user.save()
        } catch (ValidationException ve) {
            flash.message = "Ocurrio un error subiendo la imagen"
            redirect(controller: "profile")
            return
        }
        //flash.message = "Avatar (${user.avatarType}, ${user.avatar.size()} bytes) uploaded."
        redirect(controller: "profile")
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
