library(shiny)

shinyServer(
  
  function(input,output){
    
    #accessing the data in the file
    
    data<- reactive({
      file1<- input$file
      if(is.null(file1)){return()}
      read.csv(file = file$datapath,sep = ""
                 , header = TRUE)
    })
    # returns the file
    output$filedf<-renderTable({
      if(is.null(data())){return()}
      data()
    })
    
    #returns the file path
    output$filedf2<-renderTable({
      if(is.null(input$data)){return()}
      input$file$datapath 
    })
    
    # returns the file structure
    
    output$filedob<-renderPrint({
      if(is.null(data())){return()}
      str(input$file) 
    })
    
    
    output$summ <- renderPrint({
      if(is.null(data())){return()}
      summary(data())
    })
    
    
    output$selectfile<-renderUI({
      if(is.null(data())){return()}
      
      
           selectInput("sel","Select",choices = input$file$name)
    })
    
    output$table<-renderUI({
      if(is.null(data())){return(
        h4("good")
      )}
      else{
        tabsetPanel(type="tab",
                    tabPanel("File property ",tableOutput("filedf")),
                    tabPanel("Structure",tableOutput("filedf2")),
                    tabPanel("Structure",tableOutput("summ")),
                    tabPanel("File statistics",tableOutput("filedob"))
        )
      
    }})
    
    
    
  
    
    
  })