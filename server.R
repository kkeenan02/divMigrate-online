# Load packages
library("shiny")
library("divMig")#, lib.loc = "/home/kkeenan/depends/")
#library("shinyIncubator")

shinyServer(function(input, output, session){
  
  # calculate migration
  output$plt <- renderPlot({
    if(input$goButton==0) return(NULL)
    isolate({
      infile <- input$file$datapath
      if(input$stat == "D") stat <- "d"
      if(input$stat == "Gst") stat <- "gst"
      if(input$stat == "Nm") stat <- "Nm"
      divMigrate(infile = infile,
                 outfile = NULL,
                 nbs = input$nbs,
                 stat = stat,
                 filter_threshold = input$filter_threshold,
                 plot_network = TRUE,
                 plot_col = "darkblue",
                 para = TRUE)
    })
  })
  # plots  
})
