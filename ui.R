library(shiny)
library(diveRsity)



# Define UI
shinyUI(
  
  pageWithSidebar(
    
    headerPanel("divMigrate Online"),
    
    sidebarPanel(
      
      fileInput("file", "Input file", multiple = FALSE, accept = NULL),
      
      numericInput("nbs", "Number of bootstraps", value = 0, min = 0, 
                   max = 1000, step = 100),
      
      checkboxGroupInput("stat", "Migration Statistic", 
                         c("D", "Gst", "Nm"), selected = "D"),
      
      sliderInput("filter_threshold", "Filter Threshold", min = 0, max = 1, 
                  value = 0, step = 0.05),
      
      
      actionButton("goButton", "Calculate"),
      
      helpText(""),
      
      helpText("Written and designed by Kevin Keenan using shiny",
               "from RStudio and Inc. (2012).")
    ),
    
    mainPanel(
      plotOutput("plt") 
    )
 )
)