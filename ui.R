#shiny app


library(shiny)

#install.packages("devtools")  
#library(devtools)  
#devtools::install_github('wilkersj/tumgr')

library(tumgr)


ui<-(fluidPage(
  titlePanel("Tumor Growth Rate Analysis"),
  sidebarLayout(
    sidebarPanel(
      
      fileInput('file1', 'Choose file to upload',
                accept = c(
                  'text/csv',
                  'text/comma-separated-values',
                  'text/tab-separated-values',
                  'text/plain',
                  '.csv',
                  '.tsv'
                )
      ),
      tags$hr(),
      numericInput('pval','Choose p-value',.10,0,1,.01),
      br(),
      actionButton("goButton", "Run Analysis"),
      br(),
      br(),
      br(),
      br(),
      p("After analysis, the drop down box below will populate with the input patient IDs.  
        Selecting an ID will generate and display individual plots and growth rate estimates."),
      uiOutput("patientID"),
      br(),
      br(),
      br(),
      br(),
      HTML("Created using the <a href='https://cran.r-project.org/web/packages/tumgr/index.html'>tumgr</a> package.")
      ),
    mainPanel(
      tableOutput('stattab'),
      plotOutput('plot1'),
      tableOutput('restab'),
      textOutput('patientID2'),
      #textOutput('patientID'),
      width=7
    )
  )
))


#shinyApp(ui=ui, server=server)

