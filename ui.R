library(shiny)
library(shinydashboard)
library(dplyr)
library(DT)
library(plyr)
library(ggplot2)
library(RCurl)
library(stringr)
library(httr)
library(wordcloud)
library(png)
library(syuzhet)


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
                    
                    
                    uiOutput("selectfile"),
                    
                    menuItem("About", tabName = "home"),
                    
                    br(),
                    menuItem("Visualization", tabName = "visual",
                             menuSubItem("Barplot all categories",tabName = "box"),
                             menuSubItem("Histogram",tabName = "hist"),
                             menuSubItem("Barplot",tabName = "bar"),
                             menuSubItem("Scatter Plot",tabName = "scat")),
                             
                    br(),
                    menuItem("Sentiment Analysis",tabName = "sentiment"),
                    br(),
                    menuItem("Summary", tabName = "comp",
                             menuSubItem("File Property",tabName = "data"),
                             menuSubItem("Structure",tabName = "struc"),
                             menuSubItem("Summary",tabName = "summ")
                    ),
                    br(),
                   menuItem("Help", tabName = "help"),
                   br(),
                    menuItem("Reference", tabName = "ref"),
                    br(),
                    fileInput("file","Upload AppleStore dataset"),
                    fileInput("file1","Upload appleStore_description dataset")
                    
                  )
                ),
                
                dashboardBody(
                 # imageOutput("image",height = 20),
                
          
                  tabItems(
                    
                    
                    tabItem(tabName = "home",
                            
                            h2(" iOS Mobile Application Analysis System"),
                            p("This is an iOS mobile application analysis system."), p("It analyses the AppleStore and appleStore_description
                             datasets from apple store"),
                            
                            h2("Objectives"),
                            p("To study the relationships between the different application features"),
                              p("To show the application statistics of the different categories."),
                              p("To show how the different application features affect the user ratings."),
                              p("To show stribution of emotions within the application description."),
                            
                            h2("Goals"),
                            
                            p("To help app developers study the relationships between the different 
                              application features and how the app features affect the user ratings."),
                            br(),
                            h4("About the developers"),
                            p("The system was developed by a team of 3 students pursing a Bachelors in Software Engineering 
                              at Makerere University."),
                              p("The students put together the knowledge obtained from their Data science lectures to create this system."),
                              p("The developers were:"),p("Best Mugisa"),p("Kekirunga Jean"),p("Kisiga Timothy")
                    
                            
                            
                            ),
                    
                    tabItem(tabName = "help",
                            
                            h2("THE SYSTEM"),
                            p("For the system to be able to perform all the different functionalities,
                              the columns within the uploaded dataset should correspond to those in the APPLE STORE and APPLE STORE DESCRIPTION datasets."),
                            br(),
                            h4("* Upload buttons"),
                            p(h4("file1 button")),
                            p("This button enables the user to upload the appleStore dataset which the system will analyse
                              and perform different statistics on."),
                            p("The analysis performed by the system on the data will be observed on clicking the visualization menu item
                              within which different graphs are used."),
                              p("The different graphs under visualization are able to display different statistics on the data."),
                            
                            h4("file2 button"),
                            p("This button enables the user to upload the applestore_description dataset
                              on which the system will perform a sentiment analysis."),
                            br(),
                            h4("* About"),
                            p("The about menu item contains a brief description of the system, objectives and goals."),            
                              p("It also contains brief information on the project team that developed the system."),
                            br(),
                            h4("* Visualization"),
                            p("The visualization menu item enables the user to have an insight on the AppleStore dataset using graphs."),
                              p("The different graphs used include histogram,barplot,line graph and scatter plot all of which 
                              show different statistics about the data."),
                              p("This is where most of the system functionalities are implemented from."),
                            br(),
                            h4("* Sentiment Analysis"),
                            p("In this menu item, the appleStore_description dataset."),
                            p("The system determines the emotions and polarities the app_description and gives a count of each
                              ")
                            
                            
                            
                    ),
                    
                    
                    #summary
                    tabItem(tabName = "data", tableOutput("data")),
                    tabItem(tabName = "path", tableOutput("path")),
                    tabItem(tabName = "struc", verbatimTextOutput("struc")),
                    tabItem(tabName = "summ", tableOutput("summ")),
                    
                    #histogram
                    tabItem(tabName = "hist",fluidRow(
                      
                      box(title = "Reperesentation of the data using a histogram",
                          selectInput("genre1","Choose Genre",choices = c("Games","Finance","Productivity",
                                                                          "Reference","Music","Utilities","Travel",
                                                                          "Social Networking","Sports","Business",
                                                                          "Health & Fitness","Entertainment","Photo & Video",
                                                                          "Lifestyle","Food & Drink")),
                          actionButton("button2","Plot"))
                    ),
                    
                    
                    plotOutput("hist")),
                    
                    
                    #User rating barplot
                    tabItem(tabName = "bar",fluidRow(
                      box(title = "Representation of the dataset using a bar plot", solidHeader = TRUE, height = "70%",
                          
                          selectInput("genreb","Choose Genre",choices = c("Games","Finance","Productivity",
                                                                          "Reference","Music","Utilities","Travel",
                                                                          "Social Networking","Sports","Business",
                                                                          "Health & Fitness","Entertainment","Photo & Video",
                                                                          "Lifestyle","Food & Drink")),
                          selectInput("xb","Choose the x axis",choices = c("user_rating","user_rating_ver")),
                          
                          selectInput("yb","Choose the y axis",choices = c("price","sup_devices.num","lang.num","ipadSc_urls.num")),
                          
                          actionButton("button1","Plot")
                      )
                    ),plotOutput("bar1")),
                    
                    
                    #barplot all categories
                    tabItem(tabName = "box",fluidRow(
                      tabsetPanel(type="tab",
                                  tabPanel("Number of apps in a category ",plotOutput("f")),
                                  tabPanel("User Rating",plotOutput("u"))
                                  
                                  
                                  
                      )
                    ),plotOutput("boxp")),
                    
                    
                    #scatter
                    tabItem(tabName = "scat",fluidRow(
                      box(title = "Relationship between the different application features using a scatter plot", solidHeader = TRUE, height = "70%",
                          
                          selectInput("genre2","Choose Genre",choices = c("Games","Finance","Productivity",
                                                                          "Reference","Music","Utilities","Travel",
                                                                          "Social Networking","Sports","Business",
                                                                          "Health & Fitness","Entertainment","Photo & Video",
                                                                          "Lifestyle","Food & Drink")),
                          
                          selectInput("x","Choose the x axis",choices = c("rating_count_tot","rating_count_ver","user_rating","user_rating_ver","price","sup_devices.num","lang.num","ipadSc_urls.num")),
                          
                          selectInput("y","Choose the y axis",choices = c("rating_count_tot","rating_count_ver","user_rating","user_rating_ver","price","sup_devices.num","lang.num","ipadSc_urls.num")),
                          
                          actionButton("button","Plot")
                      ) 
                    ),plotOutput("scata")),
                    
                    
                    
                    #sentiment analysis
                    tabItem(tabName = "sentiment",fluidRow(
                     
                    ),plotOutput("sentr"))
                    
                    
                      ) ) ))