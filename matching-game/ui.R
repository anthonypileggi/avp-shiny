shinyUI(fluidPage(
  
  titlePanel("Matching Game"),
  
  sidebarLayout(
    
    sidebarPanel(),

    mainPanel(
      plotOutput("gameboard", 
        click = "game_click", 
        hover = hoverOpts(id = "game_hover", delay = 100, delayType = c("debounce", "throttle"))
        ),
      verbatimTextOutput("info")
    )
    
  )
  
))
