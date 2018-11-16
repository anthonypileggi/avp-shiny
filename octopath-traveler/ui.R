material_page(

  tags$head(includeScript("google-analytics.js")),
  title = "octopath traveler",
  nav_bar_color = "orange darken-4",
  tags$br(),
  
  material_side_nav(
    fixed = FALSE,
    #image_source = "example_image.jpg",
    background_color = NULL,
    material_side_nav_tabs(
      side_nav_tabs = c(
        "Example Side-Nav Tab 1" = "example_side_nav_tab_1",
        "Example Side-Nav Tab 2" = "example_side_nav_tab_2"
      ),
      icons = c("cloud", "none"),
      color = "teal"
    )
  ),
  
  material_tabs(
    tabs = c(
      "Character Explorer" = "first_tab",
      "Character Similarities (Coming soon)" = "second_tab",
      "Nut Distributor (Coming soon)" = "third_tab"
    )
  ),
  
  material_tab_content(
    tab_id = "first_tab",
    material_row(
      material_column(
        width = 2,
        material_card(
          title = "",
          depth = 4,
          material_radio_button(
            input_id = "stat",
            label = "Statistic",
            choices = unique(x$stat)
          ),
          material_slider(
            input_id = "level",
            label = "Level",
            min_value = 1,
            max_value = 99,
            initial_value = 1
          )
        )
      ),
      material_column(
        width = 10,
        material_card(
          depth = 4,
          plotlyOutput("plot_stat_vs_level")
        )
      ),
      material_column(
        width = 12,
        material_card(
          depth = 4,
          div(style = "font-size:75%",
            DT::dataTableOutput("table_stats")
          )
        )
      )
    )
  )
)
