fluidPage(
  fluidRow(
    titlePanel(h1("**Draft Only**",
                  style='padding-left: 15px'))
  ),
  fluidRow(
    box(
      width = 4,
      title = "Highest & Lowest Living Cost",
      status = "primary",

      fluidPage(
        fluidRow(
          # bar plot 1
          withSpinner(plotlyOutput("barPlot1"), type=3, color.background = "white")
        ),
        fluidRow(
          # bar plot 2
          withSpinner(plotlyOutput("barPlot2"), type=3, color.background = "white")
        )
      )
    )
    ,
    box(
      width = 8,
      title ="column2",
      status = "success",

      fluidPage(
        fluidRow(
          # map plot
          leafletOutput("map1", height = "650px")
        ),
        fluidRow(
          # distribution plot
          plotlyOutput("distplot1")
        ),
        fluidRow(
          # scatter plot
          tableOutput(outputId = "demo_table") # <- change it to scatter plot / plotly output
        )
      )
    )
  )
)
