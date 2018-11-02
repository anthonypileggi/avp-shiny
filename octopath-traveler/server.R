function(input, output) {
  
  output$plot_stat_vs_level <- renderPlot({
    plot_output <- x %>%
      dplyr::filter(
        stat %in% input$stat,
        level >= input$min_level,
        level <= input$max_level
        ) %>%
      ggplot(aes(x = level, y = value, color = name, group = name)) + 
      geom_line() + 
      geom_point() +
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

    plot_output
  })
  
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
