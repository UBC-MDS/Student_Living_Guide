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

      # possible chart output
      # ...


      fluidPage(
        fluidRow(
          withSpinner(plotlyOutput("barPlot1"), type=3, color.background = "white")
        ),
        fluidRow(
          withSpinner(plotlyOutput("barPlot2"), type=3, color.background = "white")
        )
      )

    )
    ,
    box(
      width = 8,
      title ="column2",
      status = "success",

      # possible chart output
      # ...
      # fluidPage(
      #   fluidRow(
      #     withSpinner(plotlyOutput("barPlot1"), type=3, color.background = "white")
      #   ),
      #   fluidRow(
      #     withSpinner(plotlyOutput("barPlot2"), type=3, color.background = "white")
      #   )
      # )
    )

  )
)
