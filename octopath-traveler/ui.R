material_page(
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
            input_id = "min_level",
            label = "Min. Level",
            min_value = 1,
            max_value = 99,
            initial_value = 1
          ),
          material_slider(
            input_id = "max_level",
            label = "Max. Level",
            min_value = 1,
            max_value = 99,
            initial_value = 99
          ),
          material_dropdown(
            input_id = "level",
            label = "Level",
            choices = unique(x$level),
            selected = 1
          )
        )
      ),
      material_column(
        width = 7,
        material_card(
          depth = 4,
          plotOutput("plot_stat_vs_level")
        )
      ),
      material_column(
        width = 3,
        material_card(
          depth = 4,
          plotOutput("plot_stats_this_level")
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
