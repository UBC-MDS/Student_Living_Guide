fluidPage(
  fluidRow(
    p('*All the index value is based on New York as a reference point *')
  ),
  fluidRow(
    box(
      width = 6,
      title = "scatterplot",
      status = "primary",

      fluidPage(
        fluidRow(
          # scatter plot
          withSpinner(plotlyOutput("scatterplot"), type=3, color.background = "white")
        )

      )
    )
    ,
    box(
      width = 6,
      title ="Distribution Plot",
      status = "success",

      fluidPage(
        fluidRow(
          # distribution plot
          withSpinner(plotlyOutput("distplot1"), type=3, color.background = "white")
        )


      )
    )
  )
)
