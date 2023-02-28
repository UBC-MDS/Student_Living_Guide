
# read template data
df <- read.csv('https://raw.githubusercontent.com/UBC-MDS/Student_Living_Guide/data_preprocessing/data/processed_data.csv', header=TRUE)


# reactive variables
filtered_df <- reactive({
  # data filtering based on selected country & continent(s)
  return (df %>%
            filter(Country == input$country_select | Continent %in% input$continent_select) %>%
            rename(cost_living = `Cost.of.Living.Index`))

})
filtered_df_country <- reactive({
  # data filtering based on selected country & continent(s)
  return (df %>%
            filter(Country == input$country_select) %>%
            rename(cost_living = `Cost.of.Living.Index`)
  )

})



# observe component
observe({

  # reactive element 1: select all continent if "select all" checked
  observeEvent(input$all_cont_checkbox, {
    if (is.null(input$all_cont_checkbox)) {
      selected_ <- character(0) # no choice selected
    } else {
      selected_ <- unique(df$Continent)
    }
    updatePrettyCheckboxGroup(
      session = session,
      inputId = "continent_select",
      selected = selected_
    )
  }, ignoreNULL = FALSE)

  # reactive element 2: un-select "select_all" if no continent selected
  observeEvent(input$continent_select, {
    if (is.null(input$continent_select)) {
      selected_ <- FALSE
      updateCheckboxGroupInput(
        session = session,
        inputId = "all_cont_checkbox",
        selected = selected_
      )
    }
  }, ignoreNULL = FALSE)

})

# Render the table output
output$demo_table <- renderTable({
  filtered_df()
})




output$map1 <- renderLeaflet({
  filtered_df <- filtered_df()
  filtered_df_country <- filtered_df_country()
  # define color map
  bins <- seq(from = floor(min(filtered_df$cost_living)),
              to = ceiling(max(filtered_df$cost_living)),
              length.out = 11)
  colors_0_100 <- colorRampPalette(c("blue", "purple"))(99)
  colors_0_100_200 <- c(colors_0_100, "black", rev(colorRampPalette(c("red", "yellow"))(99)))

  pal <- colorBin(colors_0_100_200, domain = filtered_df$cost_living, bins = bins)

  # define data point label
  labels <- paste("<p><b> Continent </b>: ", filtered_df$Continent, "</p>",
                  "<p><b> Country </b>: ", filtered_df$Country, "</p>",
                  "<p><b> Cost of Living Index </b>: ", filtered_df$cost_living, "</p>",
                  sep="")

  leaflet() %>%
    addTiles(urlTemplate="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png")%>%
    addRectangles(lng1 = filtered_df_country$longitude - 3, lat1 = filtered_df_country$latitude - 2,
                  lng2 = filtered_df_country$longitude + 3, lat2 = filtered_df_country$latitude + 2,
                  color = "black", fillOpacity = 0, weight = 3) %>%
    addCircleMarkers(data = filtered_df,
                     lat = ~latitude,
                     lng = ~longitude,
                     color = ~pal(filtered_df$cost_living),
                     label = lapply(labels, HTML),
                     layerId = filtered_df$Country,
                     radius = 5,
                     stroke = FALSE,
                     fillOpacity = 0.7) %>%
    addLegend(pal = pal, values = filtered_df$cost_living,
              opacity = 0.7, position="topright",
              title = "Cost of Living Index") %>%
    setView(filtered_df_country$longitude, filtered_df_country$latitude, zoom = 4)
})

# add map marker clickable event (zoom & change selection)
observeEvent(input$map1_marker_click, {
  updateSelectizeInput(session, "country_select", selected = input$map1_marker_click$id)
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

output$distplot1 <- renderPlotly({
  filtered_df <- filtered_df()
  filtered_df_country <- filtered_df_country()

  # base line for NY
  vline <- function(x = 0, color = "green") {
    list(
      type = "line",
      y0 = 0,
      y1 = 100,
      yref = "paper",
      x0 = x,
      x1 = x,
      line = list(color = color, dash="dot")
    )
  }
  # vline for selected country
  vline2 <- function(x = 0, color = "green") {
    list(
      type = "line",
      y0 = 0,
      y1 = 100,
      yref = "paper",
      x0 = x,
      x1 = x,
      line = list(color = color, dash="dot")
    )
  }



  plot_ly(filtered_df, x = ~cost_living, type = "histogram") %>%
    layout(title = "Cost of Living Index",
           xaxis = list(title = "Cost of Living Index"),
           yaxis = list(title = "Frequency"),
           shapes = list(vline(x = 100, color = "blue"),
                         vline2(x=filtered_df_country$cost_living, color="red"))) %>%
  add_annotations(x = 100, y = 30,
                 text = "NY base level",
                 showarrow = FALSE,
                 xshift = -45, yshift = 10) %>%
    add_annotations(x = filtered_df_country$cost_living, y = 35,
                    text = filtered_df_country$Country,
                    showarrow = FALSE,
                    xshift = 40, yshift = 10)

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
