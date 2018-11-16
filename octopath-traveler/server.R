
function(input, output, session) {
  
  # Reactives ---------------------------
  
  data <- reactive({
    x %>%
      dplyr::filter(
        stat %in% input$stat
      )
  })
  
  # respond to plotly click
  selected_level <- reactive({
    event_data("plotly_click")$x
  })
  observeEvent(selected_level(), {
    update_material_slider(session, "level", value = selected_level())
  })
  
  
  # Outputs --------------------------

  output$plot_stat_vs_level <- renderPlotly({
    g <- data() %>%
      mutate(
        text = stringr::str_c(
          name,
          "<br>Level ",
          level,
          "<br>",
          input$stat,
          " = ",
          scales::comma(value)
        )
      ) %>%
      ggplot(aes(x = level, y = value, color = name, group = name)) + 
      geom_line(aes(text = text)) + 
      geom_vline(xintercept = as.numeric(input$level), linetype = "dashed") +
      labs(
        x = "Level", y = NULL, color = "Character",
        title = input$stat
        ) +
      scale_y_continuous(labels = scales::comma) +
      theme_bw() +
      theme(
        plot.title = element_text(hjust = .5)
      )

    ggplotly(g, tooltip = "text")
  })
  
  # this is not used right now...
  output$plot_stats_this_level <- renderPlot({
    x %>% 
      dplyr::filter(level == input$level) %>% 
      ggplot(aes(x = name, y = value, fill = name)) + 
      geom_bar(stat = "identity") + 
      labs(x = NULL, y = NULL, fill = NULL) +
      facet_wrap(~stat, nrow = 10, scales = "free_x") + 
      coord_flip() + 
      theme_void() + 
      theme(legend.position = "bottom")
  })
  
  output$table_stats <- DT::renderDataTable({
    x %>% 
      dplyr::filter(level == input$level) %>% 
      dplyr::select(-level) %>% 
      tidyr::spread(stat, value) %>%
      DT::datatable(
        rownames = FALSE,  
        options = list(dom = "t", pageLength = 8)
        ) %>%
      DT::formatStyle(
        input$stat,
        backgroundColor = "orange"
      ) %>%
      DT::formatRound(unique(x$stat), digits = 0)
  })

}
