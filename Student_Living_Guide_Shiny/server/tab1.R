# ============================================
# read template data
df <- read.csv("https://raw.githubusercontent.com/UBC-MDS/Student_Living_Guide/main/data/processed_data.csv", header = TRUE)

data_arranged <- df|>
  arrange(desc(`Cost.of.Living.Index`))

lower_data =  tail(data_arranged , n = 10)
up_data = head(data_arranged , n = 10)

up_data$Country <- factor(up_data$Country, levels = unique(up_data$Country)[order(up_data$Cost.of.Living.Index, decreasing = FALSE)])

lower_data$Country <-factor(lower_data$Country, levels = unique(lower_data$Country)[order(lower_data$Cost.of.Living.Index, decreasing = FALSE)])



# reactive variables e.g. filtering df
index_hash <- c(
  "Cost of Living Index" = "cost_living",
  "Rent Index" = "rent_index",
  "Cost of Living Plus Rent Index" = "cost_living_rent_index",
  "Groceries Index" = "groceries_index",
  "Restaurant Price Index" = "rest_price_index",
  "Local Purchasing Power Index" = "purchasing_power_index"
)
filtered_df <- reactive({
  # data filtering based on selected country & continent(s)
  return (df %>%
            filter(Country == input$country_select | Continent %in% input$continent_select) %>%
            rename(cost_living = `Cost.of.Living.Index`,
                   rent_index = `Rent.Index`,
                   cost_living_rent_index = `Cost.of.Living.Plus.Rent.Index`,
                   groceries_index = `Groceries.Index`,
                   rest_price_index = `Restaurant.Price.Index`,
                   purchasing_power_index = `Local.Purchasing.Power.Index`))
  
})

filtered_df_country <- reactive({
  # data filtering based on selected country & continent(s)
  return (df %>%
            filter(Country == input$country_select) %>%
            rename(cost_living = `Cost.of.Living.Index`,
                   rent_index = `Rent.Index`,
                   cost_living_rent_index = `Cost.of.Living.Plus.Rent.Index`,
                   groceries_index = `Groceries.Index`,
                   rest_price_index = `Restaurant.Price.Index`,
                   purchasing_power_index = `Local.Purchasing.Power.Index`)
  )
})

mean_col_continent <- reactive({
  # calculate mean cost of living index based for the selected continent(s)
  return(round(mean(filtered_df()$cost_living), 2))
})

# end of data reading & filtering
# ============================================


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

