fluidPage(
  fluidRow(
    p('*All the index value is based on New York as a reference point *')
  ),
  fluidRow(

    box(
      width = 4,
      title = "Least & Most Expensive Countries",
      status = "primary",

      fluidPage(
        fluidRow(
          # bar plot 1
          withSpinner(plotlyOutput("barPlot1"), type = 3, color.background = "white")

        ),
        fluidRow(),
        fluidRow(
          # bar plot 2
          withSpinner(plotlyOutput("barPlot2"), type=3, color.background = "white")
        )
      )
    )
    ,
    box(
      width = 8,
      title ="Map Plot",
      status = "success",

      fluidPage(
        fluidRow(
          # map plot
          leafletOutput("map1", height = "650px"),
        )

      )
    )
  )
)
