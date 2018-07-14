library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

data<-read.csv(file.choose(),header = T)

selected_data<-as.data.frame(data)

ui<-fluidPage(
  
  dashboardPage(skin = "red",
    dashboardHeader(title="iOS Mobile Application Analysis System",
                    
                    dropdownMenu(type = "messages",
                                 messageItem(
                                   from = "About",
                                   icon = icon("cog", lib = "glyphicon"),
                                   message = "This system."
                                 ),
                                 messageItem(
                                   from = "Help",
                                   message = "How do I use this system?",
                                   icon = icon("question"))),
                           
                                 dropdownMenu(type = "notifications",        
                                    notificationItem(
                                       text = "This is an iOs mobile application analysis system",
                                       icon("users")
                                     )
                                     
                                 )
                    
                    ),
    dashboardSidebar(
      
      sidebarMenu(
    br(),
   
    
        br(),
        menuItem("About", tabName = "home"),
        
    br(),
        menuItem("Visualization", tabName = "visual",
                 
                 menuSubItem("Histogram",tabName = "hist"),
                 menuSubItem("Barplot",tabName = "bar"),
                 menuSubItem("Scatter Plot",tabName = "scat")),
    br(),
        menuItem("Computation", tabName = "comp",
                 menuSubItem("Total",tabName = "total"),
                 menuSubItem("Average",tabName = "average")
                 ),
    br(),
        menuItem("Help", tabName = "help"),
        
   
        
        uiOutput("Select file")
      )
    ),
 
    dashboardBody(
      uiOutput("table"),
      
      tabItems(
        
        tabItem(tabName = "bar",fluidRow(
          box(title = "Representation of the dataset using a bar plot", background = "maroon", solidHeader = TRUE, height = "70%",
           
            selectInput("genreb","Choose Genre",choices = c("Games","Finance","Productivity",
                                                           "Reference","Music","Utilities","Travel",
                                                           "Social Networking","Sports","Business",
                                                            "Health & Fitness","Entertainment","Photo & Video",
                                                           "Lifestyle","Food & Drink")),
            selectInput("xb","Choose the x axis",choices = c("rating_count_tot","user_rating","cont_rating","sup_devices.num","lang.num","ipadSc_urls.num","price","size_bytes")),
            
            selectInput("yb","Choose the y axis",choices = c("rating_count_tot","user_rating","cont_rating","sup_devices.num","lang.num","ipadSc_urls.num","price","size_bytes")),
            
            actionButton("button1","Plot")
            )
      ),plotOutput("bar")),
      
      
      
      
      tabItem(tabName = "hist",fluidRow(
        box(title = "Representation of the data set using a histogram", solidHeader = TRUE, height = "70%",
            
          selectInput("genre1","Choose Genre",choices = c("Games","Finance","Productivity",
                                                           "Reference","Music","Utilities","Travel",
                                                           "Social Networking","Sports","Business",
                                                           "Health & Fitness","Entertainment","Photo & Video",
                                                           "Lifestyle","Food & Drink")),
           # selectInput("histx","Choose the x axis",choices = c("rating_count_tot","user_rating","cont_rating","sup_devices.num","lang.num","ipadSc_urls.num","price","size_bytes")),
            actionButton("button2","Plot")
            )
      ),
      plotOutput("hist")),
    
        
        tabItem(tabName = "home",fluidRow(
          
              h2(" iOS Mobile Application Analysis System"),
            p("This is an iOS mobile application analysis system.
               It analyses the IOS mobile applications from apple store to have an insight
               and determine the patterns from the Apple store."),
            
            h2("Objectives"),
            p("To help app developers study the relationship between app details 
              and user ratings to help them increase the user ratings for their 
              own apps by developing apps with relavant features"),
            
            h2("Goals"),
            p("To increase the user ratings for new applications"),
            p("To compare the app statistics for different groups"),
            p("To study how app features contribute to user ratings")
            
            
        )),
      
      
      
      
      tabItem(tabName = "help",fluidRow(
        
        h2("Are you stuck? Need help?")
        
        
      )),
      
      
      tabItem(tabName = "scat",fluidRow(
        box(title = "Scatter plot", solidHeader = TRUE, height = "70%",
            
            selectInput("genre2","Choose Genre",choices = c("Games","Finance","Productivity",
                                                           "Reference","Music","Utilities","Travel",
                                                           "Social Networking","Sports","Business",
                                                           "Health & Fitness","Entertainment","Photo & Video",
                                                           "Lifestyle","Food & Drink")),
            
            selectInput("x","Choose the x axis",choices = c("rating_count_tot","user_rating","cont_rating","sup_devices.num","lang.num","ipadSc_urls.num","price","size_bytes")),
            
            selectInput("y","Choose the y axis",choices = c("rating_count_tot","user_rating","cont_rating","sup_devices.num","lang.num","ipadSc_urls.num","price","size_bytes")),
            
            actionButton("button","Plot")
            ) 
      ),plotOutput("scata"))
      
      )
      
      
    
    
     )
  
      
      
    ))
    

      
      
      
      
  
    
  
  
  

 
  
  