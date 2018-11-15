
shinyServer(function(input, output) {
  
  # Reactive data -------------
  
  team_total <- reactive({
    events %>%
      group_by(Team) %>%
      summarize(
        Points = sum(Points)
      ) %>% 
      arrange(desc(Points))
  })
  
  employee_total <- reactive({
    events %>%
      group_by(Employee, Team) %>%
      summarize(
        Gains = sum(Points[Points > 0]),
        Losses = sum(Points[Points < 0]),
        Total = sum(Points)
      ) %>% 
      arrange(desc(Total))
  })
  
  
  
  # Overall --------------------------------
  
  output$table_team_total <- DT::renderDataTable({
    DT::datatable(
      team_total(), 
      rownames = FALSE,
      options = list(
        dom = "t",
        pageLength = nrow(team_total())
      )
    )
  })
  
  output$plot_ts <- renderPlotly({
    ts <- events %>%
      arrange(Date) %>%
      group_by(Team) %>%
      mutate(
        total_points = cumsum(Points)
      ) %>%
      ungroup() %>%
      mutate(
        text = stringr::str_c(
          "Date: ",
          Date,
          "<br>Team: ",
          Team, 
          "<br>Employee: ",
          Employee, 
          "<br>Points: ",
          scales::comma(total_points)
        )
      )
    g1 <- ggplot(ts, aes(x = Date, y = total_points, group = Team, color = Team)) +
      geom_point(aes(text = text)) +
      geom_step(aes(text = text)) +
      scale_y_continuous(labels = scales::comma) +
      labs(y = "Points") +
      theme_bw() +
      theme(legend.position = "bottom", legend.title = element_blank())
    ggplotly(g1, tooltip = "text") %>%
      layout(legend = list(orientation = "h", x = 0.05, y = -0.15))
  })
  
  
  
  # Details -------------------
  
  output$table_employee_total <- DT::renderDataTable({
    this <- employee_total() %>%
      filter(Team == input$team) %>%
      select(-Team)
    
    DT::datatable(
      this,
      rownames = FALSE,
      options = list(
        dom = "t",
        pageLength = nrow(this)
      )
    )
  })
  
  output$team_title <- renderText({
    paste("Totals for", input$team)
  })
  
  output$team_text <- renderText({
    place <- which(team_total()$Team == input$team)
    paste0(
      "Hey ", input$team, "s!<br><br>",
      "You are currently ranked #", place, "<br><br>",
      dplyr::case_when(
        place == 1 ~ "You are doing awesome!  Keep it up!",
        place == 2 ~ "You are almost there, just work a little harder!",
        place == 3 ~ "You can do it, but you need to work a lot harder!",
        place >= 4 ~ "You are falling behind!"
      )
    )
  })
  
})
