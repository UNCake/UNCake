class UrlMappings {

    static mappings = {

        "/login"(controller: "login", action: "index")
        "/register"(controller: "register", action: "index")
        "/changephoto"(controller:"user" , action:"index")
        "/logout"(controller: "logout", action: "index")
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here


            }
        }

        "/"(controller: 'home', action: 'index')
        "500"(view:'/error')
        "404"(view:'/notFound')
    }
}
