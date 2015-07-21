#server
server<-(function(input, output) {
  
  
  # user input dataset
  datasetInput <- reactive({
    if(input$goButton == 0){return()}
    
    isolate({ 
      input$goButton
      inFile <- input$file1
      dta <- read.csv(inFile$datapath, header = TRUE)
      pval <- input$pval
      out <- gdrate(dta, pval, FALSE)
      sumstat <- data.frame(out$sumstats)
      row.names(sumstat) <- NULL
      sumstat
    })
    # write.csv(test_data,"solution.csv",row.names=F)
  })
  output$stattab <- renderTable({ datasetInput()})
  
  
  #populate dropdown box with list of numeric patient IDs analyzed
  outID <- reactive({
    if(input$goButton == 0){return()}
    
    isolate({
      input$goButton
      inFile <- input$file1
      dta <- read.csv(inFile$datapath, header = TRUE)
      #names <- dta$name
      pval <- input$pval
      out <- gdrate(dta, pval, FALSE)
      res <- data.frame(out$results)
      res2 <- subset(res, res$type=="included")
      names <- paste(na.omit(res2$name))
      names <- as.list(names)
      return(names)
    })
  })
  output$patientID = renderUI({selectInput('patientID2', 'Patient ID', outID())})
  
  
  #plot patient number 
  datasetInput2 <- reactive({
    if(input$goButton == 0){return()}
    if(input$patientID2 == 0){return()}
    
    isolate({ 
      input$goButton
      input$patientID2
      
      name <- input$patientID2
      inFile <- input$file1
      dta <- read.csv(inFile$datapath, header = TRUE)
      dta2 <- dta[(dta$name == name),]
      pval <-input$pval
      gdrate(dta2, pval, TRUE)
      
      
    })
    # write.csv(test_data,"solution.csv",row.names=F)
  })
  output$plot1 <- renderPlot({ datasetInput2()})
  
  
  # table growth rate estimates
  datasetOutput2 <- reactive({
    if(input$goButton == 0){return()}
    if(input$patientID2 == 0){return()}
    
    isolate({ 
      input$goButton
      input$patientID2
      name <- input$patientID2
      inFile <- input$file1
      dta <- read.csv(inFile$datapath, header = TRUE)
      dta2 <- dta[(dta$name == name),]
      pval <-input$pval
      out<-gdrate(dta2, pval, TRUE)
      res <- out$results
      row.names(res) <- NULL
      res$g <- sprintf('%1.5f',res$g)
      res$d <- sprintf('%1.5f',res$d)
      res$phi <- sprintf('%1.5f',res$phi)
      res2 <- res[, c(1,4:7)]
      res2
    })
  })
  output$restab <- renderTable({datasetOutput2()})
  
  
})
