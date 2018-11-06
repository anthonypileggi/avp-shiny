shinyUI(fluidPage(
  
  useShinyjs(),
  
  # -- Add Tracking JS File 
  tags$head(includeScript("google-analytics.js")),
  
  titlePanel("Matching Game"),
  
  sidebarLayout(
    
    sidebarPanel(
      actionButton("new_game", "New Game"),
      uiOutput("info")
    ),

    mainPanel(
      plotOutput("gameboard", 
        click = "game_click", 
        hover = hoverOpts(id = "game_hover", delay = 100, delayType = c("debounce", "throttle"))
        )
    )
    
  )
  
))
