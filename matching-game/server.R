
shinyServer(function(input, output) {
   
  rv <- 
    reactiveValues(
      click = tibble::tibble(i = integer(), j = integer(), id = integer(), item = character()),
      hover = tibble::tibble(i = integer(), j = integer(), id = integer(), item = character())
      )
  
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
    new_click <- game_df() %>%
      dplyr::filter(
        input$game_click$x > i - .5,
        input$game_click$x < i + .5,
        input$game_click$y > j - .5,
        input$game_click$y < j + .5
      )
    rv$click <- dplyr::bind_rows(rv$click, new_click)
  })
  
  observeEvent(input$game_hover, {
    rv$hover <- game_df() %>%
      dplyr::filter(
        input$game_hover$x > i - .5,
        input$game_hover$x < i + .5,
        input$game_hover$y > j - .5,
        input$game_hover$y < j + .5
      )
  })
  
  # plot gameboard
  output$gameboard <- renderPlot({
    gameboard() +
      geom_tile(color = "black", fill = "blue", alpha = .5, data = rv$hover) +
      geom_text(aes(label = item), size = 14, data = rv$click)
  })
  
  # click coords
  output$info <- renderText({
    paste0("x = ", input$game_click$x, "\ny = ", input$game_click$y)
  })
})
