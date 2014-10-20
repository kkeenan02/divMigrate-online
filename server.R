# Load packages
library("shiny")
library("diveRsity")

# Increase file upload limit
options(shiny.maxRequestSize = 50*(1024^2))

shinyServer(function(input, output, session){
  
  # calculate migration
  out <- reactive({
    if(input$goButton==0) return(NULL)
    isolate({
      infile <- input$file$datapath
      if(input$stat == "D") stat <- "d"
      if(input$stat == "Gst") stat <- "gst"
      if(input$stat == "Nm") stat <- "Nm"
      z <- divMigrate(infile = infile,
                      outfile = NULL,
                      nbs = input$nbs,
                      stat = stat,
                      filter_threshold = input$filter_threshold,
                      plot_network = TRUE,
                      plot_col = "darkblue",
                      para = FALSE,
                      app = TRUE)
    })
  })
  
  # network plots
  output$plt <- renderPlot({
    if(input$goButton==0) return(NULL)
    isolate({
      op <- out()
      if(input$stat == "D" & input$nbs != 0L){
        replayPlot(op$Dplt_bs)
      } else if(input$stat == "D" & input$nbs == 0L){
        replayPlot(op$Dplt)
      }
      if(input$stat == "gst" & input$nbs != 0L){
        replayPlot(op$Gplt_bs)
      } else if(input$stat == "gst" & input$nbs == 0L){
        replayPlot(op$Gplt)
      }
      if(input$stat == "Nm" & input$nbs != 0L){
        replayPlot(op$Nmplt_bs)
      } else if(input$stat == "Nm" & input$nbs == 0L){
        replayPlot(op$Nmplt)
      }
    })
  })
  
  # Matrix table
  output$mat <- downloadHandler(
    filenames <- function(file){
      if(input$stat == "D"){
        paste("divMigrate_", gsub(" ", "_", date()), "-[D].txt", sep = "") 
      } else if(input$stat == "Gst"){
        paste("divMigrate_", gsub(" ", "_", date()), "-[Gst].txt", sep = "")
      } else if(input$stat == "Nm"){
        paste("divMigrate_", gsub(" ", "_", date()), "-[Nm].txt", sep = "")
      }
    },
    content <- function(file){
      op <- out()
      if(input$stat == "D"){
        D <- op$D
        hdr <- paste(c(" Pops", colnames(D)), collapse = "\t")
        hdr <- c("divMigrate-online",
                 "",
                 "Relative directional Migration matrix Calculated using",
                 "D (Jost, 2008)",
                 "",
                 "If bootstrapping has been carried out, statistically",
                 "significant values (alpha = 0.5) are indicated with '*'",
                 "",
                 hdr)
        D <- cbind(colnames(D), D)
        D <- apply(D, 1, paste, collapse = " \t")
        D <- paste(c(hdr, D), collapse = "\n")
        writeLines(text = D, con = file)
      } else if(input$stat == "Gst"){
        Gst <- op$Gst
        hdr <- paste(c(" Pops", colnames(Gst)), collapse = "\t")
        hdr <- c("divMigrate-online",
                 "",
                 "Relative directional Migration matrix Calculated using",
                 "Gst (Nei & Chesser, 1983)",
                 "",
                 "If bootstrapping has been carried out, statistically",
                 "significant values (alpha = 0.5) are indicated with '*'",
                 "",
                 hdr)
        Gst <- cbind(colnames(Gst), Gst)
        Gst <- apply(Gst, 1, paste, collapse = " \t")
        Gst <- paste(c(hdr, Gst), collapse = "\n")
        writeLines(text = Gst, con = file)
      } else if(input$stat == "Nm"){
        Nm <- op$Nm
        hdr <- paste(c(" Pops", colnames(Nm)), collapse = "\t")
        hdr <- c("divMigrate-online",
                 "",
                 "Relative directional Migration matrix Calculated using",
                 "Nm (eqn. 12 from Alcala et al, 2014)",
                 "",
                 "If bootstrapping has been carried out, statistically",
                 "significant values (alpha = 0.5) are indicated with '*'",
                 "",
                 hdr)
        Nm <- cbind(colnames(Nm), Nm)
        Nm <- apply(Nm, 1, paste, collapse = " \t")
        Nm <- paste(c(hdr, Nm), collapse = "\n")
        writeLines(text = Nm, con = file)
      }
    }
  )
  
  # Downloadable plots
  #   output$dlPlt <- downloadHandler(
  #     filename = function() {
  #       if(input$stat == "D"){
  #         paste("divMigrate_", gsub(" ", "_", date()), "-[D-Network].eps", 
  #               sep = "") 
  #       } else if(input$stat == "Gst"){
  #         paste("divMigrate_", gsub(" ", "_", date()), "-[Gst-Network].eps",
  #               sep = "")
  #       } else if(input$stat == "Nm"){
  #         paste("divMigrate_", gsub(" ", "_", date()), "-[Nm-Network].eps",
  #               sep = "")
  #       }
  #     },
  #     content = function(file) {
  #       op <- out()
  #       if(input$stat == "D" & input$nbs == 0L){
  #         #tmp <- tempfile()
  #         #on.exit(unlink(tmp))
  #         png(file = file)
  #         replayPlot(op$Dplt)
  #         dev.off()
  #         #bytes <- readBin(tmp, "raw", file.info(tmp)$size)
  #         #writeBin(bytes, file)
  #         contentType = "image/png"
  #       } else if(input$stat == "D" & input$nbs != 0L){
  #         postscript(file = file, horizontal = FALSE)
  #         replayPlot(op$Dplt_bs)
  #         dev.off()
  #         bytes <- readBin(file, "raw", file.info(file)$size)
  #         writeBin(bytes, file)
  #       } else if(input$stat == "Gst" & input$nbs == 0L){
  #         postscript(file = file, horizontal = FALSE)
  #         replayPlot(op$Gplt)
  #         dev.off()
  #         bytes <- readBin(file, "raw", file.info(file)$size)
  #         writeBin(bytes, file)
  #       } else if(input$stat == "Gst" & input$nbs != 0L){
  #         postscript(file = file, horizontal = FALSE)
  #         replayPlot(op$Gplt_bs)
  #         dev.off()
  #         bytes <- readBin(file, "raw", file.info(file)$size)
  #         writeBin(bytes, file)
  #       } else if(input$stat == "Nm" & input$nbs == 0L){
  #         postscript(file = file, horizontal = FALSE)
  #         replayPlot(op$Nmplt)
  #         dev.off()
  #         bytes <- readBin(file, "raw", file.info(file)$size)
  #         writeBin(bytes, file)
  #       } else if(input$stat == "Nm" & input$nbs != 0L){
  #         postscript(file = file, horizontal = FALSE)
  #         replayPlot(op$Nmplt_bs)
  #         dev.off()
  #         bytes <- readBin(file, "raw", file.info(file)$size)
  #         writeBin(bytes, file)
  #       }
  #     }
  #   )
  
  
})