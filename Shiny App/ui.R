ui = dashboardPage(skin = "black",
  header = dashboardHeader(
    title = "Cancer & JAGS"
  ),
  sidebar = dashboardSidebar(
    sidebarMenu(
      menuItem(
        text = "Background",
        tabName = "background",
        icon = icon("chalkboard-teacher")
      ),
      menuItem(
        text = "Data Source",
        tabName = "dataSource",
        icon = icon("database")
      ),
      menuItem(
        text = "EDA",
        tabName = "eda",
        icon = icon("search")
      ),
      menuItem(
        text = "Model Performances",
        tabName = "modelPerformances",
        icon = icon("sort-numeric-up")
      ),
      menuItem(
        text = "Final Model",
        tabName = "finalModel",
        icon = icon("flag-checkered")
      )
    )
  ),
  body = dashboardBody(
    tabItems(
      tabItem(tabName = "background"
        
      ),
      tabItem(tabName = "dataSource"

      ),
      tabItem(tabName = "eda"
        
      ),
      tabItem(tabName = "modelPerformances"
              
      ),
      tabItem(tabName = "finalModel",
        tabsetPanel(
          tabPanel(title = "Model Diagram",
            fluidRow(
              box(
                uiOutput(outputId = "modelDiagram")
              ),
              box(
                uiOutput(outputId = "modelDiagram2")
              ),
              box(
                uiOutput(outputId = "modelDiagram3")
              )
            )
          ),
          tabPanel(title = "Model Interpretation"
                     
          )
        )
      )
    )
  )
)