#' my_first_module UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_my_first_module_ui <- function(id){
  ns <- NS(id)
  tagList(
    sidebarLayout(
      sidebarPanel(
        helpText(ns("Type a stock symbol to examine ( e.g AAPL). Information will be collected from Yahoo Finance. ")),
        textInput(ns( "symbol"),
                  label = "Type stock symbol",
                  value = "AAPL"),
        dateRangeInput(ns("dates"),
                       label = "date range",
                       start = "2015-01-01",
                       end = "2020-09-01"),
        checkboxInput(ns("log"),
                      label = "Plot y axis on log scale",
                      value = FALSE)
      ),
      
      mainPanel(
        plotOutput(ns("plot"))
      )
      
    )
  )
}
    
#' my_first_module Server Function
#'
#' @noRd 
mod_my_first_module_server <- function(input, output, session){
  ns <- session$ns
  
  dataInput <- reactive({
    quantmod::getSymbols(input$symbol, src = "yahoo",
                         from = input$dates[1],
                         to = input$dates[2],
                         auto.assign = FALSE)
  })
  
  output$plot <- renderPlot({
    data <- dataInput()
    
    quantmod::chartSeries(data, theme = "black",
                type = "line", log.scale = input$log, TA = NULL )
  })
 
}
    
## To be copied in the UI

    
## To be copied in the server

 
