library(shiny)
options(shiny.maxRequestSize=30*1024^2)
shinyServer(
  
  function(input,output){
  
  # for visualization  
    data<- reactive({
      file1<- input$file
      if(is.null(file1)){
        return()
        }
      myfile <- read.csv(file = input$file$datapath,T,sep = ",")
      return(myfile)
    })
    
  #  for sentiment analysis
    data2<- reactive({
      file2<- input$file1
      if(is.null(file2)){
        return()
      }
      sentfile <- read.csv(file = input$file1$datapath,T,sep = ",")
      return(sentfile)
    })
    
    output$sentr<-renderPlot({
      grouped_data2<-data2()%>%select(app_desc)
      textdata = gsub("[[:punct:]]", "", data2()$app_desc)
      textdata = gsub("[[:punct:]]", "", textdata)
      textdata = gsub("[[:digit:]]", "", textdata)
      textdata = gsub("[[:cntrl:]]", "", textdata)
      textdata = tolower(textdata)
      
      sentianalysis <- get_nrc_sentiment(textdata[1:10])
      sentimentscores <- data.frame(colSums(sentianalysis[,]))
      names(sentimentscores) <- "Score"
      sentimentscores <- cbind("sentiment" = rownames(sentimentscores), sentimentscores)
      rownames(sentimentscores) <- NULL
      ggplot(sentimentscores, aes(x = sentiment, y = Score)) +
        geom_bar(aes(fill = sentiment), stat = "identity") + 
        theme(legend.position = "none") +
        xlab("Emotions and Polarity") +
        ylab("Sentiment Score") + 
        ggtitle("A graph showing sentiment analysis")
      
    })
    
    
    output$data<-renderTable({input$file })
      
   
    
    output$struc<-renderPrint({
      str(input$file) })
    
      
    output$summ <- renderPrint({
       summary(input$file)
    })
    
    
    # output$selectfile<-renderUI({
    #   if(is.null(input$file)){return()}
    #    selectInput("sel","This is the uploaded file",choices = input$file$name)
    # })
    # 

    # histogram
    histo<-eventReactive(
      
      input$button2,{
        
        title<-input$genre1
        histy<-input$y
        histx<-input$histx
        get_genre1=input$genre1
          
        grouped_data<-data()%>%filter(prime_genre==get_genre1)%>%select(rating_count_tot,user_rating,user_rating_ver,rating_count_ver,price,sup_devices.num,lang.num,ipadSc_urls.num)
          
        ggplot(grouped_data, aes(x=user_rating)) + 
          ggtitle(substitute(atop("Frequency distribution of the user rating for"+ title)))+
         geom_histogram( fill="#990033")+xlab("User ratings") + ylab("Counts")+ theme(
          plot.title = element_text(color="#0033cc", size=20, face="bold",hjust = 0.5),
          axis.title.x = element_text(color="#990033", size=14, face="bold"),
          axis.title.y = element_text(color="#990033", size=14, face="bold"))
          
       
      })
      
    
    output$hist<-renderPlot({
      histo()
    })
    
    #barplot
    barplo<-eventReactive(
      input$button1,{
        
        get_genre=input$genreb
        grouped_data<-data()%>%filter(prime_genre==get_genre)%>%select(user_rating,user_rating_ver,price,sup_devices.num,lang.num,ipadSc_urls.num)
        
        xb<-reactive({
          grouped_data[,input$xb]
        })
        
        yb<-reactive({
          grouped_data[,input$yb]
        })
        x<-input$xb
        y<-input$yb
        ggplot(grouped_data, aes(y=yb(),x=xb()) ) +xlab(input$xb)+ylab(input$yb)+
          ggtitle(substitute(atop("HOW DIFFERENT APP FEATURES AFFECT THE USER RATING")))+
          geom_bar(stat = "identity", fill="#990033")+ theme(
            plot.title = element_text(color="#0033cc", size=20, face="bold",hjust = 0.5),
            axis.title.x = element_text(color="#0033cc", size=14, face="bold"),
            axis.title.y = element_text(color="#0033cc", size=14, face="bold")
          )
      })
    
    
    output$bar1<-renderPlot({
      barplo()
    })
    
    
    
    scatt<-eventReactive(
      
      input$button,{
      
        get_genre2=input$genre2
        
       grouped_data<-data()%>%filter(prime_genre==get_genre2)%>%select(rating_count_tot,user_rating,user_rating_ver,rating_count_ver,price,sup_devices.num,lang.num,ipadSc_urls.num)
      
        x<-reactive({
          grouped_data[,input$x]
        })
        
        y<-reactive({
          grouped_data[,input$y]
        })
        
        ggplot(grouped_data, aes(y=y(),x=x()) ) +xlab(input$x)+ylab(input$y)+
          ggtitle(substitute(atop("RELATIONSHIP BETWEEN THE APP FEATURES")))+
          geom_point(stat = "identity", fill="#990033")+ theme(
            plot.title = element_text(color="#0033cc", size=20, face="bold",hjust = 0.5),
            axis.title.x = element_text(color="#990033", size=14, face="bold"),
            axis.title.y = element_text(color="#990033", size=14, face="bold")
          ) +abline(lm(x()~y()))
        
      
       
        
      })
    
    output$scata <- renderPlot({scatt()})
    
  
    #bar pplot table panel
    output$f<- renderPlot({
      
      
      data3<-count(data(),"prime_genre")
    
      ggplot(data3, aes(x = prime_genre, y = freq)) + 
        ggtitle(substitute(atop("Total number of apps in a category")))+
        geom_bar( fill="#990033",stat = "identity")+xlab("Prime_genre") + ylab("Number of apps")+ theme(
          plot.title = element_text(color="#0033cc", size=20, face="bold",hjust = 0.5),
          axis.title.x = element_text(color="#0033cc", size=14, face="bold"),
          axis.title.y = element_text(color="#0033cc", size=14, face="bold"))
      

    })
    
     output$u<-renderPlot({
       datau<-data()%>%select(rating_count_tot)
       
      # data2<-count(data(),"rating_count_tot")
       
       data3<-count(data(),"prime_genre")
       
       
       user<-colMeans(datau)
       ggplot(data3, aes(x = prime_genre, y =user)) + geom_bar(stat = "identity")
     })
    
     
     output$image<-renderImage({
       if("True"){
         return(list(
           src="www/s.jpg",
           contentType="image/jpg",
           alt="image failed to display"))}
     })
     
     
  })