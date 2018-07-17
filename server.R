library(shiny)
library()
options(shiny.maxRequestSize=30*1024^2)
shinyServer(
  
  function(input,output){
    selected_data<-as.data.frame(file)
    #accessing the data in the file
    
    data<- reactive({
      file1<- input$file
      if(is.null(file1)){
        return()
        }
      myfile <- read.csv(file = input$file$datapath,T,sep = ",")
      return(myfile)
    })
    
    
    # returns the file
    output$data<-renderTable({
      if(is.null(input$file)){return()}
      input$file
    })
    
    #returns the file path
    output$path<-renderTable({
      input$file$datapath

    })
    
    # returns the file structure
    
    output$struc<-renderPrint({
    
      str(data()) 
    })
    
    
    output$summ <- renderTable({
      
      summary(data())
    })
    
    
    output$selectfile<-renderUI({
      if(is.null(input$file)){return()}
      
      
           selectInput("sel","This is the uploaded file",choices = input$file$name)
    })
    
   # output$table<-renderUI({
    #  if(is.null(input$file)){return(
     #   h4("Created by ", tags$img(src='licious.jpg',height= 50, width=50))
      #)}
    #   else{
    #     tabsetPanel(type="tab",
    #                 tabPanel("File Property ",tableOutput("data")),
    #                 tabPanel("File Path",tableOutput("path")),
    #                 tabPanel("Structure",tableOutput("struc")),
    #                 tabPanel("Summary",tableOutput("summ")),
    #                 tabPanel("clear",tableOutput("c"))
    #         
    #     )
    #   
    # }})
    
  
    # histogram visualization
    histo<-eventReactive(
      
      input$button2,{
        
        title<-input$genre1
        histy<-input$y
        histx<-input$histx
        get_genre1=input$genre1
          
          grouped_data<-data()%>%filter(prime_genre==get_genre1)%>%select(rating_count_tot,user_rating,user_rating_ver,rating_count_ver,price,sup_devices.num,lang.num,ipadSc_urls.num)
          
          ggplot(grouped_data, aes(x=user_rating)) + ggtitle(substitute(atop("A histogram showing the user rating count of the"+ title)))+ geom_histogram()+xlab("User ratings") + ylab("")
          
       
      }
      
    )
    
    output$hist<-renderPlot({
      histo()
    })
    
    #category output
    
    
    category<-eventReactive(
      
      input$catbutton,{
        title<-input$genre1
        
        cat11=input$cat1
        cat2<-as.factor(input$cat2)
        grouped_data<-selected_data%>%filter(prime_genre==cat11)%>%select(rating_count_tot,user_rating,user_rating_ver,rating_count_ver,price,sup_devices.num,lang.num,ipadSc_urls.num)
        
        ggplot(grouped_data, aes(x=user_rating))+ geom_bar()
        
        
      })
    output$catplot<-renderPlot({
      category()
    })
    
    
    
    
    barplo<-eventReactive(
      input$button1,{
      
         get_genre=input$genreb
         grouped_data<-data()%>%filter(prime_genre==get_genre)%>%select(rating_count_tot,user_rating,user_rating_ver,rating_count_ver,price,sup_devices.num,lang.num,ipadSc_urls.num)%>%slice(1:10)
    
        xb<-reactive({
          grouped_data[,input$xb]
        })
        
        yb<-reactive({
          grouped_data[,input$yb]
        })
        barplot(xb(),yb(),main = ("A bar plot representation"), xlab = (input$xb),ylab = (input$yb))
      })
    output$bar<-renderPlot({
      barplo()
    })
    
    
    scatt<-eventReactive(
      
      input$button,{
      
        get_genre2=input$genre2
        
       grouped_data<-data()%>%filter(prime_genre==get_genre2)%>%select(rating_count_tot,user_rating,user_rating_ver,rating_count_ver,price,sup_devices.num,lang.num,ipadSc_urls.num)%>%slice(1:10)
      
        x<-reactive({
          grouped_data[,input$x]
        })
        
        y<-reactive({
          grouped_data[,input$y]
        })
        plot(x(),y(),main = ("A scatter plot representation"), xlab = (input$x),ylab = (input$y))
        
      })
    output$scata <- renderPlot({scatt()})
    
  
    #bar pplot table panel
    output$f<- renderPlot({
      data3<-count(data(),"prime_genre")
      
      ggplot(data3, aes(x = prime_genre, y = freq)) + geom_bar(stat = "identity")
    })
    
     output$u<-renderPlot({
       data3<-count(data(),"prime_genre")%>%slice(1:11)
       
       ggplot(data3, aes(x = prime_genre, y = freq)) + geom_bar(stat = "identity")
     })
    
     output$l<-renderPlot({
       data3<-count(data(),"prime_genre")%>%slice(11:23)
       
       ggplot(data3, aes(x = prime_genre, y = freq)) + geom_bar(stat = "identity")
     })
    
  })