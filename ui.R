#library(shiny)
#library(diveRsity)
# Define UI
shinyUI(
  
  pageWithSidebar(
    
    headerPanel("divMigrate Online"),
    
    sidebarPanel(
      
      fileInput("file", "Input file", multiple = FALSE, accept = NULL),
      
      numericInput("nbs", "Number of bootstraps", value = 0, min = 0, 
                   max = 5000, step = 1),
      
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
        tabsetPanel(
          tabPanel(
            h5("Usage Instructions"),
            "Welcome to the divMigrate-Online webb app!"
          ),
          tabPanel(
            h5("Network Plots"),
            downloadButton("dlPlt", "Download Network .eps"),
            plotOutput("plt")           
          ),
          tabPanel(
            h5("Results Matrix"),
            h6("To download a file containing your results as a tab",
               "delimited file, please click the button below:"),
            downloadButton("mat", "Download your file!")
          )
        )   
    )
  )
)