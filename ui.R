#library(shiny)
#library(diveRsity)
# Define UI
shinyUI(
  
  pageWithSidebar(
    
    headerPanel(HTML("<font color = #484587>divMigrate Online</font>")),
    
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
            HTML("<h5><font color = #215F9C>Usage Instructions</font></h5>"),
            HTML("<h3><font color = #215F9C>Welcome to the divMigrate-Online       web app!</font></h3><br><br>"),
            h4("Getting started:"),
            HTML("<ol>",
                 "<li>Read your genepop file (2-digit or 3-digit)</li>",
                 "<li>Choose which statistic you want to use to calculate",
                 "relative migration</li>",
                 "<li>Statistical significance of directional migration ",
                 "can be calculated by setting the number of bootstraps ",
                 " to a value > 0</li>",
                 "<li>The number of links in the network plot can be ",
                 "manipulated using the 'filter threshold' slider</li>",
                 "<li>Download your network plot (as a .eps) and your ",
                 "result matrix (as .txt) for reporting puposes.</li>",
                 "<br>"),
            HTML("<font size = 1>Any issues or queries regarding this application can be directed to kkeenan02[at]qub.ac.uk.</font>")
          ),
          tabPanel(
            HTML("<h5><font color = #215F9C>Network Plots</font></h5>"),
            downloadButton("dlPlt", "Download Network .eps"),
            plotOutput("plt")           
          ),
          tabPanel(
            HTML("<h5><font color = #215F9C>Results Matrix</font></h5>"),
            h6("To download a file containing your results as a tab",
               "delimited file, please click the button below:"),
            downloadButton("mat", "Download your file!")
          )
        )   
    )
  )
)