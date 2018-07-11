library(shiny)
library(shinydashboard)

ui<-fluidPage(
  dashboardPage(skin = "purple",
    dashboardHeader(title="iOS Mobile Application Analysis System"),
    dashboardSidebar(
      
      sidebarMenu(
        fileInput("file","Upload file"),
        menuItem("About", tabName = "home"),
        menuItem("Visualization", tabName = "visual",
                 menuSubItem("Histogram",tabName = "hist"),
                 menuSubItem("Barplot",tabName = "bar"),
                 menuSubItem("Scatter Plot",tabName = "scat")),
        menuItem("Computation", tabName = "comp",
                 menuSubItem("Total",tabName = "total"),
                 menuSubItem("Average",tabName = "average")
                 ),
        menuItem("Help", tabName = "help"),
        
       
        
        uiOutput("Select file")
      )
    ),
 
    dashboardBody(
      uiOutput("table"),
      
      tabItems(
        
        tabItem(tabName = "hist",fluidRow(
          box(
           
            
            textOutput("axis"),
            plotOutput("hist"))
      )
      
          
         
        )
        
      )
      
     
      
      
    )
    
     )
  
      
      
    )
    

      
      
      
      
  
    
  
  
  

 
  
  