library(shinytest2)

test_that("{shinytest2} recording: dist_scatter_asia_armenia", {
  app <- AppDriver$new(name = "dist_scatter_asia_armenia", height = 569, width = 979)
  app$set_inputs(tabset1 = "Distribution Plot & Scatter Plot")
  app$set_inputs(continent_select = character(0))
  app$set_inputs(continent_select = "Asia")
  app$set_inputs(country_select = "Armenia")
  app$expect_values(output = "distplot1")
})



test_that("{shinytest2} recording: dist_scatter_europe_austria", {
  app <- AppDriver$new(name = "dist_scatter_europe_austria", height = 569, width = 979)
  app$set_inputs(tabset1 = "Bar Plot & Map")
  app$set_inputs(continent_select = character(0))
  app$set_inputs(continent_select = "Europe")
  app$set_inputs(country_select = "Austria")
  app$set_inputs(x_axis_select = "Rent Index")
  app$set_inputs(y_axis_select = "Groceries Index")
  app$expect_values(output = "barPlot1")
})



test_that("{shinytest2} recording: dist_scatter_NA", {
  app <- AppDriver$new(name = "dist_scatter_NA", height = 569, width = 979)
  app$set_inputs(tabset1 = "Distribution Plot & Scatter Plot")
  app$set_inputs(continent_select = character(0))
  app$set_inputs(continent_select = "North America")
  app$set_inputs(country_select = "Canada")
  app$set_inputs(x_axis_select = "Cost of Living Index")
  app$set_inputs(y_axis_select = "Cost of Living Index")
  app$expect_values(output = "scatterplot")
})


