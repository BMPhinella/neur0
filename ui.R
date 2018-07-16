library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)

#data<-read.csv(file.choose(),header = T)

#selected_data<-as.data.frame(file)


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
                    
                    
                    fileInput("file","Upload a file", multiple = TRUE),
                    #selectInput("select","Select the file to be used", choices = c("AppleStore","appleStore_description")),
                    
                    br(),
                    uiOutput("selectfile"),
                    
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
                    menuItem("Help", tabName = "help")
                  
                    
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
                    
                    
                    tabItem(tabName = "home",
                            
                            h2(" iOS Mobile Application Analysis System"),
                            p("This is an iOS mobile application analysis system.
                              It analyses the IOS mobile applications from apple store to have an insight
                              and determine the patterns from the Apple store."),
                            
                            h2("Objectives"),
                            p("To have an insight on the relationships between the different application features"),
                            p("To have an insight on which category has the highest number  of applications"),
                            p("To show the application statistics of the different categories"),
                            p("To show how the different application features affect the user ratings"),
                            
                            h2("Goals"),
                            
                            p("To help app developers study the relationship between app details 
                              and user ratings to help them increase the user ratings for their 
                              own apps by developing apps with relavant features"),
                            br(),
                            h4("System developers"),
                            h5("Best Mugisa"),
                            p("Kekirunga Jean"),
                            p("Kisiga Timothy")
                            
                            
                            ),
                    
                    
                    
                    
                    tabItem(tabName = "help",
                            
                            h2("GUIDELINES ON HOW TO USE THE SYSTEM"),
                            p("For the system to be able to perform all the different functionalities,
                              the columns within the uploaded data set should correspond to those in the APPLE STORE and APPLE STORE DESCRIPTION datasets"),
                            br(),
                            h4("* Upload button"),
                            p("The upload button enables one to upload a dataset that contains
                              the data which the system would analyse and find different statistics "),
                            br(),
                            h4("* About"),
                            p("The about menu item contains a brief description about the system, the objectives and  the goals.            
                              It also contains a brief information about the project team that developed the system"),
                            br(),
                            h4("* Visualization"),
                            p("The visualization menu item enables the user to have an insight on the dataset using graphs ie histogram,barplot,line graph and scatter plot.                                                                                                                           
                              Under visualization, this is where most if notall of the objectives of the systemare implemented from."),
                            br(),
                            h4("* Sentimental Analysis"),
                            p("In this menu item, the apple store description dataset is used and the system is able to determine 
                              how the application description affects the user rating")
                            
                            
                            
                            ),
                    
                    
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