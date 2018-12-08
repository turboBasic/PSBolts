Deploy Module {
    By PSGalleryModule {
        FromSource ${ENV:BHProjectName}
        To PSGallery
        WithOptions @{
            ApiKey = ${ENV:NugetApiKey}
        }
    }

    # @TODO: add deployment as tagged commit to Github
}
