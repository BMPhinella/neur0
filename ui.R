library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
#adding data to the app
data<-read.csv(file.choose(),header = T)
data_set<-as.data.frame(data)
data_set2 <- as.factor(data)

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
        
    br(),
    menuItem("About", tabName = "home"),
        
        uiOutput("Select file")
      )
    ),
 
    dashboardBody(
      uiOutput("table"),
      
      tabItems(
        
        tabItem(tabName = "bar",fluidRow(
          box(title = "Representation of the dataset using a bara plot", background = "maroon", solidHeader = TRUE, height = "70%",
           
            selectInput("genre","Choose Genre",choices = c("Games","Finance","Productivity",
                                                           "Reference","Music","Utilities","Travel",
                                                           "Social Networking","Sports","Business",
                                                            "Health & Fitness","Entertainment","Photo & Video",
                                                           "Lifestyle","Food & Drink")),
            actionButton("button1","Plot"),
            plotOutput("bar"))
      )),
      
      
      tabItem(tabName = "hist",fluidRow(
        box(title = "Representation of the data set using a histogram", background = "maroon", solidHeader = TRUE, height = "70%",
            
            selectInput("genre","Choose Genre",choices = c("Games","Finance","Productivity",
                                                           "Reference","Music","Utilities","Travel",
                                                           "Social Networking","Sports","Business",
                                                           "Health & Fitness","Entertainment","Photo & Video",
                                                           "Lifestyle","Food & Drink")),
            selectInput("histx","Choose the x axis",choices = c("rating_count_tot","user_rating","cont_rating","sup_devices.num","lang.num","ipadSc_urls.num","price","size_bytes")),
            actionButton("button2","Plot"),
            plotOutput("hist"))
      )),
    
        
        tabItem(tabName = "home",fluidRow(
          box(width = "30%" , height = "70%",
            h4("This system is an iOS mobile application analysis system.
               It analyses the IOS mobile application from apple store to have an insight
               and determine the patterns from the Apple app store.
               The insights enable in determinig :
                 which apps are trending according to user rating.")
            )
        )),
      
      
      
      tabItem(tabName = "scat",fluidRow(
        box(title = "Scatter plot", background = "maroon", solidHeader = TRUE, height = "70%",
            
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
    

      
      
      
      
  
    
  
  
  

 
  
  