# leaflet map definition & rendering
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
    addRectangles(lng1 = filtered_df_country$longitude - 2, lat1 = filtered_df_country$latitude - 2,
                  lng2 = filtered_df_country$longitude + 2, lat2 = filtered_df_country$latitude + 2,
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

# bar plot 1
output$barPlot1 <- renderPlotly({
  # get filtered data
  filtered_df <- filtered_df()
  data_arranged <- filtered_df|>
    arrange(desc(`cost_living`))
  
  up_data = head(data_arranged , n = 10)
  up_data$Country <- factor(up_data$Country, levels = unique(up_data$Country)[order(up_data$cost_living, decreasing = FALSE)])
  # ========================
  # code below for bar plot
  # ========================
  plot_ly(up_data, x = ~cost_living, y = ~Country, type = 'bar') %>%
    layout(title = paste("The ", nrow(up_data), " most expensive countries"), xaxis = list(title = "Cost index"), yaxis = list(title = "Country"))
})
br()
# bar plot 2
output$barPlot2 <- renderPlotly({
  # get filtered data
  filtered_df <- filtered_df()
  data_arranged <- filtered_df|>
    arrange(desc(`cost_living`))
  
  lower_data = tail(data_arranged , n = 10)
  lower_data$Country <- factor(lower_data$Country, levels = unique(lower_data$Country)[order(lower_data$cost_living, decreasing = FALSE)])
  
  # ========================
  # code below for bar plot
  # ========================
  plot_ly(lower_data, x = ~cost_living, y = ~Country, type = 'bar') %>%
    layout(title = paste("The ", nrow(lower_data), " least expensive countries"),
           xaxis = list(title = "Cost index"),  yaxis = list(title = "Country"))
})



# ========================
# code below for distribution plot
# ========================
output$distplot1 <- renderPlotly({
  filtered_df <- filtered_df()
  filtered_df_country <- filtered_df_country()
  mean_col_continent <- mean_col_continent()
  
  # continent cost of living mean value
  vline <- function(x = 0, color = "green") {
    list(
      type = "line",
      y0 = 0,
      y1 = 0,
      yref = "paper",
      x0 = x,
      x1 = x,
      line = list(color = color, dash = "solid")
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
      line = list(color = color, dash = "dot")
    )
  }
  
  gg <- ggplot(filtered_df, aes(x = cost_living)) +
    geom_histogram(aes(y = after_stat(density)), color = "white", fill = "#1F77B4", binwidth = 3) +
    geom_density(outline.type = "upper", adjust = 1.75, linewidth = 0.4) +
    geom_vline(aes(xintercept = mean_col_continent),
               color = "black", linetype = "solid", linewidth = 0.4) +
    # annotate("text", x = mean_col_continent + 12, y = 0.03, label = paste("Mean:", mean_col_continent)) +
    # annotate("text", x = filtered_df_country$cost_living + 12, y = 0.03, label = filtered_df_country$Country) +
    geom_vline(aes(xintercept=filtered_df_country$cost_living),
               color="red", linetype="dash", linewidth = 0.4) +
    scale_x_continuous(limits = c(min(filtered_df$cost_living) - 20,max(filtered_df$cost_living) + 20), expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0)) +
    theme_bw()
  
  ggplotly(gg) %>%
    layout(
      title = list(text = "Cost of Living Distribution Plot", y = 0.995),
      xaxis = list(title = "Cost of Living Index"),
      yaxis = list(title = "Density"),
      shapes = list(
        vline(x = mean_col_continent, color = "black"),
        vline2(x = filtered_df_country$cost_living, color = "red")
      )
    ) %>%
    add_annotations(x = mean_col_continent, y = 0.038,
                    text = paste("Mean:", mean_col_continent),
                    showarrow = FALSE,
                    xshift = 45, yshift = 10, font = list(size = 12)) %>%
    add_annotations(
      x = filtered_df_country$cost_living, y = 0.03,
      text = paste(filtered_df_country$Country, '(', filtered_df_country$cost_living ,')'),
      showarrow = FALSE,
      xshift = 70, yshift = 10, font = list(size = 12)
    )
})

# ========================
# code below for scatter plot
# ========================
#Index hashmap
index_hash <- data.frame(
  row.names=c(
    "Cost of Living Index",
    "Rent Index",
    "Cost of Living Plus Rent Index",
    "Groceries Index",
    "Restaurant Price Index",
    "Local Purchasing Power Index"
  ) ,
  val=c(
    "cost_living",
    "rent_index",
    "cost_living_rent_index",
    "groceries_index",
    "rest_price_index",
    "purchasing_power_index"
  ))


output$scatterplot <- renderPlotly({
  filtered_df <- filtered_df()
  x_axis_select <- reactive({
    # get selected indexes for x axis
    return (input$x_axis_select)
  })
  y_axis_select <- reactive({
    # get selected indexes for y axis
    return (input$y_axis_select)
  })
  x_axis_select <- toString(x_axis_select())
  y_axis_select <- toString(y_axis_select())
  plot_ly(filtered_df,
          x = as.formula(paste0('~', index_hash[x_axis_select, ])),
          y = as.formula(paste0('~', index_hash[y_axis_select, ])),
          type = "scatter") |>
    layout(title = "Correlation Plot between Indices",
           xaxis = list(title = x_axis_select),
           yaxis = list(title = y_axis_select))
  
})
