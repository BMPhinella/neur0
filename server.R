library(shiny)

shinyServer(
  
  function(input,output){
    
    
    
    output$data<-renderTable({
    if(is.null(input$file)){return()}
      input$file #returns dataframe of the dataset
    })
    
    
    
    output$sum <- renderPrint({
      if(is.null(input$file)){return()}
      summary(read.csv(file=input$file$datapath))
    })
    
    
  
    
    output$two<-renderPrint({
      if(is.null(input$file)){return()}
         str(input$file)
    })
    
    
    
    output$onr<-renderPrint({
      if(is.null(input$file)){return()}
      input$file
    })
    
    
    
    output$abt<-renderPrint({
    
      input$at})
    
    
    output$table<-renderUI({
      if(is.null(input$file))
        h4("good")
      else
        tabsetPanel(type="tab",
                    tabPanel("File property ",tableOutput("data")),
                    tabPanel("Data",tableOutput("onr")),
                    tabPanel("Structure",tableOutput("two")),
                    tabPanel("File statistics",tableOutput("sum")),
                    tabPanel("Plot",plotOutput("first")))
      
    })
    
    
   
    output$hist<-{(renderPlot(
      
    hist(mobile$fdd)  
  ))}
   
    
})