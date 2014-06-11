library(shiny)
library(diveRsity)



# Define UI
shinyUI(pageWithSidebar(
  
  #app title
  headerPanel("divMigrate Online"),
  
  #input
  sidebarPanel(
    
    fileInput("file", "Input file", multiple = FALSE, accept = NULL),
            
    numericInput("nbs", "Number of bootstraps", value = 0, min = 0, 
                 max = 1000, step = 100),
    
    checkboxGroupInput("stat", "Migration Statistic", 
                       c("D", "Gst", "Nm", "All"), selected = "D"),
    
    sliderInput("filter_threshold", "Filter Threshold", min = 0, max = 1, 
                value = 0, step = 0.05),
    
    checkboxInput("plt", "Plot Network?", FALSE),
    
    
    actionButton("goButton", "Calculate"),
    
    helpText(""),
    
    helpText("Written and designed by Kevin Keenan using shiny",
             "from RStudio and Inc. (2012)."),
    helpText("Any suggestion or questions should be directed to,"),
    helpText("<kkeenan02 AT qub.ac.uk>")
  )  
    
    ,
  
  mainPanel(plotOutput("plt"))
))