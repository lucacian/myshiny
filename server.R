# server.R

library(quantmod)
source("E:\\r-study\\R-shiny\\stockVis\\helpers.R")

shinyServer(function(input, output) {

  dataInput <- reactive({
      getSymbols(input$symb, src = "yahoo", 
      from = input$dates[1],
      to = input$dates[2],
      auto.assign = FALSE)
  })
  
  # finalInput <- reactive ({
  # if (!input$adjust)return(dataInput())
  # adjust(dataInput())
  # })
  
  #  output$plot <- renderPlot({
  #  chartSeries(finalInput(), theme = chartTheme("white"), 
  #            type = "line", log.scale = input$log, TA = NULL)
  
  
  data <- reactive({
    if (input$adjust) adjust(dataInput())else dataInput()
  })
  output$plot <- renderPlot({   
    ## data <- dataInput()
    ## if (input$adjust) data <- adjust(dataInput())
    
    chartSeries(data(), theme = chartTheme("white"), 
                type = "line", log.scale = input$log, TA = NULL)
 })
}
)

# When you click “Plot y axis on the log scale”, input$log will change and renderPlot will re-execute. Now
# renderPlot will call dataInput()
# dataInput will check that the dates and symb widgets have not changed
# dataInput will return its saved data set of stock prices without re-fetching data from Yahoo
# renderPlot will re-draw the chart with the correct axis.
