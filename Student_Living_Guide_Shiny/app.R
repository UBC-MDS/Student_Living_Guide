library(shiny)          # web app framework
library(shinyjs)        # improve user experience with JavaScript
library(shinydashboard) # dashboard layout for shiny
library(shinythemes)    # themes for shiny
library(shinycssloaders)
library(shinyWidgets)
library(leaflet)
library(plotly)
library(circlize)
library(ggplot2)
library(dplyr)

# ====================================
# ===       Global Variables       ===
# ====================================
df <- read.csv('https://raw.githubusercontent.com/UBC-MDS/Student_Living_Guide/main/data/processed_data.csv', header=TRUE)
# ====================================
# ===              UI              ===
# ====================================
ui <- dashboardPage(
  dashboardHeader(
    title = "Student Living Guide"
  ),

  dashboardSidebar(
    collapsed = FALSE,
    fluidPage(
      fluidRow(
        pickerInput(
          inputId = "continent_select",
          label = "Select the Continent(s)",
          choices = unique(df$Continent),
          selected = unique(df$Continent),
          options = pickerOptions(
            actionsBox = TRUE,
            size = 10,
            selectedTextFormat = "count > 1",
            noneSelectedText = "Please select >0 continent"
          ),
          multiple = TRUE
        ),
        selectizeInput(
          "country_select",
          label = "Select countries",
          choices = unique(df$Country)
        ),
        selectizeInput(
          "x_axis_select",
          label = "Select x_axis for correlation between indixes",
          choices = c("Cost of Living Index", "Rent Index", "Cost of Living Plus Rent Index", "Groceries Index", "Restaurant Price Index", "Local Purchasing Power Index")
        ),
        selectizeInput(
          "y_axis_select",
          label = "Select y_axis for correlation between indixes",
          choices = c("Cost of Living Index", "Rent Index", "Cost of Living Plus Rent Index", "Groceries Index", "Restaurant Price Index", "Local Purchasing Power Index")
        ),
        div(
          class = "text-center",
          tags$style(type="text/css", "#downloadData {color: black;}"),
          downloadButton("downloadData", "Download selected data", class = "butt")
        )
      )
    )
  ),

  dashboardBody(

    fluidRow(
      tabBox(
        title = "",
        id = "tabset1", height = "800px", width=12,
        tabPanel("Bar Plot & Map", source(file.path("ui", "tab1.R"),  local = TRUE)$value),
        tabPanel("Distribution Plot & Scatter Plot", source(file.path("ui", "tab2.R"),  local = TRUE)$value)
      )
    ),

    # enable shinyjs
    shinyjs::useShinyjs(),
    # tag header, script, css, etc.
    tags$head(tags$style(".table{margin: 0 auto;}"),
              tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/iframe-resizer/3.5.16/iframeResizer.contentWindow.min.js",type="text/javascript"),
              tags$style(HTML("
                .shiny-output-error-validation {
                  color: red;
                }
              "))
    )
  )
)

# ====================================
# ===            Server            ===
# ====================================
server <- function(input, output, session) {
  # loading server function for each tab item
  source(file.path("server", "tab1.R"),  local = TRUE)$value
}

# Run the application
shinyApp(ui = ui, server = server)
