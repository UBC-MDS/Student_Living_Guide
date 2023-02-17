library(shiny)          # web app framework
library(shinyjs)        # improve user experience with JavaScript
library(shinydashboard) # dashboard layout for shiny
library(shinythemes)    # themes for shiny
library(shinycssloaders)

library(plotly)

# ====================================
# ===       Global Variables       ===
# ====================================
df <- read.csv('https://raw.githubusercontent.com/UBC-MDS/Student_Living_Guide/data_preprocessing/data/processed_data.csv', header=TRUE)

# ====================================
# ===              UI              ===
# ====================================
ui <- dashboardPage(
  dashboardHeader(
    title = "Student Living Guide"
  ),

  dashboardSidebar(collapsed = FALSE,
                   sidebarMenu(id="sidebar001",
                               menuItem("Tab1", tabName = "tab1", icon = icon("table-columns"))
                   )
                   ,
                   fluidPage(
                     fluidRow(
                       checkboxGroupInput("continent_checkbox", label = "Select continents",
                                          choices = unique(df$Continent)),
                       selectizeInput("country_select", label = "Select countries", choices = unique(df$Country), multiple = TRUE)
                     )
                    )


  ),

  dashboardBody(
    # define tabItems with separated UI R script
    tabItems(
      tabItem(tabName = "tab1", source(file.path("ui", "tab1.R"),  local = TRUE)$value)
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