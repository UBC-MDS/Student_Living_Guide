
# read template data
df <- read.csv('https://raw.githubusercontent.com/UBC-MDS/Student_Living_Guide/data_preprocessing/data/processed_data.csv', header=TRUE)


# observe component

observe({
  selected_continents <- input$continent_checkbox
  if (!is.null(selected_continents)) {
    filtered_df <- df[df$Continent %in% selected_continents,]
    updateSelectizeInput(session, "country_select", choices = unique(filtered_df$Country))
  } else {
    updateSelectizeInput(session, "country_select", choices = unique(df$Country))
  }
})

# define barPlot1
output$barPlot1 <- renderPlotly({

  # [implemented in milestone 2]
  # selected_countries <- input$country_select
  # if (!is.null(selected_countries)) {
  #   filtered_df <- df[df$Country %in% selected_countries,]
  #   plot <- plot_ly(filtered_df, x = ~Cost.of.Living.Index, y = ~Country, type = 'bar') %>%
  #     layout(title = "Living Cost Bar Plot", xaxis = list(title = "Living Cost"), yaxis = list(title = "Country"))
  #   plot
  # }

  plot_ly(df, x = ~Cost.of.Living.Index, y = ~Country, type = 'bar') %>%
    layout(title = "Living Cost Bar Plot", xaxis = list(title = "Living Cost"), yaxis = list(title = "Country"))

})


output$barPlot2 <- renderPlotly({

  plot_ly(df, x = ~Cost.of.Living.Index, y = ~Country, type = 'bar') %>%
    layout(title = "Living Cost Bar Plot",
           xaxis = list(title = "latitude"), yaxis = list(title = "Country"))



})


# Layout ========================================================
# (adding every plot together)
# Bar Plot Layout
# output$barPlotSection <- renderUI({
#   fluidPage(
#     fluidRow(
#       plotlyOutput("barPlot1")
#     ),
#     fluidRow(
#       plotlyOutput("barPlot1")
#     )
#   )
# })
