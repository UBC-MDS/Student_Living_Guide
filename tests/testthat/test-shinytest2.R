library(shinytest2)

test_that("{shinytest2} recording: Bar_Plot_and_Map", {
  app <- AppDriver$new(variant = platform_variant(), name = "Bar_Plot_and_Map", height = 569, 
      width = 979)
  app$set_inputs(continent_select = c("Europe", "Africa", "South America", "Oceania", 
      "North America"))
  app$set_inputs(continent_select = c("Africa", "South America", "Oceania", "North America"))
  app$set_inputs(continent_select = c("Africa", "Oceania", "North America"))
  app$set_inputs(continent_select = c("Africa", "North America"))
  app$set_inputs(continent_select = "Africa")
  app$set_inputs(country_select = "Botswana")
  app$expect_values()
  app$expect_screenshot()
})


test_that("{shinytest2} recording: Distribution_Plot_and_Scatter_Plot", {
  app <- AppDriver$new(variant = platform_variant(), name = "Distribution_Plot_and_Scatter_Plot", 
      height = 569, width = 979)
  app$set_inputs(tabset1 = "Distribution Plot & Scatter Plot")
  app$set_inputs(continent_select = c("Europe", "Africa", "South America", "Oceania", 
      "North America"))
  app$set_inputs(continent_select = c("Africa", "South America", "Oceania", "North America"))
  app$set_inputs(continent_select = c("South America", "Oceania", "North America"))
  app$set_inputs(continent_select = c("Oceania", "North America"))
  app$set_inputs(continent_select = "North America")
  app$set_inputs(country_select = "Canada")
  app$set_inputs(x_axis_select = "Rent Index")
  app$set_inputs(y_axis_select = "Groceries Index")
  app$expect_values()
  app$expect_screenshot()
})
