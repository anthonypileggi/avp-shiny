
dashboardPage(
  dashboardHeader(title = "Timesheet Wars"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overall", tabName = "overall", icon = icon("dashboard")),
      menuItem("Details", tabName = "details", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "overall",
        fluidRow(
          box(
            width = 3,
            title = "Leaderboard",
            DT::dataTableOutput("table_team_total")
          ),
          box(
            width = 9,
            title = "Progression",
            plotlyOutput("plot_ts", height = "600")
          )
        )
      ),
      tabItem(tabName = "details",
        fluidRow(
          box(
            selectizeInput("team", "Choose Team:", choices = unique(events$Team))
          ),
          box(
            htmlOutput("team_text")
          )
        ),
        fluidRow(
          box(
            title = textOutput("team_title"),
            DT::dataTableOutput("table_employee_total")
          )
        )
      )
    )
  )
)

