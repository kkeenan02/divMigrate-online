#' deploy script

shinyapps::deployApp(appName = "divMigrate-online", appDir = "./divMigrate-online",
                     account = "popgen", upload = TRUE,
                     launch.browser = getOption("shinyapps.launch.browser", 
                                                interactive()), quiet = FALSE)

shinyapps::configureApp("divMigrate-online", account = "popgen", 
                        appDir = "./divMigrate-online", 
                        redeploy = TRUE, size = "xlarge", quiet = FALSE)
