library(shiny)

# Define UI for Miles per Gallon application 
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Analyzing Miles per Gallon for Cars"),
  
  # sidebarPanel(),
  # Sidebar with controls to select the variable to plot against MPG
  # and to specify whether outliers should be included
  sidebarPanel(
    selectInput("cityorhwy", "Choose City or Highway:", 
                choices = c("City", "Highway")),
    
    selectInput("variable", "Engine Charecteristic:",
                list("Cylinders" = "Cylinders",
                     "Transmission" = "Transmission",
                     "Origin" = "Origin",
                     "Drive Train" = "DriveTrain",
                     "Type" = "Type")),
   
    checkboxInput("outliers", "Show outliers", FALSE)
  ),
    
  # mainPanel()
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    h3(textOutput("caption")),
    plotOutput("mpgPlot")
  )
  
))
