import uncake.CustomMultipartResolver

// Place your Spring DSL code here
beans = {
    multipartResolver(CustomMultipartResolver) {
        maxUploadSize = (2*1024*1024)
    }
}
