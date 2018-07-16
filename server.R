library(shiny)
selected_data<-as.data.frame(data)
shinyServer(
  
  function(input,output){
    output$table<-renderTable({
      data_read= input$selected_data
      if(is.null(data_read)){return()}
      
      read.table(data_read)
    })
 
    
    
    
    
    # histogram visualization

      output$hist<-renderPlot({
        select1<-input$sel
      if(select1==AppleStore){return(
    
        title<-input$genre1,
        histy<-input$y,
        histx<-input$histx,
        get_genre1=input$genre1,
        grouped_data<-selected_data%>%filter(prime_genre==get_genre1)%>%select(rating_count_tot,user_rating,cont_rating,sup_devices.num,lang.num),
       
        ggplot(grouped_data, aes(x=user_rating)) + ggtitle(substitute(atop("A histogram showing the user rating count of the"+ title)))+ geom_histogram()+xlab("User ratings") + ylab("")
        
      )}
      })
      
    
  
  #category output
    
    
    category<-eventReactive(
      
      input$catbutton,{
        title<-input$genre1
  
        cat11=input$cat1
        cat2<-as.factor(input$cat2)
        grouped_data<-selected_data%>%filter(prime_genre==cat11)%>%select(rating_count_tot,user_rating,cont_rating,sup_devices.num,lang.num)
        
        ggplot(grouped_data, aes(x=user_rating))+ geom_bar()
        
        
      })
    output$catplot<-renderPlot({
      category()
    })
    
    
    
  
  barplo<-eventReactive(
    input$button1,{
      title2<-input$genreb
      bary<-input$yb
      barx<-input$xb
      get_genre=input$genreb
      grouped_data<-selected_data%>%filter(prime_genre==get_genre)%>%select(rating_count_tot,user_rating,cont_rating,sup_devices.num,lang.num)
      ggplot(data=grouped_data,aes(x=barx,y=bary))+ ggtitle(substitute(atop("Abar plot showing of "+title2+"showing"+bary+"against"+ barx )))+
        geom_col(stat="identity",color="blue", fill="white",position=position_dodge())
    })
  output$bar<-renderPlot({
    barplo()
  })
  
  
  scatt<-eventReactive(
    
  input$button,{
   scatter<-input$y
    scatter2<-input$x
    get_genre2=input$genre2
    
    grouped_data<-selected_data%>%filter(prime_genre==get_genre2)%>%select(rating_count_tot,user_rating,
                                                                      cont_rating,sup_devices.num,lang.num,ipadSc_urls.num,price,size_bytes)
  ggplot(grouped_data, aes(x=scatter2, y=scatter)) + geom_point(size=2,shape = 21) 
    
  })
output$scata <- renderPlot({scatt()})
  
    
})