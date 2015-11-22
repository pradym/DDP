library(shiny)
library(datasets)
library(MASS)
data(Cars93)

# We tweak the "am" field to have nicer factor labels. Since this doesn't
# rely on any user inputs we can do this once at startup and then use the
# value throughout the lifetime of the application.
mpgData <- Cars93
mpgData$Man.trans.avail <- factor(mpgData$Man.trans.avail, labels = c("Automatic", "Manual"))
colnames(mpgData)[16] <- c("Transmission")

# Define server logic required to plot various variables against MPG
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  formulaText <- reactive({
    if (input$cityorhwy == "City")
      paste("MPG.city ~", input$variable)
    else
      paste("MPG.highway ~", input$variable)
  })
  
  ColorText <- reactive({
    if (input$cityorhwy == "City")
      paste("", "Red")
    else
      paste("", "Green")
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    if (input$cityorhwy == "City")
      paste("MPG in City ~", input$variable)
    else
      paste("MPG on Highway ~", input$variable)
  })
  
  
  
  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = mpgData,
            ylab="Miles Per Gallon", 
            xlab=as.character(input$variable), 
            col= as.character(ColorText()),
            outline = input$outliers
            )
  })
})
