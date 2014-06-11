# Load packages
library("shiny")
library("diveRsity")#, lib.loc = "/home/kkeenan/depends/")
#library("shinyIncubator")

shinyServer(function(input, output, session){
  
  # calculate migration
  output$plt <- renderPlot({
    if(input$goButton==0) return(NULL)
    isolate({
      infile <- input$file$datapath
      divMigrate(infile = infile,
                 outfile = NULL,
                 nbs = input$nbs,
                 stat = "d",
                 filter_threshold = input$filter_threshold,
                 plot_network = TRUE,
                 plot_col = "darkblue",
                 para = TRUE)
    })
  })
  # plots  
})
