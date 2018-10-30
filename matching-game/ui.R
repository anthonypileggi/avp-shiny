library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Matching Game"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("gameboard", click = "game_click"),
      verbatimTextOutput("info")
    )
  )
))
