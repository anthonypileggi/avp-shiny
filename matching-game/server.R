#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  rv <- reactiveValues(coords = tibble::tibble(i = integer(), j = integer(), id = integer(), item = character()))
  
  # input list of matching items
  items <- reactive({
    letters[1:8]
  })
  
  # card locations
  cards <- reactive({
    tibble::tibble(
      id = 1:16,
      item = sample(rep(items(), 2))
    )
  })
  
  # game (as data.frame)
  game_df <- reactive({
    expand.grid(i = 1:4, j = 1:4) %>% 
      mutate(id = row_number()) %>%
      left_join(cards(), by = "id")
  })
  
  # game (as matrix)
  game_mat <- reactive({
    x <- matrix(NA, nrow = 4, ncol = 4)
    x[cards()$id] <- cards()$item
    x
  })
  
  gameboard <- reactive({
    game_df() %>%
      ggplot(aes(x = i, y = j)) +
      geom_tile(color = "black", fill = "blue", alpha = .2) +
      theme_void()
  })
  
  observeEvent(input$game_click, {
    new_coords <- game_df() %>%
      dplyr::filter(
        input$game_click$x > i - .5,
        input$game_click$x < i + .5,
        input$game_click$y > j - .5,
        input$game_click$y < j + .5
      )
    rv$coords <- dplyr::bind_rows(rv$coords, new_coords)
  })
  
  # plot gameboard
  output$gameboard <- renderPlot({
    gameboard() +
      geom_text(aes(label = item), size = 14, data = rv$coords)
  })
  
  # click coords
  output$info <- renderText({
    paste0("x = ", input$game_click$x, "\ny = ", input$game_click$y)
  })
})
