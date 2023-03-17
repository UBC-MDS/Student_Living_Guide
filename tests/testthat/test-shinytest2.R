library(shinytest2)

test_that("{shinytest2} recording: bar_map_europe_oceania_NA", {
  app <- AppDriver$new(name = "bar_map_europe_oceania_NA", height = 569, width = 979)
  app$set_inputs(continent_select = c("Europe", "Africa", "South America", "Oceania", 
      "North America"))
  app$set_inputs(continent_select = c("Europe", "South America", "Oceania", "North America"))
  app$set_inputs(continent_select = c("Europe", "Oceania", "North America"))
  app$expect_values()
})



test_that("{shinytest2} recording: bar_map_canada", {
  app <- AppDriver$new(name = "bar_map_canada", height = 569, width = 979)
  app$set_inputs(country_select = "")
  app$set_inputs(country_select = "Canada")
  app$expect_values()
})



test_that("{shinytest2} recording: dist_scatter_asia", {
  app <- AppDriver$new(name = "dist_scatter_asia", height = 569, width = 979)
  app$set_inputs(tabset1 = "Distribution Plot & Scatter Plot")
  app$set_inputs(continent_select = character(0))
  app$set_inputs(continent_select = "Asia")
  app$set_inputs(x_axis_select = "Rent Index")
  app$set_inputs(y_axis_select = "Groceries Index")
  app$expect_values()
})

