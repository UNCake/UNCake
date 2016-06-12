class UrlMappings {

    static mappings = {

        "/login"(controller: "login", action: "index")
        "/register"(controller: "register", action: "index")
        "/logout"(controller: "logout", action: "index")
        "/grades"(controller: "grades", action: "index")
        "/schedule"(controller: "schedule", action: "index")
        "/profile"(controller: "profile", action: "index")
        "/profile/profile"(controller: "profile", action: "index")
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here


            }
        }

        "/"(controller: 'home', action: 'index')
        "500"(view:'/503')
        "404"(view:'/404')
    }
}
