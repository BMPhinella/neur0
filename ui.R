library(shiny)

shinyUI(fluidPage(
  
  titlePanel(title="iOS Mobile Application Analysis System"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      fileInput("file","Upload file"),
     
      uiOutput("Select file"),
      
      
    selectInput("xaxis","Select the x axis",colnames(file)),
                selectInput("yaxis","Select the y axis",colnames(file))

     
      
      
    ),
    
    mainPanel(
      uiOutput("table")
      
      
      
    )
    
  )
  
  
))
 
  
  