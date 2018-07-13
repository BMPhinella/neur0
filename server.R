library(shiny)

shinyServer(
  
  function(input,output){
    
    
    
    output$data<-renderTable({
    if(is.null(input$data_set)){return()}
      input$data #returns dataframe of the dataset
    })
    
    
    
    output$sum <- renderPrint({
      if(is.null(input$data_set)){return()}
      summary(read.csv(data_set=input$data_set$datapath))
    })
    
    
  
    
    output$two<-renderPrint({
      if(is.null(input$data_set)){return()}
         str(input$data_set)
    })
    
    
    
    output$onr<-renderPrint({
      if(is.null(input$data_set)){return()}
      input$data_set
    })
    
    
    output$table<-renderUI({
      if(is.null(input$data_set))
        h4("good")
      else
        tabsetPanel(type="tab",
                    tabPanel("File property ",tableOutput("data")),
                    tabPanel("Data",tableOutput("onr")),
                    tabPanel("Structure",tableOutput("two")),
                    tabPanel("File statistics",tableOutput("sum")),
                    tabPanel("Plot",plotOutput("first")))
      
    })
    
    histo<-eventReactive(
      input$button2,{
        histy<-input$y
        histx<-input$histx
        get_genre=input$genre
        selected_data<-data_set%>%filter(prime_genre==get_genre)%>%select(rating_count_tot,user_rating,cont_rating,sup_devices.num,lang.num)
        ggplot(selected_data,aes(x=histx))+geom_bar()
      })
    output$hist<-renderPlot({
      histo()
    })
  
  
  barplo<-eventReactive(
    input$button1,{
      bary<-input$y
      barx<-input$x
      get_genre=input$genre
      selected_data<-data_set%>%filter(prime_genre==get_genre)%>%select(rating_count_tot,user_rating,cont_rating,sup_devices.num,lang.num)
      ggplot(selected_data,aes(x=user_rating))+geom_bar()
    })
  output$bar<-renderPlot({
    barplo()
  })
  
  
  scatt<-eventReactive(
    
  input$button,{
   scatter<-input$y
    scatter2<-input$x
    get_genre2=input$genre2
    
  selected_data2<-data_set%>%filter(prime_genre==get_genre2)%>%select(rating_count_tot,user_rating,
                                                                      cont_rating,sup_devices.num,lang.num,ipadSc_urls.num,price,size_bytes)
  ggplot(selected_data2, aes(x=scatter2, y=scatter)) + geom_point(size=2,shape = 21) 
    
  })
output$scata <- renderPlot({scatt()})
  
    
})