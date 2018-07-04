library(shiny)
library(shinydashboard)
shinyUI(
  dashboardPage(
    dashboardHeader(title = "iOS Mobile Application Analysis System",titleWidth = 700),
                    

    dashboardSidebar(
      
      sidebarMenu(
        menuItem("About", tabName = "dash1", icon = icon("tachometer")),
        menuItem("Data", tabName = "dash2",icon = icon("tachometer")),
        menuItem("Visualization", tabName = "dash3",icon = icon("tachometer")),
        menuItem("Computation", tabName = "dash4",icon = icon("tachometer")),
        menuItem("Help", tabName = "dash5",icon = icon("tachometer")),
        menuItem("Feedback", tabName = "dash6"),
        tags$style("body{background-color:purple;color:black}"),
        br(),
        downloadButton("file","Upload file")
        
      )
      
      
    ),
    
    dashboardBody("Graphical representation of the data")
     
   
  
    
     )
  
  
  
)
    
 
  
  